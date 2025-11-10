Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58483346AE;
	Mon, 10 Nov 2025 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800890; cv=none; b=GN1T1Z6HgX0QIqDXxpjf2jeEfQAqrI3i2ft8cpmg0ann0AqYFJ/r6+60LMgIPk+J4NkIRaZ30q4KcetBFr5gTLlHxdn5LaGjjPthdjZ1mqMUTXR5jI+fmbTU2FvRk9Yf41C7rjq/GY5wLbfENvwqxYoYKgjyRAkpxPAuBZYMsDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800890; c=relaxed/simple;
	bh=ZpB7RtCydCRVYyzVvWoD+YsIa5mPYS0VX+htx3ac/2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cq3Esl5VhanNr2eGEm+k4ydR8WybUQ5spK+/9eIrwkr+iSePSO4jq7JZHQoKGn7a0GZEbBcUz7onaIHWK+4SoM18S0QUFehAU37tGfm5+bH9ox+Sbh2Q9+nNQP52Sk5PXZ27ZuSsjGTsXQX/Vbjb9/Xba2P82uLsivLBRAF9wG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gYfJyKfs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gYfJyKfs"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA8fWjA000920;
	Mon, 10 Nov 2025 18:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7i7v9/f93B+sTjLCx
	tgOmqCNcfJ8dMjlz9YrPJeGAVw=; b=gYfJyKfsmKVGG5ojDPIAEXP0t4O1kgM20
	RjpywOxcj1/+LAojxz71NzTTS/rlVeV1vANNDbYuo/FdbwU6Xqpj2oAEuFfNbrYE
	zPKGoxV1eHEPdFZfoGZhQNAWQLCN6cwVmSMUWUoAVPCBLukspkl1Q3Pmi5bDjSYZ
	hrpN4fXNB68Ik0/QOxM1VUC739hJ62/m90HQJG3hAwL1ZKg/Gafi7hy9tdI4hvS5
	u6Efi3AF55EGEkalzJjb2+QAKyPejzDUVhnYe+6hVylmSjVwvyVkD8+lV0jNxf65
	41hFWqewf2PrSJN0O4GkdSQCSJ97A8l3eYtXdIjbqe3YQotLq1d3g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m7yyf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 18:54:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAGbrnv008239;
	Mon, 10 Nov 2025 18:54:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aah6mq4mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 18:54:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AAIsfmv30146888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 18:54:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0178020040;
	Mon, 10 Nov 2025 18:54:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D06F62004B;
	Mon, 10 Nov 2025 18:54:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Nov 2025 18:54:40 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [RFC PATCH 1/8] s390/ptrace: Rename psw_t32 to psw32_t
Date: Mon, 10 Nov 2025 19:54:33 +0100
Message-ID: <20251110185440.2667511-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251110185440.2667511-1-hca@linux.ibm.com>
References: <20251110185440.2667511-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MtZfKmae c=1 sm=1 tr=0 ts=691234f5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=3YmZTrtIW9MuEreA4lwA:9
X-Proofpoint-GUID: _MQvrH8-bhgXmX0by80M0ROmmXiUpJ7V
X-Proofpoint-ORIG-GUID: _MQvrH8-bhgXmX0by80M0ROmmXiUpJ7V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3OSBTYWx0ZWRfXy++cTXf/uTu9
 pnLUHam8ImxK/OCb5XIylL4jfMJ98O7+LC5cMPrvDFJGf9pvo2/xw/OD/0qF0fxG1zCkTtL7OjW
 6jlRgeqKQHzKFqjeCEpgrTOZpWP9c/jw5JLFeF+H4Q1yWi7KWWiGAGe9U/OErdic738lL+I4PBp
 uxhxNPsgIqH9ULMvIxzwX8CDeUAkYSptrQdv2BIYJ3vVwk9kAl+kXFzdZH6nAggeP+qOCV4ad3y
 MyGSZbnnVL0r/P10tMVAtPyTYhSGT1YLu0QIs7x8px2CsKa9HwIO7AcW2jhcLt9L7XFEbVbTcMf
 1+TrG6GY7kJhCY6rLcPPMyMVwOQTZxfkWBB5wYxnikPzKR6RDnhKe5vNmhwqA4RN3r7E7sqPFQV
 PB1ITBQUL7oOPx9F2gNgEnLLGYgWpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080079

Use a standard "_t" suffix for psw_t32 and rename it to psw32_t.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/boot/ipl_data.c       | 2 +-
 arch/s390/include/asm/ptrace.h  | 2 +-
 arch/s390/kernel/compat_linux.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/boot/ipl_data.c b/arch/s390/boot/ipl_data.c
index c4130a80b058..7957cc6554e7 100644
--- a/arch/s390/boot/ipl_data.c
+++ b/arch/s390/boot/ipl_data.c
@@ -12,7 +12,7 @@
 #define PSW_MASK_DISABLED (PSW_MASK_WAIT | PSW_MASK_EA | PSW_MASK_BA)
 
 struct ipl_lowcore {
-	psw_t32		ipl_psw;			/* 0x0000 */
+	psw32_t		ipl_psw;			/* 0x0000 */
 	struct ccw0	ccwpgm[2];			/* 0x0008 */
 	u8		fill[56];			/* 0x0018 */
 	struct ccw0	ccwpgmcc[20];			/* 0x0050 */
diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index dfa770b15fad..f2ecc013a48a 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -99,7 +99,7 @@ enum {
 typedef struct {
 	unsigned int mask;
 	unsigned int addr;
-} psw_t32 __aligned(8);
+} psw32_t __aligned(8);
 
 #define PGM_INT_CODE_MASK	0x7f
 #define PGM_INT_CODE_PER	0x80
diff --git a/arch/s390/kernel/compat_linux.h b/arch/s390/kernel/compat_linux.h
index ef23739b277c..133f22b5deeb 100644
--- a/arch/s390/kernel/compat_linux.h
+++ b/arch/s390/kernel/compat_linux.h
@@ -33,7 +33,7 @@ typedef struct {
 } _s390_fp_regs32;
 
 typedef struct {
-	psw_t32		psw;
+	psw32_t		psw;
 	__u32		gprs[__NUM_GPRS];
 	__u32		acrs[__NUM_ACRS];
 } _s390_regs_common32;
-- 
2.48.1

