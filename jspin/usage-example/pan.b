	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* CLAIM never_0 */
;
		;
		
	case 4: // STATE 5
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC q */

	case 5: // STATE 1
		;
		now.wantq = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 7: // STATE 3
		;
		now.critical = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 9: // STATE 5
		;
		now.critical = trpt->bup.oval;
		;
		goto R999;

	case 10: // STATE 6
		;
		now.wantq = trpt->bup.oval;
		;
		goto R999;

	case 11: // STATE 10
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC p */

	case 12: // STATE 1
		;
		now.wantp = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 14: // STATE 3
		;
		now.critical = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 16: // STATE 5
		;
		now.critical = trpt->bup.oval;
		;
		goto R999;

	case 17: // STATE 6
		;
		now.wantp = trpt->bup.oval;
		;
		goto R999;

	case 18: // STATE 10
		;
		p_restor(II);
		;
		;
		goto R999;
	}

