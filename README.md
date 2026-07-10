# golfet.sh
golfed fet.sh  
![screenshot](screenshot.png)

### Installing
download fet.sh and run it with ```sh fet.sh```

### Customization
`fet.sh` has a few basic configuration options using environment variables, for example:
```
$ info='n os wm sh n' fet.sh
```
Supported options are:
- `accent` (0-7)
- `info`
- `separator`
- `colourblocks`

For less trivial configuration I recommend editing the script, ~~I tried to keep it simple.~~ good luck

### Known Issues (upstream)
MacOS, BSD, and Android don't show much info.

### known issues with minified code
I think openbsd cpu vendor output might end up being slightly different here but I don't have a system to test on at the moment.  minor thing anyway  
I also think I might've fixed a bug on freebsd inadvertently
env pollution is something to contend with but that's out of scope for code golf.  run it with a clean env and you'll be ok

### unknown issues
I minified the hell out of this and don't strictly know what does or doesn't work when or where.  I have no QA pipeline, I'm just winging it.  
it still does it's primary function acting as a fetch tool, but inherited any bugs from fet.sh and probably gained a few new ones in the process
