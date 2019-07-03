Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726621AbfGCKUW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 3 Jul 2019 06:20:22 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63AJCXM031041
        for <linux-s390@vger.kernel.org>; Wed, 3 Jul 2019 06:20:21 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tgrracsge-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 03 Jul 2019 06:20:20 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Wed, 3 Jul 2019 11:20:17 +0100
From: Steffen Maier <maier@linux.ibm.com>
Subject: [PATCH 1/3] docs: s390: restore important non-kdoc parts of s390dbf.rst
Date: Wed,  3 Jul 2019 12:19:47 +0200
In-Reply-To: <1562149189-1417-1-git-send-email-maier@linux.ibm.com>
References: <1562149189-1417-1-git-send-email-maier@linux.ibm.com>
Message-Id: <1562149189-1417-2-git-send-email-maier@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-doc@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org

Complements previous ("s390: include/asm/debug.h add kerneldoc markups")
which seemed to have dropped important non-kdoc parts such as
user space interface (level, size, flush)
as well as views and caution regarding strings in the sprintf view.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 Documentation/s390/s390dbf.rst | 339 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 339 insertions(+)

diff --git a/Documentation/s390/s390dbf.rst b/Documentation/s390/s390dbf.rst
index d2595b548879..01d66251643d 100644
--- a/Documentation/s390/s390dbf.rst
+++ b/Documentation/s390/s390dbf.rst
@@ -112,6 +112,345 @@ Kernel Interfaces:
 Predefined views:
 -----------------
 
+extern struct debug_view debug_hex_ascii_view;
+
+extern struct debug_view debug_raw_view;
+
+extern struct debug_view debug_sprintf_view;
+
+Examples
+--------
+
+::
+
+  /*
+   * hex_ascii- + raw-view Example
+   */
+
+  #include <linux/init.h>
+  #include <asm/debug.h>
+
+  static debug_info_t* debug_info;
+
+  static int init(void)
+  {
+      /* register 4 debug areas with one page each and 4 byte data field */
+
+      debug_info = debug_register ("test", 1, 4, 4 );
+      debug_register_view(debug_info,&debug_hex_ascii_view);
+      debug_register_view(debug_info,&debug_raw_view);
+
+      debug_text_event(debug_info, 4 , "one ");
+      debug_int_exception(debug_info, 4, 4711);
+      debug_event(debug_info, 3, &debug_info, 4);
+
+      return 0;
+  }
+
+  static void cleanup(void)
+  {
+      debug_unregister (debug_info);
+  }
+
+  module_init(init);
+  module_exit(cleanup);
+
+::
+
+  /*
+   * sprintf-view Example
+   */
+
+  #include <linux/init.h>
+  #include <asm/debug.h>
+
+  static debug_info_t* debug_info;
+
+  static int init(void)
+  {
+      /* register 4 debug areas with one page each and data field for */
+      /* format string pointer + 2 varargs (= 3 * sizeof(long))       */
+
+      debug_info = debug_register ("test", 1, 4, sizeof(long) * 3);
+      debug_register_view(debug_info,&debug_sprintf_view);
+
+      debug_sprintf_event(debug_info, 2 , "first event in %s:%i\n",__FILE__,__LINE__);
+      debug_sprintf_exception(debug_info, 1, "pointer to debug info: %p\n",&debug_info);
+
+      return 0;
+  }
+
+  static void cleanup(void)
+  {
+      debug_unregister (debug_info);
+  }
+
+  module_init(init);
+  module_exit(cleanup);
+
+Debugfs Interface
+-----------------
+Views to the debug logs can be investigated through reading the corresponding
+debugfs-files:
+
+Example::
+
+  > ls /sys/kernel/debug/s390dbf/dasd
+  flush  hex_ascii  level pages raw
+  > cat /sys/kernel/debug/s390dbf/dasd/hex_ascii | sort -k2,2 -s
+  00 00974733272:680099 2 - 02 0006ad7e  07 ea 4a 90 | ....
+  00 00974733272:682210 2 - 02 0006ade6  46 52 45 45 | FREE
+  00 00974733272:682213 2 - 02 0006adf6  07 ea 4a 90 | ....
+  00 00974733272:682281 1 * 02 0006ab08  41 4c 4c 43 | EXCP
+  01 00974733272:682284 2 - 02 0006ab16  45 43 4b 44 | ECKD
+  01 00974733272:682287 2 - 02 0006ab28  00 00 00 04 | ....
+  01 00974733272:682289 2 - 02 0006ab3e  00 00 00 20 | ...
+  01 00974733272:682297 2 - 02 0006ad7e  07 ea 4a 90 | ....
+  01 00974733272:684384 2 - 00 0006ade6  46 52 45 45 | FREE
+  01 00974733272:684388 2 - 00 0006adf6  07 ea 4a 90 | ....
+
+See section about predefined views for explanation of the above output!
+
+Changing the debug level
+------------------------
+
+Example::
+
+
+  > cat /sys/kernel/debug/s390dbf/dasd/level
+  3
+  > echo "5" > /sys/kernel/debug/s390dbf/dasd/level
+  > cat /sys/kernel/debug/s390dbf/dasd/level
+  5
+
+Flushing debug areas
+--------------------
+Debug areas can be flushed with piping the number of the desired
+area (0...n) to the debugfs file "flush". When using "-" all debug areas
+are flushed.
+
+Examples:
+
+1. Flush debug area 0::
+
+     > echo "0" > /sys/kernel/debug/s390dbf/dasd/flush
+
+2. Flush all debug areas::
+
+     > echo "-" > /sys/kernel/debug/s390dbf/dasd/flush
+
+Changing the size of debug areas
+------------------------------------
+It is possible the change the size of debug areas through piping
+the number of pages to the debugfs file "pages". The resize request will
+also flush the debug areas.
+
+Example:
+
+Define 4 pages for the debug areas of debug feature "dasd"::
+
+  > echo "4" > /sys/kernel/debug/s390dbf/dasd/pages
+
+Stooping the debug feature
+--------------------------
+Example:
+
+1. Check if stopping is allowed::
+
+     > cat /proc/sys/s390dbf/debug_stoppable
+
+2. Stop debug feature::
+
+     > echo 0 > /proc/sys/s390dbf/debug_active
+
+lcrash Interface
+----------------
+It is planned that the dump analysis tool lcrash gets an additional command
+'s390dbf' to display all the debug logs. With this tool it will be possible
+to investigate the debug logs on a live system and with a memory dump after
+a system crash.
+
+Investigating raw memory
+------------------------
+One last possibility to investigate the debug logs at a live
+system and after a system crash is to look at the raw memory
+under VM or at the Service Element.
+It is possible to find the anker of the debug-logs through
+the 'debug_area_first' symbol in the System map. Then one has
+to follow the correct pointers of the data-structures defined
+in debug.h and find the debug-areas in memory.
+Normally modules which use the debug feature will also have
+a global variable with the pointer to the debug-logs. Following
+this pointer it will also be possible to find the debug logs in
+memory.
+
+For this method it is recommended to use '16 * x + 4' byte (x = 0..n)
+for the length of the data field in debug_register() in
+order to see the debug entries well formatted.
+
+
+Predefined Views
+----------------
+
+There are three predefined views: hex_ascii, raw and sprintf.
+The hex_ascii view shows the data field in hex and ascii representation
+(e.g. '45 43 4b 44 | ECKD').
+The raw view returns a bytestream as the debug areas are stored in memory.
+
+The sprintf view formats the debug entries in the same way as the sprintf
+function would do. The sprintf event/exception functions write to the
+debug entry a pointer to the format string (size = sizeof(long))
+and for each vararg a long value. So e.g. for a debug entry with a format
+string plus two varargs one would need to allocate a (3 * sizeof(long))
+byte data area in the debug_register() function.
+
+IMPORTANT:
+  Using "%s" in sprintf event functions is dangerous. You can only
+  use "%s" in the sprintf event functions, if the memory for the passed string
+  is available as long as the debug feature exists. The reason behind this is
+  that due to performance considerations only a pointer to the string is stored
+  in  the debug feature. If you log a string that is freed afterwards, you will
+  get an OOPS when inspecting the debug feature, because then the debug feature
+  will access the already freed memory.
+
+NOTE:
+  If using the sprintf view do NOT use other event/exception functions
+  than the sprintf-event and -exception functions.
+
+The format of the hex_ascii and sprintf view is as follows:
+
+- Number of area
+- Timestamp (formatted as seconds and microseconds since 00:00:00 Coordinated
+  Universal Time (UTC), January 1, 1970)
+- level of debug entry
+- Exception flag (* = Exception)
+- Cpu-Number of calling task
+- Return Address to caller
+- data field
+
+The format of the raw view is:
+
+- Header as described in debug.h
+- datafield
+
+A typical line of the hex_ascii view will look like the following (first line
+is only for explanation and will not be displayed when 'cating' the view):
+
+area  time           level exception cpu caller    data (hex + ascii)
+--------------------------------------------------------------------------
+00    00964419409:440690 1 -         00  88023fe
+
+
+Defining views
+--------------
+
+Views are specified with the 'debug_view' structure. There are defined
+callback functions which are used for reading and writing the debugfs files::
+
+  struct debug_view {
+	char name[DEBUG_MAX_PROCF_LEN];
+	debug_prolog_proc_t* prolog_proc;
+	debug_header_proc_t* header_proc;
+	debug_format_proc_t* format_proc;
+	debug_input_proc_t*  input_proc;
+	void*                private_data;
+  };
+
+where::
+
+  typedef int (debug_header_proc_t) (debug_info_t* id,
+				     struct debug_view* view,
+				     int area,
+				     debug_entry_t* entry,
+				     char* out_buf);
+
+  typedef int (debug_format_proc_t) (debug_info_t* id,
+				     struct debug_view* view, char* out_buf,
+				     const char* in_buf);
+  typedef int (debug_prolog_proc_t) (debug_info_t* id,
+				     struct debug_view* view,
+				     char* out_buf);
+  typedef int (debug_input_proc_t) (debug_info_t* id,
+				    struct debug_view* view,
+				    struct file* file, const char* user_buf,
+				    size_t in_buf_size, loff_t* offset);
+
+
+The "private_data" member can be used as pointer to view specific data.
+It is not used by the debug feature itself.
+
+The output when reading a debugfs file is structured like this::
+
+  "prolog_proc output"
+
+  "header_proc output 1"  "format_proc output 1"
+  "header_proc output 2"  "format_proc output 2"
+  "header_proc output 3"  "format_proc output 3"
+  ...
+
+When a view is read from the debugfs, the Debug Feature calls the
+'prolog_proc' once for writing the prolog.
+Then 'header_proc' and 'format_proc' are called for each
+existing debug entry.
+
+The input_proc can be used to implement functionality when it is written to
+the view (e.g. like with 'echo "0" > /sys/kernel/debug/s390dbf/dasd/level).
+
+For header_proc there can be used the default function
+debug_dflt_header_fn() which is defined in debug.h.
+and which produces the same header output as the predefined views.
+E.g::
+
+  00 00964419409:440761 2 - 00 88023ec
+
+In order to see how to use the callback functions check the implementation
+of the default views!
+
+Example::
+
+  #include <asm/debug.h>
+
+  #define UNKNOWNSTR "data: %08x"
+
+  const char* messages[] =
+  {"This error...........\n",
+   "That error...........\n",
+   "Problem..............\n",
+   "Something went wrong.\n",
+   "Everything ok........\n",
+   NULL
+  };
+
+  static int debug_test_format_fn(
+     debug_info_t * id, struct debug_view *view,
+     char *out_buf, const char *in_buf
+  )
+  {
+    int i, rc = 0;
+
+    if(id->buf_size >= 4) {
+       int msg_nr = *((int*)in_buf);
+       if(msg_nr < sizeof(messages)/sizeof(char*) - 1)
+	  rc += sprintf(out_buf, "%s", messages[msg_nr]);
+       else
+	  rc += sprintf(out_buf, UNKNOWNSTR, msg_nr);
+    }
+   out:
+     return rc;
+  }
+
+  struct debug_view debug_test_view = {
+    "myview",                 /* name of view */
+    NULL,                     /* no prolog */
+    &debug_dflt_header_fn,    /* default header for each entry */
+    &debug_test_format_fn,    /* our own format function */
+    NULL,                     /* no input function */
+    NULL                      /* no private data */
+  };
+
+test:
+=====
+
 ::
 
   debug_info_t *debug_info;
-- 
1.8.3.1
