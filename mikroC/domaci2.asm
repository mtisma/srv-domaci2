_Init_ADC:
;domaci2.c,33 :: 		void Init_ADC() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;domaci2.c,34 :: 		ADC_Set_Input_Channel(_ADC_CHANNEL_8 | _ADC_CHANNEL_9);
MOVW	R0, #768
BL	_ADC_Set_Input_Channel+0
;domaci2.c,35 :: 		ADC1_Init();
BL	_ADC1_Init+0
;domaci2.c,36 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_Init_ADC0:
SUBS	R7, R7, #1
BNE	L_Init_ADC0
NOP
NOP
NOP
;domaci2.c,37 :: 		}
L_end_Init_ADC:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Init_ADC
domaci2_InitializeTouchPanel:
;domaci2.c,39 :: 		static void InitializeTouchPanel() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;domaci2.c,40 :: 		Init_ADC();
BL	_Init_ADC+0
;domaci2.c,41 :: 		TFT_Init_ILI9341_8bit(320, 240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init_ILI9341_8bit+0
;domaci2.c,43 :: 		TP_TFT_Init(320, 240, 8, 9);                 // Initialize touch panel
MOVS	R3, #9
MOVS	R2, #8
MOVS	R1, #240
MOVW	R0, #320
BL	_TP_TFT_Init+0
;domaci2.c,44 :: 		TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);     // Set touch panel ADC threshold
MOVW	R0, #3000
SXTH	R0, R0
BL	_TP_TFT_Set_ADC_Threshold+0
;domaci2.c,45 :: 		}
L_end_InitializeTouchPanel:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of domaci2_InitializeTouchPanel
_Init_MCU:
;domaci2.c,47 :: 		void Init_MCU(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;domaci2.c,48 :: 		GPIO_Config(&GPIOE_BASE, _GPIO_PINMASK_9, _GPIO_CFG_DIGITAL_OUTPUT);
MOVW	R2, #20
MOVT	R2, #8
MOVW	R1, #512
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Config+0
;domaci2.c,49 :: 		TFT_BLED = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;domaci2.c,50 :: 		TFT_Set_Default_Mode();
BL	_TFT_Set_Default_Mode+0
;domaci2.c,51 :: 		TP_TFT_Set_Default_Mode();
BL	_TP_TFT_Set_Default_Mode+0
;domaci2.c,52 :: 		}
L_end_Init_MCU:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Init_MCU
_Calibrate:
;domaci2.c,54 :: 		void Calibrate() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;domaci2.c,55 :: 		TFT_Set_Pen(CL_WHITE, 3);
MOVS	R1, #3
MOVW	R0, #65535
BL	_TFT_Set_Pen+0
;domaci2.c,56 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;domaci2.c,57 :: 		TFT_Write_Text("Touch selected corners for calibration", 50, 80);
MOVW	R0, #lo_addr(?lstr1_domaci2+0)
MOVT	R0, #hi_addr(?lstr1_domaci2+0)
MOVS	R2, #80
MOVS	R1, #50
BL	_TFT_Write_Text+0
;domaci2.c,58 :: 		TFT_Line(315, 239, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #239
SXTH	R1, R1
MOVW	R0, #315
SXTH	R0, R0
BL	_TFT_Line+0
;domaci2.c,59 :: 		TFT_Line(309, 229, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #229
SXTH	R1, R1
MOVW	R0, #309
SXTH	R0, R0
BL	_TFT_Line+0
;domaci2.c,60 :: 		TFT_Line(319, 234, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #234
SXTH	R1, R1
MOVW	R0, #319
SXTH	R0, R0
BL	_TFT_Line+0
;domaci2.c,61 :: 		TFT_Write_Text("first here",235,220);
MOVW	R0, #lo_addr(?lstr2_domaci2+0)
MOVT	R0, #hi_addr(?lstr2_domaci2+0)
MOVS	R2, #220
MOVS	R1, #235
BL	_TFT_Write_Text+0
;domaci2.c,63 :: 		TP_TFT_Calibrate_Min();                      // Calibration of bottom left corner
BL	_TP_TFT_Calibrate_Min+0
;domaci2.c,64 :: 		Delay_ms(500);
MOVW	R7, #36223
MOVT	R7, #91
NOP
NOP
L_Calibrate2:
SUBS	R7, R7, #1
BNE	L_Calibrate2
NOP
NOP
NOP
;domaci2.c,66 :: 		TFT_Set_Pen(CL_BLACK, 3);
MOVS	R1, #3
MOVW	R0, #0
BL	_TFT_Set_Pen+0
;domaci2.c,67 :: 		TFT_Set_Font(TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;domaci2.c,68 :: 		TFT_Line(315, 239, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #239
SXTH	R1, R1
MOVW	R0, #315
SXTH	R0, R0
BL	_TFT_Line+0
;domaci2.c,69 :: 		TFT_Line(309, 229, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #229
SXTH	R1, R1
MOVW	R0, #309
SXTH	R0, R0
BL	_TFT_Line+0
;domaci2.c,70 :: 		TFT_Line(319, 234, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #234
SXTH	R1, R1
MOVW	R0, #319
SXTH	R0, R0
BL	_TFT_Line+0
;domaci2.c,71 :: 		TFT_Write_Text("first here",235,220);
MOVW	R0, #lo_addr(?lstr3_domaci2+0)
MOVT	R0, #hi_addr(?lstr3_domaci2+0)
MOVS	R2, #220
MOVS	R1, #235
BL	_TFT_Write_Text+0
;domaci2.c,73 :: 		TFT_Set_Pen(CL_WHITE, 3);
MOVS	R1, #3
MOVW	R0, #65535
BL	_TFT_Set_Pen+0
;domaci2.c,74 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;domaci2.c,75 :: 		TFT_Write_Text("now here ", 20, 5);
MOVW	R0, #lo_addr(?lstr4_domaci2+0)
MOVT	R0, #hi_addr(?lstr4_domaci2+0)
MOVS	R2, #5
MOVS	R1, #20
BL	_TFT_Write_Text+0
;domaci2.c,76 :: 		TFT_Line(0, 0, 5, 0);
MOVS	R3, #0
SXTH	R3, R3
MOVS	R2, #5
SXTH	R2, R2
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #0
SXTH	R0, R0
BL	_TFT_Line+0
;domaci2.c,77 :: 		TFT_Line(0, 0, 0, 5);
MOVS	R3, #5
SXTH	R3, R3
MOVS	R2, #0
SXTH	R2, R2
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #0
SXTH	R0, R0
BL	_TFT_Line+0
;domaci2.c,78 :: 		TFT_Line(0, 0, 10, 10);
MOVS	R3, #10
SXTH	R3, R3
MOVS	R2, #10
SXTH	R2, R2
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #0
SXTH	R0, R0
BL	_TFT_Line+0
;domaci2.c,80 :: 		TP_TFT_Calibrate_Max();                      // Calibration of bottom left corner
BL	_TP_TFT_Calibrate_Max+0
;domaci2.c,81 :: 		Delay_ms(500);
MOVW	R7, #36223
MOVT	R7, #91
NOP
NOP
L_Calibrate4:
SUBS	R7, R7, #1
BNE	L_Calibrate4
NOP
NOP
NOP
;domaci2.c,82 :: 		}
L_end_Calibrate:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Calibrate
_fill_array:
;domaci2.c,84 :: 		void fill_array(unsigned char array[], int n, int value)
; value start address is: 8 (R2)
; n start address is: 4 (R1)
; array start address is: 0 (R0)
SUB	SP, SP, #4
; value end address is: 8 (R2)
; n end address is: 4 (R1)
; array end address is: 0 (R0)
; array start address is: 0 (R0)
; n start address is: 4 (R1)
; value start address is: 8 (R2)
;domaci2.c,87 :: 		for (i = 0; i < n; i++)
; i start address is: 16 (R4)
MOVS	R4, #0
SXTH	R4, R4
; array end address is: 0 (R0)
; value end address is: 8 (R2)
; n end address is: 4 (R1)
; i end address is: 16 (R4)
STRH	R2, [SP, #0]
MOV	R2, R0
LDRSH	R0, [SP, #0]
L_fill_array6:
; i start address is: 16 (R4)
; array start address is: 8 (R2)
; value start address is: 0 (R0)
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; n start address is: 4 (R1)
; array start address is: 8 (R2)
; array end address is: 8 (R2)
CMP	R4, R1
IT	GE
BGE	L_fill_array7
; value end address is: 0 (R0)
; array end address is: 8 (R2)
;domaci2.c,88 :: 		array[i] = value;
; array start address is: 8 (R2)
; value start address is: 0 (R0)
ADDS	R3, R2, R4
STRB	R0, [R3, #0]
;domaci2.c,87 :: 		for (i = 0; i < n; i++)
ADDS	R4, R4, #1
SXTH	R4, R4
;domaci2.c,88 :: 		array[i] = value;
; value end address is: 0 (R0)
; n end address is: 4 (R1)
; array end address is: 8 (R2)
; i end address is: 16 (R4)
IT	AL
BAL	L_fill_array6
L_fill_array7:
;domaci2.c,89 :: 		}
L_end_fill_array:
ADD	SP, SP, #4
BX	LR
; end of _fill_array
_init:
;domaci2.c,91 :: 		void init()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;domaci2.c,93 :: 		Init_MCU();
BL	_Init_MCU+0
;domaci2.c,94 :: 		InitializeTouchPanel();
BL	domaci2_InitializeTouchPanel+0
;domaci2.c,95 :: 		Delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_init9:
SUBS	R7, R7, #1
BNE	L_init9
NOP
NOP
NOP
;domaci2.c,96 :: 		TFT_Fill_Screen(CL_WHITE);
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;domaci2.c,97 :: 		Calibrate();
BL	_Calibrate+0
;domaci2.c,98 :: 		TFT_Fill_Screen(0);
MOVS	R0, #0
BL	_TFT_Fill_Screen+0
;domaci2.c,99 :: 		RCC_APB1ENR.TIM2EN = 1;       // Enable clock gating for timer module 2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;domaci2.c,100 :: 		TIM2_CR1.CEN = 0;             // Disable timer
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;domaci2.c,102 :: 		TIM2_PSC = 80;
MOVS	R1, #80
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;domaci2.c,103 :: 		TIM2_ARR = 65514;
MOVW	R1, #65514
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;domaci2.c,104 :: 		NVIC_IntEnable(IVT_INT_TIM2); // Enable timer interrupt
MOVW	R0, #44
BL	_NVIC_IntEnable+0
;domaci2.c,105 :: 		TIM2_DIER.UIE = 1;            // Update interrupt enable
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
STR	R1, [R0, #0]
;domaci2.c,107 :: 		}
L_end_init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init
_draw_targets:
;domaci2.c,109 :: 		void draw_targets(unsigned char targets[])
; targets start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; targets end address is: 0 (R0)
; targets start address is: 0 (R0)
;domaci2.c,113 :: 		TFT_Set_Pen(0, 3);
STR	R0, [SP, #4]
MOVS	R1, #3
MOVS	R0, #0
BL	_TFT_Set_Pen+0
;domaci2.c,115 :: 		TFT_Set_Brush(1, CL_BLUE, 0, 0, 0, 0);
MOVS	R2, #0
MOVS	R1, #0
PUSH	(R2)
PUSH	(R1)
MOVS	R3, #0
MOVS	R2, #0
MOVW	R1, #31
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
LDR	R0, [SP, #4]
;domaci2.c,117 :: 		TFT_Circle(targets[0] + targets[1], targets[2], TARGET_DIAMETER);
ADDS	R1, R0, #2
LDRB	R1, [R1, #0]
UXTB	R3, R1
LDRB	R2, [R0, #0]
ADDS	R1, R0, #1
LDRB	R1, [R1, #0]
ADDS	R1, R2, R1
STR	R0, [SP, #4]
MOVW	R2, #20
SXTH	R2, R2
SXTH	R0, R1
SXTH	R1, R3
BL	_TFT_Circle+0
;domaci2.c,119 :: 		TFT_Set_Brush(1, CL_GREEN, 0, 0, 0, 0);
MOVS	R2, #0
MOVS	R1, #0
PUSH	(R2)
PUSH	(R1)
MOVS	R3, #0
MOVS	R2, #0
MOVW	R1, #1024
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
LDR	R0, [SP, #4]
;domaci2.c,121 :: 		TFT_Circle(targets[3] + targets[4], targets[5], TARGET_DIAMETER);
ADDS	R1, R0, #5
LDRB	R1, [R1, #0]
UXTB	R3, R1
ADDS	R1, R0, #3
LDRB	R2, [R1, #0]
ADDS	R1, R0, #4
LDRB	R1, [R1, #0]
ADDS	R1, R2, R1
STR	R0, [SP, #4]
MOVW	R2, #20
SXTH	R2, R2
SXTH	R0, R1
SXTH	R1, R3
BL	_TFT_Circle+0
;domaci2.c,125 :: 		TFT_Set_Brush(1, 0, 0, 0, 0, 0);
MOVS	R2, #0
MOVS	R1, #0
PUSH	(R2)
PUSH	(R1)
MOVS	R3, #0
MOVS	R2, #0
MOVS	R1, #0
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
LDR	R0, [SP, #4]
;domaci2.c,126 :: 		TFT_Circle(targets[6] + targets[7], targets[8], TARGET_DIAMETER);
ADDW	R1, R0, #8
LDRB	R1, [R1, #0]
UXTB	R3, R1
ADDS	R1, R0, #6
LDRB	R2, [R1, #0]
ADDS	R1, R0, #7
; targets end address is: 0 (R0)
LDRB	R1, [R1, #0]
ADDS	R1, R2, R1
MOVW	R2, #20
SXTH	R2, R2
SXTH	R0, R1
SXTH	R1, R3
BL	_TFT_Circle+0
;domaci2.c,131 :: 		}
L_end_draw_targets:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _draw_targets
_Timer2_interrupt:
;domaci2.c,135 :: 		void Timer2_interrupt() iv IVT_INT_TIM2
SUB	SP, SP, #4
STR	LR, [SP, #0]
;domaci2.c,141 :: 		USB_Polling_Proc();
BL	_USB_Polling_Proc+0
;domaci2.c,142 :: 		kk = HID_Read();
BL	_HID_Read+0
MOVW	R1, #lo_addr(_kk+0)
MOVT	R1, #hi_addr(_kk+0)
STRH	R0, [R1, #0]
;domaci2.c,143 :: 		if(kk != 0)
MOV	R0, R1
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Timer2_interrupt11
;domaci2.c,146 :: 		pressed_targets_index = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_pressed_targets_index+0)
MOVT	R0, #hi_addr(_pressed_targets_index+0)
STRH	R1, [R0, #0]
;domaci2.c,147 :: 		for (i = 0; i < 64; i++)
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
STRH	R1, [R0, #0]
L_Timer2_interrupt12:
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDRSH	R0, [R0, #0]
CMP	R0, #64
IT	GE
BGE	L_Timer2_interrupt13
;domaci2.c,148 :: 		niz[i] = readbuff[i];
MOVW	R3, #lo_addr(_i+0)
MOVT	R3, #hi_addr(_i+0)
LDRSH	R1, [R3, #0]
MOVW	R0, #lo_addr(_niz+0)
MOVT	R0, #hi_addr(_niz+0)
ADDS	R2, R0, R1
MOV	R0, R3
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;domaci2.c,147 :: 		for (i = 0; i < 64; i++)
MOV	R0, R3
LDRSH	R0, [R0, #0]
ADDS	R0, R0, #1
STRH	R0, [R3, #0]
;domaci2.c,148 :: 		niz[i] = readbuff[i];
IT	AL
BAL	L_Timer2_interrupt12
L_Timer2_interrupt13:
;domaci2.c,149 :: 		for (i = 0; i < 64; i++)
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
STRH	R1, [R0, #0]
L_Timer2_interrupt15:
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDRSH	R0, [R0, #0]
CMP	R0, #64
IT	GE
BGE	L_Timer2_interrupt16
;domaci2.c,150 :: 		writebuff[i] = pressed[i];
MOVW	R3, #lo_addr(_i+0)
MOVT	R3, #hi_addr(_i+0)
LDRSH	R1, [R3, #0]
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
ADDS	R2, R0, R1
MOV	R0, R3
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_pressed+0)
MOVT	R0, #hi_addr(_pressed+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;domaci2.c,149 :: 		for (i = 0; i < 64; i++)
MOV	R0, R3
LDRSH	R0, [R0, #0]
ADDS	R0, R0, #1
STRH	R0, [R3, #0]
;domaci2.c,150 :: 		writebuff[i] = pressed[i];
IT	AL
BAL	L_Timer2_interrupt15
L_Timer2_interrupt16:
;domaci2.c,151 :: 		HID_Write(&writebuff, 64);
MOVS	R1, #64
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
BL	_HID_Write+0
;domaci2.c,152 :: 		for (i = 0; i < 64; i++)
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
STRH	R1, [R0, #0]
L_Timer2_interrupt18:
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDRSH	R0, [R0, #0]
CMP	R0, #64
IT	GE
BGE	L_Timer2_interrupt19
;domaci2.c,153 :: 		pressed[i] = 0;
MOVW	R2, #lo_addr(_i+0)
MOVT	R2, #hi_addr(_i+0)
LDRSH	R1, [R2, #0]
MOVW	R0, #lo_addr(_pressed+0)
MOVT	R0, #hi_addr(_pressed+0)
ADDS	R1, R0, R1
MOVS	R0, #0
STRB	R0, [R1, #0]
;domaci2.c,152 :: 		for (i = 0; i < 64; i++)
MOV	R0, R2
LDRSH	R0, [R0, #0]
ADDS	R0, R0, #1
STRH	R0, [R2, #0]
;domaci2.c,153 :: 		pressed[i] = 0;
IT	AL
BAL	L_Timer2_interrupt18
L_Timer2_interrupt19:
;domaci2.c,155 :: 		}
L_Timer2_interrupt11:
;domaci2.c,156 :: 		draw_targets(niz);
MOVW	R0, #lo_addr(_niz+0)
MOVT	R0, #hi_addr(_niz+0)
BL	_draw_targets+0
;domaci2.c,157 :: 		TIM2_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
STR	R1, [R0, #0]
;domaci2.c,158 :: 		}
L_end_Timer2_interrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Timer2_interrupt
_check_pressed:
;domaci2.c,160 :: 		void check_pressed()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;domaci2.c,162 :: 		if (TP_TFT_Press_Detect())
BL	_TP_TFT_Press_Detect+0
CMP	R0, #0
IT	EQ
BEQ	L_check_pressed21
;domaci2.c,164 :: 		if (TP_TFT_Get_Coordinates(&x_coord, &y_coord) == 0)
MOVW	R1, #lo_addr(_y_coord+0)
MOVT	R1, #hi_addr(_y_coord+0)
MOVW	R0, #lo_addr(_x_coord+0)
MOVT	R0, #hi_addr(_x_coord+0)
BL	_TP_TFT_Get_Coordinates+0
CMP	R0, #0
IT	NE
BNE	L_check_pressed22
;domaci2.c,166 :: 		down = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_down+0)
MOVT	R0, #hi_addr(_down+0)
STRH	R1, [R0, #0]
;domaci2.c,167 :: 		}
L_check_pressed22:
;domaci2.c,168 :: 		}
IT	AL
BAL	L_check_pressed23
L_check_pressed21:
;domaci2.c,171 :: 		else if (down == 1)
MOVW	R0, #lo_addr(_down+0)
MOVT	R0, #hi_addr(_down+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_check_pressed24
;domaci2.c,173 :: 		down = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_down+0)
MOVT	R0, #hi_addr(_down+0)
STRH	R1, [R0, #0]
;domaci2.c,174 :: 		if (x_coord > 255)
MOVW	R0, #lo_addr(_x_coord+0)
MOVT	R0, #hi_addr(_x_coord+0)
LDRH	R0, [R0, #0]
CMP	R0, #255
IT	LS
BLS	L_check_pressed25
;domaci2.c,176 :: 		pressed[pressed_targets_index++] = 255;
MOVW	R2, #lo_addr(_pressed_targets_index+0)
MOVT	R2, #hi_addr(_pressed_targets_index+0)
LDRSH	R1, [R2, #0]
MOVW	R0, #lo_addr(_pressed+0)
MOVT	R0, #hi_addr(_pressed+0)
ADDS	R1, R0, R1
MOVS	R0, #255
STRB	R0, [R1, #0]
MOV	R0, R2
LDRSH	R0, [R0, #0]
ADDS	R1, R0, #1
SXTH	R1, R1
STRH	R1, [R2, #0]
;domaci2.c,177 :: 		pressed[pressed_targets_index++] = (x_coord & 0x00FF);
MOVW	R0, #lo_addr(_pressed+0)
MOVT	R0, #hi_addr(_pressed+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(_x_coord+0)
MOVT	R0, #hi_addr(_x_coord+0)
LDRH	R0, [R0, #0]
AND	R0, R0, #255
STRB	R0, [R1, #0]
MOV	R0, R2
LDRSH	R0, [R0, #0]
ADDS	R0, R0, #1
STRH	R0, [R2, #0]
;domaci2.c,178 :: 		}
IT	AL
BAL	L_check_pressed26
L_check_pressed25:
;domaci2.c,181 :: 		pressed[pressed_targets_index++] = 0;
MOVW	R2, #lo_addr(_pressed_targets_index+0)
MOVT	R2, #hi_addr(_pressed_targets_index+0)
LDRSH	R1, [R2, #0]
MOVW	R0, #lo_addr(_pressed+0)
MOVT	R0, #hi_addr(_pressed+0)
ADDS	R1, R0, R1
MOVS	R0, #0
STRB	R0, [R1, #0]
MOV	R0, R2
LDRSH	R0, [R0, #0]
ADDS	R1, R0, #1
SXTH	R1, R1
STRH	R1, [R2, #0]
;domaci2.c,182 :: 		pressed[pressed_targets_index++] = x_coord;
MOVW	R0, #lo_addr(_pressed+0)
MOVT	R0, #hi_addr(_pressed+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(_x_coord+0)
MOVT	R0, #hi_addr(_x_coord+0)
LDRH	R0, [R0, #0]
STRB	R0, [R1, #0]
MOV	R0, R2
LDRSH	R0, [R0, #0]
ADDS	R0, R0, #1
STRH	R0, [R2, #0]
;domaci2.c,183 :: 		}
L_check_pressed26:
;domaci2.c,184 :: 		pressed[pressed_targets_index++] = y_coord;
MOVW	R2, #lo_addr(_pressed_targets_index+0)
MOVT	R2, #hi_addr(_pressed_targets_index+0)
LDRSH	R1, [R2, #0]
MOVW	R0, #lo_addr(_pressed+0)
MOVT	R0, #hi_addr(_pressed+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(_y_coord+0)
MOVT	R0, #hi_addr(_y_coord+0)
LDRH	R0, [R0, #0]
STRB	R0, [R1, #0]
MOV	R0, R2
LDRSH	R0, [R0, #0]
ADDS	R0, R0, #1
STRH	R0, [R2, #0]
;domaci2.c,186 :: 		}
L_check_pressed24:
L_check_pressed23:
;domaci2.c,187 :: 		}
L_end_check_pressed:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _check_pressed
_main:
;domaci2.c,189 :: 		void main()
;domaci2.c,191 :: 		init();
BL	_init+0
;domaci2.c,192 :: 		HID_Enable(&readbuff, &writebuff);
MOVW	R1, #lo_addr(_writebuff+0)
MOVT	R1, #hi_addr(_writebuff+0)
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
BL	_HID_Enable+0
;domaci2.c,193 :: 		for (i = 0; i < 64; i++)
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
STRH	R1, [R0, #0]
L_main27:
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDRSH	R0, [R0, #0]
CMP	R0, #64
IT	GE
BGE	L_main28
;domaci2.c,194 :: 		niz[i] = 0;
MOVW	R2, #lo_addr(_i+0)
MOVT	R2, #hi_addr(_i+0)
LDRSH	R1, [R2, #0]
MOVW	R0, #lo_addr(_niz+0)
MOVT	R0, #hi_addr(_niz+0)
ADDS	R1, R0, R1
MOVS	R0, #0
STRB	R0, [R1, #0]
;domaci2.c,193 :: 		for (i = 0; i < 64; i++)
MOV	R0, R2
LDRSH	R0, [R0, #0]
ADDS	R0, R0, #1
STRH	R0, [R2, #0]
;domaci2.c,194 :: 		niz[i] = 0;
IT	AL
BAL	L_main27
L_main28:
;domaci2.c,195 :: 		for (i = 0; i < 64; i++)
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
STRH	R1, [R0, #0]
L_main30:
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDRSH	R0, [R0, #0]
CMP	R0, #64
IT	GE
BGE	L_main31
;domaci2.c,196 :: 		writebuff[i] = 0;
MOVW	R2, #lo_addr(_i+0)
MOVT	R2, #hi_addr(_i+0)
LDRSH	R1, [R2, #0]
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
ADDS	R1, R0, R1
MOVS	R0, #0
STRB	R0, [R1, #0]
;domaci2.c,195 :: 		for (i = 0; i < 64; i++)
MOV	R0, R2
LDRSH	R0, [R0, #0]
ADDS	R0, R0, #1
STRH	R0, [R2, #0]
;domaci2.c,196 :: 		writebuff[i] = 0;
IT	AL
BAL	L_main30
L_main31:
;domaci2.c,197 :: 		for (i = 0; i < 64; i++)
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
STRH	R1, [R0, #0]
L_main33:
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDRSH	R0, [R0, #0]
CMP	R0, #64
IT	GE
BGE	L_main34
;domaci2.c,198 :: 		readbuff[i] = 0;
MOVW	R2, #lo_addr(_i+0)
MOVT	R2, #hi_addr(_i+0)
LDRSH	R1, [R2, #0]
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
ADDS	R1, R0, R1
MOVS	R0, #0
STRB	R0, [R1, #0]
;domaci2.c,197 :: 		for (i = 0; i < 64; i++)
MOV	R0, R2
LDRSH	R0, [R0, #0]
ADDS	R0, R0, #1
STRH	R0, [R2, #0]
;domaci2.c,198 :: 		readbuff[i] = 0;
IT	AL
BAL	L_main33
L_main34:
;domaci2.c,199 :: 		TIM2_CR1.CEN = 1;             // Enable timer
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;domaci2.c,200 :: 		while(1)
L_main36:
;domaci2.c,202 :: 		check_pressed();
BL	_check_pressed+0
;domaci2.c,203 :: 		}
IT	AL
BAL	L_main36
;domaci2.c,204 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
