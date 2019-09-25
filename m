Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406921AbfIYN4i (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Sep 2019 09:56:38 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8PDpxhj099767
        for <linux-s390@vger.kernel.org>; Wed, 25 Sep 2019 09:56:37 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v7mfqt3t0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 25 Sep 2019 09:56:36 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 25 Sep 2019 14:56:32 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 1/2] s390x: Add missing include in smp.h
Date: Wed, 25 Sep 2019 09:56:22 -0400
In-Reply-To: <20190925135623.9740-1-frankja@linux.ibm.com>
References: <20190925135623.9740-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190925135623.9740-2-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

smp.h uses struct lowcore and struct psw, which are defined in
asm/arch_def.h

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/smp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/s390x/smp.h b/lib/s390x/smp.h
index 4476c31..ce63a89 100644
--- a/lib/s390x/smp.h
+++ b/lib/s390x/smp.h
@@ -12,6 +12,8 @@
 #ifndef SMP_H
 #define SMP_H
 
+#include <asm/arch_def.h>
+
 struct cpu {
 	struct lowcore *lowcore;
 	uint64_t *stack;
-- 
2.20.1
