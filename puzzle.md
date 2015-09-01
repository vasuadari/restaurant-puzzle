Expectation

1. For the solution, we would want you to use Ruby.
2. We are interested in the DESIGN ASPECT of your solution and would like to evaluate your OBJECT ORIENTED PROGRAMMING SKILLS.
3. You may use external libraries or tools for building or testing purposes.
4. Optionally, you may also include a brief explanation of your design and assumptions along with your code.
5. Kindly note that we are NOT expecting a web-based application or a comprehensive UI. Rather, we are expecting a simple, console based application and interested in your source code.
6. Along with solution please mention the steps involved to setup and run your code. Also mention the environment your code is expected to run into(versions etc).

==========

1     RESTAURANT PUZZLE: (Software Engineers)

Because it is the Internet Age, but also it is a recession, the Comptroller of the town of Jurgensville has decided to publish the prices of every item on every menu of every restaurant in town, all in a single CSV file (Jurgensville is not quite up to date with modern data serialization methods).  In addition, the restaurants of Jurgensville also offer Value Meals, which are groups of several items, at a discounted price.  The Comptroller has also included these Value Meals in the file.  The file's format is:

for lines that define a price for a single item:
restaurant ID, price, item label

for lines that define the price for a Value Meal (there can be any number of items in a value meal)
restaurant ID, price, item 1 label, item 2 label, ...

All restaurant IDs are integers, all item labels are lower case letters and underscores, and the price is a decimal number.


Because you are an expert software engineer, you decide to write a program that accepts the town's price file, and a list of item labels that someone wants to eat for dinner, and outputs the restaurant they should go to, and the total price it will cost them.  It is okay to purchase extra items, as long as the total cost is minimized.

Here are some sample data sets, program inputs, and the expected result:

----------------------------
Data File data.csv
1, 4.00, burger
1, 8.00, tofu_log
2, 5.00, burger
2, 6.50, tofu_log

Program Input
> program data.csv burger tofu_log

Expected Output
=> 2, 11.5
---------------------------


----------------------------
Data File data.csv
3, 4.00, chef_salad
3, 8.00, steak_salad_sandwich
4, 5.00, steak_salad_sandwich
4, 2.50, wine_spritzer

Program Input
> program data.csv chef_salad wine_spritzer

Expected Output
=> nil  (or null or false or something to indicate that no matching restaurant could be found)
---------------------------


----------------------------
Data File data.csv
5, 4.00, extreme_fajita
5, 8.00, fancy_european_water
6, 5.00, fancy_european_water
6, 6.00, extreme_fajita, jalapeno_poppers, extra_salsa

Program Input
> program data.csv fancy_european_water extreme_fajita

Expected Output
=> 6, 11.0
---------------------------



Other inputs outputs:

#Input CSV file:

1, 1, i1

1, 2, i2

1, 3, i3

1, 4, i4

1, 4, i2,i3

1, 4.5, i1,i2,i3

1, 6.5, i1,i3,i4

2, 1, i1

2, 1.9, i2

2, 3, i3

2, 4, i4

2, 4.25, i2,i3

2, 4.75, i1,i2,i3

2, 6.55, i1,i3,i4



#Command line arguments and expected results:

## i1 => 1,1

## i2 => 2,1.9

## i2 i3 => 1,4

## i1 i4 => 1,5

## i2 i4 => 2,5.9

## i3 i4 => 1,6.5

## i2 i3 i4 => 1,8

## i1 i2 i3 i4 => 2,8.45

## i1 i2 i2 i2 i3 i3 i3 => 1,12.5

## i1 i1 i1 i1 i1 i2 i3 i3 i3 i4 i4  => 1,19.5

## i1 i1 i1 i3 i4 i1 i3 i4 i4 i3 i4 i4 i4 i2 i3 i2 i3 i1 i2 i3 i1 i2 i3 i2 i2 => 53



#Second input file:

1, 3, i1

1, 5, i2

1, 7, i3

1, 10, i1, i2, x1

1, 18, i1, i2, i3, x2

1, 10, i2, i3, x3

#Test cases for the above
#i1 i2 => 8

#i1 i3 i2 i3 i2 i3 i1 i2 => 38

#Other Cases:

# Unformatted csv (invalid numbers  spaces  empty lines  and standard qa)

===================================================================
