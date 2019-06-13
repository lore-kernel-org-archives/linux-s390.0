Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728323AbfFMKfT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Jun 2019 06:35:19 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DAS1PM038466
        for <linux-s390@vger.kernel.org>; Thu, 13 Jun 2019 06:35:18 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t3k2wdgj7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 13 Jun 2019 06:35:18 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 13 Jun 2019 11:35:15 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCHv2 1/3] processor: remove spin_cpu_yield
Date: Thu, 13 Jun 2019 12:35:08 +0200
In-Reply-To: <20190613103510.60529-1-heiko.carstens@de.ibm.com>
References: <20190613103510.60529-1-heiko.carstens@de.ibm.com>
Message-Id: <20190613103510.60529-2-heiko.carstens@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

spin_cpu_yield is unused, therefore remove it.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/powerpc/include/asm/processor.h | 2 --
 include/linux/processor.h            | 9 ---------
 2 files changed, 11 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index ef573fe9873e..a9993e7a443b 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -346,8 +346,6 @@ static inline unsigned long __pack_fe01(unsigned int fpmode)
 
 #define spin_cpu_relax()	barrier()
 
-#define spin_cpu_yield()	spin_cpu_relax()
-
 #define spin_end()	HMT_medium()
 
 #define spin_until_cond(cond)					\
diff --git a/include/linux/processor.h b/include/linux/processor.h
index dbc952eec869..dc78bdc7079a 100644
--- a/include/linux/processor.h
+++ b/include/linux/processor.h
@@ -32,15 +32,6 @@
 #define spin_cpu_relax() cpu_relax()
 #endif
 
-/*
- * spin_cpu_yield may be called to yield (undirected) to the hypervisor if
- * necessary. This should be used if the wait is expected to take longer
- * than context switch overhead, but we can't sleep or do a directed yield.
- */
-#ifndef spin_cpu_yield
-#define spin_cpu_yield() cpu_relax_yield()
-#endif
-
 #ifndef spin_end
 #define spin_end()
 #endif
-- 
2.17.1
