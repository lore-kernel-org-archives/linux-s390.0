Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016216;
	b=Z/QF3ZWmhgZiJ3ILv7zdP5Pr3JMx+S5PCEOdj09YgYEKEtnWzwNjTITSecr06whjneBO
	 V9bTC3qOG56Y6nVuv/cmFbAIwiKNwpu8NWiF9xu1CZ2uzpdZzU0fG5u7cGlpPDMaKDds9
	 UGyuJeu0JEOjUAG5LRjPQ7CXSAc0HspV63UuV5PTnhxcvmdhUncsCnGpc9z9wQr35sTzd
	 YrYAPJFiALnbyeKrquIrpXmrIaVhfwdvCTCT+lCxQRmQGCF4BbVgRjsEdw8W/KM0Fzu68
	 sY8eiPFgQEvIK3BNc3KF1hkvtlg/8l1A4FGU/bxiKJW64hQFkbuvveeNcYWqPnF5IMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016216;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=TFecFQTIFhIuh3foM6FWz5QM2Krtsl5bPwzJ2rFV4Fo=;
	b=FvaBfYrsBVbK/nN/nNYtypXWzW0FzaPEa//yawp1dyEXb5BxUspPJij1Wxw6xIKheCfE
	 QiU25V20hXAPNZfioqhEnQd2zNTSoBXaIUpwqMT62BTXYdOkopQtkoC+reSdoF8DTzKVs
	 YNQgtUYWFYNd3vRAYgO7vGtsS3HJoaJ1YJqMohnYBIOUF1d8nAb0gzXmrTC4tSTvNw5NW
	 GBay35WimisC3Rj0w99niHPVGCTkBfygfsL9petia2Kbcvyx8T7bIo4DsIebAycBv1NOd
	 R2EiIxHiwVeh3twnkuaBJ4MqAHH/QOCk4dd/7zRqMd/4xLwYXjgGxO3/qVyNsUvRccw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BJOAI2ZN;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CB7606A31D;
	Mon, 26 Oct 2026 12:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8CB7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BJOAI2ZN
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QBEMbC3272807;
	Mon, 26 Oct 2026 12:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=TFecFQTIFhIuh3foM6FWz5QM2Krtsl5bPwzJ2rFV4
	Fo=; b=BJOAI2ZN7T3uvrnlsVL+0zodLL2T3YVcpmop0maWWV4SVeZPMn1rdo1s+
	5QlP3lwVzso6YGXVEgQPIQY525ndYl7O3CdnLDXtGLzE732jHO1X0ErlFCmxFuVu
	xIgiU0tvUucmcnOu2uwsD8ECtWmq1me4oZlxyAjADR7qfaTQHVV5qCX9YRiOsjD9
	M7haUv90Cv/g/6GoBL4BDM2eVaYb6YQC/b8URBjCEVlOQlHuzehEmsiEC0gZvjmM
	tAVUPeg/kvuLAvUoy8iY+EFjXV+xzxPC7WSiM+rZ4sX53n3OSHfrSBgmQA/a0CyF
	TmhoNW5hUu5MAGTiUQ21HciKEZZJg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3m1w2h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 12:03:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QB5Ktl2503079;
	Mon, 26 Oct 2026 12:03:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hh9py5ep6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 12:03:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69QC3UbS44564746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Oct 2026 12:03:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1714A2004B;
	Mon, 26 Oct 2026 12:03:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D906720040;
	Mon, 26 Oct 2026 12:03:29 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Oct 2026 12:03:29 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/4] s390: Consistent usage of text_mutex
Date: Mon, 26 Oct 2026 13:03:25 +0100
Message-ID: <20261026120329.1792436-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NiBTYWx0ZWRfX5hjzSWOV7u5v
 bYRL7voiqAi8YJ2GUihH+az9vaJdK1rlgfWPUMZQ5B1rBoHWYbcsZ5Eb8SEo5nF1mSr6Ug97ZrI
 Xbj3mv/D5jH6x8fGejTl0z3mJBz1p0k=
X-Proofpoint-ORIG-GUID: bbuLSOFfmDkhpI9xqXS-OOb1-KkHk7h0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NiBTYWx0ZWRfXyD7gtq6Zwb1v
 v3ndyJQrkGpylp/Rb5xfFP5tNCpCMf2M+iMHQDaq7H4ZSYTOIUsOxCWLR1QeeBFBLj1gz9H4AEv
 jJgKQEdl9jTTsTgRG9+/9EE1t4zmbU39SbCmkXoNkU+XMSilXaB/jzWHfMJoAfPgjZeTjyBl9dT
 NRneoJyaZmBHzbpFlbBpS9eUKKXKH2O6LUBKjGiN85d7xZVllenSg7XVA9j4gtoQVkuwCkpj+sj
 BdtSN4oVq9zRVZYzcXanKB0EJGrrvxHeGB62PUSJew58nVxUeNBlRnb+a+Q102rwhNOt+E48FWB
 HWLKaBue+q2Ap3+gvrcoTtGM+vqxavcuGvTLUY+CSrdoRhfGPU2VytX0HedpcNW96EkSG0T2GlH
 KjBch+04ZZj5XBsySlP5mvD8aHzc7yqSiUgVbiWCzaIYclF46BzcpM1Q9ritK1GM3auwlyoDAy9
 ywCkaRA1nT6L/dCtTNA==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6adf4196 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=1VkLTK7BBF5flZQr4b0A:9
X-Proofpoint-GUID: bbuLSOFfmDkhpI9xqXS-OOb1-KkHk7h0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260046

Other architectures serialize kernel text patching with text_mutex. s390
does not: __s390_kernel_write() relies on a private spinlock, and callers
partially depend on implicit exclusion (e.g. no kprobe can be set on a
jump label).

Make s390 consistent with other architectures:

- Patches 1-3 add text_mutex to the jump_label, ftrace and bpf text
  patching paths

- Patch 4 removes the redundant spinlock from __s390_kernel_write().
  CPU serialization, previously done implicitly, is now explicit via
  sync_core()

Thanks,
Heiko

Heiko Carstens (4):
  s390/jump_label: Serialize text patching with text_mutex
  s390/ftrace: Serialize text patching with text_mutex
  s390/bpf: Serialize text patching with text_mutex
  s390/maccess: Remove spinlock from __s390_kernel_write()

 arch/s390/kernel/ftrace.c     |  9 +++++++++
 arch/s390/kernel/jump_label.c |  3 +++
 arch/s390/mm/maccess.c        |  9 ++++-----
 arch/s390/net/bpf_jit_comp.c  | 21 +++++++++++++++++----
 4 files changed, 33 insertions(+), 9 deletions(-)

-- 
2.53.0

