Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D24DEC1D;
	Thu, 17 Sep 2026 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672973; cv=none; b=HQNtkvJ5QxgJxSOUkQa7wEJ7FVjs7j/GFkab2kOgam7/u2jFyzlIFIMaB7AbM0hFsGB8K7FzAt5vvHKu/XE/ljkKT45RiEDbVutEflurnv5GOxxwKjPsunai9uDneyiLhkPim4raj1zUsEAC/jDD2ZeUMWw5Ttm4ozpHlHD9Fdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672973; c=relaxed/simple;
	bh=Su7sJp4PolGeOOs8L1MNG5ZVxwB1v+NWwbtvFp2GpUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yo6StarY9xf+gkAjlEcRn+rO76CcO0Q7vKwVpp3QblztlhByFSYk0OiLdiJzm1U4jD7FiZZcjqMJ3lHBbClo3q1tcdDPNqJ0izvyOdi3AyIbHgCWIWPk+MCsWGN0UUXuXZhRg+IsTOOUNs2Q1Krk7wyvmgbr4HvAn9XtajbX5nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sQu6NSSr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sQu6NSSr"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HHVe6u2998424;
	Thu, 17 Sep 2026 19:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=O51KxBvtVfbHMzPOo
	XoHcywhUhm2H4kz862QP8ALIJw=; b=sQu6NSSregPH14u1r3J1aTzMPpCtTNDfL
	SHp5zHPOgMY8d1Q2KCoMHD04Z4vul5+pX+6c9BGsSPGX31w+aPeOGXfzbURn0HCj
	MC5toRxRBT0IYlb4HUnVdu7QnFxApK++N4I1yjmnVgm8sA2cUb/oSMPPtXn05aVk
	mkD31CSI2mR97048IICFpYsjqua8ww61ANFb88vXBVaM5lGpYhAsGXDePFUKSNfY
	dxcJuUVJ5U0Rb4s6IM54rnpfT/vSbr7ALZFciijmUend6Du71oVpX9YqRu0fHkzZ
	AKVoD6T98JcglwoOjqnKwOZrjon/k1pxhF8eRUiYrHelK7Zns1p5Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j458t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:22:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH940E261585;
	Thu, 17 Sep 2026 19:22:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr7gekk3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:22:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HJMcBP38142426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 19:22:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E86EC20040;
	Thu, 17 Sep 2026 19:22:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B892E20049;
	Thu, 17 Sep 2026 19:22:37 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 19:22:37 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mete Durlu <meted@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 02/12] s390/percpu: Add sanity check to GEN_MVIY macro
Date: Thu, 17 Sep 2026 21:22:27 +0200
Message-ID: <20260917192237.638324-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917192237.638324-1-hca@linux.ibm.com>
References: <20260917192237.638324-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI3MiBTYWx0ZWRfX26T6KMKwu6YL
 5fXnHdzjJ0WgRn6KaFijtfR+p5zN5rhn430UlQvz/Qifs/4DCMYbktcyjthbheDjh1Bv7i1LUtG
 TFzDi+PHV5J7iVyUbZ2q0/qVVACLPeb/qJuLQL+zpiMdGZIWsLq0ps+/Fteq1ED0yUMb8fynz3c
 wp7UCewSBrzTfM4BD0fO2BUKka+LIXmdQ0Q6NHkmj7wE7GgPojXWGj/wrmUEhQzPtDg0mc/y4Es
 Ofh4krSsfxUItt4Kh3B2G6htTpYTmJZObEB/ULGKXkjybNSg3oP3g4GM/cVhFY0R6BwfuvvolKy
 5/KiMEc1REnX2BFzD2TVfuMOLUXrKtOz/G7zFzfdnWlQmfp+oYwtBAogWYV/65pevTuMVi+j2vl
 CX8gnXeVECs1rrKNdCsE3EPJVcKKvhB8NOqx2vZ0k+kSb6Hsd/FW/eM8cadm52F0+n6OIJdjmHC
 YAPvm2/MqsrvxznnIlA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI3MiBTYWx0ZWRfXwMoLUJW+lmrT
 UUce9n83t18SokdJfHJ84PBly41zs/zo0PqRM9nbCSziDtY6D/Y98k3xAcbo3kNiCq7zb+g6hQi
 C1VjTiBddsUsmuhO0yne95Dtdn0W1MU=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aac3e02 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=nXcjTbxpPpxkwf3kCnwA:9
X-Proofpoint-ORIG-GUID: 9NjdtlrRKsI0NpMQl5AY0ChWIuKUP-Yo
X-Proofpoint-GUID: 9NjdtlrRKsI0NpMQl5AY0ChWIuKUP-Yo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170272

Emit an error if the GEN_MVIY macro fails to parse the passed register
string. This will make it more obvious if something similar which was
fixed with [1] happens again.

[1] commit 101782f8945a ("s390/percpu: Fix MVIY_PERCPU() with older binutils")

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 31012abe8292..9888b38dedab 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -100,12 +100,17 @@
  */
 
 #define MVIY_PERCPU(disp, dispalt, reg)						\
-	".macro GEN_MVIY disp reg\n"						\
+	".macro GEN_MVIY disp, reg\n"						\
+	".set	.Lreg,255\n"							\
 	".irp	rs,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15\n"			\
 	"	.ifc \\reg,%%r\\rs\n"						\
-	"	mviy	\\disp(%%r0),\\rs\n"					\
+	"		.set	.Lreg,\\rs\n"					\
 	"	.endif\n"							\
 	".endr\n"								\
+	".if .Lreg == 255\n"							\
+	"	.error \"Illegal register number\"\n"				\
+	".endif\n"								\
+	"mviy	\\disp(%%r0),.Lreg\n"						\
 	".endm\n"								\
 	ALTERNATIVE("GEN_MVIY " disp    ", " reg "\n",				\
 		    "GEN_MVIY " dispalt ", " reg "\n",				\
-- 
2.53.0

