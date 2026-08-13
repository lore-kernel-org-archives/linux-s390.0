Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E593955D8
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627512; cv=none; b=opnRQ+rwMRu2n8ljyDx8HYaTjBVrJ/AJqTwLId6dZR/H70DVHiWml2l9W5dkGobcfpsVOLA2Rl2yCUEdiZk/7boKxb4sp6D1H2yul8aDWtmEqqc3+AXmshk7igpjejC0T/4d3sM+IN3FSkZbbkm/SZHnL4xhUMux7vjpx03bgyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627512; c=relaxed/simple;
	bh=MUo5zH33gVxEEr7J4M3Sx9YRlXRs/fqrlnuVcHVK2vk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d9RWSW51wVZoB7PcBFgwH8ZbnWHlj9vLN0rLfSsxIKEYrGMAp/IyVwuGHOuM8hxyXM1BBrActZELsAxuzpk45N9MAXEdG5ft/g+aPdM9lYO3AjlnPJo44kglRKWTsxg3unZN+0D/xTmp0pWn7pqDv2+evlxHFI/WjkiiMaz3Xa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lOBn1i7K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lOBn1i7K"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCW6NJ2249159
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 13:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=sEMJhsjIRWMlJ/srMZ5D2zWdea2lJouOZ1VEztQhL
	IA=; b=lOBn1i7KA9jc3bMZ2TjOIu1Du3W62vMahaMjPNmB/TJ8zFWa0+JequzF0
	nTHUm5R6R/Zd0aZ5JV8Cur0UAuTeHL6fGrz9hrVHE/KbCwlPZdxoqUMlJIZRT20M
	xqeolWH/aDw/9me5dmYiCdCIJFdy1qKs5ZVQVZfo+9fMyD4W2lLd0IO2IhwiIcvO
	3gNC2d4iGAVJtUvW8onPyjaFR1OwKUBoieC6E59036e1UQlobk4iwdbSIU0uxThH
	NDKaTYofb5f6M+NinV8i5xhdx0vjNeKJNloE8nWga/juuUU1IHDB3Ho50LJtfyra
	hYP6puCnzWFmsCFbe+lVPSLCNyF+Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp372hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 13:25:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DDBJYs027188
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 13:25:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9hb365-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 13:25:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DDP5RN46203332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 13:25:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 463E82004D;
	Thu, 13 Aug 2026 13:25:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 280E520043;
	Thu, 13 Aug 2026 13:25:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 13:25:05 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH] s390/time: Use jiffies instead of jiffies_64
Date: Thu, 13 Aug 2026 15:25:05 +0200
Message-ID: <20260813132505.3691502-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7dc5b6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=bsD9nJacRPnXRzDo_HMA:9
X-Proofpoint-GUID: 1h-rXDsILGy6CL9QvtPkwBjIdNRk0o6Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA5MyBTYWx0ZWRfXxYpPupx7F9x4
 0zaS8cJMG7P6xQ8Lq/Zj5DHxTMAfcZkmvK54x7TRW+nwdbJrscm7jTf1XW8JU4eJhgHeM3tYq/T
 aoNH/Snc6rtODFepK7vv3rSjP89pKz9vrQv8070dirDY/GLe2j/gFX0M15XQKher1b6HeI368NN
 6KRq6CNrdXHYU8HPi8m023MgfNoO61gcyv5RMTgpOpepGgQzaGCdB06QUu8BP6StYhV/0T8isj1
 /OIfQ+zSuhZa5M36GOBlTfWN/xIqrW3ZeWFhLyi5Khmkx8pWONEtsYmmxdplDunShI5hFjIxxjZ
 vyQcGjV3pqNf5rMGj48pd6BOjXIY7PQV9/v7m7gR6UioK7vlBw0548Un7fp/srITiyy8CpjBdaY
 hjomf2WhzAZUdCk/AfOb7n2rrpdbn1aMUTLqmcCRQq9XKe+nDOIMRsyScQ7LFgj6R4oWmAyqMDI
 nu40bh1f05WFCR06FWQ==
X-Proofpoint-ORIG-GUID: 1h-rXDsILGy6CL9QvtPkwBjIdNRk0o6Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA5MyBTYWx0ZWRfX0JIaz7Im+WwW
 jJHHNyDy+m0n7RjN2AI4HX1bhuDbhryI9zUVThUOIs1J1G3vB1ci6i5TsrOoP/lc2OpftE9FpwG
 cl4G8ZOoykQusQOET7RRXy/m7z3cfQE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130093

Christoph Schlameuss and Alexander Egorenkov reported a data-race
reported by KCSAN when jiffies_64 is read:

==================================================================
BUG: KCSAN: data-race in do_account_vtime / tick_do_update_jiffies64

write to 0x0000016599ea8600 of 8 bytes by interrupt on cpu 6:
 tick_do_update_jiffies64+0x140/0x250
=============================================================>
BUG: KCSAN: data-race in do_account_vtime / tick_do_update_ji>

write to 0x0000016599ea8600 of 8 bytes by interrupt on cpu 6:
 tick_do_update_jiffies64+0x140/0x250
 tick_nohz_handler+0x2e6/0x300
 __run_hrtimer+0x156/0x4d0
 __hrtimer_run_queues+0xd2/0x150
...
 system_call+0x72/0x90

read to 0x0000016599ea8600 of 8 bytes by interrupt on cpu 12:
 do_account_vtime+0x7d6/0x860
 vtime_flush+0x26/0xe0
 update_process_times+0x32/0x160
 tick_nohz_handler+0x12a/0x300
...
 system_call+0x72/0x90

value changed: 0x00000000ffffaa6c -> 0x00000000ffffaa6d
...
=============================================================>

Problem is that jiffies_64 instead of jiffies is used. Both are at the
same address, but only jiffies is of volatile type, which prevents this
warning.

Change the vtime code so jiffies instead of jiffies_64 is used
everywhere. This addresses also the inconsistency that both jiffies and
jiffies_64 were used in the original patch which introduced this.

Fixes: f341b8dff982 ("s390/vtime: limit MT scaling value updates")
Reported-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/vtime.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index d804e1140c2e..efcbf406f03e 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -32,7 +32,7 @@ static atomic64_t virt_timer_elapsed;
 DEFINE_PER_CPU(u64, mt_cycles[8]);
 static DEFINE_PER_CPU(u64, mt_scaling_mult) = { 1 };
 static DEFINE_PER_CPU(u64, mt_scaling_div) = { 1 };
-static DEFINE_PER_CPU(u64, mt_scaling_jiffies);
+static DEFINE_PER_CPU(unsigned long, mt_scaling_jiffies);
 
 static inline void set_vtimer(u64 expires)
 {
@@ -81,7 +81,7 @@ static void update_mt_scaling(void)
 		memcpy(cycles_old, cycles_new,
 		       sizeof(u64) * (smp_cpu_mtid + 1));
 	}
-	__this_cpu_write(mt_scaling_jiffies, jiffies_64);
+	__this_cpu_write(mt_scaling_jiffies, jiffies);
 }
 
 static inline u64 update_tsk_timer(unsigned long *tsk_vtime, u64 new)
@@ -144,7 +144,7 @@ static int do_account_vtime(struct task_struct *tsk)
 		lc->system_timer += timer;
 
 	/* Update MT utilization calculation */
-	if (smp_cpu_mtid && time_after64(jiffies_64, __this_cpu_read(mt_scaling_jiffies)))
+	if (smp_cpu_mtid && time_after(jiffies, __this_cpu_read(mt_scaling_jiffies)))
 		update_mt_scaling();
 
 	/* Calculate cputime delta */
-- 
2.53.0

