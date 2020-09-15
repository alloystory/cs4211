#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* CLAIM never_0 */
	case 3: // STATE 1 - /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.nvr:3 - [printf('*spd* 2 %d %d 2 wantp %d wantq %d\\n',pc_value(0),pc_value(1),wantp,wantq)] (0:0:0 - 0)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[2][1] = 1;
		Printf("*spd* 2 %d %d 2 wantp %d wantq %d\n", ((P0 *) Pptr(0+BASE))->_p, ((P0 *) Pptr(1+BASE))->_p, ((int)now.wantp), ((int)now.wantq));
		_m = 3; goto P999; /* 0 */
	case 4: // STATE 5 - /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.nvr:6 - [-end-] (0:0:0 - 0)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported5 = 0;
			if (verbose && !reported5)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported5 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported5 = 0;
			if (verbose && !reported5)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported5 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[2][5] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC q */
	case 5: // STATE 1 - /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:18 - [wantq = 1] (0:0:1 - 0)
		IfNotBlocked
		reached[1][1] = 1;
		(trpt+1)->bup.oval = ((int)now.wantq);
		now.wantq = 1;
#ifdef VAR_RANGES
		logval("wantq", ((int)now.wantq));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 2 - /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:19 - [(!(wantp))] (0:0:0 - 0)
		IfNotBlocked
		reached[1][2] = 1;
		if (!( !(((int)now.wantp))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 7: // STATE 3 - /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:20 - [critical = (critical+1)] (0:0:1 - 0)
		IfNotBlocked
		reached[1][3] = 1;
		(trpt+1)->bup.oval = ((int)now.critical);
		now.critical = (((int)now.critical)+1);
#ifdef VAR_RANGES
		logval("critical", ((int)now.critical));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 8: // STATE 4 - /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:21 - [assert((critical==1))] (0:0:0 - 0)
		IfNotBlocked
		reached[1][4] = 1;
		spin_assert((((int)now.critical)==1), "(critical==1)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 9: // STATE 5 - /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:22 - [critical = (critical-1)] (0:0:1 - 0)
		IfNotBlocked
		reached[1][5] = 1;
		(trpt+1)->bup.oval = ((int)now.critical);
		now.critical = (((int)now.critical)-1);
#ifdef VAR_RANGES
		logval("critical", ((int)now.critical));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 6 - /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:23 - [wantq = 0] (0:0:1 - 0)
		IfNotBlocked
		reached[1][6] = 1;
		(trpt+1)->bup.oval = ((int)now.wantq);
		now.wantq = 0;
#ifdef VAR_RANGES
		logval("wantq", ((int)now.wantq));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 11: // STATE 10 - /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:25 - [-end-] (0:0:0 - 0)
		IfNotBlocked
		reached[1][10] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC p */
	case 12: // STATE 1 - /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:7 - [wantp = 1] (0:0:1 - 0)
		IfNotBlocked
		reached[0][1] = 1;
		(trpt+1)->bup.oval = ((int)now.wantp);
		now.wantp = 1;
#ifdef VAR_RANGES
		logval("wantp", ((int)now.wantp));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 2 - /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:8 - [(!(wantq))] (0:0:0 - 0)
		IfNotBlocked
		reached[0][2] = 1;
		if (!( !(((int)now.wantq))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 14: // STATE 3 - /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:9 - [critical = (critical+1)] (0:0:1 - 0)
		IfNotBlocked
		reached[0][3] = 1;
		(trpt+1)->bup.oval = ((int)now.critical);
		now.critical = (((int)now.critical)+1);
#ifdef VAR_RANGES
		logval("critical", ((int)now.critical));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 15: // STATE 4 - /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:10 - [assert((critical==1))] (0:0:0 - 0)
		IfNotBlocked
		reached[0][4] = 1;
		spin_assert((((int)now.critical)==1), "(critical==1)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 16: // STATE 5 - /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:11 - [critical = (critical-1)] (0:0:1 - 0)
		IfNotBlocked
		reached[0][5] = 1;
		(trpt+1)->bup.oval = ((int)now.critical);
		now.critical = (((int)now.critical)-1);
#ifdef VAR_RANGES
		logval("critical", ((int)now.critical));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 17: // STATE 6 - /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:12 - [wantp = 0] (0:0:1 - 0)
		IfNotBlocked
		reached[0][6] = 1;
		(trpt+1)->bup.oval = ((int)now.wantp);
		now.wantp = 0;
#ifdef VAR_RANGES
		logval("wantp", ((int)now.wantp));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 18: // STATE 10 - /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:14 - [-end-] (0:0:0 - 0)
		IfNotBlocked
		reached[0][10] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

