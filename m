Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F0A333420;
	Wed, 18 Feb 2026 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771424422; cv=none; b=S+D0Vhsr1bgXGbBEx8YRc5ltvyrJDhkNCjsvda/34vSecFuqV1Qv77vr3LTu2lpD1ctSf694pWxb35mVdNZQ/Sl/NPXL6+q7LSzj78+UkorGiY9x373v+2CCwrufbZtX18wtijnk7zFhtpf957buJ3nm18Z8oj+VjZ68NHXSF+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771424422; c=relaxed/simple;
	bh=n2TPzx4LU+5jcuS/l1EQyFwihwVyQtwTZDsXVjLlGXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIx0A44YqH73ojhl0eo7/0ftzr3Sq9o8f6heQ7j8MSWu3XDruO/gQ5wf2GNUnkR3L9Nyrha2LPe1GDDhTDq1bDItOC0yD0pl6e6CZhLiVM2u7G4+oGKxBvbxG9ywZtLih15qbBYvNAoTB4DK9dYEWo0n3DirAkFBffiHp+bPVps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LJHpQgcO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LJHpQgcO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I2FoTi1821639;
	Wed, 18 Feb 2026 14:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=X5xLP7BqbUHolIUTT
	AWZNmVcbnTprmY/D3KyNtaohtQ=; b=LJHpQgcOgZ23upXG048QYVIv6B9DZYsZ8
	jiI8WRTA0Sxbh6/9Uc7jwTLG8bO6xR9W7oUlCQSvV/TyKJkHeOkDn7E3GP5qihd1
	E8vq8CPQL5hVcwQ2TD/4Evb4+WQjf+hbJ0/ni7CyRVnwH8XZwG+HpvXE1VwBY5Kx
	JVizNsaFlHuag8x8Lst3wYifip6jCXQBBmQXIKRue2nhGyGRCZzPcwlcONqM9cdZ
	aXjQSotoxbVTqoRhU5tAwWGOfG1foRgfWp7/h86SilzbIKwJukTP6fxH4Gl0X7eJ
	rkutvFCUDmZQUfeSUegZFDQDvLlsDPZKzOWAJkEvk2gOPmf1HK7LA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj648ey2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 14:20:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61IDTt3K023899;
	Wed, 18 Feb 2026 14:20:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb4583b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 14:20:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61IEKDIW33947968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 14:20:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F9602004B;
	Wed, 18 Feb 2026 14:20:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CE312004E;
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
Subject: [PATCH 2/9] s390/vtime: Fix virtual timer forwarding
Date: Wed, 18 Feb 2026 15:20:05 +0100
Message-ID: <20260218142012.863464-3-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: _0EnLTnb0f7uY-O_2ADZcf7xjBH9tkn5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDEyMCBTYWx0ZWRfX6L/1GYAC5g0v
 LMfrZhE45pcah0d3ILiETKyE2HMzbyECGuGqbroHAe5Lu1xxIlUUGq1zVjll/HeREzbp1JRwHmJ
 iaxhUg6Uj70XSPzZweafuOqZXRCDuGM47wZ7OtYBjHDo97AxeMhQm6Ij0V4+MeaOlu8XSc/cwDO
 JeJJy6Ph1c64ZAjU/+JfSBE/rKhA5X+OBkqVvF9AfeTH2gOmn7jDQH/PGYhOVNJ/Gba1/9RUfn1
 esnimb4DM/OlE+IYIB87Q9H6+hXRaEPxogqs4fXvAJVP53sV9oPS+g+mpbj8NZGjSesK3X2J2pk
 agaptc59bQP4XQOP2pifz2nTAr805vNJIYvqGXdyfTojJFzdf7/SqSgYMY3O66jyLt6F1b/DADW
 jlU/NXcNErb7NV3QdhfeuF0o9ShHDT573a0FTp2s/AM0BW5vrfcp65v/M8Tez5fYrVPnhyn2TKP
 nzZIhIb06Gr6YELf7hg==
X-Proofpoint-GUID: _0EnLTnb0f7uY-O_2ADZcf7xjBH9tkn5
X-Authority-Analysis: v=2.4 cv=U+mfzOru c=1 sm=1 tr=0 ts=6995caa2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=O0ay5dtW3tVG4uawZmwA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_02,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602180120

Since delayed accounting of system time [1] the virtual timer is
forwarded by do_account_vtime() but also vtime_account_kernel(),
vtime_account_softirq(), and vtime_account_hardirq(). This leads
to double accounting of system, guest, softirq, and hardirq time.

Remove accounting from the vtime_account*() family to restore old behavior.

There is only one user of the vtimer interface, which might explain
why nobody noticed this so far.

Fixes: b7394a5f4ce9 ("sched/cputime, s390: Implement delayed accounting of system time") [1]
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/vtime.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 234a0ba30510..122d30b10440 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -225,10 +225,6 @@ static u64 vtime_delta(void)
 	return timer - lc->last_update_timer;
 }
 
-/*
- * Update process times based on virtual cpu times stored by entry.S
- * to the lowcore fields user_timer, system_timer & steal_clock.
- */
 void vtime_account_kernel(struct task_struct *tsk)
 {
 	struct lowcore *lc = get_lowcore();
@@ -238,27 +234,17 @@ void vtime_account_kernel(struct task_struct *tsk)
 		lc->guest_timer += delta;
 	else
 		lc->system_timer += delta;
-
-	virt_timer_forward(delta);
 }
 EXPORT_SYMBOL_GPL(vtime_account_kernel);
 
 void vtime_account_softirq(struct task_struct *tsk)
 {
-	u64 delta = vtime_delta();
-
-	get_lowcore()->softirq_timer += delta;
-
-	virt_timer_forward(delta);
+	get_lowcore()->softirq_timer += vtime_delta();
 }
 
 void vtime_account_hardirq(struct task_struct *tsk)
 {
-	u64 delta = vtime_delta();
-
-	get_lowcore()->hardirq_timer += delta;
-
-	virt_timer_forward(delta);
+	get_lowcore()->hardirq_timer += vtime_delta();
 }
 
 /*
-- 
2.51.0

