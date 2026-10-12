Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722A041A921;
	Mon, 12 Oct 2026 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805376; cv=none; b=Pi0rVHiV/m/9oeOL3o6orj4JPjXpXGBlESI38Ro8QeZ/7TArhnw7wSR0ql5Azqu40HwLzjww8dqQiHNff4fEq79+4eJ8fD5AA8Li2RTyGJcgqQq9IGlg2F6RoJxK4WYRTx/2lx0Q7So1bQ7apETRwKCsvh64blp9c8yWa7aaB9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805376; c=relaxed/simple;
	bh=sD5VdwfYi8Q3kVYYQA0FqeOiq2wi4sEl8dJPpMdI//s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QeCo8pfhKbXgR5BD4dmKKrL1k6Z3caXaBc7GHjmAc99HgFHpMy+HoNjiZNsR+udNa472MhwvlUAGPHx1pENRCqvjhslQTMB0x80lRXSWVq2LehdylNfGIebaVuCuWL+sQUNj6OPOp4eo+phkeix6u06SOd5QEXLpW++QejmaZ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qHFn6L5i; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qHFn6L5i"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8iBaF3917824;
	Mon, 12 Oct 2026 11:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=H14XrNQYhraumPKASnb2EySEg4wuPbu2ThzAY5slQ
	HM=; b=qHFn6L5ijR4QJLI7gQvJSzxvLMfyMqx/U/H98oNzoT8hCm5ufUL+C1P1n
	pfJ3g709f12lfdz+elW0Jg84gNJ7SyC+2wFm3iYTJOsp4kaD4LEexUBGzPVvUAmQ
	o0I49PtM9xjYX5CDqXASsun/jPk85OSIgb9Warg5GypfnZk0LoW7duj+73E+lDC6
	p9dqynDFsy8soxQAwYV09sTjg/9IscxBTuZUuoG4Mgb56k8grGwwbndt5HMggXl1
	BmNWVRSpbxXQAPUP0bkvelNk7Idsh72mIu3H2ODV2R7yzjXkFqLpq95UbjyKQrye
	wnSSAkRQtEXG6QCeXrPtNTOL5AE2Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv38ncc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 11:42:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8YrgK978596;
	Mon, 12 Oct 2026 11:42:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vn37a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 11:42:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CBgn3g44368248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 11:42:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9768820040;
	Mon, 12 Oct 2026 11:42:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71AE720049;
	Mon, 12 Oct 2026 11:42:49 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 11:42:49 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/4] s390/percpu: More small improvements
Date: Mon, 12 Oct 2026 13:42:45 +0200
Message-ID: <20261012114249.2898572-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Mcbsn4EGKR3N32XuAuflvVJE9UpZKVEg
X-Proofpoint-ORIG-GUID: Mcbsn4EGKR3N32XuAuflvVJE9UpZKVEg
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6accc7be cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=qphoL8xRS1Q0P0MBtcAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfXz2hFGfyQRZNr
 5J7wysiXv6+jNyrKN+4oasLmhsuTk4u0x8GDbip6mxzF8tN6uimCejYGK3eWUlvJe48DrpJ77/8
 ilJhmy2fuXmiaqz6+o01zUNoOf5zIvE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfX2HSN9mNqAPFK
 u6LgJknar0u9HLYNqsz2lBMYC0zkkCO95Ut1K3IcoJwFRjhaVE9ikcu2jnylmY5B/CLfz2SAjOO
 GupGj3Nv5WOPt520r0imp8vewaHRcNux5QgeTiTaCW5iwd7KQ7QWVJOBrT707trQpBAoKFThzxf
 8DfpDsMiCu00h3GXMUQz1dPfe8FxSmypBrVwlhnJOj2Xd9uJkURg0D+BECwzSXCHMI49y/TGScd
 TVsPKa+Pymt5mrZZ163oQtKqPy/eVY4rFK/DVv9NZS61fXmOb5OaRFKwYaqwYHUSD+EMfQ4TGv+
 D3Cgx109SfVk8jTOkaDrilUDvAJtRDbLtc153EDTTAQ9Gib68MbV2FKVxA6Ixt1Yq7wV+fuYQA0
 gKaIzWvO2VBzSRf/G9HrfZsLrYadTpGzphABiaYHLlmceHuO1AtV74QAD7FBMOwNvrOadiafCmD
 SKwTNd6Ly0VU2uYhGCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120044

Some more improvements for the preemptible percpu code. The missing
asm_inline conversion addressed with the first patch is the most
important one. While I first thought that it is a compiler glitch that
some simple this_cpu operations are not inlined anymore it was a simple
asm_inline vs asm in front of percpu inline assemblies which caused this.
With this addressed inlining works again like expected.

Two more patches reduce register pressure for inline assemblies. The last
patch implements this_cpu_try_cmpxchg() for s390 so the compiler can
generate slightly better code similar to try_cmpxchg().

Series applies on top of linux-next 20261008.

Thanks,
Heiko

Heiko Carstens (4):
  s390/percpu: Use asm_inline for arch_this_cpu_add()
  s390/percpu: Drop unused output register from arch_this_cpu_add()
  s390/percpu: Drop unused output register from arch_this_cpu_to_op()
  s390/percpu: Implement this_cpu_try_cmpxchg()

 arch/s390/include/asm/percpu.h | 59 ++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 10 deletions(-)

base-commit: aac26bee2287c88af5be5a5ff96d783b19a28790
-- 
2.53.0

