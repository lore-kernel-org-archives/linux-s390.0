Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C32C47CA80;
	Thu, 24 Sep 2026 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251054; cv=none; b=YJqe152YZX4IrvmxWZvnQje6LhXKLQtF7l1dj4r4d32rrmwiT9c9aRNU/POL1mHkMeiSHUS7D2Q0jMZXvQ+aBYOULeqwdJxqrw+Sl7d18s3wsvvr5rstLKUyPQswOdPthdiCVCAL/PlOmYdx4XoDyQZrkH2h4H6+itprNHA5uvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251054; c=relaxed/simple;
	bh=8elAthJn3tOqUiHulP+c4KrLbQvQzHSE/FuM1ejuB8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3uQ0CpzEZM87cGhaMTPncFGSy7e9RfVPuP/PnElx3QUcmf6TVZ/o5R76Be6TPwyOUHGlsKzb17baFiWO9LM/SX0ajB1gzmh+3CQPXl3f7gmdnu4+z2n47mcNJx/x+aCUutnjKJg2OyMVQFyD3I8ueGzymdHRrGMD07IRQjmSAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iVoGOtEl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iVoGOtEl"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5bTXP3657747;
	Thu, 24 Sep 2026 11:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=CXe88aj87pdLSpWQbtsXGqhOJKkqIX8TDwYa3IZzN
	AY=; b=iVoGOtEl9q9Sc4b5o6MIZ/Mt6TfW5dywqK1fvTqhXmJSq+O30tSLYxEaq
	zvZG8dDN4FTqIrvbMjeIznq77c+GmVld4VQiD78G2hH0pkGawpGALKfWfDwu4Nf/
	0rQpE2nT1tQj2oGtHF0R//3C4yMJ6AXgaIGzztlWeM1wtcHjBa2MvK7BA24VK4Zg
	hyOOJAlwjGYvr5gqr+oAA+HMzUmjQBuNbFviAWoAbY0kZi908s4DoRlQdZffrWfY
	EBsIwMMCLBxh/R+WsPT01Pmu4kGmUqxHiTnLGUN9MHaM7cMJNsfvCz23gR6I66rj
	nTA7zRyE5wT5fGWFS+QI0T0PNDgNg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske20sf1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 11:57:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OAEtGF1539512;
	Thu, 24 Sep 2026 11:57:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1whkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 11:57:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OBvP4138994356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:57:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 550DB2004D;
	Thu, 24 Sep 2026 11:57:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 270BE20043;
	Thu, 24 Sep 2026 11:57:25 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 11:57:25 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH] s390/kprobes: Prevent kprobes on instructions with exception table entry
Date: Thu, 24 Sep 2026 13:57:24 +0200
Message-ID: <20260924115725.1108581-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mhwT4rIvLa3p8yTzCbZSzTBodmqLzv4u
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab5102a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=3K4JMSNACPa9h271a24A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0OCBTYWx0ZWRfX24cmoQ3Xos/i
 XoMFM3zWtyxSFlztTNWDX2JyIszBwrWhrkKz5UqVFtPLrf+RwncMjpkcs/D7Mp0qOU55sjWMcJa
 q/HmV/8Jz/b9eyYJPnlmELRvXOS+Ax0=
X-Proofpoint-GUID: mhwT4rIvLa3p8yTzCbZSzTBodmqLzv4u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0OCBTYWx0ZWRfX97l3lTA1DvXx
 OSj1PDAmUl7g/ZcPWIZMtL9nX1JpEW/u8UJNWQkxHYaYmKGeAl++shq9s8Gnzae9y3NtM6Wa4md
 5pkAiPv/TrhD5XpWXde0ueXGVk06uQNjLgsPhiYnFaQZs5xbmdJRk6KxFt8x4ZC5+PVbOHJNapU
 P09Mk+pq/UWHCYVnh5wF6Of3RFgtIKll930YNP+MnZVveeWbpOWXmAV/D28c4cajW7NnpW4UED+
 9iec7QAZLc385TMZHfHfxwyMn7VXopMnQXjK/RwcBM1BN/kkhzU16TwctGZFEd68bEy5GsLzc/D
 Nxdd9TJ9AEh9AlCzdYo+RodmDvhEzbUyPwJ8Nwz4w2f3afs3AGyzy9LU3FvrQCdHhfykbl3j7ac
 QzgRTUAIKXjjru8JH6FYNewj2Uw4PaJo3QxEkdfNzzxbp8Q73C3kP6XIEq+cZ3PQT8k3zf5OQUq
 WRarfG22fbYyYWDS4ng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240048

The mvcos exception handler ex_handler_ua_mvcos() decodes the faulting
instruction, assuming it is an mvcos instruction. In case the instruction
is kprobed the decoded instruction is a breakpoint instruction instead,
which leads to incorrect instruction decoding and potential register
corruption.

Fix this by simply preventing to set a kprobe on such instructions,
similar like arm64 is doing it.

Fixes: c488f5187a24 ("s390/uaccess: Shorten raw_copy_from_user() / raw_copy_to_user() inline assemblies")
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/kprobes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index c450120b4474..e806b124e4ba 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -85,6 +85,9 @@ static bool can_probe(unsigned long paddr)
 	if (!kallsyms_lookup_size_offset(paddr, NULL, &offset))
 		return false;
 
+	if (s390_search_extables(paddr))
+		return false;
+
 	/* Decode instructions */
 	addr = paddr - offset;
 	while (addr < paddr) {
-- 
2.53.0

