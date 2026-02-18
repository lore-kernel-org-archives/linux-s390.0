Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4873A33373E;
	Wed, 18 Feb 2026 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771424423; cv=none; b=J4TwzZ1R7C0uJZAGOuI2Cr1jwa1/Q041Xda6xqgmvdgODAE0tbJ7PGlabkXKkcR7qegLaeXo3GB0H9eRKun0kcBIjhSiBs9y8S0VHuJDyr/Da8pC83P1fUZiCG/DycFGrRiEidoze/kWzdsZKiva4Yph5gXxBSWQnMGOsdyFgkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771424423; c=relaxed/simple;
	bh=pjlpVVFr2BiD+ZGjXcef6bwSS9OyARlWhEoi/H8ud4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+fqfElAU1wjYsiArDu/oV79alRNdE5FeOARXRGkqpbzmGb6rICGrcXIe8twnHx7+dCWj02hasGEepvWKa2Yy5hJX3YkvqvYnw8Pq/o5lU2HXwzUl2H0/RbbaClntrDlArIg3ASxrsZVx1EnljKG/WPDkx2P8NGFG5HxOdFAoDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mXOyfXSS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mXOyfXSS"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61IAaoxZ3664605;
	Wed, 18 Feb 2026 14:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=99NMs+c04KPx5yiuM
	qz3d3ByldSAeBupn5aZrJ0YMhk=; b=mXOyfXSS3A0tVfLMm9o3rluDX8SlhViqf
	zL4qV8eKJccXAD23Nlx3UV6INgKPGhH1lIG9PCf+HH4QBeR/SJGELtwt5ZRTyBry
	0jz50ZFM15KP1jadu68HMLMAd0IqXlBq88f/fH5b2NC7GclCQXW8v7oOclSdGLGT
	me1f/jx//0I0FNfk/DIvDAL8zcTTlDQFqG/TmNOS8sy+KJFmgCvnyRiZ6xSo9/7Z
	Nf03aQItUNS1Jfe43P7D1dhZp9gRo+puHFIS5FD1yh74MSPEVhGG/Wr05piWXXSP
	fpEMSDCWQ6wT/2zLTatEFUCT/FdWb7n1in80OWqzuHd7yJeCiy+7w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcjgf3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 14:20:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61IDTt3L023899;
	Wed, 18 Feb 2026 14:20:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb4583b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 14:20:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61IEKEo831588614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 14:20:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9BB22004E;
	Wed, 18 Feb 2026 14:20:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C756E2004B;
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
Subject: [PATCH 4/9] s390/idle: Slightly optimize idle time accounting
Date: Wed, 18 Feb 2026 15:20:07 +0100
Message-ID: <20260218142012.863464-5-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: NZoYxEUR4PZlpcFVrQmF0DXvNij8lqxd
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=6995caa2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=CLeX8EwWlJziYLe-d84A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDEyMCBTYWx0ZWRfX4uHih2QlOLd3
 X8ay81Zva0xjTu0/wNYVrt2heXBKE1leesYD+WGRYhTf6PmT5jFT9iWuAkga6Zy6ngIOLymbniC
 wecs2zFoIFGOOGHZ63zrfZiDJ23padRDIeWOv3aWUdqWX6fiuUc6cGTbpwUNLO3LfazxNuUH74j
 2R3s6DU8jWCV+nLTfXtjsEHZfAxT3peXJDDYwLVPip/qbibM7Na41YmF1Y0TUs/cDqE2nb4i8zY
 GloTzzeYLcABoluUL1DepeUbLLfobIKK/oPVW5aVfEennjxUKEYWD2C1j+I1HtQbHweMWtTut1+
 QQoYZbZOb6nw+c8w8PreQ7N4W+854MNKnVTSxzzUZki0NGjcw4tf7/lnC58odY+DaYHzAKmBJco
 Er82rs3FPwys8EDAPTlql1nwrNQPFkulAojPtAozOV8KpqfSfFBRkU604nqxUtBZKNB71KMZodW
 9hioro6ZlLu2cS5N31w==
X-Proofpoint-GUID: NZoYxEUR4PZlpcFVrQmF0DXvNij8lqxd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_02,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180120

Slightly optimize account_idle_time_irq() and update_timer_idle():

- Use fast single instruction __atomic64() primitives to update per
  cpu idle_time and idle_count, instead of READ_ONCE() / WRITE_ONCE()
  pairs

- stcctm() is an inline assembly with a full memory barrier. This
  leads to a not necessary extra dereference of smp_cpu_mtid in
  update_timer_idle(). Avoid this and read smp_cpu_mtid into a
  variable

- Use __this_cpu_add() instead of this_cpu_add() to avoid disabling /
  enabling of preemption several times in a loop in update_timer_idle().

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/idle.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 4e09f126d4fc..627d82dd900e 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -26,12 +26,13 @@ void update_timer_idle(void)
 	struct s390_idle_data *idle = this_cpu_ptr(&s390_idle);
 	struct lowcore *lc = get_lowcore();
 	u64 cycles_new[8];
-	int i;
+	int i, mtid;
 
-	if (smp_cpu_mtid) {
-		stcctm(MT_DIAG, smp_cpu_mtid, cycles_new);
-		for (i = 0; i < smp_cpu_mtid; i++)
-			this_cpu_add(mt_cycles[i], cycles_new[i] - idle->mt_cycles_enter[i]);
+	mtid = smp_cpu_mtid;
+	if (mtid) {
+		stcctm(MT_DIAG, mtid, cycles_new);
+		for (i = 0; i < mtid; i++)
+			__this_cpu_add(mt_cycles[i], cycles_new[i] - idle->mt_cycles_enter[i]);
 	}
 
 	/*
@@ -58,8 +59,8 @@ void account_idle_time_irq(void)
 	idle_time = get_lowcore()->int_clock - idle->clock_idle_enter;
 
 	/* Account time spent with enabled wait psw loaded as idle time. */
-	WRITE_ONCE(idle->idle_time, READ_ONCE(idle->idle_time) + idle_time);
-	WRITE_ONCE(idle->idle_count, READ_ONCE(idle->idle_count) + 1);
+	__atomic64_add(idle_time, &idle->idle_time);
+	__atomic64_add_const(1, &idle->idle_count);
 	account_idle_time(cputime_to_nsecs(idle_time));
 }
 
-- 
2.51.0

