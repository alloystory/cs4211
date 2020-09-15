proctype p
	state   7 -(tr  12)-> state   2  [id   0 tp   2] [----G] /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:7 => wantp = 1
	state   2 -(tr  13)-> state   3  [id   1 tp   2] [----G] /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:8 => (!(wantq))
	state   3 -(tr  14)-> state   4  [id   2 tp   2] [----G] /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:9 => critical = (critical+1)
	state   4 -(tr  15)-> state   5  [id   3 tp   2] [----G] /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:10 => assert((critical==1))
	state   5 -(tr  16)-> state   6  [id   4 tp   2] [----G] /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:11 => critical = (critical-1)
	state   6 -(tr  17)-> state   7  [id   5 tp   2] [----G] /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:12 => wantp = 0
proctype q
	state   7 -(tr   5)-> state   2  [id  10 tp   2] [----G] /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:18 => wantq = 1
	state   2 -(tr   6)-> state   3  [id  11 tp   2] [----G] /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:19 => (!(wantp))
	state   3 -(tr   7)-> state   4  [id  12 tp   2] [----G] /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:20 => critical = (critical+1)
	state   4 -(tr   8)-> state   5  [id  13 tp   2] [----G] /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:21 => assert((critical==1))
	state   5 -(tr   9)-> state   6  [id  14 tp   2] [----G] /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:22 => critical = (critical-1)
	state   6 -(tr  10)-> state   7  [id  15 tp   2] [----G] /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:23 => wantq = 0
claim never_0
	state   2 -(tr   3)-> state   2  [id  20 tp   2] [----G] /Users/aloysius/Documents/Repositories/cs4211/jspin/usage-example/example-10.pml:3 => printf('*spd* 2 %d %d 2 wantp %d wantq %d\n',pc_value(0),pc_value(1),wantp,wantq)

Transition Type: A=atomic; D=d_step; L=local; G=global
Source-State Labels: p=progress; e=end; a=accept;

pan: elapsed time 1.6e+09 seconds
pan: rate         0 states/second
