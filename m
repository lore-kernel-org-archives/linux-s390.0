Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728792AbgAQKrG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Jan 2020 05:47:06 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00HActDb078656
        for <linux-s390@vger.kernel.org>; Fri, 17 Jan 2020 05:47:05 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xk0qu0hhf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 17 Jan 2020 05:47:05 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 17 Jan 2020 10:47:03 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v3 6/9] s390x: smp: Loop if secondary cpu returns into cpu setup again
Date: Fri, 17 Jan 2020 05:46:37 -0500
In-Reply-To: <20200117104640.1983-1-frankja@linux.ibm.com>
References: <20200117104640.1983-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200117104640.1983-7-frankja@linux.ibm.com>
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
