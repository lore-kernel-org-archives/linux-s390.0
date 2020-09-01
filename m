Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34822 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbgIAJSo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Sep 2020 05:18:44 -0400
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests GIT PULL 1/3] s390x: Add custom pgm cleanup function
Date: Tue,  1 Sep 2020 11:18:21 +0200
Message-Id: <20200901091823.14477-2-frankja@linux.ibm.com>
In-Reply-To: <20200901091823.14477-1-frankja@linux.ibm.com>
References: <20200901091823.14477-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.vnet.ibm.com, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

Sometimes we need to do cleanup which we don't necessarily want to add
to interrupt.c, so let's add a way to register a cleanup function.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200807111555.11169-2-frankja@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
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
2.25.4
