Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729154AbgAUNnZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Jan 2020 08:43:25 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00LDgXH1133612
        for <linux-s390@vger.kernel.org>; Tue, 21 Jan 2020 08:43:24 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xp0s6unby-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 21 Jan 2020 08:43:24 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 21 Jan 2020 13:43:22 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v4 6/9] s390x: smp: Loop if secondary cpu returns into cpu setup again
Date: Tue, 21 Jan 2020 08:42:51 -0500
In-Reply-To: <20200121134254.4570-1-frankja@linux.ibm.com>
References: <20200121134254.4570-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200121134254.4570-7-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

Up to now a secondary cpu could have returned from the function it was
executing and ending up somewhere in cstart64.S. This was mostly
circumvented by an endless loop in the function that it executed.

Let's add a loop to the end of the cpu setup, so we don't have to rely
on added loops in the tests.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/cstart64.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/s390x/cstart64.S b/s390x/cstart64.S
index 9af6bb3..5fd8d2f 100644
--- a/s390x/cstart64.S
+++ b/s390x/cstart64.S
@@ -162,6 +162,8 @@ smp_cpu_setup_state:
 	/* We should only go once through cpu setup and not for every restart */
 	stg	%r14, GEN_LC_RESTART_NEW_PSW + 8
 	br	%r14
+	/* If the function returns, just loop here */
+0:	j	0
 
 pgm_int:
 	SAVE_REGS
-- 
2.20.1
