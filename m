Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968692;
	b=EYCHjUzNVfzJpdBiassK+Qkv4bkYJ9i50j6msxjqOJoEFOPWq5BJ1BTDEZDYySd7kmgo
	 ZD2dAcHZ32Vv2YJDk0+DtJ8qYW0WMy0+cVJQhXIQXEklLjbqxbWgbx6xPKhV2YcFPwmg+
	 /dOVegG4RfGr7Rbtufh9pF8Up4jxE8+riCMszmd25Qv8lAdNM8KXreXdoNmsS8PYsSpsR
	 jMxuYC7pzWWZ9HcPtAGEfq+aQnStzDj/St3ZRMJjSZnJLidU33skVmuokLRRhGkJhdp6L
	 tWzb00HCAevWm4PGfwhW9dI3sLNOe7m5HRyZu+sqA3bb6zAzsMWqtG0Nu8HPpZKYFaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968692;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hG18seTVanEaXXKBvW4TbT7JF2trV+WFx6lC4oMyc/M=;
	b=hqo/ELO8HKBRjBKZ+mlMgenr9gQQyJwkr/b80XbISdlJGQT/P9arwrrRAf469LsU+hoY
	 f/2d1yEsEEdxP1Ex9+8bmxZ4iJNFbNbXCNbFp7Sa8V7W86fGz91eNvz0fV6o3TSMAiogw
	 z9vjklZ8kiqdwOwcYGiVqqNkZTyoVsucoWyEDcT2WExm09u4W96uteDhmcwtvZH+uQf9P
	 KDjFLNyhMe4LPgMDMN/8cZ+KvZ8grYZw0WcrSOGJr4j6xvvT3uFO4Uc4QJtv4hR5boV/1
	 gjq6gjNDRgzuKnnv7xs7kd0BWT0+mKmmvT+SHEl9Pra2cJboEKsfyWalD5/7Ryqoc1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cQdDzVsg;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8C606A329;
	Fri,  6 Nov 2026 12:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DF8C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cQdDzVsg
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Ail7E2090283;
	Fri, 6 Nov 2026 12:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=hG18seTVanEaXXKBvW4TbT7JF2tr
	V+WFx6lC4oMyc/M=; b=cQdDzVsgqiltPjQWzuyJ1uUR0o4idoVeCEZSvD2vLJ3W
	PtRb06QSDZffMGzoRcKg347694p07aNRCSn6DBMbCYtow2Djw05XHvTA2muaM5ry
	7irSTSGDoUg0losAGcVysFN+C8obDXLdPuTPSJZHhif6QoOpDTV9tqgUGpNECXjq
	F4ME/0esu6i6yFg/U+DMHYGqUqvXkuwN9nVFbHZNnQZQV/zfRVYBvtmR0vCmEveZ
	0pEKESNUD/PbzOvm6dHac1L/biG6KPSb4NSHj37AOH9Eswfn/eWm0sIfppQ9TNSz
	X7/8eac9RwRxOG+E4dUUgoLU2xnHQJrZf/GFC0JiYg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rc44tp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 12:37:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AYwaa2071091;
	Fri, 6 Nov 2026 12:37:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hs7h12run-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 12:37:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6Cbi3f29491480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 12:37:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCDFF2004B;
	Fri,  6 Nov 2026 12:37:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87DE820043;
	Fri,  6 Nov 2026 12:37:44 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 12:37:44 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Fri, 06 Nov 2026 13:35:12 +0100
Subject: [PATCH] sched: Decouple PREFERRED_CPU from PARAVIRT
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-preferredcpu-v1-1-3f0ca4944f8b@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwMT3YKi1LTUoqLUlOSCUt0k42QDA1NLk6QUcxMloBaQZGYF2Ljo2Np
 aAD4pD6heAAAA
X-Change-ID: 20261104-preferredcpu-b3c00594bd74
To: Yury Norov <ynorov@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: Mete Durlu <meted@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0OCBTYWx0ZWRfX3dxsyLL8KEjT
 bQAWOVy4q0U8aWLYYRSJnOOLyWyG6cWpUMvqTsl1DrupCyjNvpa1gy1y4SG4+T8movJfXrtosvu
 01UdK8yQaSylChEyuaRtOKeKfAVJLiI=
X-Proofpoint-GUID: v19dGKEkhsxhuGO3CHf6Wx20sew3g2u-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0OCBTYWx0ZWRfX1KzRJGYphd91
 HI9xiqgLCJeaG+YZoohVc4XWkirQKhHDk+7sz6GQIWmPBNPj/KTDgoeyB+aWdpl6SQLpSMZfmNO
 fELIVZ5rrEUfpgH2uFLonTQglqTA+INfGG1xVvpwGGaZJx9iL1Q2jxrINOFF6sR2YrEYy+oBZNK
 tsURZ6QNit3ipGh8/9iAhuscTnnH3Bg0ROJd4txStArbjCKHSB/FB6dFESabeBtCOPqv70b5X+N
 LQoBy8CQDX7hNaS8R2xHJ84eui9Vn1Jx7th8kfyWqRqe3AKiheeN4mNN9rC93Ub/DLvdiB/+td0
 ScA7tQjf1UWWAFM7te8ty+UJvIqNK7KagLISf80O8jvW2PmrCeTLVwbN9qr3Ux6ZNW8einEFA5g
 qvjkQfUo0CHqZyOogLMGtzQG8WGLHKMKps+LFKH1z1r83UuprL1y+QmXlRe0mwGYl40FttBJld8
 mP91NcwpP6tTfgskF/Q==
X-Proofpoint-ORIG-GUID: P3SOsjES13aAhn_KEyhrgqcPDEUmck9i
X-Authority-Analysis: v=2.4 cv=CY+dd7rl c=1 sm=1 tr=0 ts=6aedca1e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=JfrnYn6hAAAA:8 a=VnNF1IyMAAAA:8 a=xJfVcbeo-DchBnYNEiMA:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060048

PREFERRED_CPU mechanism does not rely on any feature introduced by PARAVIRT
but PREFERRED_CPU still gated behind PARAVIRT. Any architecture that
would like to enable PREFERRED_CPU mechanism has to also enable PARAVIRT
and bring additional changes to accommodate PARAVIRT's requirements.

As an example, s390 doesn't enable PARAVIRT config for hardware virtualized
Logical Partitions (LPAR). The steal time is accounted for the LPARs via
architecture's own steal time accounting mechanism instead of the common
steal time infrastructure PARAVIRT supplies.
For s390 to enable PREFERRED_CPU, PRAVIRT and its required stubs are
just unncessary.

Based on the discussion between Yury Norov and Peter Zijlstra over
Yury's original patch [1]:

Introduce a new config flag HAVE_CPUTIME_STEAL to indicate that the
architecture has steal time measurement capabilities already implemented
and to signal that PARAVIRT is not required.
Remove PARAVIRT gating from CPU_PREFERRED and add HAVE_CPUTIME_STEAL
instead.
Select HAVE_CPUTIME_STEAL for s390 and powerpc-pseries configs.

[1] https://lore.kernel.org/all/20261101192203.6979-2-ynorov@nvidia.com/

Reviewed-by: Yury Norov <ynorov@nvidia.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/Kconfig                           | 8 ++++++++
 arch/powerpc/platforms/pseries/Kconfig | 1 +
 arch/s390/Kconfig                      | 1 +
 drivers/virt/Kconfig                   | 2 +-
 kernel/Kconfig.preempt                 | 2 +-
 5 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 1163736de1f9..01b8251970f6 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1080,6 +1080,14 @@ config HAVE_IRQ_TIME_ACCOUNTING
 config HAVE_PV_STEAL_CLOCK_GEN
 	bool
 
+config HAVE_CPUTIME_STEAL
+	bool
+	default y if HAVE_PV_STEAL_CLOCK_GEN
+	help
+	  Selected directly by config PARAVIRT through HAVE_PV_STEAL_CLOCK_GEN
+	  or directly by architectures that have their own CPUTIME_STEAL
+	  accounting.
+
 config HAVE_MOVE_PUD
 	bool
 	help
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 7d125e288f6e..3c49baf606d7 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -41,6 +41,7 @@ config PPC_SPLPAR
 	depends on PPC_PSERIES
 	select PARAVIRT_SPINLOCKS if PPC_QUEUED_SPINLOCKS
 	select PARAVIRT_TIME_ACCOUNTING if VIRT_CPU_ACCOUNTING_GEN
+	select HAVE_CPUTIME_STEAL
 	default y
 	help
 	  Enabling this option will make the kernel run more efficiently
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 7138d923d86f..39379e72ffdf 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -204,6 +204,7 @@ config S390
 	select HAVE_BUILDTIME_MCOUNT_SORT
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
+	select HAVE_CPUTIME_STEAL
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index eeb84e578ddf..a3721d34a55c 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -43,7 +43,7 @@ config FSL_HV_MANAGER
 
 config STEAL_GOVERNOR
 	tristate "Dynamic vCPU management based on steal time"
-	depends on PARAVIRT && SMP
+	depends on SMP && HAVE_CPUTIME_STEAL
 	select PREFERRED_CPU
 	default m
 	help
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index edc067a0c422..ffd2cb2a4d69 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -197,4 +197,4 @@ config SCHED_CLASS_EXT
 
 config PREFERRED_CPU
 	bool
-	depends on SMP && PARAVIRT
+	depends on SMP && HAVE_CPUTIME_STEAL

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261104-preferredcpu-b3c00594bd74

Best regards,
-- 
Mete Durlu <meted@linux.ibm.com>

