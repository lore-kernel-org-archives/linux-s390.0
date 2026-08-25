Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9705A3D331E
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651373; cv=none; b=Ck9iwPNuqgOJHoyr1Gvj9X/A/UeTJlVDtturFqreo4U2X5KyH9mFd6/n1puHu/jEs8MwIo5pnsO6Djr9fISzryMyE8vLxrtiN1TmGLvpV/m/GONM4bsrM2lZOsOiU40d4RtBcqW1T3IhBP7ng+jfLfphhd1Ao86Pbd6yZp9POjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651373; c=relaxed/simple;
	bh=oAAbIGJB8P9w3IY6LHmChMzTT7YK3Zxk1NALn/yMeWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqK5TH2LQxrvxnUFd7Sis/Lshc9jDQ6Gt9zB77Cr51PPJHv9rBeXEGrhGKsNeJ1NOuxE77u633nILNBGgZpkHrsQvgi/+jkNDsVt9pgZZehgcyZ4zZaN4SnFQSCx2pHBJJGN60REN3iQWXRd4HJwZIyucfVhtBYN5Zz89igVEOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R8YqjTj0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R8YqjTj0"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P8Vt3l3390832
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 09:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=s31fTtojiZPu6qoyf6UXKUr/A+tHq67RGFgNmxgAu
	70=; b=R8YqjTj0aB2P0VR/K2zSQ8Uc1yMoxUxk2+rmg9M+MzYE3hdiXkXDyETiv
	vXagaMzHter1ma4MwkNG4XO5p7rldgfXwEvak31eAZGIZq/04bvqVv4t0rm+WHP+
	2RI+Ob1X7DunoGxQFbyV9jnBvZ/GP+IhQ5p2C2+hojfM1hSN/7i/ja2Au/uff3io
	OjUi8wDXlbCY+4HhdgEuS/1/nkbZFPeMG6YlzyRUv8k17XSZMZ1enDZTcCPmzD1a
	PPUb9kBAi3hSz2M4KVHDzxFDRjyEZwGSuhXcB5vNL5okXuu/BghaVu0Jp7lehyLf
	7vI5Fo6NzY8yQa96cK8WIcdsqf5Gg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726efadm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 09:49:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67P9fGOP026169
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 09:49:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragbc7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 09:49:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67P9nPmc45613464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 09:49:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80A7E20043;
	Tue, 25 Aug 2026 09:49:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B4072004E;
	Tue, 25 Aug 2026 09:49:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 09:49:25 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>, Jan Polensky <japo@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH] s390/pai: Reduce excessive debug feature size
Date: Tue, 25 Aug 2026 11:49:25 +0200
Message-ID: <20260825094925.1791807-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8d652a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=EuNfoUzsaLC0kSwvaWYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA4MCBTYWx0ZWRfX2jXhzElceg2/
 QiXR5s6D4DvJ42GUMCinApH68ZdAAfPMFYrobQpDtFoU/0AHwMJSr9k0AHMdB4iWr6j2ogL0fXC
 +2tSB+bRqa3obK8yTyRHMXMDK6n9xU4=
X-Proofpoint-GUID: FTd1iZ03MGQDl03SBSvX-6qP1xOBGQQc
X-Proofpoint-ORIG-GUID: FTd1iZ03MGQDl03SBSvX-6qP1xOBGQQc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA4MCBTYWx0ZWRfXyb4C6PErcMms
 CEVSQUxG8+5QpwngtUC/0NUMQKIsG815uK+nxeG+2pTtVQtzFhRqsD3A1REoXG7jVVJdZM5ljQt
 cAyn+u2AtpClpqLUWYwct0SAbijUJocLsvfAustaRuMAEdPVx6Z7yF1q6QlFHXffne++7E4XH2X
 jrY60WiU7UBMGubAMUcGv6QZiSOF/wnlqh7ZE4aom8BnMgmW6E403ooI1Q4LnjC7nt/EuLVwxcj
 CWkbbsNsll56jXYTpxf1Swc4ilT8DijGkAf4v3edwcxZcnvAK/2jgGha90UteSnvrbeP1mNJxey
 MxO/F72WmctYnPKJ9pvRjVGuqRaFchJUAIGR6G9dpueeoth7x+PF10OBwSgTD17KBejomVxF0VT
 XNbzhA4WuGjgG96ycE7Ju/F3+8xlFpLOFtXRLrJlVQYWuizCu3WOiGDSQgNswYlLswQ9JUZjC2B
 87ZJnM39wwHcGn+R/yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250080

The pai debug feature is registered with 256 areas, where each area
contains 32 pages. This sums up to a total of 32MiB. The code does not use
any debug exceptions, which means that 255 of those areas are never
used. In addition all existing debug feature calls have a lower level (5)
than the default level (3).

This in turn means that without user interaction the debug feature is
unused.

Reduce the number of areas to 1, and also reduce the number of pages for
the remaining area to 1. Since user interaction is required, the user can
also increase the size of the remaining area, instead of wasting memory by
default.

This reduces the total size of the debug feature to 4KiB.

Fixes: a3f8423622ef ("s390/pai_crypto: Add PAI crypto characteristics table for parameters")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/perf_pai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
index cdb8006220ca..ab76ed7ad791 100644
--- a/arch/s390/kernel/perf_pai.c
+++ b/arch/s390/kernel/perf_pai.c
@@ -1221,7 +1221,7 @@ static int __init paipmu_setup(void)
 static int __init pai_init(void)
 {
 	/* Setup s390dbf facility */
-	paidbg = debug_register("pai", 32, 256, 128);
+	paidbg = debug_register("pai", 1, 1, 128);
 	if (!paidbg) {
 		pr_err("Registration of s390dbf pai failed\n");
 		return -ENOMEM;
-- 
2.53.0

