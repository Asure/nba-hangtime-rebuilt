****************************************************************
*
* Owner:	JOHNSON
*
* Software:	Jeff Johnson/Jamie Rivett
* Initiated:	?
*
* Modified:	?
*
* COPYRIGHT (C) 1992 WILLIAMS ELECTRONICS GAMES, INC.
*
*.Last mod - 1/15/93 15:29
****************************************************************
	.file	"select2.asm"
	.title	"name & team selection"
	.width	132
	.option	b,d,l,t
	.mnolist

	.include	"mproc.equ"
	.include	"disp.equ"
	.include	"sys.equ"
	.include	"gsp.equ"
	.include	"game.equ"
	.include	"audit.equ"
	.include	"macros.hdr"
	.include	"world.equ"

	.include	"logos.tbl"
	.include	"names2.tbl"		;New names from pnames2.img
	.include	"names2.glo"		;New names from pnames2.img

	.include	"mugshot.glo"
	.include	"imgtbl.glo"
	.include	"imgtblp.glo"
	.include	"imgtbl2.glo"
	.include	"imgtbl7.glo"
	.include	"bgndtbl.glo"
	.include	"imgtblm.glo"
	.include	"bgndtbl7.glo"
	.include	"plyrnub.tbl"

	.include	"bbvda.tbl"


	.def	CUST6,CUST7,CUST8,CUST9,CUST10

	.def	T_HAWKS,GAINED_TXT

	.def	attrib_off
	.def	attrib_on
	.def	update_attribs

;!!AM moved to sss2.asm remember to def there!!
	.ref	team_sqaud_cnts
	.ref	city_names_str_tbl
	.ref	logos
	.ref	city_table_start
	.ref	city_table_end
	.ref	our_names			;table addr.
	.ref	our_heads			;table addrs.
	.ref	player_attribs			;table addr.
	.ref	name_sort
;DJT plyr_names_img_tbl removed to ATTRACT


************************************************************************

	.ref	kp_qscrs2,PCNT
	.ref	HALT

	.ref	OUR_MUG,TOB_MUG,JAS_MUG,QUI_MUG,BOO_MUG,MARTY_MUG,CARL_MUG
;DJT Start
	.ref	HEI_MUG,MAT_MUG
;DJT End


	.def	BALLBAK1

	.def	init_x,kit_x
	.def	nub_img_tbl

	.ref	kp_ram
	.ref	snd_play1
	.ref	tm2set,tm1set

	.ref	credit1_obj
	.ref	credit2_obj
	.ref	credit3_obj
	.ref	name1_obj
	.ref	name2_obj
	.ref	name3_obj
	.ref	name4_obj

	.ref	attrib1_obj
	.ref	attrib2_obj
	.ref	attrib3_obj
	.ref	attrib4_obj
	.ref	CRED_P
	.ref	teamset1_obj
	.ref	teamset2_obj
 	.ref	create_credits
	.ref	TWOPLAYERS			;0 = NO, 1 = YES 2 players
	.ref	concat_string
	.ref	copy_rom_string,concat_rom_string
	.ref	message_ascii,mess_space_width,mess_spacing
	.ref	mess_cursy,mess_objid
	.ref	mess_line_spacing
	.ref	CYCLE_TABLE,COLTAB2
	.ref	pal_getf
;	.ref	get_initials_string
	.ref	dropout_stats
	.ref	conttimers
	.ref	PSTATUS2
	.ref	GET_ADJ
	.ref	game_purchased
	.ref	GAMSTATE
	.ref	monitor_fullgame
	.ref	message_buffer
	.ref	pleasewt
	.ref	game_over
	.ref	credits
	.ref	KILBGND,KILALL
	.ref	print_string_C2
	.ref	cntrs_delay
	.ref	can_enter_inits
	.ref	winningteam
	.ref	newptr,newplyrs
	.ref	CR_CONTP
	.ref	team_control
	.ref	plyrsdropped
	.ref	P1DATA
	.ref	pal_clean
	.ref	qtr_purchased
	.ref	credit_messages
	.ref	monitor_buyins
	.ref	COLRTEMP
	.ref	gmqrtr
	.ref	_4plyrsingame,_2plyr_competitive

	.ref	do_scrn_transition
	.ref	un_wipe_horizontal,wipe_horizontal
	.ref	wipe_stack_vertical
	.ref	NO_CREATE_DEL_OBJS,CREATE_NO_DEL_OBJS

	.ref	fade_up,fade_down
	.ref	calc_num_defeated
	.ref	RNDRNG0,BAKMODS
	.ref	team2,team1
	.ref	switches_cur
	.ref	inmatchup
	.ref	player1_data
	.ref	dec_to_asc
	.ref	cntdown_snd
	.ref	pal_set
	.ref	player2_data
	.ref	create_logos
	.ref	call_matchup
	.ref	pal_find
	.ref	special_heads
	.ref	player3_data
	.ref	create_player_heads
	.ref	update_player_heads
	.ref	create_names
	.ref	dpageflip
	.ref	IRQSKYE
	.ref	PSTATUS
	.ref	player4_data
	.ref	switches_down
	.ref	print_string_C
	.ref	BGND_UD1
	.ref	obj_on
	.ref	force_selection
	.ref	obj_off
	.ref	scores
	.ref	WIPEOUT
	.ref	mess_cursx
	.ref	update_logos
	.ref	setup_message
	.ref	copy_string
;DJT Start
	.if	ANIM_VS
	.ref	animate_vs_logo
	.endif	;ANIM_VS
;DJT End
	.ref	get_name_string
	.ref	bast8_ascii
	.ref	plyr_get_combination
	.ref	set_plyrs_powerup_ram
	.ref	bast18_ascii,brush20_ascii
	.ref	bast10_ascii
	.ref	bounce_snd,tunegc_snd
	.ref	SOUNDSUP
	.ref	OVRTME,OVERW_P
	.ref	hide_ball_under_logo
	.ref	bast8t_ascii
	.ref	get_teams_pop,teams_pop
	.ref	kp_p1_crtplr,kp_p2_crtplr,kp_p3_crtplr,kp_p4_crtplr
	.ref	kp_p1_name1,kp_p1_name2,kp_p1_name3,kp_p1_name4
	.ref	kp_p1_name5,kp_p1_name6,kp_p1_hdnbr
	.ref	kp_p2_name1,kp_p2_name2,kp_p2_name3,kp_p2_name4
	.ref	kp_p2_name5,kp_p2_name6,kp_p2_hdnbr
	.ref	kp_p3_name1,kp_p3_name2,kp_p3_name3,kp_p3_name4
	.ref	kp_p3_name5,kp_p3_name6,kp_p3_hdnbr
	.ref	kp_p4_name1,kp_p4_name2,kp_p4_name3,kp_p4_name4
	.ref	kp_p4_name5,kp_p4_name6,kp_p4_hdnbr
	.ref	kp_team1,kp_scores,kp_team2
	.ref	mess_cursx2,kern_chars
	.ref	print_string2b,hangfnt38_ascii
	.ref	brush50_ascii,mess_justify
	.ref	message_palette
;DJT Start

	.ref	t1ispro
	.ref	t2ispro
;AM start
	.ref  bsd_stat_str
	.ref  matchup_mod
	.ref  bsd_stat_str_setup
	.ref  favored_by_str
	.ref  tm1_nme_str_setup
	.ref  tm2_cty_str_setup
	.ref  tonght_matchup_str
	.ref  tm1_cty_str_setup
	.ref  tnght_mat_str_setup
	.ref  tm2_nme_str_setup

;DJT Not .refs
;DJT End
************************************************************************


	.text




PNAME_W_P:
	.word	  4
	.word	02C0BH,07FFFH,05294H,00H

GAINED_P:
	.word	  4
	.word	00H,00H,07FFFH,07FE0H

IDIOTS_P:
	.word	  6
	.word	0318CH,00H,07FFFH,07FE0H,02B1FH,07C00H


********************************
*

MAX_CRTIME	equ	07fffH		;30*60
;TEAMSEL_PAGE	equ	0*256
;NAMENT_PAGE	equ	1*256

	.asg	05eH+5,x1
	.asg	0a1H+5,x1a
	.asg	0e4H+5,x2a
	.asg	0adH+5,x1b
	.asg	012f5H+2,y1
	.asg	0131fH,y1a


	.def	ladder_imgs0
	.def	ladder_imgs1,ladder_imgs2,ladder_imgs3,ladder_imgs4
	.def	ladder_imgs5,ladder_imgs6


ladder_imgs0
ladder_imgs1
ladder_imgs2
ladder_imgs3
ladder_imgs4
ladder_imgs5
ladder_imgs6
;2
;
;
;	.long	HPR_DAL,x1+400,y1
;	.long	JAC_DAL,x1,y1
;	.long	MAS_DAL,x2a,y1
;	.long	T_MAVS,x1b,y1a
;
;	.long	THM_DET,x1,y1-0b3H
;	.long	DUM_DET,x1a,y1-0b3H
;
;	.long	ELL_DET,x2a,y1-0b3H
;;	.long	HOR_HOU,x2a,y1-0b3H
;	.long	T_PISS,x1b,y1a-0b3H
;
;	.long	0
;
;ladder_imgs1
;;4
;	.long	BAK_MLW,x1,y1-0b3H*2-2
;	.long	EDW_MLW,x1a,y1-0b3H*2-2
;	.long	DAY_MLW,x2a,y1-0b3H*2-2
;	.long	T_BUCKS,x1b,y1a-0b3H*2-2
;
;	.long	GUG_WAS,x1,y1-0b3H*3-2
;	.long	ELL_WAS,x1a,y1-0b3H*3-2
;	.long	CHE_WAS,x2a,y1-0b3H*3-2
;	.long	T_BULTS,x1b,y1a-0b3H*3-2
;
;	.long	SIM_SAC,x1,y1-0b3H*4-4
;	.long	HUR_SAC,x1a,y1-0b3H*4-4
;	.long	RIC_SAC,x2a,y1-0b3H*4-4
;	.long	T_KINGS,x1b,y1a-0b3H*4-4
;
;	.long	LTN_MIN,x1,y1-0b3H*5-4
;	.long	PRS_MIN,x1a,y1-0b3H*5-4
;	.long	RID_MIN,x2a,y1-0b3H*5-4
;	.long	T_TWOLV,x1b,y1a-0b3H*5-4
;
;	.long	0
;
;ladder_imgs2
;;4
;	.long	PEE_LAK,x1,y1-0b3H*6-6
;	.long	DIV_LAK,x1a,y1-0b3H*6-6
;	.long	CAM_LAK,x2a,y1-0b3H*6-6
;	.long	T_LAKS,x1b,y1a-0b3H*6-6
;
;	.long	WLK_ATL,x1,y1-0b3H*7-6
;;	.long	MAN_CLP,x1,y1-0b3H*7-6
;	.long	HRP_CLP,x1a,y1-0b3H*7-6
;	.long	ROB_CLP,x2a,y1-0b3H*7-6
;	.long	T_CLIPS,x1b,y1a-0b3H*7-6
;
;	.long	MCD_BOS,x1,y1-0b3H*8-8
;	.long	BRO_BOS,x1a,y1-0b3H*8-8
;	.long	GAM_BOS,x2a,y1-0b3H*8-8
;	.long	T_CELTS,x1b,y1a-0b3H*8-8
;
;	.long	WEA_PHL,x1,y1-0b3H*9-8
;;	.long	BRA_PHL,x1a,y1-0b3H*9-8
;	.long	BRA_PHL,x2a,y1-0b3H*9-8
;	.long	HRN_PHL,x2a+400,y1-0b3H*9-8
;	.long	T_76RS,x1b,y1a-0b3H*9-8
;
;	.long	0
;
;ladder_imgs3
;;4
;	.long	MIL_IND,x1,y1-0b3H*10-10
;	.long	SMI_IND,x1a,y1-0b3H*10-10
;	.long	SEL_IND,x2a,y1-0b3H*10-10
;	.long	T_PACER,x1b,y1a-0b3H*10-10
;
;	.long	COL_NEJ,x1,y1-0b3H*11-10
;	.long	AND_NEJ,x1a,y1-0b3H*11-10
;	.long	MOR_NEJ,x2a,y1-0b3H*11-10
;	.long	T_NETS,x1b,y1a-0b3H*11-10
;
;	.long	PRC_CLE,x1,y1-0b3H*12-12
;	.long	DAU_CLE,x1a,y1-0b3H*12-12
;	.long	NAN_CLE,x2a,y1-0b3H*12-12
;	.long	T_CAVS,x1b,y1a-0b3H*12-12
;
;	.long	MUT_DEN,x1,y1-0b3H*13-12
;	.long	ELL_DEN,x1a,y1-0b3H*13-12
;	.long	ROG_DEN,x2a,y1-0b3H*13-12
;	.long	T_NUGS,x1b,y1a-0b3H*13-12
;
;	.long	0
;
;ladder_imgs4
;;4
;	.long	HRD_GLD,x1,y1-0b3H*14-14
;	.long	MUL_GLD,x1a,y1-0b3H*14-14
;	.long	WEB_GLD,x2a,y1-0b3H*14-14
;	.long	T_WARS,x1b,y1a-0b3H*14-14
;
;	.long	DRX_PRT,x1,y1-0b3H*15-14
;	.long	POR_PRT,x1a,y1-0b3H*15-14
;	.long	ROB_PRT,x2a,y1-0b3H*15-14
;	.long	T_BLAZ,x1b,y1a-0b3H*15-14
;
;	.long	RCE_MIA,x1,y1-0b3H*16-16
;	.long	SKL_MIA,x1a,y1-0b3H*16-16
;	.long	MIN_MIA,x2a,y1-0b3H*16-16
;	.long	T_HEAT,x1b,y1a-0b3H*16-16
;
;	.long	JON_CHA,x1,y1-0b3H*17-16
;	.long	HWK_CHA,x1a,y1-0b3H*17-16
;	.long	MOU_CHA,x2a,y1-0b3H*17-16
;	.long	T_HORS,x1b,y1a-0b3H*17-16
;
;	.long	0
;
;ladder_imgs5
;;4
;	.long	SKL_ORL,x1,y1-0b3H*18-18
;	.long	HAR_ORL,x1a,y1-0b3H*18-18
;	.long	AND_ORL,x2a,y1-0b3H*18-18
;	.long	T_MAGIC,x1b,y1a-0b3H*18-18
;
;	.long	ROB_SAN,x1,y1-0b3H*19-18
;	.long	ROD_SAN,x1a,y1-0b3H*19-18
;	.long	ELS_SAN,x2a,y1-0b3H*19-18
;	.long	T_SPURS,x1b,y1a-0b3H*19-18
;
;	.long	MLN_UTA,x1,y1-0b3H*20-20
;	.long	STK_UTA,x1a,y1-0b3H*20-20
;	.long	BEN_UTA,x2a,y1-0b3H*20-20
;	.long	T_JAZZ,x1b,y1a-0b3H*20-20
;
;	.long	EWG_NEY,x1,y1-0b3H*21-20
;	.long	MAS_NEY,x1a,y1-0b3H*21-20
;	.long	STA_NEY,x2a,y1-0b3H*21-20
;	.long	T_KNIKS,x1b,y1a-0b3H*21-20
;
;	.long	0
;
;ladder_imgs6
;;4
;	.long	MAN_CLP,x1,y1-0b3H*22-22
;;	.long	WLK_ATL,x1,y1-0b3H*22-22
;	.long	AUG_ATL,x1a,y1-0b3H*22-22
;	.long	WLS_ATL,x2a,y1-0b3H*22-22
;	.long	T_HAWKS,x1b,y1a-0b3H*22-22
;
;;	.long	BRK_PHX,x1,y1-0b3H*23-22
;;	.long	MAJ_PHX,x1,y1-0b3H*23-22
;	.long	MAJ_PHX,x1a,y1-0b3H*23-22
;	.long	JOH_PHX,x2a,y1-0b3H*23-22
;	.long	T_SUNS,x1b,y1a-0b3H*23-22
;
;	.long	OLA_HOU,x1,y1-0b3H*24-24
;	.long	MAX_HOU,x1a,y1-0b3H*24-24
;;	.long	ELL_DET,x2a,y1-0b3H
;;	.long	ELL_DET,x2a,y1-0b3H*24-24
;	.long	HOR_HOU,x2a,y1-0b3H*24-24
;	.long	T_ROCKS,x1b,y1a-0b3H*24-24
;
;	.long	KMP_SEA,x1,y1-0b3H*25-24
;	.long	PAY_SEA,x1a,y1-0b3H*25-24
;	.long	GIL_SEA,x2a,y1-0b3H*25-24
;	.long	T_SONICS,x1b,y1a-0b3H*25-24
;
;
;	.long	0


******************************************************************************
* a8  = sleep time
* a9  = palette to change
* a10 = * palette list
* a11 = * morf pal ram


START_PAL	equ	PDATA
CUR_PAL		equ	PDATA+20h
PAL_ADDR	equ	PDATA+40h
MORF_PAL	equ	PDATA+60h
SLEEP_TIME	equ	PDATA+80h

 SUBR	morf_pal


	move	a8,*a13(SLEEP_TIME)
	move	a10,*a13(START_PAL),L
	move	a10,*a13(CUR_PAL),L
	move	a11,*a13(MORF_PAL),L

wait1
	SLEEPK	1

	move	a9,a0
	calla	pal_find
	jrz	wait1
	srl	8,a0
	sll	8,a0
	move	a0,*a13(PAL_ADDR),L

	move	*a13(MORF_PAL),a1,L
	move	*a10,a2,L
	move	*a2+,a3		;num colours
loopa
	move	*a2+,*a1+
	dsj	a3,loopa

;	SLEEP	4
	move	*a13(SLEEP_TIME),a10
dly1
	SLEEPK	1
	dsj	a10,dly1
next_pal

	move	*a13(CUR_PAL),a10,L
	addi	20h,a10
	move	*a10,a0,L
	jrn	oka
	jrz	not_sleep

	move	a10,*a13(CUR_PAL),L
	move	a0,a10
	jruc	dly1

not_sleep
	move	*a13(START_PAL),a10,L
oka
	move	a10,*a13(CUR_PAL),L

again
;	SLEEP	2
	move	*a13(SLEEP_TIME),a10
	srl	1,a10
	jrnz	dly2
	movk	1,a10
dly2
	SLEEPK	1
	dsj	a10,dly2


	move	*a13(MORF_PAL),a1,L
	move	*a13(CUR_PAL),a10,L
	move	*a10,a2,L
	move	*a2+,a0			;num colours
	clr	a11
morfit
	move	*a1,a3			;CURRENT PALETTE
	movi	0111110000000000b,a4	;5 bits of red
	and	a3,a4
	movi	0000001111100000b,a5	;5 bits of green
	and	a3,a5
	movi	0000000000011111b,a6	;5 bits of blue
	and	a3,a6

	move	*a2+,a7			;DEST PALETTE
	movi	0111110000000000b,a8	;5 bits of red
	and	a7,a8
	movi	0000001111100000b,a9	;5 bits of green
	and	a7,a9
	movi	0000000000011111b,a10	;5 bits of blue
	and	a7,a10

	srl	10,a4
	srl	10,a8
	cmp	a4,a8			;a8-a4
	jreq	redok
	jrlt	decr
	inc	a11
	inc	a4
	jruc	redok
decr
	inc	a11
	dec	a4
redok
	sll	10,a4

	srl	5,a5
	srl	5,a9
	cmp	a5,a9
	jreq	greenok
	jrlt	decg
	inc	a11
	inc	a5
	jruc	greenok
decg
	inc	a11
	dec	a5
greenok
	sll	5,a5

	cmp	a6,a10
	jreq	blueok
	jrlt	decb
	inc	a11
	inc	a6
	jruc	blueok
decb
	inc	a11
	dec	a6
blueok

	or	a5,a4
	or	a6,a4
	move	a4,*a1+

	dsj	a0,morfit

	move	*a13(CUR_PAL),a0,L	;* palette list
	move	*a0,a0,L		;* palette
	move	*a0,a2			;num colours
	move	*a13(MORF_PAL),a0,L	;* palette
	move	*a13(PAL_ADDR),a1,L	;dest palette
	calla	pal_set

	move	a11,a11
	jrnz	again

	jruc	next_pal

	DIE


;	movi	GREENPAL,a0	;* palette
;	move	*a0+,a2		;num colours
;	move	a10,a1		;dest palette
;	calla	pal_set

******************************************************************************
*
* RETURN:	a0 = start button bits
*-----------------------------------------------------------------------------

 SUBR	get_all_starts_down

	clr	a1

	move	@PSTATUS2,a2

	btst	0,a2
	jrz	no_player1
	clr	a0			;player 1
	calla	get_start_down
	or	a0,a1
no_player1

	btst	1,a2
	jrz	no_player2
	movk	1,a0			;player 2
	calla	get_start_down
	or	a0,a1
no_player2

	btst	2,a2
	jrz	no_player3
	movk	2,a0			;player 3
	calla	get_start_down
	or	a0,a1
no_player3

	btst	3,a2
	jrz	no_player4
	movk	3,a0			;player 4
	calla	get_start_down
	or	a0,a1
no_player4

	move	a1,a0
	rets

******************************************************************************
*
* RETURN:	a0 = start bit
*-----------------------------------------------------------------------------

 SUBR	get_start_down

	sll	4,a0			;x 16 bits
	addi	start_offs,a0
	move	*a0,a0
	addi	switches_down,a0
	move	*a0,a0
	andi	1,a0
	rets


	.if	TUNIT
start_offs	.word	12h,15h,19h,1ah
	.else
start_offs	.word	12h,15h,17h,27h
	.endif

******************************************************************************
* RETURN:	a0 = start bit
*-----------------------------------------------------------------------------
 SUBR	get_start_cur

	sll	4,a0			;x 16 bits
	addi	start_offs,a0
	move	*a0,a0
	addi	switches_cur,a0
	move	*a0,a0
	andi	1,a0
	rets

******************************************************************************

 SUBR	get_team1_turbo

	clr	a1

	move	@PSTATUS2,a2

	btst	0,a2
	jrz	no_player1a
	clr	a0			;player 1
	calla	get_turbo_down
	or	a0,a1
no_player1a

	btst	1,a2
	jrz	no_player2a
	movk	1,a0			;player 2
	calla	get_turbo_down
	or	a0,a1
no_player2a
	move	a1,a0

	rets

******************************************************************************
 SUBR	get_team2_turbo

	clr	a1

	move	@PSTATUS2,a2

	btst	2,a2
	jrz	no_player1b
	movk	2,a0			;player 3
	calla	get_turbo_down
	or	a0,a1
no_player1b

	btst	3,a2
	jrz	no_player2b
	movk	3,a0			;player 4
	calla	get_turbo_down
	or	a0,a1
no_player2b
	move	a1,a0

	rets

******************************************************************************
* RETURN:	a0 = start bit
*-----------------------------------------------------------------------------
 SUBR	get_turbo_down

	sll	4,a0			;x 16 bits
	addi	turbo_offs,a0
	move	*a0,a0
	addi	switches_down,a0
	move	*a0,a0
	andi	1,a0
	rets


	.if	TUNIT
turbo_offs	.word	06h,0eh,26h,2eh
	.else
turbo_offs	.word	12h,15h,17h,27h
	.endif

******************************************************************************
* RETURN:	a0 = joy switch bits
*-----------------------------------------------------------------------------
  SUBR	get_all_sticks_cur

	clr	a1

	move	@PSTATUS2,a2

	btst	0,a2
	jrz	no_player1c
	clr	a0			;player 1
	calla	get_stick_val_cur
	or	a0,a1
no_player1c

	btst	1,a2
	jrz	no_player2c
	movk	1,a0			;player 2
	calla	get_stick_val_cur
	or	a0,a1
no_player2c

	btst	2,a2
	jrz	no_player3c
	movk	2,a0			;player 3
	calla	get_stick_val_cur
	or	a0,a1
no_player3c

	btst	3,a2
	jrz	no_player4c
	movk	3,a0			;player 4
	calla	get_stick_val_cur
	or	a0,a1
no_player4c

	move	a1,a0
	rets


******************************************************************************
* RETURN:	a0 = joy switch bits
*-----------------------------------------------------------------------------
  SUBR	get_all_sticks_cur2

	clr	a1

	clr	a0			;player 1
	calla	get_stick_val_cur
	or	a0,a1

	movk	1,a0			;player 2
	calla	get_stick_val_cur
	or	a0,a1

	movk	2,a0			;player 3
	calla	get_stick_val_cur
	or	a0,a1

	movk	3,a0			;player 4
	calla	get_stick_val_cur
	or	a0,a1

	move	a1,a0
	rets


******************************************************************************
* INPUT:	a0 = player number (0-3)
*-----------------------------------------------------------------------------
* RETURN:	a0 = joy switch bits
*-----------------------------------------------------------------------------
;DJT Start
  SUBR	get_stick_val_cur_mkplr

	PUSH	a0
	move	@GAMSTATE,a0
	subk	INAMODE,a0
	mmfm	sp,a0
	jrnz	get_stick_val_cur
	.ref	stick_amode_mkplr
	move	@stick_amode_mkplr,a0
	andi	01111b,a0
	rets

;DJT End
  SUBR	get_stick_val_cur


	sll	4,a0			;x 16 bits
	addi	joy_offs,a0
	move	*a0,a0
	addi	switches_cur,a0
	move	*a0,a0
	andi	01111b,a0
	rets


******************************************************************************
* RETURN:	a0 = joy switch bits
*-----------------------------------------------------------------------------
  SUBR	get_all_sticks_down

	clr	a1

	move	@PSTATUS2,a2

	btst	0,a2
	jrz	no_player1d
	clr	a0			;player 1
	calla	get_stick_val_down
	or	a0,a1
no_player1d

	btst	1,a2
	jrz	no_player2d
	movk	1,a0			;player 2
	calla	get_stick_val_down
	or	a0,a1
no_player2d

	btst	2,a2
	jrz	no_player3d
	movk	2,a0			;player 3
	calla	get_stick_val_down
	or	a0,a1
no_player3d

	btst	3,a2
	jrz	no_player4d
	movk	3,a0			;player 4
	calla	get_stick_val_down
	or	a0,a1
no_player4d

	move	a1,a0
	rets


******************************************************************************
* RETURN:	a0 = joy switch bits
*-----------------------------------------------------------------------------
  SUBR	get_all_sticks_down2

	clr	a1

	clr	a0			;player 1
	calla	get_stick_val_down
	or	a0,a1

	movk	1,a0
	calla	get_stick_val_down
	or	a0,a1

	movk	2,a0
	calla	get_stick_val_down
	or	a0,a1

	movk	3,a0
	calla	get_stick_val_down
	or	a0,a1
	move	a1,a0

	rets


******************************************************************************
* INPUT:	a0 = player number (0-3)
*-----------------------------------------------------------------------------
* RETURN:	a0 = joy switch bits
*-----------------------------------------------------------------------------
;DJT Start
  SUBR	get_stick_val_down_mkplr

	PUSH	a0
	move	@GAMSTATE,a0
	subk	INAMODE,a0
	mmfm	sp,a0
	jrnz	get_stick_val_down
	move	@stick_amode_mkplr,a0
	andi	01111b,a0
	rets

;DJT End
  SUBR	get_stick_val_down

	sll	4,a0			;x 16 bits
	addi	joy_offs,a0
	move	*a0,a0
	addi	switches_down,a0
	move	*a0,a0
	andi	01111b,a0
	rets

joy_offs	.word	00h,08h,20h,28h

******************************************************************************
* RETURN:	a0 = joy switch bits
*-----------------------------------------------------------------------------
  SUBR	get_all_buttons_cur

	clr	a1

	move	@PSTATUS2,a2

	btst	0,a2
	jrz	no_player1e
	clr	a0			;player 1
	calla	get_but_val_cur
	or	a0,a1
no_player1e

	btst	1,a2
	jrz	no_player2e
	movk	1,a0			;player 2
	calla	get_but_val_cur
	or	a0,a1
no_player2e

	btst	2,a2
	jrz	no_player3e
	movk	2,a0			;player 3
	calla	get_but_val_cur
	or	a0,a1
no_player3e

	btst	3,a2
	jrz	no_player4e
	movk	3,a0			;player 4
	calla	get_but_val_cur
	or	a0,a1
no_player4e

	move	a1,a0
	rets


******************************************************************************
* RETURN:	a0 = joy switch bits
*-----------------------------------------------------------------------------
  SUBR	get_all_buttons_cur2

	clr	a1
	clr	a0			;player 1
	calla	get_but_val_cur
	or	a0,a1
	movk	1,a0			;player 2
	calla	get_but_val_cur
	or	a0,a1
	movk	2,a0			;player 3
	calla	get_but_val_cur
	or	a0,a1
	movk	3,a0			;player 4
	calla	get_but_val_cur
	or	a0,a1
	move	a1,a0
	rets


******************************************************************************
* INPUT:	a0 = player number (0-3)
*-----------------------------------------------------------------------------
* RETURN:	a0 = button bits
*-----------------------------------------------------------------------------
;DJT Start
  SUBR	get_but_val_cur_mkplr

	PUSH	a0
	move	@GAMSTATE,a0
	subk	INAMODE,a0
	mmfm	sp,a0
	jrnz	get_but_val_cur
	move	@stick_amode_mkplr,a0
	srl	4,a0
	andi	0111b,a0
	rets

;DJT End
 SUBR	get_but_val_cur

	sll	4,a0			;x 16 bits
	addi	but_offs,a0
	move	*a0,a0
	addi	switches_cur,a0
	move	*a0,a0
	andi	0111b,a0
	rets

******************************************************************************
* RETURN:	a0 = joy switch bits
*-----------------------------------------------------------------------------
 SUBR	get_all_buttons_down

	clr	a1

	move	@PSTATUS2,a2

	btst	0,a2
	jrz	no_player1f
	clr	a0			;player 1
	calla	get_but_val_down
	or	a0,a1
no_player1f

	btst	1,a2
	jrz	no_player2f
	movk	1,a0			;player 2
	calla	get_but_val_down
	or	a0,a1
no_player2f

	btst	2,a2
	jrz	no_player3f
	movk	2,a0			;player 3
	calla	get_but_val_down
	or	a0,a1
no_player3f

	btst	3,a2
	jrz	no_player4f
	movk	3,a0			;player 4
	calla	get_but_val_down
	or	a0,a1
no_player4f

	move	a1,a0
	rets


******************************************************************************
* RETURN:	a0 = joy switch bits
*-----------------------------------------------------------------------------
 SUBR	get_all_buttons_down2

	clr	a1
	clr	a0			;player 1
	calla	get_but_val_down
	or	a0,a1
	movk	1,a0			;player 2
	calla	get_but_val_down
	or	a0,a1
	movk	2,a0			;player 3
	calla	get_but_val_down
	or	a0,a1
	movk	3,a0			;player 4
	calla	get_but_val_down
	or	a0,a1
	move	a1,a0
	rets


******************************************************************************
* INPUT:	a0 = player number (0-3)
*-----------------------------------------------------------------------------
* RETURN:	a0 = button bits
*-----------------------------------------------------------------------------
;DJT Start
  SUBR	get_but_val_down_mkplr

	PUSH	a0
	move	@GAMSTATE,a0
	subk	INAMODE,a0
	mmfm	sp,a0
	jrnz	get_but_val_down
	move	@stick_amode_mkplr,a0
	srl	4,a0
	andi	0111b,a0
	rets

;DJT End
 SUBR	get_but_val_down

	sll	4,a0			;x 16 bits
	addi	but_offs,a0
	move	*a0,a0
	addi	switches_down,a0
	move	*a0,a0
	andi	0111b,a0
	rets

	.if	TUNIT
but_offs	.word	04h,0ch,24h,2ch
	.else
but_offs	.word	04h,0ch,1ch,24h
	.endif

******************************************************************************
* INPUT:	a0 = player number (0-3)
*-----------------------------------------------------------------------------
* RETURN:	a0 = button bits
*-----------------------------------------------------------------------------
 SUBR	get_but_val_down_nt		;masks out turbo button

	sll	4,a0			;x 16 bits
	addi	but_offs,a0
	move	*a0,a0
	addi	switches_down,a0
	move	*a0,a0
;	andi	011b,a0			;mask out turbo
	andi	01b,a0			;mask out turbo and pass
	rets

******************************************************************************
* INPUT:	a0 = player number (0-3)
*-----------------------------------------------------------------------------
* RETURN:	a0 = button bits
*-----------------------------------------------------------------------------
 SUBR	get_steal_but_cur

	sll	4,a0			;x 16 bits
	addi	but_offs,a0
	move	*a0,a0
	addi	switches_cur,a0
	move	*a0,a0
	andi	010b,a0			;mask out turbo & shoot
	rets

******************************************************************************
* INPUT:	a0 = player number (0-3)
*-----------------------------------------------------------------------------
* RETURN:	a0 = button bits
*-----------------------------------------------------------------------------
 SUBR	get_block_but_cur

	sll	4,a0			;x 16 bits
	addi	but_offs,a0
	move	*a0,a0
	addi	switches_cur,a0
	move	*a0,a0
	andi	01b,a0			;mask out turbo and pass
	rets

******************************************************************************

	.asg	330,X1		;89,X1
	.asg	330,X2		;307,X2
	.asg	207,Y
	.asg	217,Y2

 SUBR	result_screen

	move	@kp_scores,a0,L
	move	a0,@scores,L
	move	@scores,a0
	move	@scores+16,a14
	add	a0,a14
	cmpi	20,a14
	jrlt	xb ;!!AM!! not sure if xb or something else. xb was closest to j to.

	move	@kp_team1,a0
	move	a0,@team1
	move	@kp_team2,a0
	move	a0,@team2

	move	@kp_p1_crtplr,a14
	move	a14,@player1_data+PR_CREATED_PLYR
	move	@kp_p1_name1,a14
	move	a14,@player1_data+PR_NAME1
	move	@kp_p1_name2,a14
	move	a14,@player1_data+PR_NAME2
	move	@kp_p1_name3,a14
	move	a14,@player1_data+PR_NAME3
	move	@kp_p1_name4,a14
	move	a14,@player1_data+PR_NAME4
	move	@kp_p1_name5,a14
	move	a14,@player1_data+PR_NAME5
	move	@kp_p1_name6,a14
	move	a14,@player1_data+PR_NAME6
	move	@kp_p1_hdnbr,a14
	move	a14,@player1_data+PR_HEAD_NBR

	move	@kp_p2_crtplr,a14
	move	a14,@player2_data+PR_CREATED_PLYR
	move	@kp_p2_name1,a14
	move	a14,@player2_data+PR_NAME1
	move	@kp_p2_name2,a14
	move	a14,@player2_data+PR_NAME2
	move	@kp_p2_name3,a14
	move	a14,@player2_data+PR_NAME3
	move	@kp_p2_name4,a14
	move	a14,@player2_data+PR_NAME4
	move	@kp_p2_name5,a14
	move	a14,@player2_data+PR_NAME5
	move	@kp_p2_name6,a14
	move	a14,@player2_data+PR_NAME6
	move	@kp_p2_hdnbr,a14
	move	a14,@player2_data+PR_HEAD_NBR

	move	@kp_p3_crtplr,a14
	move	a14,@player3_data+PR_CREATED_PLYR
	move	@kp_p3_name1,a14
	move	a14,@player3_data+PR_NAME1
	move	@kp_p3_name2,a14
	move	a14,@player3_data+PR_NAME2
	move	@kp_p3_name3,a14
	move	a14,@player3_data+PR_NAME3
	move	@kp_p3_name4,a14
	move	a14,@player3_data+PR_NAME4
	move	@kp_p3_name5,a14
	move	a14,@player3_data+PR_NAME5
	move	@kp_p3_name6,a14
	move	a14,@player3_data+PR_NAME6
	move	@kp_p3_hdnbr,a14
	move	a14,@player3_data+PR_HEAD_NBR

	move	@kp_p4_crtplr,a14
	move	a14,@player4_data+PR_CREATED_PLYR
	move	@kp_p4_name1,a14
	move	a14,@player4_data+PR_NAME1
	move	@kp_p4_name2,a14
	move	a14,@player4_data+PR_NAME2
	move	@kp_p4_name3,a14
	move	a14,@player4_data+PR_NAME3
	move	@kp_p4_name4,a14
	move	a14,@player4_data+PR_NAME4
	move	@kp_p4_name5,a14
	move	a14,@player4_data+PR_NAME5
	move	@kp_p4_name6,a14
	move	a14,@player4_data+PR_NAME6
	move	@kp_p4_hdnbr,a14
	move	a14,@player4_data+PR_HEAD_NBR

	calla	display_blank
	calla	WIPEOUT			;CLEAN SYSTEM OUT

	movk	1,a0			;page flipping on
	move	a0,@dpageflip

	clr	a0
	move	a0,@IRQSKYE		;background color

	movi	SCRNEND,a0		;[256,405]
	move	a0,@SCRNLR,L

	clr	a0
	move	a0,@WORLDTLX,L
	move	a0,@WORLDTLY,L

	SLEEPK	2

	movi	result_mod,a0
	move	a0,@BAKMODS,L
	calla	BGND_UD1

;	clr	a10
;	movk	16,a11
;	CREATE0	fade_up

	movi	finalres_str_setup,a2
	calla	setup_message
	movi	finalres_str,a4,L
	calla	print_string_C2

	movk	3,a0
	calla	create_player_heads
	movk	3,a0
	calla	create_logos

	movi	170,a1	
	calla	create_names

	calla	update_logos
	calla	update_player_heads

	movi	name_setupa,a2
	calla	setup_message

	movi	170,a0
	move	a0,@mess_cursy

	movi	player1_data+PR_NAME1,a4
	move	@player1_data+PR_CREATED_PLYR,a14
	jrle	nxt
	movi	message_buffer,a3		;* string dest
	calla	get_name_string
	movi	56,a0
	move	a0,@mess_cursx
	calla	print_string_C
nxt	
	movi	player2_data+PR_NAME1,a4
	move	@player2_data+PR_CREATED_PLYR,a14
	jrle	nxt2
	movi	message_buffer,a3		;* string dest
	calla	get_name_string
	movi	147,a0
	move	a0,@mess_cursx
	calla	print_string_C
nxt2
	movi	player3_data+PR_NAME1,a4
	move	@player3_data+PR_CREATED_PLYR,a14
	jrle	nxt3
	movi	message_buffer,a3		;* string dest
	calla	get_name_string
	movi	251,a0
	move	a0,@mess_cursx
	calla	print_string_C
nxt3
	movi	player4_data+PR_NAME1,a4
	move	@player4_data+PR_CREATED_PLYR,a14
	jrle	nxt4
	movi	message_buffer,a3		;* string dest
	calla	get_name_string
	movi	342,a0
	move	a0,@mess_cursx
	calla	print_string_C
nxt4
;	calla	hide_ball_under_logo

	movk	1,a10
	callr	create_player_nubs

	CREATE0	final_scores

	movk	1,a0
	move	a0,@DISPLAYON

	SLEEPK	2
	calla	display_unblank

	SLEEP	1*TSEC

	movi	12*TSEC,a10
lpa	SLEEPK	1
	calla	get_all_buttons_cur2
	jrz	    nob
	SOUND1	bounce_snd
	jruc	xb
nob	
	dsj	    a10,lpa
xb
	clr	    a10
	movk	16,a11
	CREATE0	fade_down

	SLEEPK	24

	clr	a14
	move	a14,@player1_data+PR_CREATED_PLYR	;stop plyr from being
	move	a14,@player2_data+PR_CREATED_PLYR	;seen in amode
	move	a14,@player3_data+PR_CREATED_PLYR
	move	a14,@player4_data+PR_CREATED_PLYR

xc
	RETP


name_setupa
	PRINT_STR	bast8t_ascii,8,1,200,4,BAST_W_P,0


finalres_str_setup
	PRINT_STR	brush20_ascii,10,0,200,7,BRSHGYOP,0

finalres_str
	.string	"FINAL RESULTS",0
	.even


result_mod
	.long	finalresBMOD
	.word	0,0
	.long	0


******************************************************************************
* 	This routine creates the player number graphic (nub)
*
* INPUT: 
*        reg a10 - X pos. table nbr.
******************************************************************************
 SUBR	create_player_nubs

	PUSH	a9
	movi	3500,a3			;z pos
	movi	DMAWNZ|M_NOCOLL,a4
	clr	a5			;object ID
	clr	a6			;x vel
	clr	a7			;y vel

	sll	5,a10
	addi	scr_x_tbl_ptrs,a10
	move	*a10,a10,L

	movi	nub_img_tbl,a9,L
	move	@TWOPLAYERS,a14		;0 = NO, 1 = YES 2 players
	jrz	nkit
	movi	nub_img_kit_tbl,a9,L
nkit
	move	*a10+,a0,W		;get X pos.
	sll	16,a0
	move	*a10+,a1,W		;get Y pos.
	sll	16,a1
	move	*a9+,a2,L
	calla	BEGINOBJ2

	move	*a10+,a0,W		;get X pos.
	sll	16,a0
	move	*a10+,a1,W		;get X pos.
	sll	16,a1
	move	*a9+,a2,L
	calla	BEGINOBJ2

	move	*a10+,a0,W		;get X pos.
	sll	16,a0
	move	*a10+,a1,W		;get X pos.
	sll	16,a1
	move	*a9+,a2,L
	calla	BEGINOBJ2

	move	*a10+,a0,W		;get X pos.
	sll	16,a0
	move	*a10,a1,W		;get X pos.
	sll	16,a1
	move	*a9,a2,L
	calla	BEGINOBJ2
	PULL	a9
	rets


nub_img_tbl
	.long	PLYRNUB1
	.long	PLYRNUB2
	.long	PLYRNUB3
	.long	PLYRNUB4

nub_img_kit_tbl
	.long	PLYRNUB1
	.long	PLYRNUB1
	.long	PLYRNUB2
	.long	PLYRNUB2


scr_x_tbl_ptrs
	.long	stat_x_tbl,result_x_tbl
	

;stat screen
stat_x_tbl
	.word	13,103		;plyr 1
	.word	179,103		;plyr 2
	.word	208,103		;plyr 3
	.word	374,103		;plyr 4

;final result screen
result_x_tbl
	.word	12,168
	.word	178,168
	.word	208,168
	.word	374,168


******************************************************************************

	.if	0

 SUBRP	score_shadow

SHAD1	equ	PDATA
SHAD2	equ	SHAD1+20h

	.asg	40,X1
	.asg	257,X2
	.asg	205,Y

	movi	[X1,0],a0		;x val
	movi	[Y,0],a1		;y val
	movi	scorshad1,a2		;* image
	movi	300,a3			;z pos
	movi	DMAWNZ,a4		;DMA flags
	clr	a5			;object ID
	clr	a6			;x vel
	clr	a7			;y vel
	calla	BEGINOBJ
	move	a8,*a13(SHAD1),L

	movi	[X2,0],a0		;x val
	movi	[Y,0],a1		;y val
	movi	scorshad1,a2		;* image
	movi	300,a3			;z pos
	movi	DMAWNZ,a4		;DMA flags
	clr	a5			;object ID
	clr	a6			;x vel
	clr	a7			;y vel
	calla	BEGINOBJ
	move	a8,*a13(SHAD2),L

	clr	a10
big_mac
	SLEEPK	1
	xori	1,a10

	move	a10,a0
	sll	5,a0			;x 32 bits
	addi	shadows,a0
	move	*a0,a11,L		;* image

	move	*a13(SHAD1),a8,L
	calla	change_shad
	move	*a13(SHAD2),a8,L
	calla	change_shad

	jruc	big_mac

change_shad
	move	a11,a0
	move	*a8(OCTRL),a1		;DMA flags
	calla	obj_aniq		;change object image
	rets


shadows

	.long	scorshad1,scorshad2

	.endif

******************************************************************************
*   Print the final scores
******************************************************************************
 SUBRP	final_scores

	.asg	21,X1
	.asg	364,XF
	.asg	206,Y1
	.asg	227,Y2
	.asg	118,QTR1_X
	.asg	153,QTR2_X
	.asg	187,QTR3_X
	.asg	221,QTR4_X
	.asg	255,OT1_X
	.asg	289,OT2_X
	.asg	323,OT3_X

;
; Print team 1 city name
;
	movi	[X1,0],a0		;x val
	movi	[Y1,0],a1		;y val
	move	@team1,a2
	move	a2,a14
	sll	4,a14				;word length
	sll	5,a2				;LONG length
	add	a14,a2
	addi	city_table_start,a2
	move	*a2,a2,L
	movi	300,a3			;z pos
	movi	DMAWNZ|M_SCRNREL,a4		;DMA flags
	clr	a5			;object ID
	clr	a6			;x vel
	clr	a7			;y vel
	movi	BAST_W_P,b0,L
	calla	BEGINOBJP2		;plot CITY NAME
;
; Print team 2 city name
;
	movi	[X1,0],a0		;x val
	movi	[Y2,0],a1		;y val
	move	@team2,a2
	move	a2,a14
	sll	4,a14				;word length
	sll	5,a2				;LONG length
	add	a14,a2
	addi	city_table_start,a2
	move	*a2,a2,L
	movi	BAST_W_P,b0,L
	calla	BEGINOBJP2		;plot TEAM2 CITY NAME
;
; Print team scores, quarter by quarter
;
	movi	score_setup,a2
	calla	setup_message
	move	@scores,a0
	movi	999,a1			;max value
	calla	dec_to_asc
	calla	copy_string
	calla	print_string_C

	move	@scores+10h,a0
	movi	999,a1			;max value
	calla	dec_to_asc
	calla	copy_string
	movi	Y2-1,a0
	move	a0,@mess_cursy
	calla	print_string_C

;Print 1st quarter

	move	@kp_qscrs2,a0
	movi	999,a1			;max value
	calla	dec_to_asc
	calla	copy_string
	movi	QTR1_X,a0
	move	a0,@mess_cursx
	movi	Y1-1,a0
	move	a0,@mess_cursy
	calla	print_string_C

	move	@kp_qscrs2+16,a0
	movi	999,a1			;max value
	calla	dec_to_asc
	calla	copy_string
	movi	QTR1_X,a0
	move	a0,@mess_cursx
	movi	Y2-1,a0
	move	a0,@mess_cursy
	calla	print_string_C

;Print 2nd quarter

	move	@kp_qscrs2+32,a0
	movi	999,a1			;max value
	calla	dec_to_asc
	calla	copy_string
	movi	QTR2_X,a0
	move	a0,@mess_cursx
	movi	Y1-1,a0
	move	a0,@mess_cursy
	calla	print_string_C

	move	@kp_qscrs2+48,a0
	movi	999,a1			;max value
	calla	dec_to_asc
	calla	copy_string
	movi	QTR2_X,a0
	move	a0,@mess_cursx
	movi	Y2-1,a0
	move	a0,@mess_cursy
	calla	print_string_C

;Print 3rd quarter

	move	@kp_qscrs2+64,a0
	movi	999,a1			;max value
	calla	dec_to_asc
	calla	copy_string
	movi	QTR3_X,a0
	move	a0,@mess_cursx
	movi	Y1-1,a0
	move	a0,@mess_cursy
	calla	print_string_C

	move	@kp_qscrs2+80,a0
	movi	999,a1			;max value
	calla	dec_to_asc
	calla	copy_string
	movi	QTR3_X,a0
	move	a0,@mess_cursx
	movi	Y2-1,a0
	move	a0,@mess_cursy
	calla	print_string_C

;Print 4th quarter

	move	@kp_qscrs2+96,a0
	movi	999,a1			;max value
	calla	dec_to_asc
	calla	copy_string
	movi	QTR4_X,a0
	move	a0,@mess_cursx
	movi	Y1-1,a0
	move	a0,@mess_cursy
	calla	print_string_C

	move	@kp_qscrs2+112,a0
	movi	999,a1			;max value
	calla	dec_to_asc
	calla	copy_string
	movi	QTR4_X,a0
	move	a0,@mess_cursx
	movi	Y2-1,a0
	move	a0,@mess_cursy
	calla	print_string_C

;Print Overtime 1
;DJT Start

	move	@kp_qscrs2,a0,L
	move	@kp_qscrs2+32,a14,L
	add	a14,a0
	move	@kp_qscrs2+64,a14,L
	add	a14,a0
	move	@kp_qscrs2+96,a14,L
	add	a14,a0
	move	@scores,a14,L
	cmp	a14,a0
	jreq	ovr_dn

	PUSH	a0
;DJT End
	move	@kp_qscrs2+128,a0
	movi	999,a1			;max value
	calla	dec_to_asc
	calla	copy_string
	movi	OT1_X,a0
	move	a0,@mess_cursx
	movi	Y1-1,a0
	move	a0,@mess_cursy
	calla	print_string_C

	move	@kp_qscrs2+144,a0
	movi	999,a1			;max value
	calla	dec_to_asc
	calla	copy_string
	movi	OT1_X,a0
	move	a0,@mess_cursx
	movi	Y2-1,a0
	move	a0,@mess_cursy
	calla	print_string_C

;Print Overtime 2
;DJT Start

	PULL	a0
	move	@kp_qscrs2+128,a14,L
	add	a14,a0
	move	@scores,a14,L
	cmp	a14,a0
	jreq	ovr_dn

	PUSH	a0
;DJT End
	move	@kp_qscrs2+160,a0
	movi	999,a1			;max value
	calla	dec_to_asc
	calla	copy_string
	movi	OT2_X,a0
	move	a0,@mess_cursx
	movi	Y1-1,a0
	move	a0,@mess_cursy
	calla	print_string_C

	move	@kp_qscrs2+176,a0
	movi	999,a1			;max value
	calla	dec_to_asc
	calla	copy_string
	movi	OT2_X,a0
	move	a0,@mess_cursx
	movi	Y2-1,a0
	move	a0,@mess_cursy
	calla	print_string_C

;Print Overtime 3
;DJT Start

	PULL	a0
	move	@kp_qscrs2+160,a14,L
	add	a14,a0
	move	@scores,a14,L
	cmp	a14,a0
	jreq	ovr_dn

;DJT End
	move	@kp_qscrs2+192,a0
	movi	999,a1			;max value
	calla	dec_to_asc
	calla	copy_string
	movi	OT3_X,a0
	move	a0,@mess_cursx
	movi	Y1-1,a0
	move	a0,@mess_cursy
	calla	print_string_C

	move	@kp_qscrs2+208,a0
	movi	999,a1			;max value
	calla	dec_to_asc
	calla	copy_string
	movi	OT3_X,a0
	move	a0,@mess_cursx
	movi	Y2-1,a0
	move	a0,@mess_cursy
	calla	print_string_C
;DJT Start
ovr_dn
;DJT End
	DIE

score_setup
	PRINT_STR	bast10_ascii,8,0,XF,Y1-1,BAST_W_P,0


******************************************************************************

 SUBR	matchup_screen

	movk	1,a0
	move	a0,@inmatchup

	clr	a0
	movi	-1,a1
	calla	obj_delc		;delete all obj. expect transition obj

	clr	a1				;kill all processes
	calla	KILALL
	calla	KILBGND			;Kill old background

	clr	a0
	move	a0,@dpageflip

	move	@dpage,a1
	not	a1			;Flip
	move	a1,@dpage

;wipe obj. over screen
	movi	wipe_horizontal,a0,L
	movi	CREATE_NO_DEL_OBJS,a14		;dont delete objs. when done
	JSRP	do_scrn_transition

	SLEEPK	1

	movk	1,a0			;page flipping on
	move	a0,@dpageflip
;	movk	1,a0			;page flipping on
;	move	a0,@dtype

;	clr	a0
;	move	a0,@IRQSKYE		;background color

	movi	matchup_mod,a0
	move	a0,@BAKMODS,L
	calla	BGND_UD1
;DJT Start

 .if ANIM_VS
	move	@BAKLST,a0,L
vsk
	move	*a0(OSIZEX),a14
	cmpi	44,a14
	jrne	vsk1
	move	*a0(OCTRL),a14
	srl	2,a14
	sll	2,a14
	move	a14,*a0(OCTRL)
vsk1
	move	*a0,a0,L
	jrnz	vsk
 .endif ;ANIM_VS
;DJT End

	movk	1,a0
	calla	create_logos
	calla	update_logos

	movi	tnght_mat_str_setup,a2
	calla	setup_message
	movi	tonght_matchup_str,a4,L
	calla	print_string_C2

	movi	tm1_cty_str_setup,a2
	calla	setup_message
	move	@team1,a14
	sll	6,a14
	addi	city_names_str_tbl,a14
	move	*a14,a4,L
	calla	print_string_C2

	movi	tm1_nme_str_setup,a2
	calla	setup_message
	move	@team1,a14
	sll	6,a14
	addi	city_names_str_tbl,a14
	move	*a14(32),a4,L
	calla	print_string_C2

	movi	tm2_cty_str_setup,a2
	calla	setup_message
	move	@team2,a14
	sll	6,a14
	addi	city_names_str_tbl,a14
	move	*a14,a4,L
	calla	print_string_C2

	movi	tm2_nme_str_setup,a2
	calla	setup_message
	move	@team2,a14
	sll	6,a14
	addi	city_names_str_tbl,a14
	move	*a14(32),a4,L
	calla	print_string_C2

	movi	tm2_nme_str_setup,a2
	calla	setup_message
	move	@team2,a14
	sll	6,a14
	addi	city_names_str_tbl,a14
	move	*a14(32),a4,L
	calla	print_string_C2

	movi	bsd_stat_str_setup,a2
	calla	setup_message
	movi	bsd_stat_str,a4,L
	calla	print_string_C2

	move	@mess_cursy,a14
	addk	11,a14
	move	a14,@mess_cursy


	calla	get_teams_pop
	move	@team1,a0
	sll	5,a0
	addi	teams_pop,a0,L
	move	*a0,a0,L			;get team 1 'picked count'

	move	@team2,a14
	sll	5,a14
	addi	teams_pop,a14,L
	move	*a14,a14,L			;get team 2 'picked count'

	move	@team2,a4
	cmp	a0,a14				;team 2 more popular ?
	jrhs	tmpop				;br=yes
	move	@team1,a4
tmpop
	sll	6,a4
	addi	city_names_str_tbl,a4
	move	*a4,a4,L
	calla	copy_rom_string
	movi	favored_by_str,a4
	calla	concat_rom_string
;DJT Start

	clr	a0
	.ref	pup_msgs	;Matchup screen pup message flags
	move	a0,@pup_msgs,L
;DJT End

	movk	10,a0
	calla	RNDRNG0
	inc	a0
	movk	15,a1			;max value
	calla	dec_to_asc
	calla	concat_string
	calla	print_string_C

	clr	a10
	CREATE0	plyr_get_combination
	movk	1,a10
	CREATE0	plyr_get_combination
	movk	2,a10
	CREATE0	plyr_get_combination
	movk	3,a10
	CREATE0	plyr_get_combination

;	.ref	tuneq1_snd
;	SOUND1	tuneq1_snd

	SLEEPK	1

;wipe objs off screen -- reveal new screen
	movi	un_wipe_horizontal,a0,L
	movi	NO_CREATE_DEL_OBJS,a14
	JSRP	do_scrn_transition

	.ref	start_powerups
	CREATE	SMOVE_PID,start_powerups

	SLEEPK	1

;DJT Start
	.if	ANIM_VS
	CREATE	VS_LOGO_PID,animate_vs_logo
	.endif	;ANIM_VS
	CREATE0	call_matchup

	movi	TSEC*13/2,a10		;!!! 4
;DJT End
delay
	SLEEPK	1
	dsj	a10,delay
exitb
	calla	set_plyrs_powerup_ram
	movi	SMOVE_PID,a0
	movi	-1,a1
	calla	KILALL
	RETP


*******************************************************************************
; a10 = sleep count

	.asg	200-2,X
	.asg	135,Y

restarta
	calla	DELOBJA8

 SUBR	timeout

	clr	a0
	move	a0,@force_selection

	move	a10,a11
wait2
	SLEEPK	1
	dsj	a11,wait2

	movi	BRSH50R_P,b0
	movi	[X,0],a0			;x val
	movi	[Y,0],a1			;y val
	movi	BRSH50_9,a2			;* image
	movi	20700,a3			;z pos
	movi	DMAWNZ|M_SCRNREL,a4		;DMA flags
	movi	TYPTEXT,a5			;object ID
	clr	a6				;x vel
	clr	a7				;y vel
	calla	BEGINOBJP2
	calla	center_imagea

	move	@PSTATUS2,a9

	movi	9,a11
loopb
	SOUND1	cntdown_snd

	SLEEP	TSEC+25

	move	@PSTATUS2,a0		;if player buys in
	cmp	a9,a0			;then restart timer
	jrne	restarta

	calla	obj_off

	SOUND1	cntdown_snd

	SLEEP	(1*TSEC)/2

	move	@PSTATUS2,a0
	cmp	a9,a0
	jrne	restarta

	calla	obj_on
	move	a11,a0
	sll	5,a0
	addi	numsa-20h,a0
	move	*a0,a0,L		;* image
	movi	DMAWNZ,a1		;DMA flags
	calla	obj_aniq		;change object image
	calla	center_imagea

	dsj	a11,loopb

	SOUND1	cntdown_snd

	SLEEP	(1*TSEC+25)/2

	movk	1,a0
	move	a0,@force_selection

	calla	DELOBJA8
	DIE

numsa	.long	BRSH50_0,BRSH50_1,BRSH50_2
	.long	BRSH50_3,BRSH50_4,BRSH50_5
	.long	BRSH50_6,BRSH50_7,BRSH50_8,BRSH50_9

center_imagea
	move	*a8(OSIZEX),a0
	srl	1,a0
	movi	X,a1
	sub	a0,a1
	move	a1,*a8(OXPOS)
	rets


;DJT Start
	.if	TRIVCON
;DJT End
*******************************************************************************
; a10 = sleep count

	.asg	198,X
	.asg	135,Y


 SUBR	timeout4

	clr	a0
	move	a0,@force_selection

	move	a10,a11
wait3
	SLEEPK	1
	dsj	a11,wait3			;wait before count down

	movi	BRSH50R_P,b0
	movi	[X,0],a0			;x val
	movi	[Y,0],a1			;y val
	movi	BRSH50_5,a2			;* image
	movi	20700,a3			;z pos
	movi	DMAWNZ|M_SCRNREL,a4		;DMA flags
	movi	TRIVIA_TIMER,a5			;object ID
	clr	a6				;x vel
	clr	a7				;y vel
	calla	BEGINOBJP2
	calla	center_imageb

	movi	5,a11
loopc
	SOUND1	cntdown_snd

	SLEEP	TSEC+25

	calla	obj_off

	SOUND1	cntdown_snd

	SLEEP	(1*TSEC)/2

	calla	obj_on
	move	a11,a0
	sll	5,a0
	addi	numsb-20h,a0
	move	*a0,a0,L		;* image
	movi	DMAWNZ,a1		;DMA flags
	calla	obj_aniq		;change object image
	calla	center_imageb

	dsj	a11,loopc

	SOUND1	cntdown_snd

	SLEEP	(1*TSEC+25)/2		;Give'm a grace period

	movk	1,a0
	move	a0,@force_selection

	calla	DELOBJA8
	DIE


center_imageb
	move	*a8(OSIZEX),a0
	srl	1,a0
	movi	X,a1
	sub	a0,a1
	move	a1,*a8(OXPOS)
	rets



numsb	.long	BRSH50_0,BRSH50_1,BRSH50_2
	.long	BRSH50_3,BRSH50_4,BRSH50_5
	.long	BRSH50_6,BRSH50_7,BRSH50_8,BRSH50_9
;DJT Start
	.endif	;TRIVCON
;DJT End


*******************************************************************************
; a10 = sleep count

	.asg	200-2,X
	.asg	135,Y

restartb
	PULLP	a0
	calla	DELOBJA8

 SUBR	timeout2

	clr	a0
	move	a0,@force_selection

	move	a10,a11
wait4
	SLEEPK	1
	dsj	a11,wait4

	movi	BRSH50R_P,b0
	movi	[X,0],a0			;x val
	movi	[Y,0],a1			;y val
	movi	BRSH50_9,a2			;* image
	movi	30001,a3			;z pos
	movi	DMAWNZ|M_SCRNREL,a4		;DMA flags
	movi	TYPTEXT,a5			;object ID
	clr	a6				;x vel
	clr	a7				;y vel
	calla	BEGINOBJP2
	calla	center_imagec

	move	@PSTATUS2,a9
	movi	9,a0
loopd
	PUSHP	a0

	SOUND1	cntdown_snd

	movi	TSEC+25,a11
loop2a
	SLEEPK	1
	calla	get_all_starts_down
	jrnz	xit1a
	dsj	a11,loop2a
xit1a
	SOUND1	cntdown_snd

	move	@PSTATUS2,a0		;if player buys in
	cmp	a9,a0			;then restart timer
	jrne	restartb
	calla	obj_off
	movi	(1*TSEC)/2,a11
loop3a
	SLEEPK	1
	calla	get_all_starts_down
	jrnz	xit2a
	dsj	a11,loop3a
xit2a
	move	@PSTATUS2,a0
	cmp	a9,a0
	jrne	restartb

	calla	obj_on
	PULLP	a0
	PUSHP	a0
	sll	5,a0
	addi	numsc-20h,a0
	move	*a0,a0,L		;* image
	movi	DMAWNZ,a1		;DMA flags
	calla	obj_aniq		;change object image
	calla	center_imagec

	PULLP	a0
	dsj	a0,loopd

	SOUND1	cntdown_snd

	movi	(1*TSEC+25)/2,a11
loop4a
	SLEEPK	1
	calla	get_all_starts_down
	jrnz	xit3a
	dsj	a11,loop4a
xit3a
	SOUND1	cntdown_snd

	movk	1,a0
	move	a0,@force_selection

	calla	DELOBJA8
	DIE


center_imagec
	move	*a8(OSIZEX),a0
	srl	1,a0
	movi	X,a1
	sub	a0,a1
	move	a1,*a8(OXPOS)
	rets

numsc	.long	BRSH50_0,BRSH50_1,BRSH50_2
	.long	BRSH50_3,BRSH50_4,BRSH50_5
	.long	BRSH50_6,BRSH50_7,BRSH50_8,BRSH50_9

;;nums	.long	lgmd_0,lgmd_1,lgmd_2
;;	.long	lgmd_3,lgmd_4,lgmd_5
;;	.long	lgmd_6,lgmd_7,lgmd_8,lgmd_9

*******************************************************************************
; a10 = sleep count

	.asg	200-2,X
	.asg	135,Y

 SUBR	timeout3

	clr	a0
	move	a0,@force_selection

	.ref	BTIME
	move	a0,@BTIME

	movi	BRSH50R_P,b0
	movi	[X,0],a0			;x val
	movi	[Y,0],a1			;y val
	movi	BRSH50_9,a2			;* image
	movi	30001,a3			;z pos
	movi	DMAWNZ|M_SCRNREL,a4		;DMA flags
	movi	TYPTEXT,a5			;object ID
	clr	a6				;x vel
	clr	a7				;y vel
	calla	BEGINOBJP2
	calla	center_imaged

	move	@PSTATUS2,a9

	movi	9,a0
loope
	PUSHP	a0

	SOUND1	cntdown_snd

	SLEEPK	3
	movi	TSEC+25-3,a11
loop2b
	SLEEPK	1

	move	@BTIME,a0
	jrnz	reset

;DJT Start
	calla	get_all_buttons_cur2		;get_all_buttons_down2
	jrz	nobut1
	move	@gmqrtr,a0
	subk	4,a0
	jrn	xit1b
	move	@PSTATUS2,a0
	jrnz	xit1b
nobut1
;DJT End
	dsj	a11,loop2b
xit1b
	SOUND1	cntdown_snd

	calla	obj_off

	SLEEPK	2
	movi	(1*TSEC)/2-3,a11
loop3b
	SLEEPK	1

	move	@BTIME,a0
	jrnz	reset

;DJT Start
	calla	get_all_buttons_cur2		;get_all_buttons_down2
	jrz	nobut2
	move	@gmqrtr,a0
	subk	4,a0
	jrn	xit2b
	move	@PSTATUS2,a0
	jrnz	xit2b
nobut2
;DJT End
	dsj	a11,loop3b
xit2b

	calla	obj_on
	PULLP	a0
	PUSHP	a0
	sll	5,a0
	addi	numsd-20h,a0
	move	*a0,a0,L		;* image
	movi	DMAWNZ,a1		;DMA flags
	calla	obj_aniq		;change object image
	calla	center_imaged

	PULLP	a0
	dsj	a0,loope

	SOUND1	cntdown_snd

	SLEEPK	3
	movi	(1*TSEC+25)/2-3,a11
loop4b
	SLEEPK	1

	move	@BTIME,a0
	jrnz	reset

;DJT Start
	calla	get_all_buttons_cur2		;get_all_buttons_down2
	jrz	nobut3
	move	@gmqrtr,a0
	subk	4,a0
	jrn	xit3b
	move	@PSTATUS2,a0
	jrnz	xit3b
nobut3
;DJT End
	dsj	a11,loop4b
xit3b

	SOUND1	cntdown_snd

	movk	1,a0
	move	a0,@force_selection

	calla	DELOBJA8
	DIE

reset
	clr	a0
	move	a0,@BTIME
	movi	TSEC,a10
	CREATE0	timeout3
	calla	DELOBJA8
	SOUND1	cntdown_snd
	DIE


center_imaged
	move	*a8(OSIZEX),a0
	srl	1,a0
	movi	X,a1
	sub	a0,a1
	move	a1,*a8(OXPOS)
	rets


numsd	.long	BRSH50_0,BRSH50_1,BRSH50_2
	.long	BRSH50_3,BRSH50_4,BRSH50_5
	.long	BRSH50_6,BRSH50_7,BRSH50_8,BRSH50_9


*******************************************************************************
* a3  = * player data
* a10 = player number (0-3)
* sets special_heads based on initials entered
*
* updated to account for CREATED players...
*******************************************************************************
 SUBR	check_special_initials

	sll	4,a10				;x 16
	addi	special_heads,a10
;
; We want to favor the player who CREATED his/her character, this is just in case
;   its initials and pin_number match a team members. (or if a team member
;   wants to change their record)
;
	move	*a3(PR_CREATED_PLYR),a0		;player created ?
	cmpi	1,a0				;br=yep, no special head
	jrp	end

	clr	a5
	movi	team_data,a2
nexta
	move	*a3(PR_NAME1),a0
	jrle	no_match
	move	*a2,a1
	cmp	a0,a1
	jrne	no_match

	move	*a3(PR_NAME2),a0
	move	*a2(10h),a1
	cmp	a0,a1
	jrne	no_match

	move	*a3(PR_NAME3),a0
	move	*a2(20h),a1
	cmp	a0,a1
	jrne	no_match

	move	*a3(PR_NAME4),a0
	move	*a2(30h),a1
	cmp	a0,a1
	jrne	no_match

	move	*a3(PR_NAME5),a0
	move	*a2(40h),a1
	cmp	a0,a1
	jrne	no_match

	move	*a3(PR_NAME6),a0
	move	*a2(50h),a1
	cmp	a0,a1
	jrne	no_match

	move	*a3(PR_PIN_NBR1),a0
	move	*a2(60h),a1
	cmp	a0,a1
	jrne	no_match

	move	*a3(PR_PIN_NBR2),a0
	move	*a2(70h),a1
	cmp	a0,a1
	jrne	no_match

	move	*a3(PR_PIN_NBR3),a0
	move	*a2(80h),a1
	cmp	a0,a1
	jrne	no_match

	move	*a3(PR_PIN_NBR4),a0
	move	*a2(90h),a1
	cmp	a0,a1
	jrne	no_match

	movk	ADJTOURNEY,a0		;Tournament mode?
	calla	GET_ADJ			;0-1
	jrz	yes			;On? Br=yes

	move	a5,*a10			;store special head number
	move	a5,a0
	sll	4,a5
	sll	5,a0			;x 16 x 4
	add	a5,a0
	addi	team_snds,a0
	calla	snd_play1
yes	rets
	

no_match
	addi	NXT_TM_MEMBR,a2		;7 words per line in below table
	inc	a5			;head number
	cmpi	team_data1_end,a2
	jrlo	nexta
end	rets


;DJT Start
;
; This is a table of all the SPECIAL players (designers...etc) reconizied 
;
	.asg	01,A_
	.asg	02,B_
	.asg	03,C_
	.asg	04,D_
	.asg	05,E_
	.asg	06,F_
	.asg	07,G_
	.asg	08,H_
	.asg	09,I_
	.asg	10,J_
	.asg	11,K_
	.asg	12,L_
	.asg	13,M_
	.asg	14,N_
	.asg	15,O_
	.asg	16,P_
	.asg	17,Q_
	.asg	18,R_
	.asg	19,S_
	.asg	20,T_
	.asg	21,U_
	.asg	22,V_
	.asg	23,W_
	.asg	24,X_
	.asg	25,Y_
	.asg	26,Z_
	.asg	29,SP

	.asg	-1+1,NUL
	.asg	0+1,ZER
	.asg	1+1,ONE
	.asg	2+1,TWO
	.asg	3+1,THR
	.asg	4+1,FOR
	.asg	5+1,FIV
	.asg	6+1,SIX
	.asg	7+1,SEV
	.asg	8+1,EIG
	.asg	9+1,NIN
	.asg	10+1,SPC

team_data
	.word	J_,A_,P_,P_,L_,E_
	.word	SIX,SIX,SIX,ZER 	;00  JOHNSON
team_data1
	.word	D_,I_,V_,I_,T_,A_
	.word	ZER,TWO,ZER,ONE 	;01  DIVITA

	.word	T_,U_,R_,M_,E_,L_
	.word	ZER,THR,TWO,TWO 	;02  TURMELL

	.word	D_,A_,N_,I_,E_,L_
	.word	ZER,SIX,ZER,FOR 	;03  THOMPSON

	.word	E_,U_,G_,E_,N_,E_
	.word	SIX,SEV,SIX,SEV 	;04  GEER

	.word	J_,C_,0,0,0,0
	.word	ZER,ZER,ZER,ZER 	;05  CARLTON

	.word	J_,F_,E_,R_,0,0
	.word	ZER,FIV,ZER,THR 	;06  HEDRICK

	.word	J_,O_,N_,H_,E_,Y_
	.word	SIX,ZER,ZER,ZER 	;07  JON HEY

	.word	M_,O_,R_,R_,I_,S_
	.word	SIX,ZER,ZER,ZER 	;08  AIR MORRIS

	.word	B_,A_,R_,D_,O_,0
	.word	SIX,ZER,ZER,ZER 	;09  STEVE BARDO

	.word	M_,I_,N_,I_,F_,E_
	.word	SIX,ZER,ZER,ZER 	;10  MINIFEE

	.word	M_,A_,R_,T_,Y_,0
	.word	ONE,ZER,ONE,ZER 	;11  MARTINEZ

	.word	C_,A_,R_,L_,O_,S_
	.word	ONE,ZER,ONE,ZER 	;12  PESINA

	.word	S_,H_,A_,W_,N_,0
	.word	ZER,ONE,TWO,THR 	;13  LIPTAK

	.word	E_,D_,D_,I_,E_,0
	.word	SIX,TWO,ONE,THR 	;14  EDDIE

	.word	M_,X_,V_,0,0,0
	.word	ONE,ZER,ONE,FOR 	;15  MIKE V.

	.word	J_,A_,M_,I_,E_,0
	.word	ONE,ZER,ZER,ZER 	;16  JAMIE

	.word	N_,I_,C_,K_,0,0
	.word	SEV,ZER,ZER,ZER 	;17  NICK E.

	.word	R_,O_,O_,T_,0,0
	.word	SIX,ZER,ZER,ZER 	;18  J. ROOT

	.word	M_,E_,D_,N_,I_,K_
	.word	SIX,ZER,ZER,ZER 	;19  C. MEDNICK

	.word	D_,A_,N_,R_,0,0
	.word	ZER,ZER,ZER,ZER 	;20  DAN R.

	.word	P_,A_,T_,F_,0,0
	.word	TWO,ZER,ZER,ZER 	;21  PAT F.
		
	.word	K_,O_,M_,B_,A_,T_
	.word	ZER,ZER,ZER,FOR 	;22  ED BOON
		  
	.word	M_,O_,R_,T_,A_,L_
	.word	ZER,ZER,ZER,FOR 	;23  J. TOBIAS
	
	.word	S_,N_,O_,0,0,0
	.word	ZER,ONE,ZER,THR 	;24 OURSLER
	    
	.word	J_,A_,S_,O_,N_,0
	.word	ZER,SEV,TWO,SPC 	;25  JASON

	.word	Q_,U_,I_,N_,0,0
	.word	ZER,THR,THR,ZER 	;26 QUINN

	.word	P_,E_,R_,R_,Y_,0
	.word	THR,FIV,ZER,ZER 	;27 PERRY

	.word	N_,F_,U_,N_,K_,0
	.word	ZER,ONE,ZER,ONE 	;28 NEIL FUNK

	.word	M_,D_,O_,C_,0,0
	.word	TWO,ZER,NUL,NUL 	;29 MDOC

	.word	N_,O_,B_,U_,D_,0
	.word	ONE,ZER,ONE,ZER 	;30 BUD

	.word	M_,A_,R_,I_,U_,S_
	.word	ONE,ZER,ZER,FIV 	;31 MARIUS

	.word	M_,U_,N_,D_,A_,Y_
	.word	FIV,FOR,THR,TWO 	;32 MUNDAY

	.word	N_,O_,R_,T_,H_,0
	.word	FIV,ZER,FIV,ZER 	;33 NORTH

	.word	A_,M_,R_,I_,C_,H_
	.word	TWO,ZER,TWO,ZER 	;34 AMRICH

	.word	J_,I_,G_,G_,E_,T_
	.word	ONE,ZER,ONE,ZER 	;35 JIGGETS

	.word	Z_,I_,R_,I_,N_,0
	.word	ONE,ZER,ONE,ZER 	;36 ZIRIN

	.word	H_,E_,I_,T_,H_,0
	.word	ONE,ZER,SEV,NIN		;37 HEITH BETTLEMAN

	.word	M_,A_,T_,T_,SP,B_
	.word	ZER,ONE,EIG,FOR		;38 MATT BETTLEMAN

	.word	K_,SP,D_,A_,Y_,0
	.word	FOR,TWO,FOR,TWO		;39 KEVIN DAY

;Superstar special guests
;FIX!!!
;Use name and birthday as pin 

	.word	P_,I_,P_,P_,E_,N_
	.word	ZER,ZER,ZER,ZER 	;PIPPEN  

	.word	R_,O_,D_,M_,A_,N_
	.word	ZER,ZER,ZER,ZER 	;RODMAN

	.word	J_,O_,H_,N_,S_,N_
	.word	ZER,ZER,ZER,ZER 	;JOHNSN_L

	.word	R_,I_,C_,E_,0,0
	.word	ZER,ZER,ZER,ZER 	;RICE

	.word	K_,I_,D_,D_,0,0
	.word	ZER,ZER,ZER,ZER 	;KIDD

	.word	M_,O_,T_,U_,M_,B_
	.word	ZER,ZER,ZER,ZER 	;MOTUMBO

	.word	G_,H_,I_,L_,L_,0
	.word	ZER,ZER,ZER,ZER 	;G. HILL

	.word	D_,R_,E_,A_,M_,0
	.word	ZER,ZER,ZER,ZER 	;OLAJUAMWN

	.word	M_,I_,L_,L_,E_,R_
	.word	ZER,ZER,ZER,ZER 	;R. MILLER

	.word	S_,M_,I_,T_,S_,0
	.word	ZER,ZER,ZER,ZER 	;R. SMITS

	.word	M_,O_,U_,R_,N_,G_
	.word	ZER,ZER,ZER,ZER 	;MOURNING

	.word	G_,L_,E_,N_,N_,R_
	.word	ZER,ZER,ZER,ZER 	;G. ROBINSON

	.word	E_,W_,I_,N_,G_,0
	.word	ZER,ZER,ZER,ZER 	;EWING

	.word	S_,T_,A_,R_,K_,S_
	.word	ZER,ZER,ZER,ZER 	;STARKS

	.word	A_,H_,R_,D_,W_,Y_
	.word	ZER,ZER,ZER,ZER 	;A. HARDAWAY

	.word	H_,G_,R_,A_,N_,T_
	.word	ZER,ZER,ZER,ZER 	;H. GRANT

	.word	S_,T_,A_,C_,K_,H_
	.word	ZER,ZER,ZER,ZER 	;STACKHOUSE

	.word	C_,L_,I_,F_,F_,R_
	.word	ZER,ZER,ZER,ZER 	;CLIFF R.

	.word	D_,A_,V_,I_,D_,R_
	.word	ZER,ZER,ZER,ZER 	;DAVID R.

	.word	E_,L_,L_,I_,O_,T_
	.word	ZER,ZER,ZER,ZER 	;S. ELLIOT

	.word	K_,E_,M_,P_,0,0
	.word	ZER,ZER,ZER,ZER 	;KEMP

	.word	M_,A_,L_,O_,N_,E_
	.word	ZER,ZER,ZER,ZER 	;MALONE

	.word	W_,E_,B_,B_,E_,R_
	.word	ZER,ZER,ZER,ZER 	;WEBBER

	.word	M_,U_,R_,S_,A_,N_
	.word	ZER,ZER,ZER,ZER 	;MURESAN

;New Superstar special guests removed from teams
;FIX!!!
;Use name and birthday as pin 

	.word	M_,C_,L_,O_,U_,D_
	.word	ZER,ZER,ZER,ZER 	;McCLOUD,     george

	.word	T_,M_,I_,L_,L_,S_
	.word	ZER,ZER,ZER,ZER 	;MILLS,       terry

	.word	K_,S_,M_,I_,T_,H_
	.word	ZER,ZER,ZER,ZER 	;SMITH,       kenny

	.word	M_,C_,K_,E_,E_,0
	.word	ZER,ZER,ZER,ZER 	;McKEE,       derek

	.word	C_,H_,A_,P_,M_,N_
	.word	ZER,ZER,ZER,ZER 	;CHAPMAN,     rex

	.word	B_,E_,N_,J_,M_,N_
	.word	ZER,ZER,ZER,ZER 	;BENJAMIN,    benoit

	.word	D_,O_,U_,G_,L_,S_
	.word	ZER,ZER,ZER,ZER 	;DOUGLAS,     sherman

	.word	S_,P_,U_,D_,0,0
	.word	ZER,ZER,ZER,ZER 	;WEBB,        spud

	.word	G_,I_,L_,I_,A_,M_
	.word	ZER,ZER,ZER,ZER 	;GILLIAM,     armon

	.word	K_,E_,V_,I_,N_,E_
	.word	ZER,ZER,ZER,ZER 	;EDWARDS,     kevin

	.word	O_,A_,K_,L_,E_,Y_
	.word	ZER,ZER,ZER,ZER 	;OAKLEY,      charles

	.word	R_,U_,F_,F_,I_,N_
	.word	ZER,ZER,ZER,ZER 	;RUFFIN,      trevor

	.word	W_,E_,S_,L_,E_,Y_
	.word	ZER,ZER,ZER,ZER 	;PERSON,      wesley

	.word	F_,I_,N_,L_,E_,Y_
	.word	ZER,ZER,ZER,ZER 	;FINLEY,      michael

	.word	B_,U_,C_,K_,0,0
	.word	ZER,ZER,ZER,ZER 	;WILLIAMS,    buck

	.word	P_,E_,R_,S_,O_,N_
	.word	ZER,ZER,ZER,ZER 	;PERSON,      chuck

	.word	A_,L_,V_,I_,N_,R_
	.word	ZER,ZER,ZER,ZER 	;ROBERTSON,   alvin

	.word	O_,M_,I_,L_,L_,R_
	.word	ZER,ZER,ZER,ZER 	;MILLER,      oliver

	.word	M_,U_,R_,R_,A_,Y_
	.word	ZER,ZER,ZER,ZER 	;MURRAY,      tracy

	.word	B_,E_,N_,O_,I_,T_
	.word	ZER,ZER,ZER,ZER 	;BENOIT,      david

	.word	B_,S_,C_,O_,T_,T_
	.word	ZER,ZER,ZER,ZER 	;SCOTT,       byron

	.word	M_,U_,R_,D_,C_,K_
	.word	ZER,ZER,ZER,ZER 	;MURDOCK,     eric

team_data1_end



NXT_TM_MEMBR	.equ	(team_data1-team_data)
NUM_MEMBRS	.equ	(team_data1_end-team_data)/NXT_TM_MEMBR


	
team_snds
	.word	03505H,32,2290		;0  JEFF JOHNSON
	.word	03505H,31,2276		;1  SAL DIVITA
	.word	03505H,32,2272		;2  TURMELL
	.word	03505H,28,2286		;3  THOMPSON
	.word	03505H,22,2278		;4  GEER 
	.word	03505H,33,2288		;5  CARLTON
	.word	03505H,28,2280		;6  HEDRICK
	.word	03505H,23,2274		;7  JOHN HEY
	.word	03505H,43,2266		;8  AIR MORRIS
	.word	03505H,30,2268		;9  STEVE BARDO
	.word	03505H,35,2270		;10 MINIFEE
	.word	03505H,41,2282		;11 MARTINEZ
	.word	03505H,36,2284		;12 PESINA
	.word	03505H,36,2250		;13 LIPTAK
	.word	03505H,46,1910		;14 EDDIE
	.word	03505H,26,1920		;15 MIKE V
	.word	03505H,37,2867		;16 JAMIE R.
	.word	03505H,37,2867		;17 NICK E.
	.word	03505H,37,2867		;18 J. ROOT
	.word	03505H,37,2867		;19 MEDNICK
	.word	03505H,37,2867		;20 DAN R.
	.word	03505H,37,2867		;21 PAT F.
	.word	03505H,37,2867		;22 ED BOON
	.word	03505H,37,2867		;23 J. TOBIAS
	.word	03505H,37,2867		;24 OURSLER
	.word	03505H,37,2867		;25 JASON S.
	.word	03505H,37,2867		;26 QUINN
	.word	03505H,37,2867		;27 M. PERRY
	.word	03505H,37,2867		;28 N. FUNK
	.word	03505H,37,2867		;29 MDOC
	.word	03505H,37,2867		;30 BUD
	.word	03505H,54,1877		;31 MARIUS
	.word	03505H,37,2867		;32 MUNDAY
	.word	03505H,37,2867		;33 NORTH
	.word	03505H,37,2867		;34 AMRICH 
	.word	03505H,37,2867		;35 JIGGETS
	.word	03505H,37,2867		;36 ZIRIN
	.word	03505H,37,2867		;37 HEITH BETTLEMAN
	.word	03505H,37,2867		;38 MATT BETTLEMAN
	.word	03505H,43,2787		;39 KEVIN DAY

;Superstar special guests
 .word	0100DH,72,1360	;PIPPEN,      scottie
 .word	0100DH,60,1364	;RODMAN,      dennis
 .word	0100DH,74,1344	;JOHNSON,     larry
 .word	0100DH,65,1348	;RICE,        glen
 .word	0100DH,68,1404	;KIDD,        jason
 .word	0100DH,103,1424	;MUTUMBO,     dekembe
 .word	0100DH,63,1444	;HILL,        grant
 .word	0100DH,118,1480	;OLAJUWAN,    hakeem
 .word	0100DH,85,1500	;MILLER,      reggie
 .word	0100DH,71,1508	;SMITS,       rik
 .word	0100DH,97,1560	;MOURNING,    alonzo
 .word	0100DH,93,1584	;ROBINSON,    glen
 .word	0100DH,82,1640	;EWING,       patrick
 .word	0100DH,70,1656	;STARKS,      john
 .word	0100DH,95,1660	;HARDAWAY,    anfernee
 .word	0100DH,76,1664	;GRANT,       horace
 .word	0100DH,96,1680	;STACKHOUSE,  jerry
 .word	0100DH,94,1724	;ROBINSON,    cliff
 .word	0100DH,92,1764	;ROBINSON,    david
 .word	0100DH,69,1760	;ELLIOTT,     sean
 .word	0100DH,64,1780	;KEMP,        shawn
 .word	0100DH,68,1824	;MALONE,      karl
 .word	0100DH,53,1864	;WEBBER,      chris
 .word	0100DH,92,1876	;MURESAN,     gheorge

;New Superstar special guests removed from teams
 .word	0100DH,84,1416	;McCLOUD,     george
 .word	0100DH,76,1448	;MILLS,       terry
 .word	0100DH,64,1496	;SMITH,       kenny
 .word	0100DH,77,1512	;McKEE,       derek
 .word	0100DH,60,1961	;CHAPMAN,     rex
 .word	0100DH,69,1592	;BENJAMIN,    benoit
 .word	0100DH,69,1596	;DOUGLAS,     sherman
 .word	0100DH,61,1964	;WEBB,        spud
 .word	0100DH,54,1628	;GILLIAM,     armon
 .word	0100DH,60,1636	;EDWARDS,     kevin
 .word	0100DH,81,1652	;OAKLEY,      charles
 .word	0100DH,64,1967	;RUFFIN,      trevor
 .word	0100DH,77,1712	;PERSON,      wesley
 .word	0100DH,95,1716	;FINLEY,      michael
 .word	0100DH,73,1732	;WILLIAMS,    buck
 .word	0100DH,71,1772	;PERSON,      chuck
 .word	0100DH,61,1952	;ROBERTSON,   alvin
 .word	0100DH,67,1812	;MILLER,      oliver
 .word	0100DH,53,1816	;MURRAY,      tracy
 .word	0100DH,69,1832	;BENOIT,      david
 .word	0100DH,60,1958	;SCOTT,       byron
 .word	0100DH,63,1856	;MURDOCK,     eric


;DJT End
*******************************************************************************

 SUBR	select_teams

;DJT Start
	PUSH	a3

	clr	a3
	not	a3
	move	a3,@t1ispro		;Set for regular skill level
	move	a3,@t2ispro

;DJT End
	move	@team1,a0
	move	@team2,a1
	or	a0,a1
	move	a1,a1
	jrnn	teams_ok		;both teams selected?

	move	@team1,a0
	jrnn	select_team2

select_team1
	movi	ALL_TMS_DEFEATD,a1
	move	@PSTATUS2,a0
	btst	2,a0
	jrz	nop3
	move	@player3_data+PR_NAME1,a0
	jrle	nop3
	move	@player3_data+PR_TEAMSDEF,a0,L
	and	a0,a1
nop3
	move	@PSTATUS2,a0
	btst	3,a0
	jrz	nop4
	move	@player4_data+PR_NAME1,a0
	jrle	nop4
	move	@player4_data+PR_TEAMSDEF,a0,L
	and	a0,a1
nop4
;DJT Start
	calla	calc_num_defeated	;A1/A2 are not destroyed!!!
	clr	a3
	cmpi	NUM_ISPRO,a0
	subb	a3,a3
	cmpi	NUM_ISCHAMP,a0
	addc	a3,a3
	cmpi	NUM_TEAMS,a0
	jreq	choose_random1		; br=all teams beat/no initials entry

	calla	get_opponent_team	;Returns A2=team 
	move	a2,@team1

	move	a2,a0			;CPU team. Do RNDPER for new squad 
	sll	4,a0			; based on total possible per team
	addi	team_sqaud_cnts,a0,L
	move	*a0,a0
	subk	1,a0
	move	a3,a3			;Human team @ champ level?
	jrnz	nc1			; br=no
	movk	1,a0			;Select from first 2 squads only
nc1
	calla	RNDRNG0
	sll	4,a2
	addi	tm1set,a2,L
	move	a0,*a2
	jruc	ispro1

choose_random1
	movk	NUM_TEAMS-1,a0		;RNDPER for any team 
	calla	RNDRNG0
	move	a0,@team1

	move	@HCOUNT,a1		;RNDPER for either of first 2 squads
	movk	1,a14
	and	a14,a1
	sll	4,a0
	addi	tm1set,a0
	move	a1,*a0

	move	@player3_data+PR_NAME1,a14	;Beat all teams? Chk initials
	jrgt	cont1
	move	@player4_data+PR_NAME1,a14
	jrle	teams_ok			; br=no
cont1
	movi	NUM_MEMBRS-1,a0		;Give superstar plyr a rnd special
	calla	RNDRNG0			; guest opponent
;;	addi	56,a0
;;	clr	a0
	move	a0,@special_heads+10h
ispro1
	move	a3,@t2ispro
	jruc	teams_ok

;; NOT!! NUM_TEAMS elements
;; Table needs to be plyr initials (currently $1-$1D)  of elements
;setnum	.word	0
;	.word	1,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,3,0,0,0,3,1,1,0
;DJT End

select_team2
	movi	ALL_TMS_DEFEATD,a1
	move	@PSTATUS2,a0
	btst	0,a0
	jrz	nop1
	move	@player1_data+PR_NAME1,a0
	jrle	nop1
	move	@player1_data+PR_TEAMSDEF,a0,L
	and	a0,a1
nop1
	move	@PSTATUS2,a0
	btst	1,a0
	jrz	nop2
	move	@player2_data+PR_NAME1,a0
	jrle	nop2
	move	@player2_data+PR_TEAMSDEF,a0,L
	and	a0,a1
nop2
;DJT Start
	calla	calc_num_defeated	;A1/A2 are not destroyed!!!
	clr	a3
	cmpi	NUM_ISPRO,a0
	subb	a3,a3
	cmpi	NUM_ISCHAMP,a0
	addc	a3,a3
	cmpi	NUM_TEAMS,a0
	jreq	choose_random2		; br=all teams beat/no initials entry

	calla	get_opponent_team	;Returns A2=team 
	move	a2,@team2

	move	a2,a0			;CPU team. Do RNDPER for new squad 
	sll	4,a0			; based on total possible per team
	addi	team_sqaud_cnts,a0,L
	move	*a0,a0
	subk	1,a0
	move	a3,a3			;Human team @ champ level?
	jrnz	nc2			; br=no
	movk	1,a0			;Select from first 2 squads only
nc2
	calla	RNDRNG0
	sll	4,a2
	addi	tm2set,a2,L
	move	a0,*a2
	jruc	ispro2

choose_random2
	movk	NUM_TEAMS-1,a0		;RNDPER for any team 
	calla	RNDRNG0
	move	a0,@team2

	move	@HCOUNT,a1		;RNDPER for either of first 2 squads
	movk	1,a14
	and	a14,a1
	sll	4,a0
	addi	tm2set,a0
	move	a1,*a0

	move	@player1_data+PR_NAME1,a14	;Beat all teams? Chk initials
	jrgt	cont2
	move	@player2_data+PR_NAME1,a14
	jrle	teams_ok			; br=no
cont2
	movi	NUM_MEMBRS-1,a0		;Give superstar plyr a rnd special
	calla	RNDRNG0			; guest opponent
;;	addi	56,a0
;;	clr	a0
	move	a0,@special_heads+30h
ispro2
	move	a3,@t1ispro

teams_ok
	PULL	a3
	rets


;This table should be ranked by real NBA record
;Updated on 10/15/96
;Worst to Best:

_ATL	.equ	0
_BOS	.equ	1
_CHA	.equ	2
_CHI	.equ	3
_CLE	.equ	4
_DAL	.equ	5
_DEN	.equ	6
_DET	.equ	7
_GOL	.equ	8
_HOU	.equ	9
_IND	.equ	10
_LAC	.equ	11
_LAL	.equ	12
_MI	.equ	13
_MIL	.equ	14
_MIN	.equ	15
_NJ	.equ	16
_NY	.equ	17
_ORL	.equ	18
_PHI	.equ	19
_PHX	.equ	20
_POR	.equ	21
_SAC	.equ	22
_SAN	.equ	23
_SEA	.equ	24
_TOR	.equ	25
_UTA	.equ	26
_VAN	.equ	27
_WAS	.equ	28

team_orders
	.word	_VAN	;27	29
	.word	_PHI	;19	28
	.word	_TOR	;25	27
	.word	_MIL	;14	26
	.word	_DAL	;5	25
	.word	_MIN	;15	24
	.word	_LAC	;11	23
	.word	_NJ	;16	22
	.word	_BOS	;1	21
	.word	_DEN	;6	20
	.word	_GOL	;8	19
	.word	_SAC	;22	18
	.word	_WAS	;28	17
	.word	_CHA	;2	16
	.word	_PHX	;20	15
	.word	_MI	;13	14
	.word	_POR	;21	13
	.word	_DET	;7	12
	.word	_ATL	;0	11
	.word	_CLE	;4	10
	.word	_NY	;17	9
	.word	_HOU	;9	8
	.word	_IND	;10	7
	.word	_LAL	;12	6
	.word	_UTA	;26	5
	.word	_SAN	;23	4
	.word	_ORL	;18	3
	.word	_SEA	;24	2
	.word	_CHI	;3	1
	.word	-1
;DJT End


*******************************************************************************
*
* INPUT:	a0 = Nth undefeated team
*		a1 = teams defeated bits
* RETURN:	a2 = team number
*
*------------------------------------------------------------------------------
 SUBR	get_opponent_team

	movi	team_orders,a0
next_teama
	move	*a0+,a2			;team number (0-28)
	jrn	err			;shouldn't happen
	btst	a2,a1			;defeated?
	jrnz	next_teama
	rets
err
	clr	a2
	rets




 .if 0
	PUSH	a1
	clr	a2
next_teamb
	srl	1,a1
	jrc	def
;	dec	a0			;teams defeated count ++
;	jrn	done
def
	inc	a2
	cmpi	26,a2
	jrlo	next_teamb
donea
	PULL	a1
	rets
 .endif

******************************************************************************


 SUBR	print_plr_name

	move	a10,a0
	sll	4,a0				;x 16 bits
	move	a0,a1
	sll	1,a0				;x 32 bits
	addi	plyrdata,a0
	move	*a0,a4,L			;* scr initials

	movi	init_x,a2
	move	@TWOPLAYERS,a0		;0 = NO, 1 = YES 2 players
	jrz	not2a
	movi	kit_x,a2			;kit x vals
not2a
	add	a2,a1

	move	*a1,a1
	move	a1,@mess_cursx
	movi	message_buffer,a3		;* string dest
	calla	get_name_string
	calla	print_string_C			;centered
	rets



	.asg	70,Y1
	.asg	104,Y2

 SUBR	ingame_mess

wait5
	move	@PSTATUS2,a0
	btst	a10,a0
	jrnz	ingame
	SLEEPK	1
	jruc	wait5
ingame

	movi	name_setupb,a2
	calla	setup_message

	callr	print_plr_name

	move	@gmqrtr,a0
	cmpi	4,a0
	jrls	okb
	movk	4,a0
okb
	sll	5,a0			;x 32 bits
	addi	qtr_msgs,a0
	move	*a0,a2,L		;* image

	sll	4,a10			;x 16 bits

	movi	qtr_x,a3
	move	@TWOPLAYERS,a0		;0 = NO, 1 = YES 2 players
	jrz	not2b
	movi	kit_x,a3			;kit x vals
not2b
	add	a3,a10

	move	*a10,a0
	sll	16,a0			;x val
	PUSH	a0
	movi	[Y2,0],a1		;y val
	movi	1000,a3			;z pos
	movi	DMAWNZ,a4		;DMA flags
	movi	TYPTEXT,a5		;object ID
	clr	a6			;x vel
	clr	a7			;y vel
	movi	BAST_W_P,b0		;pal
	calla	BEGINOBJP2

	PULL	a0
	movi	[Y1,0],a1		;y val
	movi	getready,a2		;* image
	movi	1000,a3			;z pos
	movi	DMAWNZ,a4		;DMA flags
	movi	TYPTEXT,a5		;object ID
	clr	a6			;x vel
	clr	a7			;y vel
	movi	BAST_W_P,b0		;pal
	calla	BEGINOBJP2
	DIE


plyrdata
	.long	player1_data+PR_NAME1
	.long	player2_data+PR_NAME1
	.long	player3_data+PR_NAME1
	.long	player4_data+PR_NAME1

name_setupb
	PRINT_STR	bast8_ascii,5,0,200,208,BAST_R_P,0

qtr_msgs
	.long	_1quart,_2quart
	.long	_3quart,_4quart
	.long	OVRTME,OVRTME
	.long	OVRTME,OVRTME
;	.long	overtme,overtme
;	.long	overtme,overtme

qtr_x	.word	55,151,249,344	;x val


init_x	.word	56,149,250,342
;init_x	.word	56,145,250,339

kit_x	.word	0,101,295,0	;kit x vals



******************************************************************************

 SUBR	winner_stays_on

	movi	ADJWINMODE,a0
	calla	GET_ADJ
	move	a0,a14
	jrz	    exita				;br=disabled

;	cmpi	1,a14				;'all games' ?
;	jreq	allow				;br=yes
;
;	cmpi	2,a14				;'player vs. player' ?
;	jrne	ckfor				;br=no
;	move	@_2plyr_competitive,a0
;	jrz	allow				;br=A human on each team!
;ckfor
;	cmpi	3,a14				;'4 players' ?
;	jrne	exita				;br=no, exit
	move	@_4plyrsingame,a0
	jrnz	exita		 		;br=not a four player game
;allow
	movk	INFREEPRICE,a0
	move	a0,@GAMSTATE

;Zero PxDATA areas

	clr	a0
	movi	P1DATA,a1
	movi	PDSIZE*4/16,A2
zlp	move	a0,*a1+
	dsj	a2,zlp

	move	a0,@conttimers,L		;4 words
	move	a0,@conttimers+20h,L

	clr	a0
	move	a0,@PSTATUS
	move	a0,@PSTATUS2

	calla	display_blank
	calla	WIPEOUT			;CLEAN SYSTEM OUT

	movi	MAX_CRTIME,a0
	move	a0,@cntrs_delay

	movk	1,a0			;page flipping on
	move	a0,@dpageflip

	clr	a0
	move	a0,@IRQSKYE		;background color

	movi	SCRNEND,a0		;[256,405]
	move	a0,@SCRNLR,L

	clr	a0
	move	a0,@WORLDTLX,L
	move	a0,@WORLDTLY,L

	clr	a10
	move	@scores,a0
	move	@scores+10h,a1
	cmp	a1,a0			;score2 - score1
	jrgt	t1_wins
	movk	1,a10			;t2_wins
t1_wins
	move	a10,@winningteam	;0 or 1

	SLEEPK	2

	movi	winner_mod,a0
	move	a0,@BAKMODS,L
	calla	BGND_UD1

	movk	1,a0
	move	a0,@DISPLAYON

	CREATE0	monitor_buyins
	CREATE0	team_control

	CREATE0	credits
	CREATE0	credit_messages
	CREATE0	monitor_fullgame

	.asg	102,X1
	.asg	294,X2

	.asg	21,Y1
	.asg	42,Y2
	.asg	110,Y3

	move	a10,a0
	sll	4,a0
	addi	xpos,a0
	move	*a0,a11

	move	a11,a0				;x val
	sll	16,a0
	movi	[Y1,0],a1			;y val
	movi	congrats_l,a2			;* image
	movi	19001,a3			;z pos
	movi	DMAWNZ|M_SCRNREL,a4		;DMA flags
	movi	TYPTEXT,a5			;object ID
	clr	a6				;x vel
	clr	a7				;y vel
	calla	BEGINOBJ2

	move	a11,a0				;x val
	sll	16,a0
	movi	[Y3,0],a1			;y val
	movi	winfree,a2			;* image
	movi	19001,a3			;z pos
	movi	DMAWNZ|M_SCRNREL,a4		;DMA flags
	movi	TYPTEXT,a5			;object ID
	clr	a6				;x vel
	clr	a7				;y vel
	calla	BEGINOBJ2

	movi	inits_setup,a2
	calla	setup_message
	movi	str_pl12,a4
	move	a10,a10
	jrz	tm1
	movi	str_pl34,a4		;tm2
tm1
	move	a11,@mess_cursx
	calla	print_string_C2

	move	a10,a0
	xori	1,a0
	sll	4,a0
	addi	xpos,a0
	move	*a0,a11
	move	a11,a0				;x val
	sll	16,a0
	movi	[Y3-18,0],a1			;y val
	movi	chalneed_l,a2			;* image
	movi	19001,a3			;z pos
	movi	DMAWNZ|M_SCRNREL,a4		;DMA flags
	movi	TYPTEXT,a5			;object ID
	clr	a6				;x vel
	clr	a7				;y vel
	calla	BEGINOBJ2

	movi	1*TSEC,a10
	CREATE	CNTDWN_PID,timeout2

	SLEEPK	2
	calla	display_unblank

slp	SLEEP	20*TSEC				;15;13
	move	@PSTATUS2,a0
	jrnz	slp
exita
	movi	-1,a0
	move	a0,@winningteam		;-1 for no valid half price
	RETP



inits_setup
	PRINT_STR	bast18_ascii,8,0,X1,Y2,BST18Y_P,0

str_pl12
	.string	"PLAYERS 1 - 2",0
str_pl34
	.string	"PLAYERS 3 - 4",0
	.even

xpos
	.word	X1+1,X2+1

winner_mod
	.long	ENTERKITBMOD
	.word	0,0		;x,y
	.long	ATRIBUTEBMOD
	.word	0,178
	.long	0

******************************************************************************

 SUBR	buyin_screen


	move	@PSTATUS2,a0
	move	a0,@plyrsdropped

	clr	a0
	move	a0,@pleasewt
	move	a0,@newplyrs,L

	move	@gmqrtr,a14
	cmpi	4,a14
	jrlt	tag1
	move	@scores,a14
	move	@scores+16,a1
	cmp	    a1,a14
	jrz	    tag1
exitc
	RETP
tag1
	move	@PSTATUS2,a9
	movi	qtr_purchased,a1	; - 1 quarter for each player
	clr	a2
dec_loop
	move	*a1,a0
	jrz	skip2
	dec	a0
	move	a0,*a1
	jrnz	skip2
	movk	1,a0
	sla	a2,a0
	move	@PSTATUS2,a3
	andn	a0,a3
	move	a3,@PSTATUS
skip2
	addk	16,a1
	inc	a2
	cmpi	3,a2
	jrls	dec_loop
	move	@PSTATUS2,a0
	cmp	a0,a9
	jrnz	cont
;But, if someone inserted coins, go to buyin_screen anyway!
	calla	CR_CONTP		;Credits to continue
	jrlo	bx			;No?
   	move	@game_purchased,a0
	cmpi	0fH,a0
	jrnz	cont
bx
	RETP

cont
	clr	a0
	move	a0,@IRQSKYE		;background color

	clr	a0
	move	a0,@COLRTEMP,L
	move	a0,@dtype		;2D

	movk	1,a0			;page flipping on
	move	a0,@dpageflip

	movk	ININTRO,a0
	move	a0,@GAMSTATE

	movi	newplyrs,a0
	move	a0,@newptr,L

;setup new background
	movi	wipe_stack_vertical,a0,L
	movi	CREATE_NO_DEL_OBJS,a14		;dont delete objs. when done
	JSRP	do_scrn_transition

	SLEEPK	1

	calla	KILBGND			;Kill old background
	calla	pal_clean
	clr	a0
	movi	-1,a1
	calla	obj_delc		;Kill all objs (Screen mem is clr)
	clr	a0
	calla	KIL1C

	.ref	buyin_tune
	SOUND1	buyin_tune

	movi	SCRNEND,a0		;[256,405]
	move	a0,@SCRNLR,L
	clr	a0
	move	a0,@WORLDTLY,L
	move	a0,@WORLDTLX,L
	move	a0,@WORLDTL,L

	movi	buyin_mod,a0
	move	@TWOPLAYERS,a1		;0 = NO, 1 = YES 2 players
	jrz	not2
	movi	buyin_kit_mod,a0
not2
	move	a0,@BAKMODS,L
	calla	BGND_UD1
yesh
	SLEEPK	2
;	calla	create_bits

	movi	TSEC,a10
	CREATE0	timeout3

	CREATE0	credits
	CREATE0	credit_messages

	movk	1,a0
	move	a0,@can_enter_inits	;if 0 deletes challenger messages

	movk	1,a10			;player 2
	CREATE0	ingame_mess
	CREATE0	challenger
	movk	2,a10			;player 3
	CREATE0	ingame_mess
	CREATE0	challenger

	move	@TWOPLAYERS,a0		;0 = NO, 1 = YES 2 players
	jrnz	x2_plyrs

	clr	a10			;player 1
	CREATE0	ingame_mess
	CREATE0	challenger
	movk	3,a10			;player 4
	CREATE0	ingame_mess
	CREATE0	challenger

x2_plyrs

	SLEEP	4
;	SLEEP	10

;wipe things off
	movi	un_wipe_horizontal,a0,L
	movi	NO_CREATE_DEL_OBJS,a14
	JSRP	do_scrn_transition
wait6
	SLEEPK	1
	move	@force_selection,a0
	jrz	wait6
	move	@PSTATUS2,a0
	jrnz	okc

;2/9/93
	calla	dropout_stats
	jauc	game_over

okc	RETP


;buyin2_mod
;	.long	ENTER4BMOD		;enter initials module
;	.word	0,0
;	.long	ATRIBUTEBMOD
;	.word	0,178		;x,y
;	.long	0
;
;buyin2_kit_mod
;	.long	ENTERKITBMOD
;	.word	0,0		;x,y
;	.long	ATRBKITBMOD			;option screen background
;	.word	0,178		;x,y
;	.long	0

buyin_mod
	.long	ENTER4BMOD		;enter initials module
	.word	0,0
	.long	ATRIBUTEBMOD
	.word	0,178
	.long	0

buyin_kit_mod
	.long	ENTERKITBMOD
	.word	0,0
	.long	ATRBKITBMOD
	.word	0,178
	.long	0

******************************************************************************

 SUBR	blink_tmslct

	movi	[200,0],a0
	movi	[15,0],a1
	movi	PRESSBUTT,a2			;* image
	movi	19001,a3			;z pos
	movi	DMAWNZ|M_SCRNREL,a4		;DMA flags
	movi	0,a5				;object ID
	clr	a6				;x vel
	clr	a7				;y vel
	calla	BEGINOBJ2

lpb
	SLEEP	90

	movi	PRESS_P,a0		;SGMD8RED,a0
	calla	pal_getf
	move	a0,*a8(OPAL)

	movi	PRESSTURB,a0		;* image
	movi	DMAWNZ,a1		;DMA flags
	calla	obj_aniq		;change object image

	SLEEP	90

	movi	PRESS_P,a0		;SGMD8WHT,a0
	calla	pal_getf
	move	a0,*a8(OPAL)

	movi	PRESSBUTT,a0		;* image
	movi	DMAWNZ,a1		;DMA flags
	calla	obj_aniq		;change object image


	SLEEP	90

	movi	PRESS2_P,a0		;SGMD8WHT,a0
	calla	pal_getf
	move	a0,*a8(OPAL)

	movi	PRESSPASS,a0		;* image
	movi	DMAWNZ,a1		;DMA flags
	calla	obj_aniq		;change object image
	jruc	lpb


******************************************************************************

	.asg	50,YSPACE

 SUBR	grand_champs_screen


	clr	a10
chk_nxt
	callr	check_champ
;DJT Start
	jrnc	found_champ
;DJT End
	inc	a10
	cmpi	4,a10
	jrlt	chk_nxt

	clr	a10
	RETP


;DJT Start
 SUBR	found_champ

 .if DEBUG
	movk	INPLYRINFO,a14
	move	a14,@GAMSTATE
 .endif

	move	*a13(PROCID),*a13(PDATA)
	movi	GRANDCHAMP_PID,a14
	move	a14,*a13(PROCID)

	clr	a14
	move	a14,@PSTATUS
	move	a14,@PSTATUS2
;DJT End

	calla	display_blank
	calla	WIPEOUT

	clr	a0
	move	a0,@HALT

;DJT Start
	movi	CHEERS,a8
;	movi	TROPHY,a8
;DJT End
	movi	[0,0],a9
	.ref	movie_run
	JSRP	movie_run

	movi	CLSDEAD|123,a0
	move	a0,@mess_objid
	movi	kern_chars,a0
	move	a0,@mess_justify,L	;justification method

;DJT Start
	.asg	       2,CC_BEG
	.asg	      18,CC_END
	.asg	       3,CC_RAT
	.asg	BRSHGYOP,CC_PAL

	.bss	cycram,(CC_END-CC_BEG+1)*16*2

	movi	CC_PAL,a8,L		;*pal
	movi	cycram,a9,L		;Get cycle RAM ptr
	movi	[CC_BEG,CC_END],a10,L	;1st,last color
	movk	CC_RAT,a11		;Rate
	.ref	COLCYC
	CREATE	CYCPID,COLCYC

;DJT End
	movi	champ_mess_tbl,a9,L
	jruc	ctnxt
ctxt
	move	*a4+,a0,L
	move	a0,@message_ascii,L	;
	move	*a4+,a0			;space char width
	move	a0,@mess_space_width	;
	move	*a4+,a0			;spacing between chars
	move	a0,@mess_spacing	;
	move	*a4+,a0			;message cursor pos X
	move	a0,@mess_cursx2		;
	move	*a4+,a0			;message cursor pos Y
	move	a0,@mess_cursy		;
	move	*a4+,a0,L
	move	a0,@message_palette,L

	calla	print_string2b
ctnxt
	move	*a9+,a4,L
	cmpi	4000,a4			;at end ?
	jrne	ctxt			;br=no

	movk	1,a0
	move	a0,@DISPLAYON
	SLEEPK	1

	clr	a0
	move	a0,@DISPLAYON
	movk	1,a0			;page flipping on
	move	a0,@dpageflip
	SLEEPK	1
	clr	a0
	move	a0,@dpageflip
	calla	display_unblank

	SOUND1	tunegc_snd
	.ref	cheer_snd
	SOUND1	cheer_snd

;DJT Start
	SLEEP	10*TSEC
;DJT End

;	movi	5*TSEC,a10
;lpzz	SLEEPK	1
;	calla	get_all_buttons_cur2
;	jrz	nob
;	SOUND1	bounce_snd
;	jruc	xb
;nob	
;	dsj	a10,lpzz
;xb
;DJT Start
found_champ1
;DJT End
	calla	display_blank
	calla	WIPEOUT


	movi	vmod,a0
	move	a0,@BAKMODS,L
	calla	BGND_UD1

;print player nbr.
;
;	movi	congrats_setup,a2	;print player X on line below
;	calla	setup_message
;	movi	CLSDEAD|123,a0
;	move	a0,@mess_objid
;	movi	YSPACE,a0
;	move	a0,@mess_line_spacing
;	movi	player_str,a4
;	calla	copy_rom_string
;
;	move	a10,a0
;	move	@TWOPLAYERS,a1		;0 = NO, 1 = YES 2 players
;	jrnz	iskit
;	inc	a0			;1,2,3,4
;iskit					;1,2
;	movi	4,a1			;max value
;	calla	dec_to_asc
;	calla	concat_string
;
;	movi	100,a0
;	move	a0,@mess_cursx2
;	movi	kern_chars,a0
;	move	a0,@mess_justify,L	;justification method
;	calla	print_string2b

;start scrolling text

;DJT Start
	movi	congrats_setup,a2
	calla	setup_message
	movi	CLSDEAD|123,a0
	move	a0,@mess_objid
	movi	kern_chars,a0
	move	a0,@mess_justify,L	;justification method

	movi	grand_mess_tbl,a9,L
txt
	move	@mess_cursy,a0
txt1
	move	*a9+,a4,L
	cmpi	4001,a4			;spc case?
	jrne	txt2
	addk	14,a0
	jruc	txt1
txt2
	cmpi	4000,a4			;at end ?
	jreq	txtdn			;br=no

	addi	YSPACE,a0
	move	a0,@mess_cursy

	move	*a4+,a0,W
	move	a0,@mess_cursx2
	move	*a4+,a0,L
	move	a0,@message_palette,L

	calla	print_string2b
	jruc	txt

txtdn
	movi	-0c000h,a3		;scroll text up screen
	movi	OBJLST,a14
lpc
	move	*a14,a14,L
	jrz	    xd
	move	*a14(OID),a2
	cmpi	CLSDEAD|123,a2
	jrne	lpc
	move	a3,*a14(OYVEL),L
	jruc	lpc
xd

;	movi	[18h,0],a0
;	movi	[2eh,0],a1
;	movi	TROPHYD1,a2		;* image
;	movi	19001,a3		;z pos
;	movi	DMAWNZ,a4		;DMA flags
;	clr	a5
;	clr	a6			;x vel
;	clr	a7			;y vel
;	calla	BEGINOBJ2

	movk	1,a0
	move	a0,@DISPLAYON
	move	a0,@dpageflip

	SLEEPK	8

;	SOUND1	tunegc_snd

	.ref	plyr_jscrowdsnd
	CREATE0	plyr_jscrowdsnd

	calla	display_unblank

	SLEEP	TSEC*18

	CREATE0	plyr_jscrowdsnd

	SLEEP	22*TSEC +7

	clr	a3			;turn off scroll
	movi	OBJLST,a14
lp1
	move	*a14,a14,L
	jrz	    xq
	move	*a14(OID),a2
	cmpi	CLSDEAD|123,a2
	jrne	lp1
	move	a3,*a14(OYVEL),L
	jruc	lp1
xq
	SLEEP	4*TSEC-8 -7

	.ref	tune_gmovr,pregame_tune,tuneend_snd
	SOUND1	pregame_tune

	.ref	show_designteam
	JSRP	show_designteam

	move	*a13(PDATA),*a13(PROCID)

	SOUND1	tune_gmovr
;DJT End

	movk	1,a10
	RETP


;a10 = player number (0-3)
check_champ

	move	@PSTATUS2,a0
	btst	a10,a0
	jrz	fail

	move	a10,a0
	sll	5,a0
	addi	pdata,a0
	move	*a0,a0,L			;* player data

	move	*a0(PR_NAME1),a1
	jrle	fail
	move	*a0(PR_NUMDEF),a1
	cmpi	NUM_TEAMS,a1
	jrlt	fail
	move	*a0(PR_NUMDEFOLD),a1
	cmpi	NUM_TEAMS,a1
	jrge	fail

	clrc
	rets
fail
	setc
	rets


pdata
	.long	player1_data
	.long	player2_data
	.long	player3_data
	.long	player4_data


vmod
	.long	BKGDBMOD
	.word	0,1
	.long	0


	.asg	200,X
	.asg	10+300,Y

congrats_setup
;	PRINT_STR	bast18_ascii,10,0,X,Y,BSTGYG_P,0
;DJT Start
	PRINT_STR	hangfnt38_ascii,14,0,200,180,HANGF_Y_P,kern_chars
;DJT End
;	PRINT_STR	brush50_ascii,14,0,200,60,BRSH50R_P,kern_chars



;DJT Start
champ_mess_tbl
	.long	line1
	.long	line2
	.long	line3
	.long	line3a
	.long	4000

grand_mess_tbl
	.long	line_blnk
	.long	line4
	.long	line4a
	.long	line4b
	.long	line5
	.long	line5a
	.long	line5b
	.long	line_blnk
	.long	line6
	.long	line6a
	.long	line7
	.long	line7a
	.long	line8
	.long	line8a
	.long	line9
	.long	line9a
	.long	line_blnk
	.long	line12
	.long	line12a
	.long	line13
	.long	line14
	.long	line15
	.long	line15a
	.long	line_blnk
	.long	line16
	.long	line16a
	.long	line_blnk
	.long	line_blnk
	.long	line10
	.long	line11
	.long	4001
	.long	line17
	.long	line17a
	.long	4000


line1
 .long	brush20_ascii	;font
 .word	10,0		;space width, spacing
 .word	24,197		;x,y
; .word	24,174		;x,y
 .long	BRSHGWKP ;_Y_P ;GYGP
 .string "Y",1,-4,"OU",1,-2,"'",1,1,"V",1,-2,"E "
 .string "GO",1,-2,"T"
 .string 0
 .even

line2
 .long	brush20_ascii	;font
 .word	10,0		;space width, spacing
 .word	24,221		;x,y
 .long	BRSH_G_P
 .string "M",1,-1,"AX",1,-2,"I",1,-2,"M",1,-1,"U",1,-1,"M "
 .string "H",1,-4,"AN",1,-2,"G",1,-1,"T",1,-2,"I",1,-2,"M",1,-1,"E"
 .string "!",0
 .even

line3
 .long	brush20_ascii	;font
 .word	10,0		;space width, spacing
 .word	194,14		;x,y
 .long	CC_PAL
 .string "Y",1,-4,"OU "
 .string "AR",1,-1,"E "
 .string "T",1,-3,"H",1,-2,"E"
 .string 0
 .even

line3a
 .long	brush20_ascii	;font
 .word	10,0		;space width, spacing
 .word	128,38		;x,y
 .long	CC_PAL
 .string "GR",1,-1,"AN",1,-1,"D "
 .string "CH",1,-4,"AM",1,-1,"PI",1,-2,"ON",1,-1,"!"
 .string 0
 .even

;; .word	20,48		;x,y
;; .string "YOU ARE",0
;;; .string "Y",1,-5,"O",1,-2,"U",1,-2," ",1,-2,"AR",1,-5,"E"," ","T",1,-6,"H",1,-6,"E",0
;; .word	20,74		;x,y
;; .string "THE NBA",0
;;; .string "N",1,-6,"B",1,-5,"A",0
;; .word	20,100		;x,y
;; .string "HANGTIME",0
;;; .string "H",1,-6,"AN",1,-4,"GT",1,-5,"I",1,-5,"M",1,-5,"E",0
;; .word	20,126		;x,y
;; .string "GRAND",0
;;; .string "G",1,-4,"R",1,-4,"AN",1,-6,"D",0
;; .word	20,152		;x,y
;; .string "CHAMPION!",0
;;; .string "C",1,-5,"H",1,-7,"AM",1,-5,"P",1,-4,"I",1,-5,"O",1,-4,"N",1,-1,"!",0


line_blnk
 .word	0
 .long	HANGF_Y_P
 .string "",0
 .even

line4
 .word	26
 .long	HANGF_Y_P
 .string "T",1,-7,"H",1,-7,"E P",1,-5,"L",1,-1,"A",1,2,"Y",1,-7,"E",1,-6,"R",1,-3,"S"
 .string 0
 .even

line4a
 .word	105
 .long	HANGF_Y_P
 .string "I",1,-6,"N N",1,-7,"B",1,-6,"A"
 .string 0
 .even

line4b
 .word	58
 .long	HANGF_G_P
 .string "H",1,-7,"A",1,1,"N",1,-5,"G",1,1,"T",1,-7,"I",1,-6,"M",1,-7,"E"
 .string 0
 .even

line5
 .word	62
 .long	HANGF_Y_P
 .string "T",1,-4,"U",1,-6,"R",1,-5,"N",1,-7,"E",1,-7,"D IT"
 .string 0
 .even

line5a
 .word	79
 .long	HANGF_Y_P
 .string "U",1,-6,"P T",1,-5,"O G",1,-2,"O"
 .string 0
 .even

line5b
 .word	48
 .long	HANGF_R_P
 .string "M",1,-7,"A",1,1,"X",1,-6,"I",1,-6,"M",1,-4,"U",1,-6,"M!"
 .string 0
 .even

line6
 .word	72
 .long	HANGF_Y_P
 .string "B",1,-3,"UT N",1,-5,"O",1,-1,"W"
 .string 0
 .even

line6a
 .word	70
 .long	HANGF_Y_P
 .string "Y",1,-8,"O",1,-2,"U H",1,-7,"A",1,1,"V",1,-8,"E"
 .string 0
 .even

line7
 .word	69
 .long	HANGF_Y_P
 .string "D",1,-5,"E",1,-7,"F",1,-7,"E",1,-7,"A",1,1,"T",1,-7,"E",1,-7,"D"
 .string 0
 .even

line7a
 .word	107
 .long	HANGF_Y_P
 .string "A",1,1,"L",1,-1,"L 2",1,-3,"9"
 .string 0
 .even

line8
 .word	68
 .long	HANGF_Y_P
 .string "T",1,-7,"E",1,-7,"A",1,1,"M",1,-4,"S T",1,-1,"O"
 .string 0
 .even

line8a
 .word	33
 .long	HANGF_Y_P
 .string "B",1,-5,"E",1,-5,"C",1,-2,"O",1,-4,"M",1,-7,"E T",1,-7,"H",1,-7,"E"
 .string 0
 .even

line9
 .word	33
 .long	HANGF_R_P
 .string "N",1,-7,"E",1,-2,"W G",1,-4,"R",1,-4,"A",1,1,"N",1,-7,"D"
 .string 0
 .even

line9a
 .word	43
 .long	HANGF_R_P
 .string "C",1,-5,"H",1,-7,"A",1,1,"M",1,-6,"P",1,-5,"I",1,-5,"O",1,-5,"N!"
 .string 0
 .even

line12
 .word	65
 .long	HANGF_G_P
 .string "M",1,-6,"I",1,-7,"DW",1,-11,"A",1,2,"Y",1,2,"'",1,-2,"S"
 .string 0
 .even

line12a
 .word	26
 .long	HANGF_Y_P
 .string "N",1,-7,"E",1,-7,"X",1,1,"T B",1,4,"'",1,-3,"B",1,-6,"A",1,1,"L",1,-1,"L"
 .string 0
 .even

line13
 .word	45
 .long	HANGF_Y_P
 .string "C",1,-5,"H",1,-7,"A",1,1,"L",1,-1,"L",1,-1,"E",1,-7,"N",1,-5,"G",1,-5,"E"
 .string 0
 .even

line14
 .word	62
 .long	HANGF_Y_P
 .string "W",1,-6,"I",1,-7,"L",1,-1,"L H",1,-7,"A",1,1,"V",1,-8,"E"
 .string 0
 .even

line15
 .word	108
 .long	HANGF_Y_P
 .string "A N",1,-7,"E",1,-2,"W"
 .string 0
 .even

line15a
 .word	48
 .long	HANGF_Y_P
 .string "D",1,-4,"I",1,-6,"M",1,-7,"E",1,-7,"N",1,-6,"S",1,-4,"I",1,-4,"O",1,-5,"N"
 .string 0
 .even

line16
 .word	96
 .long	HANGF_R_P
 .string "A T",1,-7,"H",1,-7,"I",1,-6,"R",1,-5,"D"
 .string 0
 .even

line16a
 .word	48
 .long	HANGF_R_P
 .string "D",1,-4,"I",1,-6,"M",1,-7,"E",1,-7,"N",1,-6,"S",1,-4,"I",1,-4,"O",1,-5,"N"
 .string 0
 .even

line10
 .word	49
 .long	HANGF_Y_P
 .string "T",1,-7,"H",1,-7,"A",1,1,"N",1,-7,"K Y",1,-8,"O",1,-2,"U"
 .string 0
 .even

line11
 .word	16
 .long	HANGF_Y_P
 .string "F",1,-5,"O",1,-4,"R P",1,-5,"L",1,-1,"A",1,1,"Y",1,-6,"I",1,-7,"N",1,-5,"G!"
 .string 0
 .even

line17
 .word	26
 .long	HANGF_G_P
 .string "Y",1,-8,"O",1,-2,"U H",1,-7,"A",1,1,"V",1,-8,"E",1,-7,"N",1,1,"'",1,2,"T"
 .string 0
 .even

line17a
 .word	24
 .long	HANGF_G_P
 .string "S",1,-5,"E",1,-7,"E",1,-7,"N IT A",1,1,"L",1,-1,"L!"
 .string 0
 .even


; .string "Y",1,-5,"O",1,-2,"U",1,1," ",1,1,"H",1,-7,"A",1,2,"V",1,-7,"E",0
; .string "D",1,-5,"E",1,-6,"F",1,-6,"E",1,-6,"A",1,1,"T",1,-6,"E",1,-5,"D",0
; .string "AL",1,-1,"L",1,2," ","2",1,-1,"9",0
; .string "N",1,-6,"B",1,-5,"A",1,1," ","T",1,-6,"E",1,-6,"A",1,1,"M",1,-4,"S",0
;
; .string "B",1,-3,"U",1,-1,"T"," ","A",0
; .string "G",1,-4,"R",1,-5,"E",1,-7,"AT",1,-6,"E",1,-5,"R",0
; .string "C",1,-4,"H",1,-6,"ALL",1,-2,"E",1,-5,"N",1,-3,"G",1,-4,"E",0
; .string "A",1,1,"W",1,-11,"A",1,1,"IT",1,-5,"S",0
;
; .string "C",1,-3,"O",1,-3,"M",1,-5,"I",1,-5,"N",1,-4,"G",0
; .string "S",1,-3,"O",1,-2,"O",1,-4,"N",0
;
; .string "N",1,-6,"B",1,-5,"A",0
; .string "M",1,-7,"A",1,-1,"X",1,-5,"I",1,-5,"M",1,-3,"U",1,-5,"M",0
; .string "H",1,-6,"AN",1,-4,"GT",1,-5,"I",1,-5,"M",1,-5,"E",0
;
; .string "A",1,2,"V",1,-14,"A",1,1,"I",1,-6,"L",1,-2,"AB",1,-4,"L",1,-1,"E",0
; .string "N",1,-4,"O",1,2,"V",1,-2,"."," ",1,2,"1",1,1,".",0
;
; .string "T",1,-6,"H",1,-7,"AN",1,-6,"K"," ","Y",1,-6,"O",1,-2,"U",0
; .string "F",1,-4,"O",1,-4,"R"," ","P",1,-4,"L",1,-2,"A",1,1,"Y",1,-5,"I",1,-5,"N",1,-4,"G",0
;DJT End


;congrats_str
;	.string	"congratulations!",1
;	.string	"",1
;	.string	"",1
;	.string	"",1
;	.string	"you have defeated",1
;	.string	"all 29 nba teams!",1
;	.string	"",1
;	.string	"",1
;	.string	"",1
;	.string	"You are the new",1
;	.string	"NBA hangtime",1
;	.string	"grand champion!",1
;	.string	"",1
;	.string	"",1
;	.string	"you are an incredible",1
;	.string	"player and one of the",1
;	.string	"best nba hangtime",1
;	.string	"stars of all time!",1
;	.string	"",1
;	.string	"",1
;	.string	"however, this is a",1
;	.string	"midway game!  Which",1
;	.string	"means that there is yet",1
;	.string	"a greater challenge",1
;	.string	"awaiting you . . .",1
;	.string	"",1
;	.string	"Play on . . .",1
;	.string	"",1
;	.string	"",1
;	.string	"thank you for playing",1
;	.string	"nba hangtime!",1
;	.string	"",0
;	.even


player_str
	.string	"PLAYER ",0
	.even



******************************************************************************
******************************************************************************
;check if all credits have been sucked up (that can be)
;
; 0  = not all credits sucked up
; !0 = all credits sucked up

 SUBR	check_suckup

	move	@gmqrtr,a0
	cmpi	2,a0
	jrz	not_enough

	movk	ADJFREPL,a0
	calla	GET_ADJ 	;SEE IF FREEPLAY......(Z BIT CLEAR IF SO!)
	jrnz	free_play

	calla	CRED_P			;get number credits
	move	a0,a3
	movi	ADJCSTRT,a0		; credits to start
	calla	GET_ADJ
	divu	a0,a3			;credits / credits to continue
	move	a3,a3
	jrz	not_enough

	clr	a4
nextb
	move	@PSTATUS2,a0
	btst	a4,a0
	jrz	no_player

	move	@game_purchased,a0
	btst	a4,a0
	jrz	not_purchased

no_player
	inc	a4
	cmpi	4,a4
	jrlt	nextb

not_enough			;to continue
free_play			;so no suckup required
	movk	1,a0
	move	a0,a0
	rets


not_purchased
	clr	a0
	rets


;============================================================
;============================================================
attrib_off
	PUSH	a8
	movk	9,a0
atlp1
	move	*a2+,a8,L
	PUSH	a0,a2
	calla	obj_off
	PULL	a0,a2
	dsj	a0,atlp1
	PULL	a8
	rets

;============================================================
;============================================================
attrib_on
	PUSH	a8
	movk	9,a0
atlp2
	move	*a2+,a8,L
	PUSH	a0,a2
	calla	obj_on
	PULL	a0,a2
	dsj	a0,atlp2
	PULL	a8
	rets

;-----------------------------------------------------------------------------
; JBJ -- updated to accout for less attributes (6)
;-----------------------------------------------------------------------------
update_attribs
	move	a6,a6			;special head ?
	jrnn	norm2			;br=yes, exit

	movk	6,a0			; attribs. to update
udlp
	move	*a11+,a8,L		;a11 points to attribute obj ptrs.
	move	*a10+,a1		;a1=attribute value (0-10)

	.if	DEBUG
	cmpi	10,a1
	jrle	okd
	LOCKUP
okd
	.endif

	PUSH	a0,a10,a11


;;;Special head?
;;	move	a6,a6
;;	jrn	norm
;;;Yes, hide stats!
;;	movk	11,a1
norm

	sll	5,a1			;x32 (index into below table)
	addi	attrib_imgs,a1
	move	*a1,a0,L
;;;;	movi	DMAWNZ,a1		;DMA flags
;;;;	calla	obj_aniq		;change object image
;
; Here I update the attribute 'bar' img. for this object to a new one.
;
	move	a0,*a8(OIMG),L			;update img. pointer
	move	*a0(0),*a8(OSIZE),L		;update size
	move	*a0(ISAG),*a8(OSAG),L		;update source addr.

	move	*a0(ICTRL),a1		     ;get bits per pixel...(ctrl data)
	move	*a8(OCTRL),a14			;get current ctrl data
	andi	08fffH,a14			;clear bits (12-14)
	or	a1,a14				;set bits (12-14)
	move	a14,*a8(OCTRL)			;update 'ctrl' data

	PULL	a0,a10,a11
	dsj	a0,udlp
norm2	rets


attrib_imgs
	.long	ATTBAR01	;0
	.long	ATTBAR01	;1
	.long	ATTBAR02	;2
	.long	ATTBAR03
	.long	ATTBAR04
	.long	ATTBAR05
	.long	ATTBAR06
	.long	ATTBAR07
	.long	ATTBAR08
	.long	ATTBAR09
	.long	ATTBAR10	;10
	.long	ATTBAR10	;10


;;============================================================
;;============================================================
; SUBR	del_box_imgs
;
;	movi	CLSDEAD|123,a0
;	calla	obj_del1c		;delete text cpu subs
;
;	move	@teamset1_obj,a0,L
;	calla	DELOBJ	
;	move	@teamset2_obj,a0,L
;	calla	DELOBJ	
;	move	@name1_obj,a0,L
;	calla	DELOBJ	
;	move	@name2_obj,a0,L
;	calla	DELOBJ	
;	move	@name3_obj,a0,L
;	calla	DELOBJ	
;	move	@name4_obj,a0,L
;	calla	DELOBJ	
;
;	movk	9,a11
;	movi	attrib1_obj,a10
;	movi	attrib2_obj,a9
;	movi	attrib3_obj,a8
;	movi	attrib4_obj,a7
;
;lp	move	*a10+,a0,L
;	calla	DELOBJ
;	move	*a9+,a0,L
;	calla	DELOBJ
;	move	*a8+,a0,L
;	calla	DELOBJ
;	move	*a7+,a0,L
;	calla	DELOBJ
;	dsjs	a11,lp
;
;	movi	BAKLST,a14
;
;lp2	move	a14,a3		;A3=*Prev
;	move	*a14,a14,L	;A14=*Next
;	jrz	x
;cmp	move	*a14(OZPOS),a2
;	cmpi	60,a2
;	jrz	kil
;	cmpi	61,a2
;	jrne	lp2
;kil
;
;	move	*a14,*a3,L	;Unlink from obj list
;
;	move	@OFREE,*a14+,L	;Add to free list
;	subk	32,a14
;	move	a14,@OFREE,L
;	move	*a3,a14,L
;	jrnz	cmp
;x
;	move	@credit1_obj,a0,L
;	calla	DELOBJ
;	move	@credit2_obj,a0,L
;	calla	DELOBJ
;	move	@credit3_obj,a0,L
;	calla	DELOBJ
;	
;	clr	a0
;	callr	create_credits
;
;	rets

*******************************************************************************

 SUBR	brown_shadow
 	rets

;	movi	NBAPAL,a0
;	calla	pal_find
;	andi	0ff00h,a0
;	move	a0,a10
;
;;	callr	obj_ckpal
;;	rets
;
;
;	move	a10,a1			;dest pal
;	ori	52,a1	;26*16,a1	;26
;	movi	brown_shad,a0		;pal data
;	movk	3,a2			;3 colours
;	calla	pal_set
;	rets
;
;brown_shad
;	.word	11<<10+5<<5+0
;	.word	9<<10+3<<5+0
;	.word	7<<10+2<<5+0
;
;obj_ckpal
;	movi	OBJLST,a14
;	movi	kp_ram,a2
;	clr	a1
;	move	a1,*a2,L
;
;lp
;	move	*a14,a14,L	;A14=*Next
;	jrz	x
;	move	*a14(OPAL),a1
;	cmp	a0,a1
;	jrne	lp
;
;	move	a14,*a2+,L
;	clr	a1
;	move	a1,*a2,L
;	jruc	lp
;
;x
;	movi	kp_ram,a2
;lp2
;	move	*a2+,a0,L
;	jrz	xx
;	calla	DELOBJ
;	jruc	lp2
;xx
;	rets


*******************************************************************************

 SUBR	blue_shadow
	rets
;	movi	wood64b,a0		;NBAPAL,a0
;	calla	pal_find
;;	andi	0ff00h,a0
;	move	a0,a10
;
;
;	callr	obj_ckpal
;
;	movi	NBAPAL,a0		;NBAPAL,a0
;	calla	pal_find
;;	andi	0ff00h,a0
;	move	a0,a10
;
;
;	callr	obj_ckpal
;	rets
;
;
;	move	a10,a1			;dest pal
;	ori	52,a1	;26*16,a1	;26
;	movi	blue_shad,a0		;pal data
;	movk	3,a2			;3 colours
;	calla	pal_set
;	rets
;
;blue_shad
;	.word	0<<10+3<<5+6	;2
;	.word	0<<10+2<<5+4	;6
;	.word	0<<10+0<<5+0	;52


******************************************************************************
;challenger needed / teammate needed message
;on name entry screen
;a10 = player (0-3)

;;	.asg	105,CHALLY
	.asg	88,CHALLY

 SUBR	challenger

	move	a10,a0
	sll	4,a0
	addi	chall_xa,a0
	move	@TWOPLAYERS,a1		;0 = NO, 1 = YES 2 players
	jrz	not_2p
	addi	4*16,a0
not_2p
	move	*a0,a0
	sll	16,a0			;x val
	movi	[CHALLY,0],a1		;y val
;	move	@gmqrtr,a2
;	cmpi	2,a2
;	jrnz	skp
;	movi	[CHALLY+256,0],a1	;y val
skp
	movi	CHALENG,a2		;* image
	movi	1000,a3			;z pos
	movi	DMAWNZ,a4		;DMA flags
	clr	a5			;object ID
	clr	a6			;x vel
	clr	a7			;y vel
	calla	BEGINOBJ2

isoffa
	calla	obj_off
	SLEEPK	1
	move	@PSTATUS2,a0
	btst	a10,a0
	jrz	ison

	move	@PSTATUS2,a0
	btst	a10,a0

	jrnz	isoffa
ison
	move	@PSTATUS2,a0
	btst	a10,a0
	jrz	ison2

	movi	continue,a0		;* image
	movi	DMAWNZ,a1		;DMA flags
	calla	obj_aniq		;change object image
	calla	obj_on

wait7
	move	@can_enter_inits,a0	;finished initials entry?
	jrz	doneb
	SLEEPK	1
	move	@PSTATUS2,a0
	btst	a10,a0
	jrz	wait7
ison2
	calla	obj_on
loopf
	SLEEPK	1

	move	@can_enter_inits,a0	;finished initials entry?
	jrz	doneb

	move	@PSTATUS2,a0
	btst	a10,a0
	jrnz	isoffa

	move	@PCNT,a0		;frame count
	btst	6,a0
	jrnz	nojoina

	movi	join3,a0		;* image
	jruc	join
nojoina
	movi	CHALENG,a0		;* image
	move	a10,a1
	xori	1,a1			;teammate bit
	move	@PSTATUS2,a2
	btst	a1,a2
	jrz	ischall
	movi	TMATE,a0		;* image
ischall
join
	movi	DMAWNZ,a1		;DMA flags
	calla	obj_aniq		;change object image
	jruc	loopf
doneb
	calla	DELOBJA8
	DIE


chall_xa	.word	55,150,249,344	;x val
		.word	0,101,295,0	;x val  for KIT


******************************************************************************
;challenger needed message
;on team selection screen
;a10 = team (0-1)

	.asg	160-14+TEAMSEL_PAGE,CHALLY
;;;;	.asg	172-14+TEAMSEL_PAGE,CHALLY

 SUBR	challenger2

	move	a10,a0
	sll	4,a0
	addi	chall_xb,a0
	move	*a0,a0
	sll	16,a0			;x val
	movi	[CHALLY,0],a1		;y val
	movi	CHALENG,a2		;* image
	movi	1000,a3			;z pos
	movi	DMAWNZ,a4		;DMA flags
	clr	a5			;object ID
	clr	a6			;x vel
	clr	a7			;y vel
	calla	BEGINOBJ2

	move	a10,a11			;(0-1)
	sll	4,a11			;x 16 bits
	addi	team1,a11		;team1 or team2
isoffb
	calla	obj_off
	SLEEPK	1
	move	*a11,a0
	jrnn	isoffb

	calla	obj_on
loopg
	SLEEPK	1
	move	*a11,a0
	jrnn	isoffb

	movi	CHALENG,a0		;* image
	move	@PCNT,a1		;frame count
	btst	6,a1
	jrnz	nojoinb
	movi	join3,a0		;* image
nojoinb
	movi	DMAWNZ,a1		;DMA flags
	calla	obj_aniq		;change object image

	jruc	loopg

chall_xb	.word	101,295		;x val


******************************************************************************

 SUBR	drw_chicks
 	RETP



;;;;;;;;;;TABLES;;;;;;;;;;;;;
;;;;;;;;;;TABLES;;;;;;;;;;;;;
	.end
;DJT End