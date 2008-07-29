Return-Path: <linux-kernel-owner+w=401wt.eu-S1757331AbYG2LJY@vger.kernel.org>
Subject: Re: [patch 02/15] kmsg: Kernel message catalog script.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20080729084536.GA29659@uranus.ravnborg.org>
References: <20080728175355.734299984@de.ibm.com>
	 <20080728175511.260174666@de.ibm.com>
	 <20080728192828.GA11431@uranus.ravnborg.org>
	 <1217320950.10259.15.camel@localhost>
	 <20080729084536.GA29659@uranus.ravnborg.org>
Content-Type: text/plain
Date: Tue, 29 Jul 2008 13:09:10 +0200
Message-Id: <1217329750.10259.38.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Michael Holzheu <holzheu@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2008-07-29 at 10:45 +0200, Sam Ravnborg wrote:
> On Tue, Jul 29, 2008 at 10:42:30AM +0200, Martin Schwidefsky wrote:
> > On Mon, 2008-07-28 at 21:28 +0200, Sam Ravnborg wrote:
> > > > 
> > > > The kmsg man page creation is invoked with "make K=2" and reads the source
> > > > files for all built objects, looks up the message description and writes
> > > > a man page to $(objtree)/man.
> > > Can we use M=2 instead of K=?
> > > I have sort of reserved 'K' for Kconfig usage.
> > 
> > Ok, K= is taken but I can't use M= either because that is used for KBUILD_EXTMOD.
> > If tested with D= for "documentation", would that be okay ?
> 
> D sounds fine with me.
> 
> Dunno what drugs I was on when I suggested M :-(

Or not enough drugs: It is by caffeine alone I set my mind in motion, ..

The new patch with your proposed changes below. I still do not feel too
comfortable with changing the main Makefiles, the kmsg-doc script
currently only works for s390 and the D= option is added for all
architectures. I was thinking about replacing the hardcoded s390 with
$ARCH and keep the option to add the second path Documentation/kmsg for
common code kmsgs if a miracle happens and they get used by common code.
If that should happen the kmsg.h header would have to be moved out of
asm-s390 as well. Makes sense?

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

--
Subject: [PATCH] kmsg: Kernel message catalog script.

From: Michael Holzheu <holzheu@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add a script and the calls to the make process that allows to check the
kmsg printk messages and to format man pages from the message descriptions.

The kmsg message description is a comment with the following format:

/*?
 * Tag: <component>.<id>
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

The script looks for a kmsg comment for a kmsg printk at two places,
the source file where the kmsg call is located and in the file
Documentation/s390/kmsg/<component>.

The kmsg check is invoked with "make K=1" and reads the source files for
all objects that are built by the current configuration and searches for
matching kmsg descriptions for the kmsg messages in the source which
have a messages id > 0. If a message description can not be found the
script prints a blueprint and causes a make error.

The kmsg man page creation is invoked with "make K=2" and reads the source
files for all built objects, looks up the message description and writes
a man page to $(objtree)/man.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Makefile               |   16 ++
 scripts/Makefile.build |   14 +
 scripts/kmsg-doc       |  358 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 388 insertions(+)

diff -urpN linux-2.6/Makefile linux-2.6-patched/Makefile
--- linux-2.6/Makefile	2008-07-29 11:32:45.000000000 +0200
+++ linux-2.6-patched/Makefile	2008-07-29 11:33:06.000000000 +0200
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
diff -urpN linux-2.6/scripts/kmsg-doc linux-2.6-patched/scripts/kmsg-doc
--- linux-2.6/scripts/kmsg-doc	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/scripts/kmsg-doc	2008-07-29 11:33:06.000000000 +0200
@@ -0,0 +1,358 @@
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
+
+my $errors = 0;
+my $warnings = 0;
+my $srctree = "";
+my $objtree = "";
+my $kmsg_count = 0;
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
+    $text =~ s/\" \"//g; # remove ...
+    $kmsg_desc{$tag}->{'TEXT'} = $text;
+    $kmsg_desc{$tag}->{'SEV'} = $sev;
+    $kmsg_desc{$tag}->{'ARGV'} = $argv;
+    $kmsg_desc{$tag}->{'DESC'} = $desc;
+    $kmsg_desc{$tag}->{'USER'} = $user;
+}
+
+sub add_kmsg_print($$$$$)
+{
+    my ($component, $id, $text, $sev, $argv) = @_;
+    my ($tag, $count, $parm);
+
+    if ($id == 0) {
+	return;
+    }
+    $text =~ s/\\n//g; # remove trailing newline character
+    $text =~ s/\" \"//g; # remove ...
+    $text =~ s/$component:\s*//g;
+    $tag = $component . "." . $id;
+    # Pretty print severity
+    $sev =~ s/EMERG/Emerg/;
+    $sev =~ s/ALERT/Alert/;
+    $sev =~ s/CRIT/Critical/;
+    $sev =~ s/ERR/Error/;
+    $sev =~ s/WARNING/Warning/;
+    $sev =~ s/NOTICE/Notice/;
+    $sev =~ s/INFO/Informational/;
+    $sev =~ s/DEBUG/Debug/;
+    $kmsg_print{$kmsg_count}->{'TAG'} = $tag;
+    $kmsg_print{$kmsg_count}->{'TEXT'} = $text;
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
+	# kmsg message component: #define KMSG_COMPONENT "<id>"
+	if (/^#define\s+KMSG_COMPONENT\s+\"(.*)\"[^\"]*$/o) {
+	    $component = $1;
+	}
+	if ($state == 0) {
+	    # kmsg message start: '/*?'
+	    if (/^\s*\/\*\?\s*$/o) {
+		$state = 1;
+		($tag, $text, $sev, $argv, $desc, $user) = ( "", "", "", "", "", "" );
+	    }
+	} elsif ($state == 1) {
+	    # kmsg message tag: ' * Tag: <tag>'
+	    if (/^\s*\*\s*Tag:\s*(\S*)\s*$/o) {
+		$tag = $1;
+	    }
+	    # kmsg message text: ' * Text: "<message>"'
+	    elsif (/^\s*\*\s*Text:\s*\"(.*)\"\s*$/o) {
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
+	if (/.*printk\(\s*__KMSG_CHECK\s*\(([^,]*)\,\s*(\d+)\s*\)\s*\"(.*)\"\s*,\s*(.*)\s*\)/o) {
+	    if ($component ne "") {
+		add_kmsg_print($component, $2, $3, $1, $4)
+	    } else {
+		warn "Error(${file}:$.): kmsg without component\n";
+		$errors++;
+	    }
+	} elsif (/.*printk\(\s*__KMSG_CHECK\s*\(([^,]*)\,\s*(\d+)\s*\)\s*\"(.*)\"\s*(.*)\s*\)/o) {
+	    if ($component ne "") {
+		add_kmsg_print($component, $2, $3, $1, $4)
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
+			  $kmsg_print{$i}->{'TEXT'},
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
+    @tags = keys %kmsg_desc;
+    @nums = ();
+    for (@tags) {
+	push @nums, /\.(\d+)/;
+    }
+    foreach $tag (@tags[ sort { $nums[$a] <=> $nums[$b] } 0..$#tags ]) {
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
+	$file = $objtree . "man/" . $tag;
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
+	    @parms = split(/,/,$kmsg_desc{$tag}->{'ARGV'});
+	    map{s/\s*//} @parms;
+	    foreach $parm (@parms) {
+		$parm =~ s/^\s+//;
+		if (!($parm eq "")) {
+		    print WR "$parm\n";
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
+    process_source_file($srctree . "Documentation/s390/kmsg/" . $component);
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
diff -urpN linux-2.6/scripts/Makefile.build linux-2.6-patched/scripts/Makefile.build
--- linux-2.6/scripts/Makefile.build	2008-07-13 23:51:29.000000000 +0200
+++ linux-2.6-patched/scripts/Makefile.build	2008-07-29 11:33:06.000000000 +0200
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
