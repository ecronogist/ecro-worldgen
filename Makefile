dir			=$(./)
csrc		=$(wildcard src/*.c)
obj			=$(csrc:.c=.o)
dep			=$(obj:.o=.d)
target		=bin

PREFIX		=/usr/local
LDFLAGS		=-L/lib
LDLIBS		=-lm

eworldgen:	$(obj)
			$(CC)	-o	$@	$^	$(LDFLAGS)

-include	$(dep)
%.d:		%.c
			@$(CPP) $(CFLAGS) $< -MM -MT $(@:.d=.o) >$@ 

.PHONY:		sort
sort:
			mkdir -p ./obj ./dep
			mv ./src/*.o ./obj/
			mv ./src/*.d ./dep/

.PHONY:		clean
clean:
			rm	-rf	./obj
			rm	-rf	./dep

#.PHONY:		cleandep
#				cleandep:
#				rm -f $(dep)

.PHONY:		install
install: eworldgen
			mkdir	-p	$(DESTDIR)$(PREFIX)/bin
			cp		$<	$(DESTDIR)$(PREFIX)/bin/eworldgen

.PHONY:		uninstall
uninstall:
			rm -f $(DESTDIR)$(PREFIX)/bin/eworldgen
