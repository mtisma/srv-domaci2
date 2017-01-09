#line 1 "C:/Users/Andreja/Desktop/mikroC/domaci2.c"


unsigned int TFT_DataPort at GPIOE_ODR;
sbit TFT_RST at GPIOE_ODR.B8;
sbit TFT_RS at GPIOE_ODR.B12;
sbit TFT_CS at GPIOE_ODR.B15;
sbit TFT_RD at GPIOE_ODR.B10;
sbit TFT_WR at GPIOE_ODR.B11;
sbit TFT_BLED at GPIOE_ODR.B9;



sbit DriveX_Left at GPIOB_ODR.B1;
sbit DriveX_Right at GPIOB_ODR.B8;
sbit DriveY_Up at GPIOB_ODR.B9;
sbit DriveY_Down at GPIOB_ODR.B0;



const MAX_TARGETS = 32;
const TARGET_DIAMETER = 20;
const ADC_THRESHOLD = 3000;

unsigned char readbuff[128];
unsigned char writebuff[128];
int pressed_targets_index = 0;
unsigned x_coord, y_coord;
int down = 0;
int kk = 0;
unsigned char niz[128];
int i;
unsigned char pressed[64];
void Init_ADC() {
 ADC_Set_Input_Channel(_ADC_CHANNEL_8 | _ADC_CHANNEL_9);
 ADC1_Init();
 Delay_ms(100);
}

static void InitializeTouchPanel() {
 Init_ADC();
 TFT_Init_ILI9341_8bit(320, 240);

 TP_TFT_Init(320, 240, 8, 9);
 TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);
}

void Init_MCU(){
 GPIO_Config(&GPIOE_BASE, _GPIO_PINMASK_9, _GPIO_CFG_DIGITAL_OUTPUT);
 TFT_BLED = 1;
 TFT_Set_Default_Mode();
 TP_TFT_Set_Default_Mode();
}

void Calibrate() {
 TFT_Set_Pen(CL_WHITE, 3);
 TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
 TFT_Write_Text("Touch selected corners for calibration", 50, 80);
 TFT_Line(315, 239, 319, 239);
 TFT_Line(309, 229, 319, 239);
 TFT_Line(319, 234, 319, 239);
 TFT_Write_Text("first here",235,220);

 TP_TFT_Calibrate_Min();
 Delay_ms(500);

 TFT_Set_Pen(CL_BLACK, 3);
 TFT_Set_Font(TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
 TFT_Line(315, 239, 319, 239);
 TFT_Line(309, 229, 319, 239);
 TFT_Line(319, 234, 319, 239);
 TFT_Write_Text("first here",235,220);

 TFT_Set_Pen(CL_WHITE, 3);
 TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
 TFT_Write_Text("now here ", 20, 5);
 TFT_Line(0, 0, 5, 0);
 TFT_Line(0, 0, 0, 5);
 TFT_Line(0, 0, 10, 10);

 TP_TFT_Calibrate_Max();
 Delay_ms(500);
}

void fill_array(unsigned char array[], int n, int value)
{
 int i;
 for (i = 0; i < n; i++)
 array[i] = value;
}

void init()
{
 Init_MCU();
 InitializeTouchPanel();
 Delay_ms(1000);
 TFT_Fill_Screen(CL_WHITE);
 Calibrate();
 TFT_Fill_Screen(0);
 RCC_APB1ENR.TIM2EN = 1;
 TIM2_CR1.CEN = 0;

 TIM2_PSC = 80;
 TIM2_ARR = 65514;
 NVIC_IntEnable(IVT_INT_TIM2);
 TIM2_DIER.UIE = 1;

}

void draw_targets(unsigned char targets[])
{
 int i;
 int x;
 TFT_Set_Pen(0, 3);

 TFT_Set_Brush(1, CL_BLUE, 0, 0, 0, 0);

 TFT_Circle(targets[0] + targets[1], targets[2], TARGET_DIAMETER);

 TFT_Set_Brush(1, CL_GREEN, 0, 0, 0, 0);

 TFT_Circle(targets[3] + targets[4], targets[5], TARGET_DIAMETER);



 TFT_Set_Brush(1, 0, 0, 0, 0, 0);
 TFT_Circle(targets[6] + targets[7], targets[8], TARGET_DIAMETER);




}



void Timer2_interrupt() iv IVT_INT_TIM2
{




 USB_Polling_Proc();
 kk = HID_Read();
 if(kk != 0)
 {

 pressed_targets_index = 0;
 for (i = 0; i < 64; i++)
 niz[i] = readbuff[i];
 for (i = 0; i < 64; i++)
 writebuff[i] = pressed[i];
 HID_Write(&writebuff, 64);
 for (i = 0; i < 64; i++)
 pressed[i] = 0;

 }
 draw_targets(niz);
 TIM2_SR.UIF = 0;
}

void check_pressed()
{
 if (TP_TFT_Press_Detect())
 {
 if (TP_TFT_Get_Coordinates(&x_coord, &y_coord) == 0)
 {
 down = 1;
 }
 }


 else if (down == 1)
 {
 down = 0;
 if (x_coord > 255)
 {
 pressed[pressed_targets_index++] = 255;
 pressed[pressed_targets_index++] = (x_coord & 0x00FF);
 }
 else
 {
 pressed[pressed_targets_index++] = 0;
 pressed[pressed_targets_index++] = x_coord;
 }
 pressed[pressed_targets_index++] = y_coord;

 }
}

void main()
{
 init();
 HID_Enable(&readbuff, &writebuff);
 for (i = 0; i < 64; i++)
 niz[i] = 0;
 for (i = 0; i < 64; i++)
 writebuff[i] = 0;
 for (i = 0; i < 64; i++)
 readbuff[i] = 0;
 TIM2_CR1.CEN = 1;
 while(1)
 {
 check_pressed();
 }
}
