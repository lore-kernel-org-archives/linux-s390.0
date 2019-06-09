Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:55714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbfFIC1e (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 8 Jun 2019 22:27:34 -0400
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v3 27/33] s390: include/asm/debug.h add kerneldoc markups
Date: Sat,  8 Jun 2019 23:27:17 -0300
Message-Id: <62625860db165cead495ceae80239d122a6ea762.1560045490.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1560045490.git.mchehab+samsung@kernel.org>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

Instead of keeping the documentation inside s390dbf.rst,
move them to arch/s390/include/asm/debug.h, using standard
kernel-doc markups.

Keeping the documentation close to the code helps to keep it
updated. It also makes easier to document other stuff inside
debug.h, as all it needs is to add kernel-doc markups inside
it, as the file will be already be included at the produced
documentation.

-

Those were converted to kerneldoc using this script specially
designed to parse ths file, and manually editted:

<script>
use strict;

my $mode = "";
my $parameter = "";
my $ret = "";
my $descr = "";

sub add_var($)
{
	my $ln = shift;

	$ln =~ s/^\s+//;
	$ln =~ s/\s+$//;

	return if ($ln eq "");

	$ln =~ s/^(\S+)\s+/$1\t/;

	print " * \@$ln\n";
}

sub add_return($)
{
	my $ln = shift;

	print " *\n * Return:\n" if ($mode ne "Return Value:");

	$ln =~ s/^\s+//;
	$ln =~ s/\s+$//;

	return if ($ln eq "");

	print " * -   $ln\n";
}

sub add_description($)
{
	my $ln = shift;

	print " *\n * \n" if ($mode ne "Description:");

	$ln =~ s/^\s+//;
	$ln =~ s/\s+$//;

	return if ($ln eq "");

	print " * $ln\n";
}

sub flush_results()
{
	print " */\n\n";
}

while (<>) {
	if (m/^[\-]+$/) {
		flush_results();
		$mode = "";
		$parameter = "";
		$ret = "";
		$descr = "";
		next;
	}
	if (m/(Parameter:)(.*)/) {
		print " *\n" if ($mode eq "func");
		add_var($2);
		$mode = $1;
		next;
	}
	if (m/(Return Value:)(.*)/) {
		add_return($2);
		$mode = $1;
		next;
	}
	if (m/(Description:)(.*)/) {
		add_description($2);
		$mode = $1;
		next;
	}
	if ($mode eq "Parameter:") {
		add_var($_);
		next;
	}
	if ($mode eq "Return Value:") {
		add_return($_);
		next;
	}
	if ($mode eq "Description:") {
		add_description($_);
		next;
	}
	next if (m/^\s*$/);

	if (m/^\S+.*\s\*?(\S+)\s*\(/) {
		if ($mode eq "") {
			print "/**\n * $1()\n";
		} else {
			print " * $1()\n";
		}
		$mode="func";
	}
}
flush_results();
</script>

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/s390/s390dbf.rst | 672 +--------------------------------
 arch/s390/include/asm/debug.h  | 231 ++++++++++++
 2 files changed, 232 insertions(+), 671 deletions(-)

diff --git a/Documentation/s390/s390dbf.rst b/Documentation/s390/s390dbf.rst
index ec2a1faa414b..d2595b548879 100644
--- a/Documentation/s390/s390dbf.rst
+++ b/Documentation/s390/s390dbf.rst
@@ -104,684 +104,14 @@ the "debug_stoppable" sysctl. If you set "debug_stoppable" to 0 the debug
 feature cannot be stopped. If the debug feature is already stopped, it
 will stay deactivated.
 
-----------------------------------------------------------------------------
-
 Kernel Interfaces:
 ------------------
 
-::
-
-  debug_info_t *debug_register(char *name, int pages, int nr_areas,
-			       int buf_size);
-
-Parameter:
-	      name:
-			   Name of debug log (e.g. used for debugfs entry)
-	      pages:
-			   Number of pages, which will be allocated per area
-	      nr_areas:
-			   Number of debug areas
-	      buf_size:
-			   Size of data area in each debug entry
-
-Return Value:
-	Handle for generated debug area
-
-	  NULL if register failed
-
-Description:  Allocates memory for a debug log
-	      Must not be called within an interrupt handler
-
-----------------------------------------------------------------------------
-
-::
-
-  debug_info_t *debug_register_mode(char *name, int pages, int nr_areas,
-				    int buf_size, mode_t mode, uid_t uid,
-				    gid_t gid);
-
-Parameter:
-	      name:
-			   Name of debug log (e.g. used for debugfs entry)
-	      pages:
-			   Number of pages, which will be allocated per area
-	      nr_areas:
-			   Number of debug areas
-	      buf_size:
-			   Size of data area in each debug entry
-	      mode:
-			   File mode for debugfs files. E.g. S_IRWXUGO
-	      uid:
-			   User ID for debugfs files. Currently only 0 is
-			   supported.
-	      gid:
-			   Group ID for debugfs files. Currently only 0 is
-			   supported.
-
-Return Value:
-	      Handle for generated debug area
-
-		NULL if register failed
-
-Description:
-	      Allocates memory for a debug log
-	      Must not be called within an interrupt handler
-
----------------------------------------------------------------------------
-
-::
-
-  void debug_unregister (debug_info_t * id);
-
-Parameter:
-	       id:
-		    handle for debug log
-
-Return Value:
-	       none
-
-Description:
-	       frees memory for a debug log and removes all registered debug
-	       views.
-
-	       Must not be called within an interrupt handler
-
----------------------------------------------------------------------------
-
-::
-
-  void debug_set_level (debug_info_t * id, int new_level);
-
-Parameter:     id:        handle for debug log
-	       new_level: new debug level
-
-Return Value:
-	       none
-
-Description:
-	       Sets new actual debug level if new_level is valid.
-
----------------------------------------------------------------------------
-
-::
-
-  bool debug_level_enabled (debug_info_t * id, int level);
-
-Parameter:
-	      id:
-			  handle for debug log
-	      level:
-			  debug level
-
-Return Value:
-	      True if level is less or equal to the current debug level.
-
-Description:
-	      Returns true if debug events for the specified level would be
-	      logged. Otherwise returns false.
-
----------------------------------------------------------------------------
-
-::
-
-  void debug_stop_all(void);
-
-Parameter:
-	       none
-
-Return Value:
-	       none
-
-Description:
-	       stops the debug feature if stopping is allowed. Currently
-	       used in case of a kernel oops.
-
----------------------------------------------------------------------------
-
-::
-
-  debug_entry_t* debug_event (debug_info_t* id, int level, void* data,
-			      int length);
-
-Parameter:
-	       id:
-		       handle for debug log
-	       level:
-		       debug level
-	       data:
-		       pointer to data for debug entry
-	       length:
-		       length of data in bytes
-
-Return Value:
-	       Address of written debug entry
-
-Description:
-	       writes debug entry to active debug area (if level <= actual
-	       debug level)
-
----------------------------------------------------------------------------
-
-::
-
-  debug_entry_t* debug_int_event (debug_info_t * id, int level,
-				  unsigned int data);
-  debug_entry_t* debug_long_event(debug_info_t * id, int level,
-				  unsigned long data);
-
-Parameter:
-	       id:
-		       handle for debug log
-	       level:
-		       debug level
-	       data:
-		       integer value for debug entry
-
-Return Value:
-	       Address of written debug entry
-
-Description:
-	       writes debug entry to active debug area (if level <= actual
-	       debug level)
-
----------------------------------------------------------------------------
-
-::
-
-  debug_entry_t* debug_text_event (debug_info_t * id, int level,
-				   const char* data);
-
-Parameter:
-	       id:
-		       handle for debug log
-	       level:
-		       debug level
-	       data:
-		       string for debug entry
-
-Return Value:
-	       Address of written debug entry
-
-Description:
-	       writes debug entry in ascii format to active debug area
-	       (if level <= actual debug level)
-
----------------------------------------------------------------------------
-
-::
-
-  debug_entry_t* debug_sprintf_event (debug_info_t * id, int level,
-				      char* string,...);
-
-Parameter:
-	       id:
-		      handle for debug log
-	       level:
-		      debug level
-	       string:
-		      format string for debug entry
-	       ...:
-		      varargs used as in sprintf()
-
-Return Value:  Address of written debug entry
-
-Description:
-	       writes debug entry with format string and varargs (longs) to
-	       active debug area (if level $<=$ actual debug level).
-	       floats and long long datatypes cannot be used as varargs.
-
----------------------------------------------------------------------------
-
-::
-
-  debug_entry_t* debug_exception (debug_info_t* id, int level, void* data,
-				  int length);
-
-Parameter:
-	       id:
-		       handle for debug log
-	       level:
-		       debug level
-	       data:
-		       pointer to data for debug entry
-	       length:
-		       length of data in bytes
-
-Return Value:
-	       Address of written debug entry
-
-Description:
-	       writes debug entry to active debug area (if level <= actual
-	       debug level) and switches to next debug area
-
----------------------------------------------------------------------------
-
-::
-
-  debug_entry_t* debug_int_exception (debug_info_t * id, int level,
-				      unsigned int data);
-  debug_entry_t* debug_long_exception(debug_info_t * id, int level,
-				      unsigned long data);
-
-Parameter:     id:     handle for debug log
-	       level:  debug level
-	       data:   integer value for debug entry
-
-Return Value:  Address of written debug entry
-
-Description:   writes debug entry to active debug area (if level <= actual
-	       debug level) and switches to next debug area
-
----------------------------------------------------------------------------
-
-::
-
-  debug_entry_t* debug_text_exception (debug_info_t * id, int level,
-				       const char* data);
-
-Parameter:     id:     handle for debug log
-	       level:  debug level
-	       data:   string for debug entry
-
-Return Value:  Address of written debug entry
-
-Description:   writes debug entry in ascii format to active debug area
-	       (if level <= actual debug level) and switches to next debug
-	       area
-
----------------------------------------------------------------------------
-
-::
-
-  debug_entry_t* debug_sprintf_exception (debug_info_t * id, int level,
-					  char* string,...);
-
-Parameter:     id:    handle for debug log
-	       level: debug level
-	       string: format string for debug entry
-	       ...: varargs used as in sprintf()
-
-Return Value:  Address of written debug entry
-
-Description:   writes debug entry with format string and varargs (longs) to
-	       active debug area (if level $<=$ actual debug level) and
-	       switches to next debug area.
-	       floats and long long datatypes cannot be used as varargs.
-
----------------------------------------------------------------------------
-
-::
-
-  int debug_register_view (debug_info_t * id, struct debug_view *view);
-
-Parameter:     id:    handle for debug log
-	       view:  pointer to debug view struct
-
-Return Value:  0  : ok
-	       < 0: Error
-
-Description:   registers new debug view and creates debugfs dir entry
-
----------------------------------------------------------------------------
-
-::
-
-  int debug_unregister_view (debug_info_t * id, struct debug_view *view);
-
-Parameter:     id:    handle for debug log
-	       view:  pointer to debug view struct
-
-Return Value:  0  : ok
-	       < 0: Error
-
-Description:   unregisters debug view and removes debugfs dir entry
-
-
+.. kernel-doc:: arch/s390/include/asm/debug.h
 
 Predefined views:
 -----------------
 
-extern struct debug_view debug_hex_ascii_view;
-
-extern struct debug_view debug_raw_view;
-
-extern struct debug_view debug_sprintf_view;
-
-Examples
---------
-
-::
-
-  /*
-   * hex_ascii- + raw-view Example
-   */
-
-  #include <linux/init.h>
-  #include <asm/debug.h>
-
-  static debug_info_t* debug_info;
-
-  static int init(void)
-  {
-      /* register 4 debug areas with one page each and 4 byte data field */
-
-      debug_info = debug_register ("test", 1, 4, 4 );
-      debug_register_view(debug_info,&debug_hex_ascii_view);
-      debug_register_view(debug_info,&debug_raw_view);
-
-      debug_text_event(debug_info, 4 , "one ");
-      debug_int_exception(debug_info, 4, 4711);
-      debug_event(debug_info, 3, &debug_info, 4);
-
-      return 0;
-  }
-
-  static void cleanup(void)
-  {
-      debug_unregister (debug_info);
-  }
-
-  module_init(init);
-  module_exit(cleanup);
-
----------------------------------------------------------------------------
-
-::
-
-  /*
-   * sprintf-view Example
-   */
-
-  #include <linux/init.h>
-  #include <asm/debug.h>
-
-  static debug_info_t* debug_info;
-
-  static int init(void)
-  {
-      /* register 4 debug areas with one page each and data field for */
-      /* format string pointer + 2 varargs (= 3 * sizeof(long))       */
-
-      debug_info = debug_register ("test", 1, 4, sizeof(long) * 3);
-      debug_register_view(debug_info,&debug_sprintf_view);
-
-      debug_sprintf_event(debug_info, 2 , "first event in %s:%i\n",__FILE__,__LINE__);
-      debug_sprintf_exception(debug_info, 1, "pointer to debug info: %p\n",&debug_info);
-
-      return 0;
-  }
-
-  static void cleanup(void)
-  {
-      debug_unregister (debug_info);
-  }
-
-  module_init(init);
-  module_exit(cleanup);
-
-Debugfs Interface
------------------
-Views to the debug logs can be investigated through reading the corresponding
-debugfs-files:
-
-Example::
-
-  > ls /sys/kernel/debug/s390dbf/dasd
-  flush  hex_ascii  level pages raw
-  > cat /sys/kernel/debug/s390dbf/dasd/hex_ascii | sort -k2,2 -s
-  00 00974733272:680099 2 - 02 0006ad7e  07 ea 4a 90 | ....
-  00 00974733272:682210 2 - 02 0006ade6  46 52 45 45 | FREE
-  00 00974733272:682213 2 - 02 0006adf6  07 ea 4a 90 | ....
-  00 00974733272:682281 1 * 02 0006ab08  41 4c 4c 43 | EXCP
-  01 00974733272:682284 2 - 02 0006ab16  45 43 4b 44 | ECKD
-  01 00974733272:682287 2 - 02 0006ab28  00 00 00 04 | ....
-  01 00974733272:682289 2 - 02 0006ab3e  00 00 00 20 | ...
-  01 00974733272:682297 2 - 02 0006ad7e  07 ea 4a 90 | ....
-  01 00974733272:684384 2 - 00 0006ade6  46 52 45 45 | FREE
-  01 00974733272:684388 2 - 00 0006adf6  07 ea 4a 90 | ....
-
-See section about predefined views for explanation of the above output!
-
-Changing the debug level
-------------------------
-
-Example::
-
-
-  > cat /sys/kernel/debug/s390dbf/dasd/level
-  3
-  > echo "5" > /sys/kernel/debug/s390dbf/dasd/level
-  > cat /sys/kernel/debug/s390dbf/dasd/level
-  5
-
-Flushing debug areas
---------------------
-Debug areas can be flushed with piping the number of the desired
-area (0...n) to the debugfs file "flush". When using "-" all debug areas
-are flushed.
-
-Examples:
-
-1. Flush debug area 0::
-
-     > echo "0" > /sys/kernel/debug/s390dbf/dasd/flush
-
-2. Flush all debug areas::
-
-     > echo "-" > /sys/kernel/debug/s390dbf/dasd/flush
-
-Changing the size of debug areas
-------------------------------------
-It is possible the change the size of debug areas through piping
-the number of pages to the debugfs file "pages". The resize request will
-also flush the debug areas.
-
-Example:
-
-Define 4 pages for the debug areas of debug feature "dasd"::
-
-  > echo "4" > /sys/kernel/debug/s390dbf/dasd/pages
-
-Stooping the debug feature
---------------------------
-Example:
-
-1. Check if stopping is allowed::
-
-     > cat /proc/sys/s390dbf/debug_stoppable
-
-2. Stop debug feature::
-
-     > echo 0 > /proc/sys/s390dbf/debug_active
-
-lcrash Interface
-----------------
-It is planned that the dump analysis tool lcrash gets an additional command
-'s390dbf' to display all the debug logs. With this tool it will be possible
-to investigate the debug logs on a live system and with a memory dump after
-a system crash.
-
-Investigating raw memory
-------------------------
-One last possibility to investigate the debug logs at a live
-system and after a system crash is to look at the raw memory
-under VM or at the Service Element.
-It is possible to find the anker of the debug-logs through
-the 'debug_area_first' symbol in the System map. Then one has
-to follow the correct pointers of the data-structures defined
-in debug.h and find the debug-areas in memory.
-Normally modules which use the debug feature will also have
-a global variable with the pointer to the debug-logs. Following
-this pointer it will also be possible to find the debug logs in
-memory.
-
-For this method it is recommended to use '16 * x + 4' byte (x = 0..n)
-for the length of the data field in debug_register() in
-order to see the debug entries well formatted.
-
-
-Predefined Views
-----------------
-
-There are three predefined views: hex_ascii, raw and sprintf.
-The hex_ascii view shows the data field in hex and ascii representation
-(e.g. '45 43 4b 44 | ECKD').
-The raw view returns a bytestream as the debug areas are stored in memory.
-
-The sprintf view formats the debug entries in the same way as the sprintf
-function would do. The sprintf event/exception functions write to the
-debug entry a pointer to the format string (size = sizeof(long))
-and for each vararg a long value. So e.g. for a debug entry with a format
-string plus two varargs one would need to allocate a (3 * sizeof(long))
-byte data area in the debug_register() function.
-
-IMPORTANT:
-  Using "%s" in sprintf event functions is dangerous. You can only
-  use "%s" in the sprintf event functions, if the memory for the passed string
-  is available as long as the debug feature exists. The reason behind this is
-  that due to performance considerations only a pointer to the string is stored
-  in  the debug feature. If you log a string that is freed afterwards, you will
-  get an OOPS when inspecting the debug feature, because then the debug feature
-  will access the already freed memory.
-
-NOTE:
-  If using the sprintf view do NOT use other event/exception functions
-  than the sprintf-event and -exception functions.
-
-The format of the hex_ascii and sprintf view is as follows:
-
-- Number of area
-- Timestamp (formatted as seconds and microseconds since 00:00:00 Coordinated
-  Universal Time (UTC), January 1, 1970)
-- level of debug entry
-- Exception flag (* = Exception)
-- Cpu-Number of calling task
-- Return Address to caller
-- data field
-
-The format of the raw view is:
-
-- Header as described in debug.h
-- datafield
-
-A typical line of the hex_ascii view will look like the following (first line
-is only for explanation and will not be displayed when 'cating' the view):
-
-area  time           level exception cpu caller    data (hex + ascii)
---------------------------------------------------------------------------
-00    00964419409:440690 1 -         00  88023fe
-
-
-Defining views
---------------
-
-Views are specified with the 'debug_view' structure. There are defined
-callback functions which are used for reading and writing the debugfs files::
-
-  struct debug_view {
-	char name[DEBUG_MAX_PROCF_LEN];
-	debug_prolog_proc_t* prolog_proc;
-	debug_header_proc_t* header_proc;
-	debug_format_proc_t* format_proc;
-	debug_input_proc_t*  input_proc;
-	void*                private_data;
-  };
-
-where::
-
-  typedef int (debug_header_proc_t) (debug_info_t* id,
-				     struct debug_view* view,
-				     int area,
-				     debug_entry_t* entry,
-				     char* out_buf);
-
-  typedef int (debug_format_proc_t) (debug_info_t* id,
-				     struct debug_view* view, char* out_buf,
-				     const char* in_buf);
-  typedef int (debug_prolog_proc_t) (debug_info_t* id,
-				     struct debug_view* view,
-				     char* out_buf);
-  typedef int (debug_input_proc_t) (debug_info_t* id,
-				    struct debug_view* view,
-				    struct file* file, const char* user_buf,
-				    size_t in_buf_size, loff_t* offset);
-
-
-The "private_data" member can be used as pointer to view specific data.
-It is not used by the debug feature itself.
-
-The output when reading a debugfs file is structured like this::
-
-  "prolog_proc output"
-
-  "header_proc output 1"  "format_proc output 1"
-  "header_proc output 2"  "format_proc output 2"
-  "header_proc output 3"  "format_proc output 3"
-  ...
-
-When a view is read from the debugfs, the Debug Feature calls the
-'prolog_proc' once for writing the prolog.
-Then 'header_proc' and 'format_proc' are called for each
-existing debug entry.
-
-The input_proc can be used to implement functionality when it is written to
-the view (e.g. like with 'echo "0" > /sys/kernel/debug/s390dbf/dasd/level).
-
-For header_proc there can be used the default function
-debug_dflt_header_fn() which is defined in debug.h.
-and which produces the same header output as the predefined views.
-E.g::
-
-  00 00964419409:440761 2 - 00 88023ec
-
-In order to see how to use the callback functions check the implementation
-of the default views!
-
-Example::
-
-  #include <asm/debug.h>
-
-  #define UNKNOWNSTR "data: %08x"
-
-  const char* messages[] =
-  {"This error...........\n",
-   "That error...........\n",
-   "Problem..............\n",
-   "Something went wrong.\n",
-   "Everything ok........\n",
-   NULL
-  };
-
-  static int debug_test_format_fn(
-     debug_info_t * id, struct debug_view *view,
-     char *out_buf, const char *in_buf
-  )
-  {
-    int i, rc = 0;
-
-    if(id->buf_size >= 4) {
-       int msg_nr = *((int*)in_buf);
-       if(msg_nr < sizeof(messages)/sizeof(char*) - 1)
-	  rc += sprintf(out_buf, "%s", messages[msg_nr]);
-       else
-	  rc += sprintf(out_buf, UNKNOWNSTR, msg_nr);
-    }
-   out:
-     return rc;
-  }
-
-  struct debug_view debug_test_view = {
-    "myview",                 /* name of view */
-    NULL,                     /* no prolog */
-    &debug_dflt_header_fn,    /* default header for each entry */
-    &debug_test_format_fn,    /* our own format function */
-    NULL,                     /* no input function */
-    NULL                      /* no private data */
-  };
-
-test:
-=====
-
 ::
 
   debug_info_t *debug_info;
diff --git a/arch/s390/include/asm/debug.h b/arch/s390/include/asm/debug.h
index b94783f71322..b55486f70deb 100644
--- a/arch/s390/include/asm/debug.h
+++ b/arch/s390/include/asm/debug.h
@@ -95,25 +95,106 @@ debug_entry_t *debug_exception_common(debug_info_t *id, int level,
 
 /* Debug Feature API: */
 
+/**
+ * debug_register() - allocates memory for a debug log.
+ *
+ * @name:        Name of debug log (e.g. used for debugfs entry)
+ * @pages:       Number of pages, which will be allocated per area
+ * @nr_areas:    Number of debug areas
+ * @buf_size:    Size of data area in each debug entry
+ *
+ * Return:
+ * - Handler for generated debug area
+ * - %NULL if register failed
+ *
+ * Must not be called within an interrupt handler.
+ */
 debug_info_t *debug_register(const char *name, int pages, int nr_areas,
 			     int buf_size);
 
+/**
+ * debug_register_mode() - allocates memory for a debug log.
+ *
+ * @name:	Name of debug log (e.g. used for debugfs entry)
+ * @pages:	Number of pages, which will be allocated per area
+ * @nr_areas:	Number of debug areas
+ * @buf_size:	Size of data area in each debug entry
+ * @mode:	File mode for debugfs files. E.g. S_IRWXUGO
+ * @uid:	User ID for debugfs files. Currently only 0 is supported.
+ * @gid:	Group ID for debugfs files. Currently only 0 is supported.
+ *
+ * Return:
+ * - Handler for generated debug area
+ * - %NULL if register failed
+ *
+ * Must not be called within an interrupt handler
+ */
 debug_info_t *debug_register_mode(const char *name, int pages, int nr_areas,
 				  int buf_size, umode_t mode, uid_t uid,
 				  gid_t gid);
 
+/**
+ * debug_unregister() - frees memory for a debug log and removes all
+ *			registered debug
+ * views.
+ *
+ * @id:		handle for debug log
+ *
+ * Return:
+ *    none
+ *
+ * Must not be called within an interrupt handler
+ */
 void debug_unregister(debug_info_t *id);
 
+/**
+ * debug_set_level() -  Sets new actual debug level if new_level is valid.
+ *
+ * @id:		handle for debug log
+ * @new_level:	new debug level
+ *
+ * Return:
+ *    none
+ */
 void debug_set_level(debug_info_t *id, int new_level);
 
 void debug_set_critical(void);
+
+/**
+ * debug_stop_all() - stops the debug feature if stopping is allowed.
+ *
+ * Return:
+ * -   none
+ */
 void debug_stop_all(void);
 
+/**
+ * debug_level_enabled() - Returns true if debug events for the specified
+ *			   level would be logged. Otherwise returns false.
+ *
+ * @id:		handle for debug log
+ * @level:	debug level
+ *
+ * Return:
+ * - %true if level is less or equal to the current debug level.
+ */
 static inline bool debug_level_enabled(debug_info_t *id, int level)
 {
 	return level <= id->level;
 }
 
+/**
+ * debug_event() - writes debug entry to active debug area
+ *		   (if level <= actual debug level)
+ *
+ * @id:		handle for debug log
+ * @level:	debug level
+ * @data:	pointer to data for debug entry
+ * @length:	length of data in bytes
+ *
+ * Return:
+ * - Address of written debug entry
+ */
 static inline debug_entry_t *debug_event(debug_info_t *id, int level,
 					 void *data, int length)
 {
@@ -122,6 +203,18 @@ static inline debug_entry_t *debug_event(debug_info_t *id, int level,
 	return debug_event_common(id, level, data, length);
 }
 
+/**
+ * debug_int_event() - writes debug entry to active debug area
+ * 		       (if level <= actual debug level)
+ *
+ * @id:		handle for debug log
+ * @level:	debug level
+ * @tag:	integer value for debug entry
+ *
+ * Return:
+ * - Address of written debug entry
+ * - %NULL if error
+ */
 static inline debug_entry_t *debug_int_event(debug_info_t *id, int level,
 					     unsigned int tag)
 {
@@ -132,6 +225,18 @@ static inline debug_entry_t *debug_int_event(debug_info_t *id, int level,
 	return debug_event_common(id, level, &t, sizeof(unsigned int));
 }
 
+/**
+ * debug_long_event() - writes debug entry to active debug area
+ * 		       (if level <= actual debug level)
+ *
+ * @id:		handle for debug log
+ * @level:	debug level
+ * @tag:	integer value for debug entry
+ *
+ * Return:
+ * - Address of written debug entry
+ * - %NULL if error
+ */
 static inline debug_entry_t *debug_long_event(debug_info_t *id, int level,
 					      unsigned long tag)
 {
@@ -142,6 +247,18 @@ static inline debug_entry_t *debug_long_event(debug_info_t *id, int level,
 	return debug_event_common(id, level, &t, sizeof(unsigned long));
 }
 
+/**
+ * debug_text_event() - writes debug entry in ascii format to active
+ *			debug area (if level <= actual debug level)
+ *
+ * @id:		handle for debug log
+ * @level:	debug level
+ * @txt:	string for debug entry
+ *
+ * Return:
+ * - Address of written debug entry
+ * - %NULL if error
+ */
 static inline debug_entry_t *debug_text_event(debug_info_t *id, int level,
 					      const char *txt)
 {
@@ -158,6 +275,22 @@ extern debug_entry_t *
 __debug_sprintf_event(debug_info_t *id, int level, char *string, ...)
 	__attribute__ ((format(printf, 3, 4)));
 
+/**
+ * debug_sprintf_event() - writes debug entry with format string
+ *			   and varargs (longs) to active debug area
+ *			   (if level $<=$ actual debug level).
+ *
+ * @_id:	handle for debug log
+ * @_level:	debug level
+ * @_fmt:	format string for debug entry
+ * @...:	varargs used as in sprintf()
+ *
+ * Return:
+ * - Address of written debug entry
+ * - %NULL if error
+ *
+ * floats and long long datatypes cannot be used as varargs.
+ */
 #define debug_sprintf_event(_id, _level, _fmt, ...)			\
 ({									\
 	debug_entry_t *__ret;						\
@@ -172,6 +305,20 @@ __debug_sprintf_event(debug_info_t *id, int level, char *string, ...)
 	__ret;								\
 })
 
+/**
+ * debug_exception() - writes debug entry to active debug area
+ *		       (if level <= actual debug level) and switches
+ *		       to next debug area
+ *
+ * @id:		handle for debug log
+ * @level:	debug level
+ * @data:	pointer to data for debug entry
+ * @length:	length of data in bytes
+ *
+ * Return:
+ * - Address of written debug entry
+ * - %NULL if error
+ */
 static inline debug_entry_t *debug_exception(debug_info_t *id, int level,
 					     void *data, int length)
 {
@@ -180,6 +327,19 @@ static inline debug_entry_t *debug_exception(debug_info_t *id, int level,
 	return debug_exception_common(id, level, data, length);
 }
 
+/**
+ * debug_int_exception() - writes debug entry to active debug area
+ *			   (if level <= actual debug level)
+ *			   and switches to next debug area
+ *
+ * @id:		handle for debug log
+ * @level:	debug level
+ * @tag:	integer value for debug entry
+ *
+ * Return:
+ * - Address of written debug entry
+ * - %NULL if error
+ */
 static inline debug_entry_t *debug_int_exception(debug_info_t *id, int level,
 						 unsigned int tag)
 {
@@ -190,6 +350,19 @@ static inline debug_entry_t *debug_int_exception(debug_info_t *id, int level,
 	return debug_exception_common(id, level, &t, sizeof(unsigned int));
 }
 
+/**
+ * debug_long_exception() - writes debug entry to active debug area
+ *			   (if level <= actual debug level)
+ *			   and switches to next debug area
+ *
+ * @id:		handle for debug log
+ * @level:	debug level
+ * @tag:	integer value for debug entry
+ *
+ * Return:
+ * - Address of written debug entry
+ * - %NULL if error
+ */
 static inline debug_entry_t *debug_long_exception (debug_info_t *id, int level,
 						   unsigned long tag)
 {
@@ -200,6 +373,20 @@ static inline debug_entry_t *debug_long_exception (debug_info_t *id, int level,
 	return debug_exception_common(id, level, &t, sizeof(unsigned long));
 }
 
+/**
+ * debug_text_exception() - writes debug entry in ascii format to active
+ *			    debug area (if level <= actual debug level)
+ *			    and switches to next debug
+ * area
+ *
+ * @id:	handle for debug log
+ * @level:	debug level
+ * @txt:	string for debug entry
+ *
+ * Return:
+ * - Address of written debug entry
+ * - %NULL if error
+ */
 static inline debug_entry_t *debug_text_exception(debug_info_t *id, int level,
 						  const char *txt)
 {
@@ -216,6 +403,24 @@ extern debug_entry_t *
 __debug_sprintf_exception(debug_info_t *id, int level, char *string, ...)
 	__attribute__ ((format(printf, 3, 4)));
 
+
+/**
+ * debug_sprintf_exception() - writes debug entry with format string and
+ *			       varargs (longs) to active debug area
+ * 			       (if level $<=$ actual debug level)
+ *			       and switches to next debug area.
+ *
+ * @_id:	handle for debug log
+ * @_level:	debug level
+ * @_fmt:	format string for debug entry
+ * @...:	varargs used as in sprintf()
+ *
+ * Return:
+ * - Address of written debug entry
+ * - %NULL if error
+ *
+ * floats and long long datatypes cannot be used as varargs.
+ */
 #define debug_sprintf_exception(_id, _level, _fmt, ...)			\
 ({									\
 	debug_entry_t *__ret;						\
@@ -230,7 +435,33 @@ __debug_sprintf_exception(debug_info_t *id, int level, char *string, ...)
 	__ret;								\
 })
 
+/**
+ * debug_register_view() - registers new debug view and creates debugfs
+ *			   dir entry
+ *
+ * @id:	handle for debug log
+ * @view:	pointer to debug view struct
+ *
+ * Return:
+ * -   0  : ok
+ * -   < 0: Error
+ */
 int debug_register_view(debug_info_t *id, struct debug_view *view);
+
+/**
+ * debug_unregister_view()
+ *
+ * @id:	handle for debug log
+ * @view:	pointer to debug view struct
+ *
+ * Return:
+ * -   0  : ok
+ * -   < 0: Error
+ *
+ *
+ * unregisters debug view and removes debugfs dir entry
+ */
+
 int debug_unregister_view(debug_info_t *id, struct debug_view *view);
 
 /*
-- 
2.21.0
