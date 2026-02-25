Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7FF3203A0;
	Wed, 25 Feb 2026 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031115; cv=none; b=l6wzj5iPEcRS6GJTZf0PmV3/F1I7VN2UYbZFKOBtq/ViNKDRmUSJcFsoBHDlIJChkxrOjtHCEzdEzXrO10J/wg+awatp/a6kB/8xzhH9wxd08ReE9+dX6CoxIcnT3ik1dcFPEGAeQqbLIn1Vk1GdemDh9D2/Qzx5KJVr5mpbCUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031115; c=relaxed/simple;
	bh=d9yiZmVpT9hQ6XzzTJ+ueF5NoE331+4B4L6+Viiao8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwE/7kBIJjhYHafEG2a+QR579+Nfn2PcNX4uAOYTRcbWRIx2T9Ka06bonqgmHeQ2TZn56k1ax35SScN7cVif2uc/MR+uFHDZFbxuHhW5ABCfwJjCYMxoVbEczbMtHUU5Smqx0WUWFrcsu/65sfOdzRJyXxBxvSYDmS4eeuM/gsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TGC4UvAz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TGC4UvAz"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61ONDk4h3514000;
	Wed, 25 Feb 2026 14:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5IEKiCuIwyvn/nSL1
	EMp4vrfwEmujZpytvwzlR7z9Ho=; b=TGC4UvAzOSbXu9BPMLsf4aMtfMfMnzYS3
	ce9YCm9eePTDq9XIyBA7cqBo9EXaniXHYRA+PAypNQdoPllhyvW+5hGyJU3cU2jT
	DKydNY2h3mefXWY6hREIs2t6T4MNegjoOoOlvPBWKuiHrsKraLgvXHRmXQjYmg6R
	/w8KHxucU2iyYWkdMek/AEYY+7eswmlOqI6VqT7bz6cCIBpnxJVKkmZULd4cGiLJ
	XA6/qqrunXpkmwUF2TiY/X/FBF2khjob3REmCTCuCkM09mGkAd/jf+yiP749nYkY
	wlqt1qb+Y2vafyPwy2JYpqmcGd+okuyIKI1fZ0hHCbU5nmY1ywT1w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4720s0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 14:51:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PCY73c015750;
	Wed, 25 Feb 2026 14:51:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfq1snttq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 14:51:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61PEpk9a38535600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 14:51:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94F0420040;
	Wed, 25 Feb 2026 14:51:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77C962004B;
	Wed, 25 Feb 2026 14:51:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 14:51:46 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [RFC PATCH 1/3] fixup! s390/time: Prepare to stop elapsing in dynticks-idle
Date: Wed, 25 Feb 2026 15:51:44 +0100
Message-ID: <20260225145146.1031705-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225145146.1031705-1-hca@linux.ibm.com>
References: <20260225145146.1031705-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9XcJTvTcHphFiaJXPTC3dTKBEWfxROjD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE0MCBTYWx0ZWRfX8Ae0vih6fdMu
 bsoysC0ydz29A/l5pCvHbqUWfdt7QzUnpXPw6l7dE+SKphNeq7VinKQCWQJMYlERTCo7ygoqNoc
 7yNvbUGYN2xVRqzgAmQopYsrkweV6O+hy+I7GwgIAjCB9PnZHIX05ZkWnVnIfMh9XolDDgc6EkL
 NKk3xZR+OanNRR+kxXr4ENLnfQLKYEqRCQEbtlizMIk67t6ybuTW3+Xl4VS9yyaYGiJlgWNpuOE
 jI9m9LTUppxuUTqPWEYZaRFTpRkaQ7a2fMjQieVDP/kEkaPKve1bvvcNICNWDlIrL+E28UG3nwU
 6TyWdC+pzt9epWDmWNtq/m6ivOLF9rIUn9bkG7ez1rksnDpY9KpRlTLhC1Tvg6se+tQ9K7P1w+i
 xvj+Ps8bAE+nATKOUjqmC1FjLvWIKlQd40VUjRcCsJJvkToZxJV05XjM+GqoBE2YyJE+Uux8XED
 Rmug72FUNRrU7m+2HIQ==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=699f0c87 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=_wgiQX5-pw1UyFs_v5sA:9
X-Proofpoint-GUID: 9XcJTvTcHphFiaJXPTC3dTKBEWfxROjD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_01,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250140

This should be merged with "s390/time: Prepare to stop elapsing in
dynticks-idle".

It makes sure that idle->clock_idle_enter is always set when loading the
idle psw. Otherwise the idle_time calculation in account_idle_time_irq()
would be incorrect.

Also "revert" some not needed code movements and whitespace changes to keep
the diff minimal.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/idle.h | 12 ++++++------
 arch/s390/kernel/idle.c      |  9 +++------
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/s390/include/asm/idle.h b/arch/s390/include/asm/idle.h
index 285b3da318d6..7f2a1240b6ff 100644
--- a/arch/s390/include/asm/idle.h
+++ b/arch/s390/include/asm/idle.h
@@ -13,12 +13,12 @@
 #include <linux/device.h>
 
 struct s390_idle_data {
-	bool		idle_dyntick;
-	unsigned long	idle_count;
-	unsigned long	idle_time;
-	unsigned long	clock_idle_enter;
-	unsigned long	timer_idle_enter;
-	unsigned long	mt_cycles_enter[8];
+	bool	      idle_dyntick;
+	unsigned long idle_count;
+	unsigned long idle_time;
+	unsigned long clock_idle_enter;
+	unsigned long timer_idle_enter;
+	unsigned long mt_cycles_enter[8];
 };
 
 DECLARE_PER_CPU(struct s390_idle_data, s390_idle);
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 614db5ea6ea3..fb4f431342f5 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -35,11 +35,10 @@ void account_idle_time_irq(void)
 			this_cpu_add(mt_cycles[i], cycles_new[i] - idle->mt_cycles_enter[i]);
 	}
 
-	WRITE_ONCE(idle->idle_count, READ_ONCE(idle->idle_count) + 1);
-
 	/* Account time spent with enabled wait psw loaded as idle time. */
 	idle_time = lc->int_clock - idle->clock_idle_enter;
 	WRITE_ONCE(idle->idle_time, READ_ONCE(idle->idle_time) + idle_time);
+	WRITE_ONCE(idle->idle_count, READ_ONCE(idle->idle_count) + 1);
 
 	/* Dyntick idle time accounted by nohz/scheduler */
 	if (idle->idle_dyntick)
@@ -66,10 +65,8 @@ void noinstr arch_cpu_idle(void)
 	set_cpu_flag(CIF_ENABLED_WAIT);
 	if (smp_cpu_mtid)
 		stcctm(MT_DIAG, smp_cpu_mtid, (u64 *)&idle->mt_cycles_enter);
-	if (!idle->idle_dyntick) {
-		idle->clock_idle_enter = get_tod_clock_fast();
-		idle->timer_idle_enter = get_cpu_timer();
-	}
+	idle->clock_idle_enter = get_tod_clock_fast();
+	idle->timer_idle_enter = get_cpu_timer();
 	bpon();
 	__load_psw_mask(psw_mask);
 }
-- 
2.51.0

