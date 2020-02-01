Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726814AbgBAP3G (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 1 Feb 2020 10:29:06 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 011FLVxj122834
        for <linux-s390@vger.kernel.org>; Sat, 1 Feb 2020 10:29:05 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xw66xpvat-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 01 Feb 2020 10:29:05 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Sat, 1 Feb 2020 15:29:03 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v5 3/7] s390x: Stop the cpu that is executing exit()
Date: Sat,  1 Feb 2020 10:28:47 -0500
In-Reply-To: <20200201152851.82867-1-frankja@linux.ibm.com>
References: <20200201152851.82867-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200201152851.82867-4-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

CPU 0 is not necessarily the CPU which does the exit if we ran into a
test abort situation. So, let's ask stap() which cpu does the exit and
stop it on exit.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/s390x/io.c b/lib/s390x/io.c
index 32f09b5..e091c37 100644
--- a/lib/s390x/io.c
+++ b/lib/s390x/io.c
@@ -46,6 +46,6 @@ void exit(int code)
 	smp_teardown();
 	printf("\nEXIT: STATUS=%d\n", ((code) << 1) | 1);
 	while (1) {
-		sigp(0, SIGP_STOP, 0, NULL);
+		sigp(stap(), SIGP_STOP, 0, NULL);
 	}
 }
-- 
2.20.1
