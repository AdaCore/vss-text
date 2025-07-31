
# Common scenario variables of the GPR files:
#
# VSS_BUILD_PROFILE | BUILD_PROFILE = release | validation | development
#
# VSS_COVERAGE_MODE | COVERAGE_MODE = none | gcov
#
# VSS_CI_MODE | CI_MODE = none | on
#
# ADAFLAGS = ...
# GPRFLAGS = ...

PREFIX                 ?= /usr
GPRDIR                 ?= $(PREFIX)/share/gpr
LIBDIR                 ?= $(PREFIX)/lib
BINDIR                 ?= $(PREFIX)/bin
INSTALL_PROJECT_DIR    ?= $(DESTDIR)$(GPRDIR)
INSTALL_INCLUDE_DIR    ?= $(DESTDIR)$(PREFIX)/include/vss
INSTALL_EXEC_DIR       ?= $(DESTDIR)$(BINDIR)
INSTALL_LIBRARY_DIR    ?= $(DESTDIR)$(LIBDIR)
INSTALL_ALI_DIR        ?= $(INSTALL_LIBRARY_DIR)/vss/$(word 2, $(subst _, ,$*))

GPRBUILD_FLAGS = -p -j0 $(GPRFLAGS) \
	-XVSS_BUILD_PROFILE=$(word 1, $(subst _, ,$*)) \
	-XVSS_LIBRARY_TYPE=$(word 2, $(subst _, ,$*))
GPRINSTALL_FLAGS = $(GPRFLAGS) \
	-XVSS_BUILD_PROFILE=$(word 1, $(subst _, ,$*)) \
	-XVSS_LIBRARY_TYPE=$(word 2, $(subst _, ,$*)) \
	--build-name=$(word 2, $(subst _, ,$*)) \
	--build-var=LIBRARY_TYPE --build-var=VSS_LIBRARY_TYPE \
	--prefix=$(PREFIX) --exec-subdir=$(INSTALL_EXEC_DIR) \
	--lib-subdir=$(INSTALL_ALI_DIR) --project-subdir=$(INSTALL_PROJECT_DIR) \
	--link-lib-subdir=$(INSTALL_LIBRARY_DIR) --sources-subdir=$(INSTALL_INCLUDE_DIR)

OK_RE_TESTS := 615 # Number of re_tests to be passed

ifeq ($(OS),Windows_NT)
	VSS_PS=;
else
	VSS_PS=:
endif

.PHONY: docs

.NOTPARALLEL:

all: build-libs-development_relocatable

build-all-libs: \
	build-libs-release_relocatable build-libs-release_static build-libs-release_static-pic \
	build-libs-validation_relocatable build-libs-validation_static build-libs-validation_static-pic

build-libs-%:
	gprbuild $(GPRBUILD_FLAGS) gnat/vss_gnat.gpr
	gprbuild $(GPRBUILD_FLAGS) gnat/vss_text.gpr

install: install-libs-development_relocatable

install-all-libs: install-libs-release_static install-libs-release_static-pic install-libs-release_relocatable

install-libs-%:
	gprinstall $(GPRINSTALL_FLAGS)/gnat -f -p -P gnat/vss_gnat.gpr --install-name=vss_gnat
	gprinstall $(GPRINSTALL_FLAGS)/text -f -p -P gnat/vss_text.gpr --install-name=vss_text

generate: generate-development_static

generate-%:
	gprbuild $(GPRBUILD_FLAGS) gnat/tools/gen_ucd.gpr
	.objs/$(word 1, $(subst _, ,$*))/tools/gen_ucd data/ucd .objs/ucd.ada
	rm -f source/text/ucd/*.ad[sb]
	gnatchop -gnat2022 .objs/ucd.ada source/text/ucd

build-tests: build-tests-validation_static build-performance-release_static

build-tests-%:
	gprbuild $(GPRBUILD_FLAGS) gnat/tests/vss_text_tests.gpr
	gprbuild $(GPRBUILD_FLAGS) gnat/tests/vss_stream_tests.gpr

build-performance-%:
	gprbuild $(GPRBUILD_FLAGS) gnat/tests/vss_text_performance.gpr

check: build-tests check_text

check_text:
	.objs/validation/tests/test_characters data/ucd
	.objs/validation/tests/test_character_iterators
	.objs/validation/tests/test_character_markers
	.objs/validation/tests/test_converters
	.objs/validation/tests/test_grapheme_cluster_iterators data/ucd data/emoji
	.objs/validation/tests/test_line_iterators
	.objs/validation/tests/test_stream_element_vector
	.objs/validation/tests/test_text_streams
	.objs/validation/tests/test_string_append
	.objs/validation/tests/test_string_compare
	.objs/validation/tests/test_string_conversions
	.objs/validation/tests/test_string_hash
	.objs/validation/tests/test_string_insert
	.objs/validation/tests/test_string_buffer
	.objs/validation/tests/test_string_split
	.objs/validation/tests/test_string_split_lines
	.objs/validation/tests/test_string
	.objs/validation/tests/test_string_template
	.objs/validation/tests/test_string_vector
	.objs/validation/tests/test_transformer data/ucd testsuite/text/w3c-i18n-tests-casing/*.txt
	.objs/validation/tests/test_word_iterators data/ucd
	.objs/validation/tests/test_string_decoder iso-8859-1 false testsuite/text/converters/all_bytes.bin testsuite/text/converters/iso88591-utf8.txt
	.objs/validation/tests/test_string_decoder iso-8859-2 false testsuite/text/converters/all_bytes.bin testsuite/text/converters/iso88592-utf8.txt
	.objs/validation/tests/test_string_decoder iso-8859-5 false testsuite/text/converters/all_bytes.bin testsuite/text/converters/iso88595-utf8.txt
	.objs/validation/tests/test_string_decoder iso-8859-6 true testsuite/text/converters/all_bytes.bin testsuite/text/converters/iso88596-utf8.txt
	.objs/validation/tests/test_string_decoder iso-8859-7 true testsuite/text/converters/all_bytes.bin testsuite/text/converters/iso88597-utf8.txt
	.objs/validation/tests/test_string_decoder iso-8859-8 true testsuite/text/converters/all_bytes.bin testsuite/text/converters/iso88598-utf8.txt
	.objs/validation/tests/test_string_decoder iso-8859-9 false testsuite/text/converters/all_bytes.bin testsuite/text/converters/iso88599-utf8.txt
	.objs/validation/tests/test_string_decoder iso-8859-15 false testsuite/text/converters/all_bytes.bin testsuite/text/converters/iso885915-utf8.txt
	.objs/validation/tests/test_string_decoder koi8-r false testsuite/text/converters/all_bytes.bin testsuite/text/converters/koi8r-utf8.txt
	.objs/validation/tests/test_string_decoder EUC-JP false testsuite/text/converters/eucjp_chars.eucjp testsuite/text/converters/eucjp_chars-utf8.txt
	.objs/validation/tests/test_string_decoder shift-jis false testsuite/text/converters/sjis_chars.sjis testsuite/text/converters/sjis_chars-utf8.txt
	.objs/validation/tests/test_decimal_to_number /dev/null data/parse-number-fxx-test-data/data/*.txt
	.objs/release/tests/test_string_performance

check_install:
	echo 'with "vss_text.gpr";'                          >  example.gpr
	echo 'project Example is'                            >> example.gpr
	echo '   for Main use ("example.adb");'              >> example.gpr
	echo '   package Compiler is'                        >> example.gpr
	echo '      for Switches ("Ada") use ("-gnat2022");' >> example.gpr
	echo '   end Compiler;'                              >> example.gpr
	echo 'end Example;'                                  >> example.gpr
	echo 'with VSS.Strings;'                             >  example.adb
	echo 'procedure Example is'                          >> example.adb
	echo 'begin null; end;'                              >> example.adb
	gprbuild -aP $(INSTALL_PROJECT_DIR) -P example.gpr
	gprclean -aP $(INSTALL_PROJECT_DIR) -P example.gpr
	rm -f example.*

coverage:
	find .objs/ -name *.o | xargs -s 512 gcov || true

docs:
	make -C docs

clean:
	rm -rf .objs .libs

spellcheck:
	@STATUS=0; \
	for J in source/*/*.ads; do \
	  sed -e 's/#[^#]*#//g' -e "s/'\([A-Z]\)/ \1/g" $$J |   \
	  aspell list --lang=en --home-dir=./data/ --ignore-case > /tmp/spell.txt; \
	  if [ -s /tmp/spell.txt ] ; then \
	    echo "\n$$J:"; sort -u -f /tmp/spell.txt; STATUS=1; \
	  fi  \
	done; \
	if [ $$STATUS != 0 ] ; then \
	   echo "\n\nFIX SPELLING or append exceptions to data/.aspell.en.pws !!!" ; \
	   exit 1 ; \
	fi

spellcheck_json:
	for J in source/*/*.ads; do \
	  sed -e 's/#[^#]*#//g' -e "s/'\([A-Z]\)/ \1/g" $$J |   \
	  aspell list --lang=en --home-dir=./data/ --ignore-case > /tmp/spell.txt; \
	  if [ -s /tmp/spell.txt ] ; then \
	    sort -u -f /tmp/spell.txt | jq -R --arg file "$$J" '{description: "Wrong spelling: \(.)", fingerprint: ., severity: "major", location: {path: $$file, lines: {begin: 1} }}' ; \
	  fi  \
	done | jq -s 'reduce inputs as $$in (.; . + $$in)' > spellcheck.json
