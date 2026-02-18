Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DB9334C1B;
	Wed, 18 Feb 2026 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771424424; cv=none; b=TjL0PUET/BzGN5PgXZCAg8LZHLDdCI5BLqWE3JG6MToXgmpNe5KEiExHqPVxtmnzi0Nsr/V/QamIA23ooMF22fcqnU8rzgDbgDtZP21fiRQVPF3F0ekX2P3YK8d7rRQjWoKNdXrQsNdewHFJI6B/WZSrIaBMM2i3OQj7in2qx3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771424424; c=relaxed/simple;
	bh=ELh00Bb8DK9VFq+/7jcmPhT9fEC9OYKEPjUQyC9jYpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJoeCACYtzjQIFP6vdc7j+CAn7bfy63yoYD9taVo/9A3qhu4psY/au6PesL8zmVD1BYCey6aAv6+Ic+O2vEzkmKBWWG2U7dd5EzXxV/Az+9J0DShCenJZLP1Ye9aLu4GIRGp2bAqmeGqM/W/QsrH7p51I7vYKhTygD3nWBVYADo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iF3UIkWk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iF3UIkWk"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I6ucK62749445;
	Wed, 18 Feb 2026 14:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gv/ovjkPaQXawhGo7
	8gf1fT4H1MiqMsf1/WLRgUf5S8=; b=iF3UIkWk5G49Ngs66PAwejXoJiuU+Qu3R
	0s65+KFb6/h5d8QRHdk3UB48xsRwKzebCpetjNsPb1XI9/dp1esdQ8utUlpUKQCC
	3masj9+ekCC6P6dPJh9bYz7giHJaXqoFaLoQiaL/FKUc9ACoZUHG2HNsSc0bwmQo
	aMghFD4Wghnogtm19M0jj1RAO0joBpefUNmvZmEboJeCVFVhloiwokuLOOdDpAV5
	WTexOQlmdFwq5aC4RnIz/xH4stM08Rug+eaJPWfe+Zb2cd19Xz9pOchQcTSAmLwQ
	CYBYaOQtq3KOsDFpqrqKw4j9byH7aTBp5i4+VKrBzSa6d9ZdnWv6A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4kgdt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 14:20:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61IDbaqf001375;
	Wed, 18 Feb 2026 14:20:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb2bg31p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 14:20:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61IEKEDW15204756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 14:20:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1946220040;
	Wed, 18 Feb 2026 14:20:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED0BD2004F;
	Wed, 18 Feb 2026 14:20:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Feb 2026 14:20:13 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 5/9] s390/idle: Inline update_timer_idle()
Date: Wed, 18 Feb 2026 15:20:08 +0100
Message-ID: <20260218142012.863464-6-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260218142012.863464-1-hca@linux.ibm.com>
References: <20260218142012.863464-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDEyMCBTYWx0ZWRfX47uZ8K2yITQB
 nXwJEKhV/r/ZTN4eL03i13qR2qlSLksZkGwMs6p4iW9maL6XDHBp+01kW+RhU2yrwDPPI0hPc3j
 tSSoV63Itts1sYSl8Pmqb4tZeE4rHW+10uNda0m61PIWEZ2fpmANnGJZhhlnTQrMLj/8Fg5SzcR
 JEx9uD2QHigDqiREtl2HimIViHy8cstqC4uRb6ojqVwojh9QMt1ZnBxME4pf3Dg589MnxNOfehW
 liiA/+hHwVLSAU/zXr0EvoaDHMlNOQiMozAzYwoSlszfYjTGxlvv0MO6L1zwGSn++RLuaneiga4
 StD51+sfn3QBAFoXFdjCee46UtvIxHMyoDE7ooAdmKsDVvrjMIZclBCshjKuOt4p98NM8VtBSoZ
 f74Tb6VeldTDa5glqfjY9i2BoBJY681WScq5UCxsVFR1B2DUzK4QvPYeGZLUHRUPba90kUCdVui
 wS/9osLr1sVsyp/6dnA==
X-Proofpoint-ORIG-GUID: rfyObM6X41IXQG4u93dEXu8jR2DyLPjT
X-Proofpoint-GUID: rfyObM6X41IXQG4u93dEXu8jR2DyLPjT
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=6995caa2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=tAyWV0bZ07vegb1XaBYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_02,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180120

Inline update_timer_idle() again to avoid an extra function call. This
way the generated code is close to old assembler version again.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/idle.h  |  3 ++-
 arch/s390/include/asm/vtime.h | 34 ++++++++++++++++++++++++++++++++++
 arch/s390/kernel/entry.h      |  2 --
 arch/s390/kernel/idle.c       | 34 ++--------------------------------
 4 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/arch/s390/include/asm/idle.h b/arch/s390/include/asm/idle.h
index 133059d9a949..8c5aa7329461 100644
--- a/arch/s390/include/asm/idle.h
+++ b/arch/s390/include/asm/idle.h
@@ -19,10 +19,11 @@ struct s390_idle_data {
 	unsigned long mt_cycles_enter[8];
 };
 
+DECLARE_PER_CPU(struct s390_idle_data, s390_idle);
+
 extern struct device_attribute dev_attr_idle_count;
 extern struct device_attribute dev_attr_idle_time_us;
 
 void psw_idle(struct s390_idle_data *data, unsigned long psw_mask);
-void update_timer_idle(void);
 
 #endif /* _S390_IDLE_H */
diff --git a/arch/s390/include/asm/vtime.h b/arch/s390/include/asm/vtime.h
index 9d25fb35a042..b1db75d14e9d 100644
--- a/arch/s390/include/asm/vtime.h
+++ b/arch/s390/include/asm/vtime.h
@@ -2,6 +2,12 @@
 #ifndef _S390_VTIME_H
 #define _S390_VTIME_H
 
+#include <asm/lowcore.h>
+#include <asm/cpu_mf.h>
+#include <asm/idle.h>
+
+DECLARE_PER_CPU(u64, mt_cycles[8]);
+
 static inline void update_timer_sys(void)
 {
 	struct lowcore *lc = get_lowcore();
@@ -20,4 +26,32 @@ static inline void update_timer_mcck(void)
 	lc->last_update_timer = lc->mcck_enter_timer;
 }
 
+static inline void update_timer_idle(void)
+{
+	struct s390_idle_data *idle = this_cpu_ptr(&s390_idle);
+	struct lowcore *lc = get_lowcore();
+	u64 cycles_new[8];
+	int i, mtid;
+
+	mtid = smp_cpu_mtid;
+	if (mtid) {
+		stcctm(MT_DIAG, mtid, cycles_new);
+		for (i = 0; i < mtid; i++)
+			__this_cpu_add(mt_cycles[i], cycles_new[i] - idle->mt_cycles_enter[i]);
+	}
+	/*
+	 * This is a bit subtle: Forward last_update_clock so it excludes idle
+	 * time. For correct steal time calculation in do_account_vtime() add
+	 * passed wall time before idle_enter to steal_timer:
+	 * During the passed wall time before idle_enter CPU time may have
+	 * been accounted to system, hardirq, softirq, etc. lowcore fields.
+	 * The accounted CPU times will be subtracted again from steal_timer
+	 * when accumulated steal time is calculated in do_account_vtime().
+	 */
+	lc->steal_timer += idle->clock_idle_enter - lc->last_update_clock;
+	lc->last_update_clock = lc->int_clock;
+	lc->system_timer += lc->last_update_timer - idle->timer_idle_enter;
+	lc->last_update_timer = lc->sys_enter_timer;
+}
+
 #endif /* _S390_VTIME_H */
diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
index dd55cc6bbc28..fb67b4abe68c 100644
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -56,8 +56,6 @@ long sys_s390_pci_mmio_write(unsigned long, const void __user *, size_t);
 long sys_s390_pci_mmio_read(unsigned long, void __user *, size_t);
 long sys_s390_sthyi(unsigned long function_code, void __user *buffer, u64 __user *return_code, unsigned long flags);
 
-DECLARE_PER_CPU(u64, mt_cycles[8]);
-
 unsigned long stack_alloc(void);
 void stack_free(unsigned long stack);
 
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 627d82dd900e..1f1b06b6b4ef 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -15,41 +15,11 @@
 #include <trace/events/power.h>
 #include <asm/cpu_mf.h>
 #include <asm/cputime.h>
+#include <asm/idle.h>
 #include <asm/nmi.h>
 #include <asm/smp.h>
-#include "entry.h"
 
-static DEFINE_PER_CPU(struct s390_idle_data, s390_idle);
-
-void update_timer_idle(void)
-{
-	struct s390_idle_data *idle = this_cpu_ptr(&s390_idle);
-	struct lowcore *lc = get_lowcore();
-	u64 cycles_new[8];
-	int i, mtid;
-
-	mtid = smp_cpu_mtid;
-	if (mtid) {
-		stcctm(MT_DIAG, mtid, cycles_new);
-		for (i = 0; i < mtid; i++)
-			__this_cpu_add(mt_cycles[i], cycles_new[i] - idle->mt_cycles_enter[i]);
-	}
-
-	/*
-	 * This is a bit subtle: Forward last_update_clock so it excludes idle
-	 * time. For correct steal time calculation in do_account_vtime() add
-	 * passed wall time before idle_enter to steal_timer:
-	 * During the passed wall time before idle_enter CPU time may have
-	 * been accounted to system, hardirq, softirq, etc. lowcore fields.
-	 * The accounted CPU times will be subtracted again from steal_timer
-	 * when accumulated steal time is calculated in do_account_vtime().
-	 */
-	lc->steal_timer += idle->clock_idle_enter - lc->last_update_clock;
-	lc->last_update_clock = lc->int_clock;
-
-	lc->system_timer += lc->last_update_timer - idle->timer_idle_enter;
-	lc->last_update_timer = lc->sys_enter_timer;
-}
+DEFINE_PER_CPU(struct s390_idle_data, s390_idle);
 
 void account_idle_time_irq(void)
 {
-- 
2.51.0

