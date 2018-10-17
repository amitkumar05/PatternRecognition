echo `head -n 375 Class1.txt > Class1_train.txt`
echo `head -n 375 Class2.txt > Class2_train.txt`
echo `head -n 375 Class3.txt > Class3_train.txt`

echo `tail -n 125 Class1.txt > Class1_test.txt`
echo `tail -n 125 Class2.txt > Class2_test.txt`
echo `tail -n 125 Class3.txt > Class3_test.txt`


# cat Class1_train.txt  Class2_train.txt > ClassComb_train.txt
#echo 'cat Class1_train.txt  Class2_train.txt > ClassComb_train.txt'
#ClassComb_train.txt
