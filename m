Return-Path: <linux-kernel-owner+w=401wt.eu-S1756345AbYHODJX@vger.kernel.org>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
From: Joe Perches <joe@perches.com>
In-Reply-To: <b3ece790808141150s3770531bsc88ec387e0f840d3@mail.gmail.com>
References: <20080730165656.118280544@de.ibm.com>
	 <20080730171156.824640459@de.ibm.com>
	 <b3ece790808121735t21b4a629iaf6a968b30332d74@mail.gmail.com>
	 <1218733457.2651.11.camel@localhost>
	 <b3ece790808141150s3770531bsc88ec387e0f840d3@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 14 Aug 2008 20:08:59 -0700
Message-Id: <1218769739.24527.76.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tim Hockin <thockin@hockin.org>
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Jochen =?ISO-8859-1?Q?Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2008-08-14 at 11:50 -0700, Tim Hockin wrote:
>     // this is the actual implementation
>     extern void send_kmsg(int level, const char *fmt, ...);
>     // this is a convenience wrapper, maybe not needed as they get combinatoric
>     #define kmsg_err(fmt, ...) \
>     	send_kmsg(KERN_ERROR, fmt, ##__VA_ARGS__)
>   inside a subsystem-specific header:
>     #define mysubsys_kmsg_err(fmt, ...) \
>     	kmsg_err("mysubsys:" fmt "\n", ##__VA_ARGS__)
>   inside each subsystem-driver:
>     #define mydriver_kmsg_err(fmt, ...) \
>     	mysubsys_kmsg_err("mydriver:" fmt, ##__VA_ARGS__)
>   then the driver just calls:
>     mydriver_kmsg_err("something happened");

I think adding system/subsystem/driver prefixes
to function names is not good.

Though Martin Schwidefsky thinks KMSG_COMPONENT is necessary,
I am unconvinced.

Perhaps using something like Jason Baron's new dynamic
debug infrastructure, all the event logging functions
could optionally print KBUILD_MODNAME, __func__ and __line__
if desired.

> Do you see *every* printk() becoming a kmsg?
> Just printk() in drivers?
> Or just some hand-chosen printk()s ?

I'd prefer every printk(KERN_<level> become pr_<level>
and kernel.h be reorganized so that all logging functions
are declared in a separate include file, maybe logging.h

kmsg_<level> could eventually live in logging.h

Here's a reorganization of kernel.h:
----------------------

Create <linux/logging.h>
Move content of <linux/ratelimit.h> into <linux/logging.h>
Delete <linux/ratelimit.h>
Move logging content from <linux/kernel.h> into <linux/logging.h>

Signed-off-by: Joe Perches <joe@perches.com>
---
 include/linux/kernel.h    |  109 +----------------------------------
 include/linux/logging.h   |  139 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ratelimit.h |   27 ---------
 3 files changed, 141 insertions(+), 134 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2651f80..63e647b 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -15,13 +15,11 @@
 #include <linux/bitops.h>
 #include <linux/log2.h>
 #include <linux/typecheck.h>
-#include <linux/ratelimit.h>
+#include <linux/logging.h>
+
 #include <asm/byteorder.h>
 #include <asm/bug.h>
 
-extern const char linux_banner[];
-extern const char linux_proc_banner[];
-
 #define USHORT_MAX	((u16)(~0U))
 #define SHORT_MAX	((s16)(USHORT_MAX>>1))
 #define SHORT_MIN	(-SHORT_MAX - 1)
@@ -81,29 +79,6 @@ extern const char linux_proc_banner[];
  */
 #define lower_32_bits(n) ((u32)(n))
 
-#define	KERN_EMERG	"<0>"	/* system is unusable			*/
-#define	KERN_ALERT	"<1>"	/* action must be taken immediately	*/
-#define	KERN_CRIT	"<2>"	/* critical conditions			*/
-#define	KERN_ERR	"<3>"	/* error conditions			*/
-#define	KERN_WARNING	"<4>"	/* warning conditions			*/
-#define	KERN_NOTICE	"<5>"	/* normal but significant condition	*/
-#define	KERN_INFO	"<6>"	/* informational			*/
-#define	KERN_DEBUG	"<7>"	/* debug-level messages			*/
-
-/*
- * Annotation for a "continued" line of log printout (only done after a
- * line that had no enclosing \n). Only to be used by core/arch code
- * during early bootup (a continued line is not SMP-safe otherwise).
- */
-#define	KERN_CONT	""
-
-extern int console_printk[];
-
-#define console_loglevel (console_printk[0])
-#define default_message_loglevel (console_printk[1])
-#define minimum_console_loglevel (console_printk[2])
-#define default_console_loglevel (console_printk[3])
-
 struct completion;
 struct pt_regs;
 struct user;
@@ -190,48 +165,8 @@ extern int kernel_text_address(unsigned long addr);
 struct pid;
 extern struct pid *session_of_pgrp(struct pid *pgrp);
 
-#ifdef CONFIG_PRINTK
-asmlinkage int vprintk(const char *fmt, va_list args)
-	__attribute__ ((format (printf, 1, 0)));
-asmlinkage int printk(const char * fmt, ...)
-	__attribute__ ((format (printf, 1, 2))) __cold;
-
-extern struct ratelimit_state printk_ratelimit_state;
-extern int printk_ratelimit(void);
-extern bool printk_timed_ratelimit(unsigned long *caller_jiffies,
-				   unsigned int interval_msec);
-#else
-static inline int vprintk(const char *s, va_list args)
-	__attribute__ ((format (printf, 1, 0)));
-static inline int vprintk(const char *s, va_list args) { return 0; }
-static inline int printk(const char *s, ...)
-	__attribute__ ((format (printf, 1, 2)));
-static inline int __cold printk(const char *s, ...) { return 0; }
-static inline int printk_ratelimit(void) { return 0; }
-static inline bool printk_timed_ratelimit(unsigned long *caller_jiffies, \
-					  unsigned int interval_msec)	\
-		{ return false; }
-#endif
-
-extern void asmlinkage __attribute__((format(printf, 1, 2)))
-	early_printk(const char *fmt, ...);
-
 unsigned long int_sqrt(unsigned long);
 
-static inline void console_silent(void)
-{
-	console_loglevel = 0;
-}
-
-static inline void console_verbose(void)
-{
-	if (console_loglevel)
-		console_loglevel = 15;
-}
-
-extern void bust_spinlocks(int yes);
-extern void wake_up_klogd(void);
-extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 extern int panic_timeout;
 extern int panic_on_oops;
 extern int panic_on_unrecovered_nmi;
@@ -261,22 +196,6 @@ extern enum system_states {
 #define TAINT_OVERRIDDEN_ACPI_TABLE	(1<<8)
 #define TAINT_WARN			(1<<9)
 
-extern void dump_stack(void) __cold;
-
-enum {
-	DUMP_PREFIX_NONE,
-	DUMP_PREFIX_ADDRESS,
-	DUMP_PREFIX_OFFSET
-};
-extern void hex_dump_to_buffer(const void *buf, size_t len,
-				int rowsize, int groupsize,
-				char *linebuf, size_t linebuflen, bool ascii);
-extern void print_hex_dump(const char *level, const char *prefix_str,
-				int prefix_type, int rowsize, int groupsize,
-				const void *buf, size_t len, bool ascii);
-extern void print_hex_dump_bytes(const char *prefix_str, int prefix_type,
-			const void *buf, size_t len);
-
 extern const char hex_asc[];
 #define hex_asc_lo(x)	hex_asc[((x) & 0x0f)]
 #define hex_asc_hi(x)	hex_asc[((x) & 0xf0) >> 4]
@@ -288,30 +207,6 @@ static inline char *pack_hex_byte(char *buf, u8 byte)
 	return buf;
 }
 
-#define pr_emerg(fmt, arg...) \
-	printk(KERN_EMERG fmt, ##arg)
-#define pr_alert(fmt, arg...) \
-	printk(KERN_ALERT fmt, ##arg)
-#define pr_crit(fmt, arg...) \
-	printk(KERN_CRIT fmt, ##arg)
-#define pr_err(fmt, arg...) \
-	printk(KERN_ERR fmt, ##arg)
-#define pr_warning(fmt, arg...) \
-	printk(KERN_WARNING fmt, ##arg)
-#define pr_notice(fmt, arg...) \
-	printk(KERN_NOTICE fmt, ##arg)
-#define pr_info(fmt, arg...) \
-	printk(KERN_INFO fmt, ##arg)
-
-#ifdef DEBUG
-/* If you are writing a driver, please use dev_dbg instead */
-#define pr_debug(fmt, arg...) \
-	printk(KERN_DEBUG fmt, ##arg)
-#else
-#define pr_debug(fmt, arg...) \
-	({ if (0) printk(KERN_DEBUG fmt, ##arg); 0; })
-#endif
-
 /*
  *      Display an IP address in readable format.
  */
diff --git a/include/linux/logging.h b/include/linux/logging.h
new file mode 100644
index 0000000..63734cd
--- /dev/null
+++ b/include/linux/logging.h
@@ -0,0 +1,139 @@
+#ifndef _LINUX_LOGGING_H
+#define _LINUX_LOGGING_H
+
+#include <linux/param.h>
+
+extern const char linux_banner[];
+extern const char linux_proc_banner[];
+
+extern const char *print_tainted(void);
+
+extern int console_printk[];
+
+#define console_loglevel (console_printk[0])
+#define default_message_loglevel (console_printk[1])
+#define minimum_console_loglevel (console_printk[2])
+#define default_console_loglevel (console_printk[3])
+
+static inline void console_silent(void)
+{
+	console_loglevel = 0;
+}
+
+static inline void console_verbose(void)
+{
+	if (console_loglevel)
+		console_loglevel = 15;
+}
+
+
+#ifdef CONFIG_PRINTK
+asmlinkage int vprintk(const char *fmt, va_list args)
+	__attribute__ ((format (printf, 1, 0)));
+asmlinkage int printk(const char * fmt, ...)
+	__attribute__ ((format (printf, 1, 2))) __cold;
+
+extern struct ratelimit_state printk_ratelimit_state;
+extern int printk_ratelimit(void);
+extern bool printk_timed_ratelimit(unsigned long *caller_jiffies,
+				   unsigned int interval_msec);
+#else
+static inline int vprintk(const char *s, va_list args)
+	__attribute__ ((format (printf, 1, 0)));
+static inline int vprintk(const char *s, va_list args) { return 0; }
+static inline int printk(const char *s, ...)
+	__attribute__ ((format (printf, 1, 2)));
+static inline int __cold printk(const char *s, ...) { return 0; }
+static inline int printk_ratelimit(void) { return 0; }
+static inline bool printk_timed_ratelimit(unsigned long *caller_jiffies, \
+					  unsigned int interval_msec)	\
+		{ return false; }
+#endif
+
+extern void asmlinkage __attribute__((format(printf, 1, 2)))
+	early_printk(const char *fmt, ...);
+
+extern void dump_stack(void) __cold;
+
+enum {
+	DUMP_PREFIX_NONE,
+	DUMP_PREFIX_ADDRESS,
+	DUMP_PREFIX_OFFSET
+};
+extern void hex_dump_to_buffer(const void *buf, size_t len,
+				int rowsize, int groupsize,
+				char *linebuf, size_t linebuflen, bool ascii);
+extern void print_hex_dump(const char *level, const char *prefix_str,
+				int prefix_type, int rowsize, int groupsize,
+				const void *buf, size_t len, bool ascii);
+extern void print_hex_dump_bytes(const char *prefix_str, int prefix_type,
+			const void *buf, size_t len);
+
+#define	KERN_EMERG	"<0>"	/* system is unusable			*/
+#define	KERN_ALERT	"<1>"	/* action must be taken immediately	*/
+#define	KERN_CRIT	"<2>"	/* critical conditions			*/
+#define	KERN_ERR	"<3>"	/* error conditions			*/
+#define	KERN_WARNING	"<4>"	/* warning conditions			*/
+#define	KERN_NOTICE	"<5>"	/* normal but significant condition	*/
+#define	KERN_INFO	"<6>"	/* informational			*/
+#define	KERN_DEBUG	"<7>"	/* debug-level messages			*/
+
+/*
+ * Annotation for a "continued" line of log printout (only done after a
+ * line that had no enclosing \n). Only to be used by core/arch code
+ * during early bootup (a continued line is not SMP-safe otherwise).
+ */
+#define	KERN_CONT	""
+
+#define pr_emerg(fmt, arg...) \
+	printk(KERN_EMERG fmt, ##arg)
+#define pr_alert(fmt, arg...) \
+	printk(KERN_ALERT fmt, ##arg)
+#define pr_crit(fmt, arg...) \
+	printk(KERN_CRIT fmt, ##arg)
+#define pr_err(fmt, arg...) \
+	printk(KERN_ERR fmt, ##arg)
+#define pr_warning(fmt, arg...) \
+	printk(KERN_WARNING fmt, ##arg)
+#define pr_notice(fmt, arg...) \
+	printk(KERN_NOTICE fmt, ##arg)
+#define pr_info(fmt, arg...) \
+	printk(KERN_INFO fmt, ##arg)
+
+#ifdef DEBUG
+/* If you are writing a driver, please use dev_dbg instead */
+#define pr_debug(fmt, arg...) \
+	printk(KERN_DEBUG fmt, ##arg)
+#else
+#define pr_debug(fmt, arg...) \
+	({ if (0) printk(KERN_DEBUG fmt, ##arg); 0; })
+#endif
+
+extern void bust_spinlocks(int yes);
+extern void wake_up_klogd(void);
+extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
+
+#define DEFAULT_RATELIMIT_INTERVAL (5 * HZ)
+#define DEFAULT_RATELIMIT_BURST 10
+
+struct ratelimit_state {
+	int interval;
+	int burst;
+	int printed;
+	int missed;
+	unsigned long begin;
+};
+
+#define DEFINE_RATELIMIT_STATE(name, interval, burst)		\
+		struct ratelimit_state name = {interval, burst,}
+
+extern int __ratelimit(struct ratelimit_state *rs);
+
+static inline int ratelimit(void)
+{
+	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
+					DEFAULT_RATELIMIT_BURST);
+	return __ratelimit(&rs);
+}
+
+#endif
diff --git a/include/linux/ratelimit.h b/include/linux/ratelimit.h
deleted file mode 100644
index 18a5b9b..0000000
--- a/include/linux/ratelimit.h
+++ /dev/null
@@ -1,27 +0,0 @@
-#ifndef _LINUX_RATELIMIT_H
-#define _LINUX_RATELIMIT_H
-#include <linux/param.h>
-
-#define DEFAULT_RATELIMIT_INTERVAL (5 * HZ)
-#define DEFAULT_RATELIMIT_BURST 10
-
-struct ratelimit_state {
-	int interval;
-	int burst;
-	int printed;
-	int missed;
-	unsigned long begin;
-};
-
-#define DEFINE_RATELIMIT_STATE(name, interval, burst)		\
-		struct ratelimit_state name = {interval, burst,}
-
-extern int __ratelimit(struct ratelimit_state *rs);
-
-static inline int ratelimit(void)
-{
-	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
-					DEFAULT_RATELIMIT_BURST);
-	return __ratelimit(&rs);
-}
-#endif
