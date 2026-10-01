Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF57C43B3F6;
	Thu,  1 Oct 2026 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850790; cv=none; b=ty3EWPb9XygVdvEUxVWv6K8sAFAG/GPtwvA2sjvnTs8qkUZ+AL0rPMIrRNQLIGnWMeq8uK/d4PAU3JvI4lKOwugq68bau6Ag9sF/xe5RtT06liQHKNbA5ss7hYAL+siRPzL3GHY+FtUiupNlU2kDhgrw7vJL76gnmQ2WCoP7uCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850790; c=relaxed/simple;
	bh=zqSssT+DrmrFwVnV8JFnFiZdYuLF8Nm3mexrZBbWxHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9gwZVLTz2gI2LyWczcTzd7xGcqxror+OylvnSv71l+T49wGHPx2jH9z92VB5CAmlEIp1dh7dJYCgKsn3kc4MQ1uHWIVPpI1XSZuYy8xIQSY82rpc4DWZzl94slT1ihejnE99a7cvQ+iqHvDDDh0zEFYxMOjnRHBh3D8Nr4bYio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OrydcS49; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OrydcS49"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175cT6907404;
	Thu, 1 Oct 2026 10:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KLR/KsylF28fiatQU
	SGae0Shr51VD6U/u9gJdqerP4o=; b=OrydcS49GjohHM6f5ibzj7CyWg7Ab2Dne
	cae+b1jeYaW6wCwgFFojz3OYBOjyUk1ZSHTYQY3k25ThAMC4+M104z8e6yO7yyxK
	OfRU2r3iCmv7ODsTHwKvGEEm8ktUjBLn09NtTN8mXu/qiOkX9i++9yDarpxNVJle
	KuFHgN0XJnJ7TKZoRLhZ/UXvlKe209dPJY2iixcuRd98v+x0yexuiPjCkmtgrkoX
	fwrUgxKZOd2THHbaGoVSD2rzxLtvoEv/bXVAbCCrv52YRj5XzVhOb7+orYiXF2iz
	rEcJq9B+ehrEcq+KzIpNYvJHK+rLw5VoMXWDB0U9BpDBhLtkRgYWA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkhspu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172tm63460494;
	Thu, 1 Oct 2026 10:32:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pexb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWp8V14746098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00A1020043;
	Thu,  1 Oct 2026 10:32:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B89E62004D;
	Thu,  1 Oct 2026 10:32:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:50 +0000 (GMT)
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
Subject: [PATCH 10/32] s390/diag: Convert amode31 exception tables to EX_TABLE_INSN
Date: Thu,  1 Oct 2026 12:32:25 +0200
Message-ID: <20261001103247.1989111-11-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: DwbsA7sLnlnIeYKEMk4gvnsu2Z0dJc-2
X-Proofpoint-GUID: DwbsA7sLnlnIeYKEMk4gvnsu2Z0dJc-2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX4UE2VzNlt5HI
 gIOukhG0mc5sUCS17pHIYe47/A6j94mc+M1r6M1vb8KJgtG2mHHmQHTbXzT1e+PUSFE5Q6Iwzwd
 35rhwneNGm/CXt8z9A/MnhGAAUInU/Q=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abe36d8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Zi-ju_Wtc8KfHy_39owA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX9JDI7ywSQq6c
 8iVhoktkxRhh2jzYwQlcZVQZUSD+aWCNeHJmN5O+wCq/3pzROGvNp+m1RBmZfv5PHFGVjDcXAeS
 wrb/GBRky7tH2RL1i46BHQvqVQhpqc+wfitY2hFEiUZwNS0k/7ZhA3N1TBj/wDIOQdDb1YjLGBY
 01b65rQ8mRp1pDSZ+nwBKrMa4yC2UsYHytc+QgyRIaQjVAEWce3zBKUfzGdlD82EgArphncSRkt
 8F/P6cFjMvbhp3sSOH46t/fXCF0LkRDIAeftwpCLG2d+SIxBSEdzkiqM2fBy8A9ewajgbryeXLT
 MZPXCz76YfQNDY8xhk5l99iVkxmUDWZdcp5JPE84Iwmu64o9ff9obcA1XqKbU1Hk8ExSE+19a/N
 eGi2np9yJfjIj2bJ+JVM0CL3nXdFQt68VMU582W+cd9OnyfXuWDcHILU9qNLrznAX3BVCHaSjGm
 vZqnLwvul0n+/jpILIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010040

Convert all amode31 exception table entries to use EX_TABLE_INSN.
With EX_TABLE_INSN entries always point to the faulting instruction,
so named labels are replaced with numeric labels.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/text_amode31.S | 34 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/s390/kernel/text_amode31.S b/arch/s390/kernel/text_amode31.S
index f007d892d0c5..7761de491443 100644
--- a/arch/s390/kernel/text_amode31.S
+++ b/arch/s390/kernel/text_amode31.S
@@ -19,9 +19,9 @@
  * affects a few functions that are not performance-relevant.
  */
 	.macro BR_EX_AMODE31_r14
-	exrl	0,0f
+	exrl	0,555f
 	j	.
-0:	br	%r14
+555:	br	%r14
 	.endm
 
 /*
@@ -33,15 +33,13 @@ SYM_TYPED_FUNC_START(_diag14_amode31)
 	lgr	%r3,%r4
 	lhi	%r5,-EIO
 	sam31
-	diag	%r1,%r2,0x14
-.Ldiag14_ex:
+0:	diag	%r1,%r2,0x14
 	ipm	%r5
 	srl	%r5,28
-.Ldiag14_fault:
-	sam64
+1:	sam64
 	lgfr	%r2,%r5
 	BR_EX_AMODE31_r14
-	EX_TABLE_AMODE31(.Ldiag14_ex, .Ldiag14_fault)
+	EX_TABLE_INSN_AMODE31(0b, 1b)
 SYM_FUNC_END(_diag14_amode31)
 
 /*
@@ -51,15 +49,13 @@ SYM_TYPED_FUNC_START(_diag210_amode31)
 	lgr	%r1,%r2
 	lhi	%r2,-1
 	sam31
-	diag	%r1,%r0,0x210
-.Ldiag210_ex:
+0:	diag	%r1,%r0,0x210
 	ipm	%r2
 	srl	%r2,28
-.Ldiag210_fault:
-	sam64
+1:	sam64
 	lgfr	%r2,%r2
 	BR_EX_AMODE31_r14
-	EX_TABLE_AMODE31(.Ldiag210_ex, .Ldiag210_fault)
+	EX_TABLE_INSN_AMODE31(0b, 1b)
 SYM_FUNC_END(_diag210_amode31)
 
 /*
@@ -68,12 +64,11 @@ SYM_FUNC_END(_diag210_amode31)
 SYM_TYPED_FUNC_START(_diag8c_amode31)
 	llgf	%r3,0(%r3)
 	sam31
-	diag	%r2,%r4,0x8c
-.Ldiag8c_ex:
-	sam64
+0:	diag	%r2,%r4,0x8c
+1:	sam64
 	lgfr	%r2,%r3
 	BR_EX_AMODE31_r14
-	EX_TABLE_AMODE31(.Ldiag8c_ex, .Ldiag8c_ex)
+	EX_TABLE_INSN_AMODE31(0b, 1b)
 SYM_FUNC_END(_diag8c_amode31)
 /*
  * int _diag26c_amode31(void *req, void *resp, enum diag26c_sc subcode)
@@ -81,12 +76,11 @@ SYM_FUNC_END(_diag8c_amode31)
 SYM_TYPED_FUNC_START(_diag26c_amode31)
 	lghi	%r5,-EOPNOTSUPP
 	sam31
-	diag	%r2,%r4,0x26c
-.Ldiag26c_ex:
-	sam64
+0:	diag	%r2,%r4,0x26c
+1:	sam64
 	lgfr	%r2,%r5
 	BR_EX_AMODE31_r14
-	EX_TABLE_AMODE31(.Ldiag26c_ex, .Ldiag26c_ex)
+	EX_TABLE_INSN_AMODE31(0b, 1b)
 SYM_FUNC_END(_diag26c_amode31)
 
 /*
-- 
2.53.0

