Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FB82E2852
	for <linux-s390@vger.kernel.org>; Sun,  7 Jun 2026 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780849784; cv=none; b=q9nZA12BnkwfQsZZafRxg9jXNBPkAAImrOnnbTLuuSM3vWW/wX362VKoKndyIwFJfHjiAtv6H6UPCiTmBpQAGL1ZCiDC4875NbW0o/SpXZ+55dgBb7xiQme2A2AjFPzwvSo/7Jt76jbCUReVQoZb0Qs7puhBpo9sz+ERIF7pXKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780849784; c=relaxed/simple;
	bh=euXBz9hMcHtLKbXJ6SkPM6eRGvjMeKngyg3SXw6FNW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/I9kRdRgcREnALvh5XXbx5vNHNJt1UET4JVRobN+4KrqbQzo3sVqOfkIRDY+Co39lOd85R6RG3aSpdNCvsRQQ6zWQqYSesjz5O0/0Ie8GpBxhng85bx5BujthprD/ZZ/gZgRf5wI6iX82Vs+46B1+KyeYo4sIHxNFOIqUvUhME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DHndDLob; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DHndDLob"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657BGlK72561908
	for <linux-s390@vger.kernel.org>; Sun, 7 Jun 2026 16:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tDluLaWzCDEVdI0Jg
	81C+rWjvldSV/kD6/JVUfw6cU0=; b=DHndDLobjCYnGeAIhet6UlXgU1kYR2Pei
	sXytmrYyI3in+AKblYqcu7tzFGkj178mZuwR9X8NaEEYur5ZDE7t93z4bd7N7EKM
	Sd7ZqAPQW/TAqjnsuAlL9cgzIQ8Y1yJO8jSNRC0qdH9LHpOHzAbLuR5mHLJlk27D
	Q9m+IV+AO20SLVV7PpyW/RvsLi6yCmAnCPKJH4jrAHRD5D2iZJzswo7AOi8Xp1Ur
	/87Ijev30lHkzhTQHYVhWFV6Io0cdGU8qG/pPiKy+2vRoNI7l1D8kCJiJzQ6ipAQ
	mRXXvUfphehPsbwwbMDsx1Nk6d/HDShYWGkWQq5ON6wjnBqMnSyEQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6sm3g1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 07 Jun 2026 16:29:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 657GJlI2004931
	for <linux-s390@vger.kernel.org>; Sun, 7 Jun 2026 16:29:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvpt7um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 07 Jun 2026 16:29:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 657GTbMj52494760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jun 2026 16:29:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC85320043;
	Sun,  7 Jun 2026 16:29:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B40B520040;
	Sun,  7 Jun 2026 16:29:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jun 2026 16:29:37 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 2/8] s390: Add .noinstr.text to boot and purgatory linker scripts
Date: Sun,  7 Jun 2026 18:29:31 +0200
Message-ID: <20260607162937.2927356-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260607162937.2927356-1-hca@linux.ibm.com>
References: <20260607162937.2927356-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SltHtirfSN7yH8t8d4_29psT7Zww5pzn
X-Proofpoint-GUID: SltHtirfSN7yH8t8d4_29psT7Zww5pzn
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a259c76 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=9kNBAdQCpEflj3fUxFoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDE2MCBTYWx0ZWRfXxti2C5L2t5Le
 aVD2V8GshrFOY02P2ybxyNj9dkBa86gP5ra+e69wwCZ68nqNJGdCahfT1YM1JlteUnbGaMd8NCl
 RG+9pgt4PCJ1cGMngI+1sd3YaSmSiJKzfMMrYupfa2I86sE0sloS6UpVqDVmZVRNJqaFkTcYT49
 1IkBM9PAspaN4IlfgdYNOzX370qlrMPlHCAfxuqm4Z7zn4NR5uq7I2zQikqOIa/eelIALdNFoxi
 VZXBgjrFkwgint/z8Amq/NF7Tqi4qkXA+a56JwTYApFstKe9cOnwgwixv6zblVFYmoh+f33MYwB
 cmrKhBYsY0i3hL4QGRcwt71weiNq5/A5iNI4ZeblKJwTvnFjw9UqSTF8X3caz2g/LFzeo3hN0dD
 vzKaPZo0TTWoCpco5YajThbVKhb93zTvgB8LNiiXpr6iZuQrkHOPWtCZqaPdwPgG1MYWtT4qeji
 dvm8GQH6KpBqICEhgpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606070160

Upcoming changes will result in a .noinstr.text section within the
boot and purgatory string.o binary. Explicitly add the new section to
avoid orphaned warnings from the linker.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/boot/vmlinux.lds.S        | 1 +
 arch/s390/purgatory/purgatory.lds.S | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/boot/vmlinux.lds.S b/arch/s390/boot/vmlinux.lds.S
index 070bc18babd0..d44964592541 100644
--- a/arch/s390/boot/vmlinux.lds.S
+++ b/arch/s390/boot/vmlinux.lds.S
@@ -31,6 +31,7 @@ SECTIONS
 		_text = .;	/* Text */
 		*(.text)
 		*(.text.*)
+		*(.noinstr.text)
 		INIT_TEXT
 		_etext = . ;
 	}
diff --git a/arch/s390/purgatory/purgatory.lds.S b/arch/s390/purgatory/purgatory.lds.S
index 482eb4fbcef1..387d0db4085f 100644
--- a/arch/s390/purgatory/purgatory.lds.S
+++ b/arch/s390/purgatory/purgatory.lds.S
@@ -19,6 +19,7 @@ SECTIONS
 		_text = .;	/* Text */
 		*(.text)
 		*(.text.*)
+		*(.noinstr.text)
 		_etext = . ;
 	}
 	.rodata : {
-- 
2.53.0

