Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728779AbgAQKrF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Jan 2020 05:47:05 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00HAbvlg043228
        for <linux-s390@vger.kernel.org>; Fri, 17 Jan 2020 05:47:05 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xk0qsrex1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 17 Jan 2020 05:47:05 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 17 Jan 2020 10:47:03 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v3 7/9] s390x: smp: Remove unneeded cpu loops
Date: Fri, 17 Jan 2020 05:46:38 -0500
In-Reply-To: <20200117104640.1983-1-frankja@linux.ibm.com>
References: <20200117104640.1983-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200117104640.1983-8-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

Now that we have a loop which is executed after we return from the
main function of a secondary cpu, we can remove the surplus loops.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/smp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/s390x/smp.c b/s390x/smp.c
index 555ed72..c12a3db 100644
--- a/s390x/smp.c
+++ b/s390x/smp.c
@@ -29,15 +29,9 @@ static void wait_for_flag(void)
 	}
 }
 
-static void cpu_loop(void)
-{
-	for (;;) {}
-}
-
 static void test_func(void)
 {
 	testflag = 1;
-	cpu_loop();
 }
 
 static void test_start(void)
@@ -234,7 +228,7 @@ int main(void)
 
 	/* Setting up the cpu to give it a stack and lowcore */
 	psw.mask = extract_psw_mask();
-	psw.addr = (unsigned long)cpu_loop;
+	psw.addr = (unsigned long)test_func;
 	smp_cpu_setup(1, psw);
 	smp_cpu_stop(1);
 
-- 
2.20.1
