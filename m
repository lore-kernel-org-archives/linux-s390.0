Return-Path: <linux-kernel-owner+w=401wt.eu-S1756016AbYIYQpg@vger.kernel.org>
Message-Id: <20080925163020.021553473@de.ibm.com>
References: <20080925162827.818261893@de.ibm.com>
Date: Thu, 25 Sep 2008 18:28:30 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 3/6] kmsg: Kernel message catalog script.
Content-Disposition: inline; filename=802-kmsg-script.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Joe Perches <joe@perches.com>, Tim Hockin <thockin@hockin.org>, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, =?ISO-8859-15?q?Jochen=20Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>, Jan Blunck <jblunck@suse.de>, Rick Troth <rmt@casita.net>, Utz Bacher <utz.bacher@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Michael Holzheu <holzheu@de.ibm.com>

Add a script and the calls to the make process that allows to check the
kmsg_xxx and dev_xxx printk message and to format man pages from the
message descriptions.

The kmsg message description is a comment with the following format:

/*?
 * Tag: <component>.<hash>
 * Text: "<kmsg message text>"
 * Severity: <severity>
 * Parameter:
 *   @1: <description of the first message parameter>
 *   @2: <description of the second message parameter>
 *   ...
 * Description:
 * <What is the kmsg message all about>
 * User action:
 * <What can the user do to fix the problem>
 */

The following short form of a kmsg message can be used if the message does
not have a full documentation:

/*? Tag: <component>.<hash> Text: "<kmsg message text>" */

No man page will be printed for these messages.

The script looks for a kmsg comment for a tagged printk at three places,
the source file where the kmsg_xxx / dev_xxx call is located, and in the
files with the name <component> in the two directories Documentation/kmsg
and Documentation/$ARCH/kmsg.

The kmsg check is invoked with "make D=1". It will read the source files for
all objects that are built by the current configuration and searches for
matching kmsg descriptions for the tagged printk in the source. If a message
description can not be found the script prints a blueprint and causes a make
error.

The kmsg man page creation is invoked with "make D=2" and reads the source
files for all built objects, looks up the message description and writes
a man page to $(objtree)/man.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Makefile               |   16 +
 scripts/Makefile.build |   14 +
 scripts/kmsg-doc       |  466 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 496 insertions(+)

Index: kmsg-2.6/Makefile
===================================================================
--- kmsg-2.6.orig/Makefile
+++ kmsg-2.6/Makefile
@@ -63,6 +63,20 @@ ifndef KBUILD_CHECKSRC
   KBUILD_CHECKSRC = 0
 endif
 
+# Call message checker as part of the C compilation
+#
+# Use 'make D=1' to enable checking
+# Use 'make D=2' to create the message catalog
+
+ifdef D
+  ifeq ("$(origin D)", "command line")
+    KBUILD_KMSG_CHECK = $(D)
+  endif
+endif
+ifndef KBUILD_KMSG_CHECK
+  KBUILD_KMSG_CHECK = 0
+endif
+
 # Use make M=dir to specify directory of external module to build
 # Old syntax make ... SUBDIRS=$PWD is still supported
 # Setting the environment variable KBUILD_EXTMOD take precedence
@@ -321,6 +335,7 @@ PERL		= perl
 CHECK		= sparse
 
 CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise $(CF)
+KMSG_CHECK	= $(srctree)/scripts/kmsg-doc
 MODFLAGS	= -DMODULE
 CFLAGS_MODULE   = $(MODFLAGS)
 AFLAGS_MODULE   = $(MODFLAGS)
@@ -355,6 +370,7 @@ export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODU
 export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
 export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
 export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
+export KBUILD_KMSG_CHECK KMSG_CHECK
 
 # When compiling out-of-tree modules, put MODVERDIR in the module
 # tree rather than in the kernel tree. The kernel tree might
Index: kmsg-2.6/scripts/kmsg-doc
===================================================================
--- /dev/null
+++ kmsg-2.6/scripts/kmsg-doc
@@ -0,0 +1,466 @@
+#!/usr/bin/perl -w
+#
+# kmsg kernel messages check and print tool.
+#
+# To check the source code for missing messages the script is called
+# with check, the name compiler and the compile parameters
+#	kmsg-doc check $(CC) $(c_flags) $<
+# To create man pages for the messages the script is called with
+#	kmsg-doc print $(CC) $(c_flags) $<
+#
+# Copyright IBM Corp. 2008
+# Author(s):  Martin Schwidefsky <schwidefsky@de.ibm.com>
+#	      Michael Holzheu <holzheu@linux.vnet.ibm.com>
+#
+
+use Cwd;
+use Switch;
+
+my $errors = 0;
+my $warnings = 0;
+my $srctree = "";
+my $objtree = "";
+my $kmsg_count = 0;
+
+sub remove_quotes($)
+{
+    my ($string) = @_;
+    my $inside = 0;
+    my $slash = 0;
+    my $result = "";
+
+    foreach my $str (split(/([\\"])/, $string)) {
+        if ($inside && ($str ne "\"" || $slash)) {
+            $result .= $str;
+        }
+        # Check for backslash before quote
+        if ($str eq "\"") {
+            if (!$slash) {
+                $inside = !$inside;
+            }
+	     $slash = 0;
+        } elsif ($str eq "\\") {
+            $slash = !$slash;
+        } elsif ($str ne "") {
+            $slash = 0;
+        }
+    }
+    return $result;
+}
+
+sub string_to_bytes($)
+{
+    my ($string) = @_;
+    my %is_escape = ('"', 0x22, '\'', 0x27, 'n', 0x0a, 'r', 0x0d, 'b', 0x08,
+		     't', 0x09, 'f', 0x0c, 'a', 0x07, 'v', 0x0b, '?', 0x3f);
+    my (@ar, $slash, $len);
+
+    # scan string, interpret backslash escapes and write bytes to @ar
+    $len = 0;
+    foreach my $ch (split(//, $string)) {
+	if ($ch eq '\\') {
+	    $slash = !$slash;
+	    if (!$slash) {
+		$ar[$len] = ord('\\');
+		$len++;
+	    }
+	} elsif ($slash && defined $is_escape{$ch}) {
+	    # C99 backslash escapes: \\ \" \' \n \r \b \t \f \a \v \?
+	    $ar[$len] = $is_escape{$ch};
+	    $len++;
+	    $slash = 0;
+	} elsif ($slash) {
+	    # FIXME: C99 backslash escapes \nnn \xhh
+	    die("Unknown backslash escape in message $string.");
+	} else {
+	    # normal character
+	    $ar[$len] = ord($ch);
+	    $len++;
+	}
+    }
+    return @ar;
+}
+
+sub calc_jhash($)
+{
+    my ($string) = @_;
+    my @ar;
+    my ($a, $b, $c, $i, $length, $len);
+
+    @ar = string_to_bytes($string);
+    $length = @ar;
+    # add dummy elements to @ar to avoid if then else hell
+    push @ar, (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
+    $a = 0x9e3779b9;
+    $b = 0x9e3779b9;
+    $c = 0;
+    $i = 0;
+    for ($len = $length + 12; $len >= 12; $len -= 12) {
+	if ($len < 23) {
+	    # add length for last round
+	    $c += $length;
+	}
+	$a += $ar[$i] + ($ar[$i+1]<<8) + ($ar[$i+2]<<16) + ($ar[$i+3]<<24);
+	$b += $ar[$i+4] + ($ar[$i+5]<<8) + ($ar[$i+6]<<16) + ($ar[$i+7]<<24);
+	$c += $ar[$i+8] + ($ar[$i+9]<<8) + ($ar[$i+10]<<16) + ($ar[$i+11]<<24);
+	$a &= 0xffffffff; $b &= 0xffffffff; $c &= 0xffffffff;
+	$a -= $b; $a -= $c; $a ^= ($c >> 13); $a &= 0xffffffff;
+	$b -= $c; $b -= $a; $b ^= ($a << 8); $b &= 0xffffffff;
+	$c -= $a; $c -= $b; $c ^= ($b >> 13); $c &= 0xffffffff;
+	$a -= $b; $a -= $c; $a ^= ($c >> 12); $a &= 0xffffffff;
+	$b -= $c; $b -= $a; $b ^= ($a << 16); $b &= 0xffffffff;
+	$c -= $a; $c -= $b; $c ^= ($b >> 5); $c &= 0xffffffff;
+	$a -= $b; $a -= $c; $a ^= ($c >> 3); $a &= 0xffffffff;
+	$b -= $c; $b -= $a; $b ^= ($a << 10); $b &= 0xffffffff;
+	$c -= $a; $c -= $b; $c ^= ($b >> 15); $c &= 0xffffffff;
+	$i += 12;
+    }
+    return $c;
+}
+
+sub add_kmsg_desc($$$$$$)
+{
+    my ($tag, $text, $sev, $argv, $desc, $user) = @_;
+
+    if ($kmsg_desc{$tag}) {
+	warn "Duplicate message with tag $tag\n";
+	$errors++;
+	return;
+    }
+    $text = remove_quotes($text);
+    $kmsg_desc{$tag}->{'TEXT'} = $text;
+    $kmsg_desc{$tag}->{'SEV'} = $sev;
+    $kmsg_desc{$tag}->{'ARGV'} = $argv;
+    $kmsg_desc{$tag}->{'DESC'} = $desc;
+    $kmsg_desc{$tag}->{'USER'} = $user;
+}
+
+sub add_kmsg_print($$$$$)
+{
+    my ($component, $sev, $prefix, $text, $argv) = @_;
+    my ($hash, $tag, $count, $parm);
+
+    $text = remove_quotes($text);
+    $hash = substr(sprintf("%08x", calc_jhash($text)), 2, 6);
+    $tag = $component . "." . $hash;
+    # Pretty print severity
+    $sev =~ s/"<0>"/Emerg/;
+    $sev =~ s/"<1>"/Alert/;
+    $sev =~ s/"<2>"/Critical/;
+    $sev =~ s/"<3>"/Error/;
+    $sev =~ s/"<4>"/Warning/;
+    $sev =~ s/"<5>"/Notice/;
+    $sev =~ s/"<6>"/Informational/;
+    $sev =~ s/"<7>"/Debug/;
+    $kmsg_print{$kmsg_count}->{'TAG'} = $tag;
+    $kmsg_print{$kmsg_count}->{'TEXT'} = $prefix . $text;
+    $kmsg_print{$kmsg_count}->{'SEV'} = $sev;
+    $kmsg_print{$kmsg_count}->{'ARGV'} = $argv;
+    $kmsg_count += 1;
+}
+
+sub process_source_file($)
+{
+    my $file = "@_";
+    my $state;
+    my $component = "";
+    my ($tag, $text, $sev, $argv, $desc, $user);
+
+    if (!open(FD, "$file")) {
+	return "";
+    }
+
+    $state = 0;
+    while (<FD>) {
+	chomp;
+	# kmsg message component: #define KMSG_COMPONENT "<component>"
+	if (/^#define\s+KMSG_COMPONENT\s+\"(.*)\"[^\"]*$/o) {
+	    $component = $1;
+	}
+	if ($state == 0) {
+	    # single line kmsg for undocumented messages, format:
+	    # /*? Tag: <component>.<hash> Text: "<message>" */
+	    if (/^\s*\/\*\?\s*Tag:\s*(\S*)\s*Text:\s*(\".*\")\s*\*\/\s*$/o) {
+		add_kmsg_desc($1, $2, "", "", "", "");
+	    }
+	    # kmsg message start: '/*?'
+	    if (/^\s*\/\*\?\s*$/o) {
+		$state = 1;
+		($tag, $text, $sev, $argv, $desc, $user) = ( "", "", "", "", "", "" );
+	    }
+	} elsif ($state == 1) {
+	    # kmsg message end: ' */'
+	    if (/^\s*\*\/\s*/o) {
+		add_kmsg_desc($tag, $text, $sev, $argv, $desc, $user);
+		$state = 0;
+	    }
+	    # kmsg message tag: ' * Tag: <tag>'
+	    elsif (/^\s*\*\s*Tag:\s*(\S*)\s*$/o) {
+		$tag = $1;
+	    }
+	    # kmsg message text: ' * Text: "<message>"'
+	    elsif (/^\s*\*\s*Text:\s*(\".*\")\s*$/o) {
+		$text = $1;
+	    }
+	    # kmsg message severity: ' * Severity: <sev>'
+	    elsif (/^\s*\*\s*Severity:\s*(\S*)\s*$/o) {
+		$sev = $1;
+	    }
+	    # kmsg message parameter: ' * Parameter: <argv>'
+	    elsif (/^\s*\*\s*Parameter:\s*(\S*)\s*$/o) {
+		if (!defined($1)) {
+		    $argv = "";
+		} else {
+		    $argv = $1;
+		}
+		$state = 2;
+	    }
+	    # kmsg message description start: ' * Description:'
+	    elsif (/^\s*\*\s*Description:\s*(\S*)\s*$/o) {
+		if (!defined($1)) {
+		    $desc = "";
+		} else {
+		    $desc = $1;
+		}
+		$state = 3;
+	    }
+	    # kmsg has unrecognizable lines
+	    else {
+		warn "Warning(${file}:$.): Cannot understand $_";
+		$warnings++;
+		$state = 0;
+	    }
+	} elsif ($state == 2) {
+	    # kmsg message end: ' */'
+	    if (/^\s*\*\//o) {
+		warn "Warning(${file}:$.): Missing description, skipping message";
+		$warnings++;
+		$state = 0;
+	    }
+	    # kmsg message description start: ' * Description:'
+	    elsif (/^\s*\*\s*Description:\s*$/o) {
+		$desc = $1;
+		$state = 3;
+	    }
+	    # kmsg message parameter line: ' * <argv>'
+	    elsif (/^\s*\*(.*)$/o) {
+		$argv .= "\n" . $1;
+	    } else {
+		warn "Warning(${file}:$.): Cannot understand $_";
+		$warnings++;
+		$state = 0;
+	    }
+	} elsif ($state == 3) {
+	    # kmsg message end: ' */'
+	    if (/^\s*\*\/\s*/o) {
+		add_kmsg_desc($tag, $text, $sev, $argv, $desc, $user);
+		$state = 0;
+	    }
+	    # kmsg message description start: ' * User action:'
+	    elsif (/^\s*\*\s*User action:\s*$/o) {
+		$user = $1;
+		$state = 4;
+	    }
+	    # kmsg message description line: ' * <text>'
+	    elsif (/^\s*\*\s*(.*)$/o) {
+		$desc .= "\n" . $1;
+	    } else {
+		warn "Warning(${file}:$.): Cannot understand $_";
+		$warnings++;
+		$state = 0;
+	    }
+	} elsif ($state == 4) {
+	    # kmsg message end: ' */'
+	    if (/^\s*\*\/\s*/o) {
+		add_kmsg_desc($tag, $text, $sev, $argv, $desc, $user);
+		$state = 0;
+	    }
+	    # kmsg message user action line: ' * <text>'
+	    elsif (/^\s*\*\s*(.*)$/o) {
+		$user .= "\n" . $1;
+	    } else {
+		warn "Warning(${file}:$.): Cannot understand $_";
+		$warnings++;
+		$state = 0;
+	    }
+	}
+    }
+    return $component;
+}
+
+sub process_cpp_file($$$$)
+{
+    my ($cc, $options, $file, $component) = @_;
+
+    open(FD, "$cc $gcc_options|") or die ("Preprocessing failed.");
+
+    while (<FD>) {
+	chomp;
+	if (/.*__KMSG_PRINT\(\s*(\S*)\s*_FMT_(.*)_ARGS_\s*(.*)?_END_\s*\)/o) {
+	    if ($component ne "") {
+		add_kmsg_print($component, $1, "", $2, $3);
+	    } else {
+		warn "Error(${file}:$.): kmsg without component\n";
+		$errors++;
+	    }
+	} elsif (/.*__KMSG_DEV\(\s*(\S*)\s*_FMT_(.*)_ARGS_\s*(.*)?_END_\*s\)/o) {
+	    if ($component ne "") {
+		add_kmsg_print($component, $1, "%s: ", $2, $3);
+	    } else {
+		warn "Error(${file}:$.): kmsg without component\n";
+		$errors++;
+	    }
+	}
+    }
+}
+
+sub check_messages($)
+{
+    my $component = "@_";
+    my $failed = 0;
+
+    for ($i = 0; $i < $kmsg_count; $i++) {
+	$tag = $kmsg_print{$i}->{'TAG'};
+	if (!defined($kmsg_desc{$tag})) {
+	    add_kmsg_desc($tag,
+			  "\"" . $kmsg_print{$i}->{'TEXT'} . "\"",
+			  $kmsg_print{$i}->{'SEV'},
+			  $kmsg_print{$i}->{'ARGV'},
+			  "Please insert description here",
+			  "What is the user supposed to do");
+	    $kmsg_desc{$tag}->{'CHECK'} = 1;
+	    $failed = 1;
+	    warn "$component: Missing description for: $tag\n";
+	    $errors++;
+	    next;
+	}
+	if ($kmsg_print{$i}->{'TEXT'} ne $kmsg_desc{$tag}->{'TEXT'}) {
+	    warn "$component: format string mismatch for: $tag\n";
+	    warn "  --- $kmsg_print{$i}->{'TEXT'}\n";
+	    warn "  +++ $kmsg_desc{$tag}->{'TEXT'}\n";
+	    $errors++;
+	}
+    }
+    return $failed;
+}
+
+sub print_templates()
+{
+    print "Templates for missing messages:\n";
+    foreach $tag ( sort { $kmsg_desc{$a} <=> $kmsg_desc{$b} } keys %kmsg_desc ) {
+	if (!defined($kmsg_desc{$tag}->{'CHECK'})) {
+	    next;
+	}
+	print "/*?\n";
+	print " * Tag: $tag\n";
+	print " * Text: \"$kmsg_desc{$tag}->{'TEXT'}\"\n";
+	print " * Severity: $kmsg_desc{$tag}->{'SEV'}\n";
+	$argv = $kmsg_desc{$tag}->{'ARGV'};
+	if ($argv ne "") {
+	    print " * Parameter:\n";
+	    @parms = split(/\s*,\s*/,$kmsg_desc{$tag}->{'ARGV'});
+	    $count = 0;
+	    foreach $parm (@parms) {
+		$count += 1;
+		if (!($parm eq "")) {
+		    print " *   \@$count: $parm\n";
+		}
+	    }
+	}
+	print " * Description:\n";
+	print " * $kmsg_desc{$tag}->{'DESC'}\n";
+	print " * User action:\n";
+	print " * $kmsg_desc{$tag}->{'USER'}\n";
+	print " */\n\n";
+    }
+}
+
+sub write_man_pages()
+{
+    my $file;
+
+    foreach $tag (keys(%kmsg_desc)) {
+	if (defined($kmsg_desc{$tag}->{'CHECK'})) {
+	    next;
+	}
+	if ($kmsg_desc{$tag}->{'DESC'} eq "") {
+	    next;
+	}
+	$file = $objtree . "man/" . $tag . ".9";
+	if (!open(WR, ">$file")) {
+	    warn "Error: Cannot open file $file\n";
+	    $errors++;
+	    return;
+	}
+	print WR ".TH \"$tag\" 9 \"Linux Messages\" LINUX\n";
+	print WR ".SH Message\n";
+	print WR $tag . ": " . $kmsg_desc{$tag}->{'TEXT'} . "\n";
+	print WR ".SH Severity\n";
+	print WR "$kmsg_desc{$tag}->{'SEV'}\n";
+	$argv = $kmsg_desc{$tag}->{'ARGV'};
+	if ($argv ne "") {
+	    print WR ".SH Parameters\n";
+	    @parms = split(/\s*\n\s*/,$kmsg_desc{$tag}->{'ARGV'});
+	    foreach $parm (@parms) {
+		$parm =~ s/^\s*(.*)\s*$/$1/;
+		if (!($parm eq "")) {
+		    print WR "$parm\n\n";
+		}
+	    }
+	}
+	print WR ".SH Description";
+	print WR "$kmsg_desc{$tag}->{'DESC'}\n";
+	$user = $kmsg_desc{$tag}->{'USER'};
+	if ($user ne "") {
+	    print WR ".SH User action";
+	    print WR "$user\n";
+	}
+    }
+}
+
+if (defined($ENV{'srctree'})) {
+    $srctree = "$ENV{'srctree'}" . "/";
+} else {
+    $srctree = getcwd;
+}
+
+if (defined($ENV{'objtree'})) {
+    $objtree = "$ENV{'objtree'}" . "/";
+} else {
+    $objtree = getcwd;
+}
+
+if (defined($ENV{'SRCARCH'})) {
+    $srcarch = "$ENV{'SRCARCH'}" . "/";
+} else {
+    print "kmsg-doc called without a valid \$SRCARCH\n";
+    exit 1;
+}
+
+$option = shift;
+
+$cc = shift;
+$gcc_options = "-E -D __KMSG_CHECKER ";
+foreach $tmp (@ARGV) {
+    $tmp =~ s/\(/\\\(/;
+    $tmp =~ s/\)/\\\)/;
+    $gcc_options .= " $tmp";
+    $filename = $tmp;
+}
+
+$component = process_source_file($filename);
+if ($component ne "") {
+    process_source_file($srctree . "Documentation/kmsg/" . $srcarch . $component);
+    process_source_file($srctree . "Documentation/kmsg/" . $component);
+}
+
+if ($option eq "check") {
+    process_cpp_file($cc, $gcc_options, $filename, $component);
+    if (check_messages($component)) {
+	print_templates();
+    }
+} elsif ($option eq "print") {
+    write_man_pages();
+}
+
+exit($errors);
Index: kmsg-2.6/scripts/Makefile.build
===================================================================
--- kmsg-2.6.orig/scripts/Makefile.build
+++ kmsg-2.6/scripts/Makefile.build
@@ -211,12 +211,14 @@ endef
 # Built-in and composite module parts
 $(obj)/%.o: $(src)/%.c FORCE
 	$(call cmd,force_checksrc)
+	$(call cmd,force_check_kmsg)
 	$(call if_changed_rule,cc_o_c)
 
 # Single-part modules are special since we need to mark them in $(MODVERDIR)
 
 $(single-used-m): $(obj)/%.o: $(src)/%.c FORCE
 	$(call cmd,force_checksrc)
+	$(call cmd,force_check_kmsg)
 	$(call if_changed_rule,cc_o_c)
 	@{ echo $(@:.o=.ko); echo $@; } > $(MODVERDIR)/$(@F:.o=.mod)
 
@@ -339,6 +341,18 @@ $(multi-used-m) : %.o: $(multi-objs-m) F
 
 targets += $(multi-used-y) $(multi-used-m)
 
+# kmsg check tool
+ifneq ($(KBUILD_KMSG_CHECK),0)
+  ifeq ($(KBUILD_KMSG_CHECK),2)
+    kmsg_cmd := print
+    quiet_cmd_force_check_kmsg = KMSG_PRINT $<
+    $(shell [ -d $(objtree)/man ] || mkdir -p $(objtree)/man)
+  else
+    kmsg_cmd := check
+    quiet_cmd_force_check_kmsg = KMSG_CHECK $<
+  endif
+  cmd_force_check_kmsg = $(KMSG_CHECK) $(kmsg_cmd) $(CC) $(c_flags) $< ;
+endif
 
 # Descending
 # ---------------------------------------------------------------------------

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
