local XInputDisconnect =
{
	background =
	{
		class = "static",
		left 	= 0,
		top 	= 0,
		width = 800,
		height= 600,
		zorder= 100,

		color = {	0, 0, 0, 200	},
	},

	template= 
	{
		class = "button",
		left 	= 280,
		top 	= 280,
		width = 400,
		height= 20,
		zorder= 110,
		text	= "Reconnect controller or press <enter> to continue",

		color = {	0, 0, 0, 0	},
		
		text_color 			= UIWhite,
		text_over_color	= { 255, 204, 48, 255 },
		text_down_color	= { 255, 204, 48, 255 },
	},
}

UI:MakeScreen(XInputDisconnect, "xinputdisconnect");