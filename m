Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438172AbfITLYB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Sep 2019 07:24:01 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8KBMZEI174408
        for <linux-s390@vger.kernel.org>; Fri, 20 Sep 2019 07:24:00 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v4ufdw0fd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 20 Sep 2019 07:24:00 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 20 Sep 2019 12:23:58 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH] s390x: Add linemode buffer to fix newline on every print
Date: Fri, 20 Sep 2019 13:23:45 +0200
In-Reply-To: <43bb9ff6-4233-3f6f-8cdb-3a00d1662d4d@redhat.com>
References: <43bb9ff6-4233-3f6f-8cdb-3a00d1662d4d@redhat.com>
Message-Id: <20190920112345.2359-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

Linemode seems to add a newline for each sent message which makes
reading rather hard. Hence we add a small buffer and only print if
it's full or a newline is encountered.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 lib/s390x/sclp-console.c | 43 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/lib/s390x/sclp-console.c b/lib/s390x/sclp-console.c
index 19416b5..6067a1a 100644
--- a/lib/s390x/sclp-console.c
+++ b/lib/s390x/sclp-console.c
@@ -13,6 +13,7 @@
 #include <asm/page.h>
 #include <asm/arch_def.h>
 #include <asm/io.h>
+#include <asm/spinlock.h>
 #include "sclp.h"
 
 /*
@@ -87,6 +88,10 @@ static uint8_t _ascebc[256] = {
      0x90, 0x3F, 0x3F, 0x3F, 0x3F, 0xEA, 0x3F, 0xFF
 };
 
+static char lm_buff[120];
+static unsigned char lm_buff_off;
+static struct spinlock lm_buff_lock;
+
 static void sclp_print_ascii(const char *str)
 {
 	int len = strlen(str);
@@ -103,10 +108,10 @@ static void sclp_print_ascii(const char *str)
 	sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
 }
 
-static void sclp_print_lm(const char *str)
+static void lm_print(const char *buff, int len)
 {
 	unsigned char *ptr, *end, ch;
-	unsigned int count, offset, len;
+	unsigned int count, offset;
 	struct WriteEventData *sccb;
 	struct mdb *mdb;
 	struct mto *mto;
@@ -117,11 +122,10 @@ static void sclp_print_lm(const char *str)
 	end = (unsigned char *) sccb + 4096 - 1;
 	memset(sccb, 0, sizeof(*sccb));
 	ptr = (unsigned char *) &sccb->msg.mdb.mto;
-	len = strlen(str);
 	offset = 0;
 	do {
 		for (count = sizeof(*mto); offset < len; count++) {
-			ch = str[offset++];
+			ch = buff[offset++];
 			if (ch == 0x0a || ptr + count > end)
 				break;
 			ptr[count] = _ascebc[ch];
@@ -148,6 +152,37 @@ static void sclp_print_lm(const char *str)
 	sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
 }
 
+
+/*
+ * In contrast to the ascii console, linemode produces a new
+ * line with every write of data. The report() function uses
+ * several printf() calls to generate a line of data which
+ * would all end up on different lines.
+ *
+ * Hence we buffer here until we encounter a \n or the buffer
+ * is full. That means that linemode output can look a bit
+ * different from ascii and that it takes a bit longer for
+ * lines to appear.
+ */
+static void sclp_print_lm(const char *str)
+{
+	int i;
+	const int len = strlen(str);
+
+	spin_lock(&lm_buff_lock);
+
+	for (i = 0; i < len; i++) {
+		lm_buff[lm_buff_off++] = str[i];
+
+		/* Buffer full or newline? */
+		if (str[i] == '\n' || lm_buff_off == (ARRAY_SIZE(lm_buff) - 1)) {
+			lm_print(lm_buff, lm_buff_off);
+			lm_buff_off = 0;
+		}
+	}
+	spin_unlock(&lm_buff_lock);
+}
+
 /*
  * SCLP needs to be initialized by setting a send and receive mask,
  * indicating which messages the control program (we) want(s) to
-- 
2.17.2
