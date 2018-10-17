echo `head -n 1866 class1.txt > Class1_train.txt`
echo `head -n 1840 class2.txt > Class2_train.txt`
echo `head -n 1623 class3.txt > Class3_train.txt`

echo `tail -n 622 class1.txt > Class1_test.txt`
echo `tail -n 614 class2.txt > Class2_test.txt`
echo `tail -n 541 class3.txt > Class3_test.txt`

#cat Class1_train.txt  Class2_train.txt Class3_train.txt > ClassComb_train.txt


