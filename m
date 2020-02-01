Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726913AbgBAP3K (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 1 Feb 2020 10:29:10 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 011FI9HP077619
        for <linux-s390@vger.kernel.org>; Sat, 1 Feb 2020 10:29:09 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xwa6mtdyr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 01 Feb 2020 10:29:08 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Sat, 1 Feb 2020 15:29:06 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v5 7/7] s390x: smp: Wait for cpu setup to finish
Date: Sat,  1 Feb 2020 10:28:51 -0500
In-Reply-To: <20200201152851.82867-1-frankja@linux.ibm.com>
References: <20200201152851.82867-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200201152851.82867-8-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

We store the user provided psw address into restart new, so a psw
restart does not lead us through setup again.

Also we wait on smp_cpu_setup() until the cpu has finished setup
before returning. This is necessary for z/VM and LPAR where sigp is
asynchronous.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 lib/s390x/smp.c  | 3 +++
 s390x/cstart64.S | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
index 4578003..3f86243 100644
--- a/lib/s390x/smp.c
+++ b/lib/s390x/smp.c
@@ -210,6 +210,9 @@ int smp_cpu_setup(uint16_t addr, struct psw psw)
 
 	/* Start processing */
 	smp_cpu_restart_nolock(addr, NULL);
+	/* Wait until the cpu has finished setup and started the provided psw */
+	while (lc->restart_new_psw.addr != psw.addr)
+		mb();
 out:
 	spin_unlock(&lock);
 	return rc;
diff --git a/s390x/cstart64.S b/s390x/cstart64.S
index 86dd4c4..9af6bb3 100644
--- a/s390x/cstart64.S
+++ b/s390x/cstart64.S
@@ -159,6 +159,8 @@ smp_cpu_setup_state:
 	xgr	%r1, %r1
 	lmg     %r0, %r15, GEN_LC_SW_INT_GRS
 	lctlg   %c0, %c0, GEN_LC_SW_INT_CRS
+	/* We should only go once through cpu setup and not for every restart */
+	stg	%r14, GEN_LC_RESTART_NEW_PSW + 8
 	br	%r14
 
 pgm_int:
-- 
2.20.1
