Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0A73C9890;
	Thu,  1 Oct 2026 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850790; cv=none; b=sO7PCnBVt/DYYMGErcsvUV2yn6Jgk6Yl0uZKd/y6QochVR48ttL/cVznJdd1eJxgVP37S97XGTItOVFDsSaWQVIB/npTA30Z1mVcOj3ZAdiZ7thhh9ZKHzlRFnRYsPNk2yXmJckZTSqdi08Nd781VGlWKj6gHz6XgWffV3ln+oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850790; c=relaxed/simple;
	bh=jl/gk+zjUOEBFedKXKsSvz+ON53VWy1XkyqlnGwbGAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oD6TEJER/illilxgG851TAhnZT/DX84+LDu+2DNVILYDrOE0ZNoJyvZ9CQUqg2PJNssgv2PD8EpjPzD6DGnEhh2qKA3qgMofwR4QT2+mcEa3/eenRR8uRYOVtl8NBnXrmA6/u5pNGo0gW5LnUGXpWt33rB1bF4EugM/c4h7MiAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kYs0D5gc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kYs0D5gc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175Wr04040782;
	Thu, 1 Oct 2026 10:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vBHdVF/NKCXChlqwv
	caSHUSF82N8bjZliOkItt+ySLQ=; b=kYs0D5gcNsm0u/01osZcLbecOZacHPVaV
	pR6hlE7GwBDlHBprvtY4qPs4f7fb6C+QsiYLVphp5UjAsd2fe6zijjhX+wLCtfWU
	ewBvIiiWD5IydnDxmtpREF48PfmdNwTGFUOwyZ4DJCxTHmKorZilobSNhqeYprfB
	FCDW69UFzfjUHMHMuQIrwlHdA28AnBKYRtPbmst0a+CFBW/KxxpmwEzZwmYOr7q+
	+MpxDZL6pB67tyQx5A3xSgmTW+EK6syOcPs23JdgodsNyYo6yCwvPa06LidPypxt
	TiXnzh74gT5HnjpUN8EADobqyqEXx2JXQ8tp2se+YgRM7cYnnoQnA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fehfn4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172cu4589725;
	Thu, 1 Oct 2026 10:32:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa7tf51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWpPs11206990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3C6820040;
	Thu,  1 Oct 2026 10:32:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88B282004D;
	Thu,  1 Oct 2026 10:32:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:51 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 13/32] s390/futex: Convert inline assembly to EX_TABLE_INSN
Date: Thu,  1 Oct 2026 12:32:28 +0200
Message-ID: <20261001103247.1989111-14-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001103247.1989111-1-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abe36d8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Fh9geHkbIchNwblgTfQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXwYjsMC46b2GA
 sWeo4BQwjtjfVRjDtyU9sajdR5VanF/LYXnliMyRbaOmwTdXLICUWA+qXkQ8IGSLig18FylmnBs
 5RvBVoglAhhYhfd+A558IziKz6yUyzc=
X-Proofpoint-ORIG-GUID: Y-fXBxb13_KJ-uh5xakIPBTRFIzhQ-_U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX2e4GzzbYRad8
 SHb0QyuECQHno5mJZDSpPfdz6FMbzHXJ6t4fAI0OaK/OqJpEyGwrW90txcFrkA0CcVMeC3PKSyq
 6onHIh4OvJSpT6QrjkXOxKIXpfPaKLKHa3HEOiknH7BVVAlLJLGnN0DJOGbeB60BY/XkYc+u7ud
 J5YmYq2Nd330WlfGBb6OPkmk43qKFKnxxa5Z+ZIYcQAGQZNlQFEMIqo/ySRGpidBMic7uArr2R0
 1LbbInDPn49O/qzIDrKlq5mkRT2Zp44osK2qR8qB1kFumdu40oyyE4l18JYsmOx2iq7yy4tQX1U
 xO/APsEgZBm9tC8r7jDSdgCjqk/b0MkQtJSlDfk6eqGov1N5aK+MixSt5zguVxrMEbviZGeI38D
 VtFN/KPROcLHxMf6AZ0e8vIgGVrnm0qRMWtXnHutQZbYkMUYM0abIR+u7ZRk8mfEmeI4QRc4KLF
 dno0/QqQ/xCE0z6nZYA==
X-Proofpoint-GUID: Y-fXBxb13_KJ-uh5xakIPBTRFIzhQ-_U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010040

Convert all futex exception table entries to use EX_TABLE_INSN.
With EX_TABLE_INSN entries always point to the faulting instruction,
so duplicate entries are removed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/futex.h | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/futex.h b/arch/s390/include/asm/futex.h
index 942f21c39697..71e8060637be 100644
--- a/arch/s390/include/asm/futex.h
+++ b/arch/s390/include/asm/futex.h
@@ -23,13 +23,11 @@ __futex_atomic_##name(int oparg, int *old, u32 __user *uaddr)			\
 		"0:	l	%[old],%[uaddr]\n"				\
 		"1:"insn							\
 		"2:	cs	%[old],%[new],%[uaddr]\n"			\
-		"3:	jl	1b\n"						\
+		"	jl	1b\n"						\
 		"	lhi	%[rc],0\n"					\
-		"4:	sacf	768\n"						\
-		EX_TABLE_UA_FAULT(0b, 4b, %[rc])				\
-		EX_TABLE_UA_FAULT(1b, 4b, %[rc])				\
-		EX_TABLE_UA_FAULT(2b, 4b, %[rc])				\
-		EX_TABLE_UA_FAULT(3b, 4b, %[rc])				\
+		"3:	sacf	768\n"						\
+		EX_TABLE_INSN_UA_FAULT(0b, 3b, %[rc])				\
+		EX_TABLE_INSN_UA_FAULT(2b, 3b, %[rc])				\
 		: [rc] "=d" (rc), [old] "=&d" (*old),				\
 		  [new] "=&d" (new), [uaddr] "+Q" (*uaddr)			\
 		: [oparg] "d" (oparg)						\
@@ -86,10 +84,9 @@ int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr, u32 oldval, u32
 	asm_inline volatile(
 		"	sacf	256\n"
 		"0:	cs	%[old],%[new],%[uaddr]\n"
-		"1:	lhi	%[rc],0\n"
-		"2:	sacf	768\n"
-		EX_TABLE_UA_FAULT(0b, 2b, %[rc])
-		EX_TABLE_UA_FAULT(1b, 2b, %[rc])
+		"	lhi	%[rc],0\n"
+		"1:	sacf	768\n"
+		EX_TABLE_INSN_UA_FAULT(0b, 1b, %[rc])
 		: [rc] "=d" (rc), [old] "+d" (oldval), [uaddr] "+Q" (*uaddr)
 		: [new] "d" (newval)
 		: "cc", "memory");
-- 
2.53.0

