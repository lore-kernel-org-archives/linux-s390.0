Return-Path: <linux-doc-owner@vger.kernel.org>
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 32/57] s390: include/asm/debug.h add kerneldoc markups
Date: Mon, 15 Apr 2019 23:55:57 -0300
Message-Id: <bc2830acc1469ab34f801e0786132deafe810e59.1555382110.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-doc/>
List-Post: <mailto:linux-doc@vger.kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Instead of keeping the documentation inside s390dbf.txt,
move them to arch/s390/include/asm/debug.h, using standard
kernel-doc markups.

Those were converted to kerneldoc using this specially made
script and manually editted:

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
 Documentation/s390/s390dbf.txt | 322 +--------------------------------
 arch/s390/include/asm/debug.h  | 231 +++++++++++++++++++++++
 2 files changed, 232 insertions(+), 321 deletions(-)

diff --git a/Documentation/s390/s390dbf.txt b/Documentation/s390/s390dbf.txt
index 549dba50fc3b..b0ca0d142ea1 100644
--- a/Documentation/s390/s390dbf.txt
+++ b/Documentation/s390/s390dbf.txt
@@ -107,327 +107,7 @@ will stay deactivated.
 Kernel Interfaces:
 ------------------
 
-----------------------------------------------------------------------------
-
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
-debug_entry_t* debug_text_exception (debug_info_t * id, int level,
-				     const char* data);
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
-debug_entry_t* debug_sprintf_exception (debug_info_t * id, int level,
-					char* string,...);
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
-int debug_register_view (debug_info_t * id, struct debug_view *view);
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
-int debug_unregister_view (debug_info_t * id, struct debug_view *view);
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
diff --git a/arch/s390/include/asm/debug.h b/arch/s390/include/asm/debug.h
index c305d39f5016..7cc83938c659 100644
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
2.20.1
