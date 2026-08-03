Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4F623E358;
	Mon,  3 Aug 2026 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777712; cv=none; b=o/w2k02ShJyezYqPy1x15PieAvUT9cHodfFE499S08ZWg5NG4HxKlCn8xyhvvJCsCrUv5pM9vRYjiJxaVaJ2TgMmcPgc1qYAHNATt/Zfvq0OngWkkdUpM9yeEu0WIw5svDKyIqOFrh8OQzvrt7LAjo3QBvw26fo4Wp+h+kkZu6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777712; c=relaxed/simple;
	bh=ia35J50/qvGw0yJS2CXghY4RflXyW+Ym2+Mo5BTkpZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNhci6GUgp21HhFjpowsYLWBv0TR2rbpmiV2hrzG0h2ksQfevakIA0VggplCLraJ4ND/wEzmsTc0Uur+1UOjHy5NpP7FctF+oio3Yn5ax4txe+m+tmqUhl7Ck3vizofPqsih7kjuKkEteuCt7Zi9KCb6JDdnz16FpaaLEHqqQbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iloqdNSI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iloqdNSI"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673HHZ6r815137;
	Mon, 3 Aug 2026 17:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mg9h8BWVICkCLhRpv
	TJelz9NeR6gjHxl4GX3BWVenJc=; b=iloqdNSINlR8HY56S6owvrc3BvBgLNom2
	kD2qh8IW4ZjiubAel52zJmm0jlYUlHD041+7weGLUmltIYfet5FBTiNZcM/DbcRU
	+6NOBfkhH/4uhwPHfUCF+zM17QAulRv3+mo4VwWkG1OpMFV120tvsN6b/t6duC7z
	wmqik6WdNY546NGJMaMtpF/Ek9egUqN33hFOiicnakXRYt3tXAS+d8xJRKoZtzW1
	xomBLemISgnEACUBL+PVyJ/03GyXrW4wMCY4w5pFVVxkslvAiImJqt/KQBGTYjYi
	ow/NBzSgfwFUPo/Bx/h7rDf79JafTKN3PI7T0eCn9+1E+fDDaqgzg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqj07g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 17:21:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673HBdSq023890;
	Mon, 3 Aug 2026 17:21:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtye7p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 17:21:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673HLj5H51052856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 17:21:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13F5F2004D;
	Mon,  3 Aug 2026 17:21:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E08622005A;
	Mon,  3 Aug 2026 17:21:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 17:21:44 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] s390/mm: Add __context_unsafe() attribute to do_secure_storage_access()
Date: Mon,  3 Aug 2026 19:21:42 +0200
Message-ID: <20260803172144.827049-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803172144.827049-1-hca@linux.ibm.com>
References: <20260803172144.827049-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MshYhiOWXYzIylDNS7kgOWaYlMPWryrS
X-Proofpoint-ORIG-GUID: MshYhiOWXYzIylDNS7kgOWaYlMPWryrS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE1NCBTYWx0ZWRfX0kyRPWWkVKpC
 2N9D+Eh7f32DzNV3D2cH5tyBB+RZInlUrdoPQmXm0w+LkPfr1aviaSzQyZdLR8/yq9q2QV5zx1C
 URdM29dGvKlnMpyHOEWsrdYotIt8Z5A=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a70ce2d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=As_xCgHIpSFzjsy36Q0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE1NCBTYWx0ZWRfX2cNV+SDSAWIL
 SdwREIrvvDFb3Z8jAEAUg2MDz6HWx1tAOZOEPwUEu48Mn19xdF0fG8bDZQEpmxy3NFRWIlzHX57
 4dh4xk7mPQPsAGS0TQU4EpqDVp2pK9/kLB2nX1fRNyFRPh8FOgBvTxNs6TRmXlpmS+YwaQMOd+V
 nrafuh06X71FWEJcANcfdFG1OhOtv+M1X26IB/5xhwFQQLmzUsLofDeq7H9Y6Cd7wWIoOMkqWSJ
 txqGQy0QvhxXuaJkSohQ0FGHgkRMdyVTt4rjcYiBz39Ap7e5ST20NIYw9xBektzA8OFWvQuKWQ9
 f8iP6CsVvru0v9qSNf1e+Z2qYRwpbDmLKnCRhv1gDEbDiV10V7rpX8jsmcAZMYZrMpK8LmcOkks
 whS5tx52G6a9aVVJ6vjOpIb8+apJmSUOdGkMDVJPnE3C/Lub4m+yVCymQKnEZI/YLsXA7JSG94H
 tmg8aDrXdaoowcED/3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_04,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030154

Compiling do_secure_storage_access() with context analysis enabled
results in this warning:

arch/s390/mm/fault.c:472:3: warning: releasing spinlock 'fw.ptl' that was not held
  472 |                 folio_walk_end(&fw, vma);

Problem is that folio_walk_end() comes without the required context
analysis attribute. Also the proper attribute cannot be added easily,
since folio_walk_end() is a macro, and not a function.

For the time being disable context analysis only for
do_secure_storage_access() until this is resolved.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/fault.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 028aeb9c48d6..5af448fca962 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -406,6 +406,7 @@ NOKPROBE_SYMBOL(do_dat_exception);
 #if IS_ENABLED(CONFIG_KVM)
 
 void do_secure_storage_access(struct pt_regs *regs)
+__context_unsafe(/* folio_walk_end() not instrumented */)
 {
 	union teid teid = { .val = regs->int_parm_long };
 	unsigned long addr = get_fault_address(regs);
-- 
2.53.0

