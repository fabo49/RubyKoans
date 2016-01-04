require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutArrays < Neo::Koan
  def test_creating_arrays
    empty_array = Array.new
    assert_equal Array, empty_array.class
    assert_equal 0, empty_array.size
  end

  def test_array_literals
    array = Array.new
    assert_equal [], array

    array[0] = 1
    assert_equal [1], array

    array[1] = 2
    assert_equal [1, 2], array

    array << 333
    assert_equal [1, 2, 333], array
  end

  def test_accessing_array_elements
    array = [:peanut, :butter, :and, :jelly]

    assert_equal :peanut, array[0]
    assert_equal :peanut, array.first
    assert_equal :jelly, array[3]
    assert_equal :jelly, array.last
    assert_equal :jelly, array[-1]
    assert_equal :butter, array[-3]
  end

  def test_slicing_arrays
    # Slicing e indexar son operaciones distintas!
    # La primera posicion dice donde iniciar, la segunda dice cuantos elementos agarrar
    array = [:peanut, :butter, :and, :jelly]

    assert_equal [:peanut], array[0,1]
    assert_equal [:peanut, :butter], array[0,2]
    assert_equal [:and, :jelly], array[2,2]
    assert_equal [:and, :jelly], array[2,20]
    # Como es distinto a indexar, en realidad se tienen que ver los arrays de la siguiente manera:
    #   :peanut,   :butter,   :and,   :jelly
    #  0        1          2       3        4
    # Debido a lo anterior, la posicion 4 del array existe pero esta vacia ([]) cuando se quiere
    # sacar tajadas del arreglo. Si se estuviera indexando entonces efectivamente se esta solicitando
    # el elemento 4 (array[4]) el cual no existe.
    assert_equal [], array[4,0]
    assert_equal [], array[4,100]
    assert_equal nil, array[5,0]  # La posicion 5 del todo no existe y por eso es nil.
  end

  def test_arrays_and_ranges
    assert_equal Range, (1..5).class
    assert_not_equal [1,2,3,4,5], (1..5)
    assert_equal [1, 2, 3, 4, 5], (1..5).to_a # to_a => "to array"
    assert_equal [1, 2, 3, 4], (1...5).to_a
  end

  def test_slicing_with_ranges
    array = [:peanut, :butter, :and, :jelly]

    assert_equal [:peanut, :butter, :and], array[0..2]
    assert_equal [:peanut, :butter], array[0...2]
    assert_equal [:and, :jelly], array[2..-1]
    # Cuando se hace con rangos, entonces es como si estuviera indexando. Por lo que lo que retorna
    # son las posiciones del rango, ejemplo:
    # array = [:hola, :como, :va, :todo]
    #             0     1     2     3
    # array[0..2] => [:hola, :como, :va]
    # Donde cada uno corresponde a su indice en el arreglo.
  end

  def test_pushing_and_popping_arrays
    array = [1,2]
    array.push(:last)

    assert_equal [1, 2, :last], array

    popped_value = array.pop
    assert_equal :last, popped_value
    assert_equal [1, 2], array
  end

  def test_shifting_arrays
    array = [1,2]
    array.unshift(:first)

    assert_equal [:first, 1, 2], array

    shifted_value = array.shift
    assert_equal :first, shifted_value
    assert_equal [1, 2], array
  end

end
