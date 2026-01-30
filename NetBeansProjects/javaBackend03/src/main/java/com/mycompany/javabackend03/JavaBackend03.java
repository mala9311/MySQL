/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.javabackend03;

/**
 *
 * @author HP
 */
import java.util.Scanner;
import java.util.Arrays;

public class JavaBackend03 {

    public static void main(String[] args) {
        int number[] = {2,4,6,8,9,10};
        int start = 0;
        int end = number.length-1;
        for(int i = number.length -1; i>0; i--){
            int temp = number[start];
            number[start] = number[end];
            number[end] = temp;
        }
        System.out.println("Reverse the Arrays:" + Arrays.toString(number));
            
    }
}
