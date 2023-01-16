#include <system.h>
#include <sys/alt_stdio.h>
#include <sys/alt_irq.h>
#include <alt_types.h>
#include <io.h>
#include <unistd.h>
#include <../../ip/opencores_i2c/HAL/src/opencores_i2c.c>

#define DATAX0 0X32
#define DATAX1 0X33
#define DATAY0 0X34
#define DATAY1 0X35
#define DATAZ0 0X36
#define DATAZ1 0X37

#define ACT_INACT_CTL 0x27
#define POWER_CTL 0x2D
#define DATA_FORMAT 0x31

int data;
int lecture_i2c(alt_8 reg);
void ecriture_i2c(alt_8 reg, int valeur);

int main()
{
    int data1 = 0, data2 = 0;

    I2C_init(OPENCORES_I2C_0_BASE, ALT_CPU_FREQ, 100000);

    /*Configurations ADXL*/
    ecriture_i2c(ACT_INACT_CTL, 240);
    ecriture_i2c(POWER_CTL, 8);
    ecriture_i2c(DATA_FORMAT, 11);

    while (1)
    {
        data2 = lecture_i2c(DATAX0);
        //alt_printf("X0 : %x \n", data2);

        data1 = lecture_i2c(DATAX1);
        //alt_printf("X1 : %x \n", data1);

        data = (data2) | (data1 << 8);
        alt_printf("************\n");
        printf("X : %d \n", data);
        alt_printf("*************\n");
        data = 0;


        usleep(2000000);
    }

    return 0;
}

int lecture_i2c(alt_8 reg)
{
    int d;

    I2C_start(OPENCORES_I2C_0_BASE, 0x1d, 0); // address the chip in write mode
    I2C_write(OPENCORES_I2C_0_BASE, reg, 0);  // set command to read input register.
    I2C_start(OPENCORES_I2C_0_BASE, 0x1d, 1); // send start again but this time in read mode
    d = I2C_read(OPENCORES_I2C_0_BASE, 1);    // read the input register and send stop

    return d;
}

void ecriture_i2c(alt_8 reg, int valeur)
{
    I2C_start(OPENCORES_I2C_0_BASE, 0x1d, 0);   // chip address in write mode
    I2C_write(OPENCORES_I2C_0_BASE, reg, 0);    // write to register 3 command
    I2C_write(OPENCORES_I2C_0_BASE, valeur, 1); // set the bottom 4 bits to outputs for the LEDs set the stop
}