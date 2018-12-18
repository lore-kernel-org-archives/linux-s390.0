From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 18 Dec 2018 09:26:57 +0000
Subject: [kvm-unit-tests RFC v3 13/13] lib/report: Add stamps to reports
Message-Id: <20181218092657.46466-14-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Lets add a function to get stamps for our reports. It'll help with
finding the test case that was causing problems in dumps.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---

I know this should be a common discussion and it will be later. But
first I want to get a few opinions here, especially about how to wire
that up. Using ifdefs? Enabling via argv?

My current plan for s390 is to register a wrapper of time_get_ns()
that prints "[%ld]" as the stamp prefix. As other archs might have
other values or might want to include the cpu# I kept it as generic as
possible.

---
 lib/libcflat.h |  1 +
 lib/report.c   | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/lib/libcflat.h b/lib/libcflat.h
index 7529958..4d462f8 100644
--- a/lib/libcflat.h
+++ b/lib/libcflat.h
@@ -98,6 +98,7 @@ extern int vsnprintf(char *buf, int size, const char *fmt, va_list va)
 extern int vprintf(const char *fmt, va_list va)
 					__attribute__((format(printf, 1, 0)));
 
+extern void report_register_stamp(char * (*func)(void));
 void report_prefix_pushf(const char *prefix_fmt, ...)
 					__attribute__((format(printf, 1, 2)));
 extern void report_prefix_push(const char *prefix);
diff --git a/lib/report.c b/lib/report.c
index ca9b4fd..586db63 100644
--- a/lib/report.c
+++ b/lib/report.c
@@ -16,9 +16,17 @@
 static unsigned int tests, failures, xfailures, skipped;
 static char prefixes[256];
 static struct spinlock lock;
+static char * (*stamp_func)(void);
 
 #define PREFIX_DELIMITER ": "
 
+void report_register_stamp(char * (*func)(void))
+{
+	spin_lock(&lock);
+	stamp_func = func;
+	spin_unlock(&lock);
+}
+
 void report_pass(void)
 {
 	spin_lock(&lock);
@@ -90,6 +98,8 @@ static void va_report(const char *msg_fmt,
 	spin_lock(&lock);
 
 	tests++;
+	if (stamp_func)
+		printf("%s ", stamp_func());
 	printf("%s: ", prefix);
 	puts(prefixes);
 	vprintf(msg_fmt, va);
-- 
2.14.3
