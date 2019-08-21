Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbfHUKsU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 21 Aug 2019 06:48:20 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LAhoMZ138622
        for <linux-s390@vger.kernel.org>; Wed, 21 Aug 2019 06:48:20 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uh2jmw6te-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 21 Aug 2019 06:48:19 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 21 Aug 2019 11:48:17 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 1/4] s390x: Support PSW restart boot
Date: Wed, 21 Aug 2019 12:47:33 +0200
In-Reply-To: <20190821104736.1470-1-frankja@linux.ibm.com>
References: <20190821104736.1470-1-frankja@linux.ibm.com>
Message-Id: <20190821104736.1470-2-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

Add a boot PSW to PSW restart new, so we can also boot via a PSW
restart.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 s390x/flat.lds | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/s390x/flat.lds b/s390x/flat.lds
index 403d967..86dffac 100644
--- a/s390x/flat.lds
+++ b/s390x/flat.lds
@@ -1,14 +1,18 @@
 SECTIONS
 {
-	/*
-	 * Initial short psw for disk boot, with 31 bit addressing for
-	 * non z/Arch environment compatibility and the instruction
-	 * address 0x10000 (cstart64.S .init).
-	 */
 	.lowcore : {
+		/*
+		 * Initial short psw for disk boot, with 31 bit addressing for
+		 * non z/Arch environment compatibility and the instruction
+		 * address 0x10000 (cstart64.S .init).
+		 */
 		. = 0;
 		 LONG(0x00080000)
 		 LONG(0x80010000)
+		 /* Restart new PSW for booting via PSW restart. */
+		 . = 0x1a0;
+		 QUAD(0x0000000180000000)
+		 QUAD(0x0000000000010000)
 	}
 	. = 0x10000;
 	.text : {
-- 
2.17.0
