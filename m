Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726226AbgHGLQG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Aug 2020 07:16:06 -0400
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 1/3] s390x: Add custom pgm cleanup function
Date: Fri,  7 Aug 2020 07:15:53 -0400
Message-Id: <20200807111555.11169-2-frankja@linux.ibm.com>
In-Reply-To: <20200807111555.11169-1-frankja@linux.ibm.com>
References: <20200807111555.11169-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, imbrenda@linux.ibm.com

Sometimes we need to do cleanup which we don't necessarily want to add
to interrupt.c, so let's add a way to register a cleanup function.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 lib/s390x/asm/interrupt.h |  1 +
 lib/s390x/interrupt.c     | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/s390x/asm/interrupt.h b/lib/s390x/asm/interrupt.h
index 4cfade9..2772e6b 100644
--- a/lib/s390x/asm/interrupt.h
+++ b/lib/s390x/asm/interrupt.h
@@ -15,6 +15,7 @@
 #define EXT_IRQ_EXTERNAL_CALL	0x1202
 #define EXT_IRQ_SERVICE_SIG	0x2401
 
+void register_pgm_cleanup_func(void (*f)(void));
 void handle_pgm_int(void);
 void handle_ext_int(void);
 void handle_mcck_int(void);
diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
index 243b9c2..a074505 100644
--- a/lib/s390x/interrupt.c
+++ b/lib/s390x/interrupt.c
@@ -16,6 +16,7 @@
 
 static bool pgm_int_expected;
 static bool ext_int_expected;
+static void (*pgm_cleanup_func)(void);
 static struct lowcore *lc;
 
 void expect_pgm_int(void)
@@ -51,6 +52,11 @@ void check_pgm_int_code(uint16_t code)
 	       lc->pgm_int_code);
 }
 
+void register_pgm_cleanup_func(void (*f)(void))
+{
+	pgm_cleanup_func = f;
+}
+
 static void fixup_pgm_int(void)
 {
 	switch (lc->pgm_int_code) {
@@ -115,7 +121,11 @@ void handle_pgm_int(void)
 	}
 
 	pgm_int_expected = false;
-	fixup_pgm_int();
+
+	if (pgm_cleanup_func)
+		(*pgm_cleanup_func)();
+	else
+		fixup_pgm_int();
 }
 
 void handle_ext_int(void)
-- 
2.25.1
