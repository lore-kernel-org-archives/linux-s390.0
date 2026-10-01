Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDBA4CDDF7;
	Thu,  1 Oct 2026 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850797; cv=none; b=Gjq//ra3tNGSfWFo7LrTy98cMA0RQ3NzmNo20fZCvCyjNeA6fFvrcHatb/KVkKI2xUPRybAGbYIUpeD9EM4ZLlw8ETIO3pH7rgjrVEz/V6Oko7TadSZ/TLCobj0tGGw3AFk/NQIqAE1qTp77euU3Rxn8tirc5O0Lr4B5SxqNsFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850797; c=relaxed/simple;
	bh=lXDTFeGhE0maPqCZgeOkXGsBXLTByWYVqMt3YVOeLZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4FdjakYD0yYcxq5icfbDhpMqE3aXU9k4uE6cWrUD3V164+uYNi5bxxEa9sZRS4edwKcaWhvMvoVDwLnQSQQc1R5C0Tjeo9y923grkTImWukIfOyCRcACdH8WbgtfRfVtkh2dXwSF79XgW7xA9nlMJ7ct2FjGUSv+KvfCw79WJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mZMmQdlJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mZMmQdlJ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175oFf1086744;
	Thu, 1 Oct 2026 10:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=q7fIKGiLuvHegw9R0
	96pT+E8X3m6c5vbTnUvMnJWM20=; b=mZMmQdlJPEPHClYemq9w53JhtNUkgwpSa
	aYgVU5MKjn2Mb8nRPIu9Dx5yt3n8cBDyUVvhm+ErRXcwUkt/bw6lQif40+FB8Flg
	ChCetM4GW5GO7DUjl97DaczUEPnVChLZppdZK8E0VKYE0K8aWoWEp2zUuaoewvRq
	Ull2MHTjP2wQavYPRvzaLxf0+j/YBicHK+WoSMKQZ5hkMftRwLR+dyVROPmi/bME
	GKFJaOaFn5e10AeN/rdJMywl+CX1g44oYlXDtn6WZVAAwF0nf0rF+SUaJfNK48jU
	JkHakWqR3cNX0GRflh89rVf4U8bi2BRcH/p1OJV+6BeOCElwFRmZw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5jk2q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6917HPaE545524;
	Thu, 1 Oct 2026 10:32:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcsdg15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWtk556361246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F64420040;
	Thu,  1 Oct 2026 10:32:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEB7B2004B;
	Thu,  1 Oct 2026 10:32:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:54 +0000 (GMT)
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
Subject: [PATCH 24/32] s390/kvm: Convert inline assembly to EX_TABLE_INSN
Date: Thu,  1 Oct 2026 12:32:39 +0200
Message-ID: <20261001103247.1989111-25-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX3Hq+9dQj0fle
 yheSBxkgl9fC/xf6IZDGWY5twFwbGK8Q1ScXIDkf/+UIx+ND7+SOtxw99wG1ZTvV//6TRFah0NM
 a1XAHjaKCBlSrAA6TVo4vCrMNx/EBlU=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abe36db cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=d0-8ORCbJCeV-nA_9m0A:9
X-Proofpoint-GUID: dFG7GZZjVTTSGZXqbWynuVcuh4_q-HcQ
X-Proofpoint-ORIG-GUID: dFG7GZZjVTTSGZXqbWynuVcuh4_q-HcQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX59UPnaj8KMfX
 9D5qrD2jSMR/sefd2ojSY6TqyKT7TZ72YwHQ4WjiLGBEuLJuDXBtAPrsqDWQlJeWo5S3P65OlNT
 3r4cccgurdrhz7vn8cDFBVSAEyVLWZ+adOzMjbluTIIh1KxcpjflmQ5j7dvRvsJMRAth3wcLgcM
 7GVX8j5tmOwb66vFfmK8Hv8cVQEH9DGeUvH4iOpiKvn4j29OIRsENsU0S50Nt7j6iJkTbZ/zRKM
 Vqrq1BqZPTW85VhC22F5sF7JyLiZ6tI2KLpps8QUMbpk4u89b+49FOBGn03LoB1Sw19ivfjHHmT
 oUp7KvBfO2iaZ8NGF9ip0DmhSbNYjO8mD4tQ53HChXVo4WWeOjgj1BCOIHQ3xBknWLDDxAX6Yhr
 YKb7SjJtTvFnya7BwI13sZ0QY1sGRUk5E7JSC10dkGLJj+45PRPPyoCtZWDtEay69orHGRK9y94
 lkMIrckbDCGPMQP53cA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010040

Convert the gaccess mvcos exception table entries to use EX_TABLE_INSN.
With EX_TABLE_INSN entries always point to the faulting instruction,
so duplicate entries are removed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kvm/s390/gaccess.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/s390/gaccess.c b/arch/s390/kvm/s390/gaccess.c
index 405345ccc4f1..2d27dcb68002 100644
--- a/arch/s390/kvm/s390/gaccess.c
+++ b/arch/s390/kvm/s390/gaccess.c
@@ -838,12 +838,11 @@ static int mvcos_key(void *to, const void *from, unsigned long size, u8 dst_key,
 	int exception = PGM_PROTECTION;
 
 	asm_inline volatile(
-		"       lr      %%r0,%[spec]\n"
-		"0:     mvcos   %[to],%[from],%[size]\n"
-		"1:     lhi     %[exc],0\n"
-		"2:\n"
-		EX_TABLE(0b, 2b)
-		EX_TABLE(1b, 2b)
+		"	lr	%%r0,%[spec]\n"
+		"0:	mvcos	%[to],%[from],%[size]\n"
+		"	lhi	%[exc],0\n"
+		"1:\n"
+		EX_TABLE_INSN(0b, 1b)
 		: [size] "+d" (size), [to] "=Q" (*(char *)to), [exc] "+d" (exception)
 		: [spec] "d" (spec.val), [from] "Q" (*(const char *)from)
 		: "memory", "cc", "0");
-- 
2.53.0

