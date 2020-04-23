Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726541AbgDWJKb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Apr 2020 05:10:31 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03N93Wjs025953
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 05:10:30 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30k3xu7bbj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 05:10:30 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 23 Apr 2020 10:09:41 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v2 06/10] s390x: smp: Remove unneeded cpu loops
Date: Thu, 23 Apr 2020 05:10:09 -0400
In-Reply-To: <20200423091013.11587-1-frankja@linux.ibm.com>
References: <20200423091013.11587-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200423091013.11587-7-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com

Now that we have a loop which is executed after we return from the
main function of a secondary cpu, we can remove the surplus loops.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 s390x/smp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/s390x/smp.c b/s390x/smp.c
index a8e3dd7..7462211 100644
--- a/s390x/smp.c
+++ b/s390x/smp.c
@@ -35,15 +35,9 @@ static void set_flag(int val)
 	mb();
 }
 
-static void cpu_loop(void)
-{
-	for (;;) {}
-}
-
 static void test_func(void)
 {
 	set_flag(1);
-	cpu_loop();
 }
 
 static void test_start(void)
@@ -292,7 +286,7 @@ int main(void)
 
 	/* Setting up the cpu to give it a stack and lowcore */
 	psw.mask = extract_psw_mask();
-	psw.addr = (unsigned long)cpu_loop;
+	psw.addr = (unsigned long)test_func;
 	smp_cpu_setup(1, psw);
 	smp_cpu_stop(1);
 
-- 
2.25.1
