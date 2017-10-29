; ╔══════════════════════════════════════════════════════════╦═══════╗
; ║ ButtonIconGadget                                         ║ v N/A ║
; ╠══════════════════════════════════════════════════════════╩═══════╣
; ║                                                                  ║
; ║   ...                                                            ║
; ║                                                                  ║
; ╟──────────────────────────────────────────────────────────────────╢
; ║ Requirements: PB v4.41+ (As indicated by the original author)    ║
; ║               Also Work with PB v5.60+ without any modification  ║
; ╟──────────────────────────────────────────────────────────────────╢
; ║ Source: Trond on purebasic.fr                                    ║
; ║     http://www.purebasic.fr/english/viewtopic.php?f=12&t=41045   ║
; ╚══════════════════════════════════════════════════════════════════╝

Procedure ButtonIconGadget(x, y, w, h, Text.s, Icon, Flags=0)
	Static Border = 10
	Static Padding = 10
	
	Protected Font = GetGadgetFont(#PB_Default)
	Protected Image, G
	Protected iw, ih    ; label image height width
	Protected icx, icy	; icon x, y within label image
	Protected tw, th	; text height width
	Protected  tx, ty	; text x, y within label image
	Protected tcol = RGBA(0, 0, 0, 255)  ; text color
	
	; Calculate coordinates
	iw = ImageWidth(Icon) + Padding
	ih = ImageHeight(Icon)
	icx = 0
	icy = 0
	
	tx = iw
	
	StartDrawing(ImageOutput(Image))
	DrawingFont(Font)
	tw = TextWidth(Text)
	th = TextHeight("Wg")
	StopDrawing()
	If th > ih
		ih = th
		icy + (th-ih)/2
	EndIf
	iw + tw
	
	ty = ih/2-th/2
	
	; Create image
	Image = CreateImage(#PB_Any, iw, ih, 32)
	StartDrawing(ImageOutput(Image))
	DrawingMode(#PB_2DDrawing_AlphaChannel)
	Box(0, 0, iw, ih, RGBA(255, 255, 255, 0))
	DrawingMode(#PB_2DDrawing_AlphaBlend | #PB_2DDrawing_Transparent)
	DrawingFont(Font)
	DrawImage(ImageID(Icon), icx, icy)
	DrawText(tx, ty, Text, tcol)
	Box(25, 25, 25, 25, RGBA(255, 0, 0, 255))
	StopDrawing()
	
	G = ButtonImageGadget(#PB_Any, x, y, w, h, ImageID(Image), Flags)
	SetGadgetData(G, Image)
	ProcedureReturn G
EndProcedure

Procedure FreeButtonIcon(Button)
	FreeImage(GetGadgetData(Button))
EndProcedure

CompilerIf #PB_Compiler_IsMainFile
	Global bi, bj
	
	OpenWindow(0, 0, 0, 220, 130, "", #PB_Window_ScreenCentered | #PB_Window_SystemMenu | #PB_Window_SizeGadget | #PB_Window_MinimizeGadget | #PB_Window_MaximizeGadget)
	
	UsePNGImageDecoder()
	LoadImage(0, ".\icon_16.png")
	bi = ButtonIconGadget(10, 10, 120, 25, "I can do icon too", 0)
	bj = ButtonIconGadget(10, 50, 200, 70, "And large buttons too", 0)
	
	Repeat
		Select WaitWindowEvent()
			Case #PB_Event_Gadget
				DisableGadget(bi, 1)
			Case #PB_Event_CloseWindow
				Break
		EndSelect
	ForEver
CompilerEndIf

; IDE Options = PureBasic 5.60 (Windows - x86)
; CursorPosition = 13
; FirstLine = 3
; Folding = -
; EnableXP
; CompileSourceDirectory