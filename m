Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25F83FD14F;
	Fri, 17 Jul 2026 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294067; cv=none; b=VNb/kVjgcvPdn/FS7ZD6ZX7fFMEPFFmyFAWikokuZzB6C2i+LGXQI1lcT3tdyh32Msg9Q+J4YOtj0VpYEcO+jyCuqqWDfpFW8LSd9odweat3i+zGXhha3yPgCrMcjLS2ytla8kwMjYyLBMVw/6l0P9Ss2mysuaVKT8XBZ2DjmlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294067; c=relaxed/simple;
	bh=p40NI5+SbbU6sf1rKMKCSyLGFtC6+197G3hU7xXjveA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nyhKoIeF95YjoZiHROcYng6dBS4j0SotsOvVtrWnwHhJg4uMOC5fS/TE4eqkb4dg8VNW/MQ4gIYwBozv2isvVhjMSZUAYPbBSyk+z3Umd6e9jWn5AYfZworSY27H5A/dKMWAYxELlsI0HisU+Xt8zDvyfseUgIUh9m16Ab4boMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ejuy0aZC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ejuy0aZC"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HCfqcw1959221;
	Fri, 17 Jul 2026 13:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=OSSgFem/6BxTSGqh0Tyrrgu7B/ooRh1RbpSvBqW5V
	AQ=; b=ejuy0aZCyhMTDz5QF8pxwnToVH/0sA9g5uMbaNvpTJBJqMQeNxOBefsyI
	BQCTHLYDh11JbiysXy/0KXZOdKRWXBnaY2vKcfjVIWwCc9rcvzSedVI3yCD+ZKtK
	wH2xB8P0Ls3J6K0F59Nkf5RLodllmX+YMnIjQUr7Ql0K9mYoOtyadz2Gz2BpwFNO
	YjDH7vrMs1L0sfVzsFwvhaAz7CfSs9Hk6j8CbkEsVdZLRJY1vEZeJ2pjGfCxbn3T
	lqw/pUZCkkU79LVaniye2hy82PG5ZgHdpWepBLxdccWVyPzsbM1jRyfBQrHv+P66
	0d67ap1jlErb5d0HOcxq8emKBkIzA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexx5h5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:14:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HD4bRG018899;
	Fri, 17 Jul 2026 13:14:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hwhx54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:14:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66HDE7cm59113966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 13:14:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E24620043;
	Fri, 17 Jul 2026 13:14:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A7BE20040;
	Fri, 17 Jul 2026 13:14:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 13:14:07 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] s390/mm: Add missing vm_start <= addr check to do_secure_storage_access()
Date: Fri, 17 Jul 2026 15:14:07 +0200
Message-ID: <20260717131407.855327-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zlPznC1jKJe2CbA4AygVWmLGB81TDMZ_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEzNCBTYWx0ZWRfX+o0eHZlpyD0c
 YDzF2PcJcK8qJSnuXmwzg092bixpEGHPqIhBhfYPRaCJ2ExNHCNjy6rFbwhBvqPxPpml7yWf4Gd
 ZUbxjKm7hkC2rZyKDEThDYDrNHwJynXbjK7sNDwCiq7m4rEEohVw1U+pbWqsNOKMkaxNYzs5w5P
 OJQI0ImpAcPCNJS1R48pEyTfw9OCWU6ZYYddaE5B0NeJ0XWsSTBoCBx3xaaposoIylFlEvMnnFF
 8sKXxxbH3HLs57LZRxxh97Rm4sTQIga37lQ0ODdqDUlnbw3EcappTnGramn1mdHWTTqz/Vt4W/W
 wJS4aG/vNApUxlH9lwpIqwV2coXDnE+wXNIBVhA8YICr1lkt8LTMVhh3Qszjp3weeuMn+56qPgy
 mdv6FAFrKqbKqEexTxTmIcuVynNv49M3HQKsHsA7eJE5PmCa0tlL1drLKDv0TZDgZR+XXo4BokM
 OE+1dOribVouNWhgEQg==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a5a2aa4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=q1cbuJAsPhdWy6OxXkMA:9
X-Proofpoint-ORIG-GUID: zlPznC1jKJe2CbA4AygVWmLGB81TDMZ_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEzNCBTYWx0ZWRfX75L6QFbi4PUo
 V8krna8JxG++yXu7ZWr6AgaElkCinaqan+esuWYcybMLuEcFOC0/yx06Lm6rvaTNAdxSJdZ6eeh
 zNGPTnDOTsDmtCMgqYHCbKEmdCvM/eQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170134

do_secure_storage_access() uses find_vma() without verifying that the
faulting address is within the returned vma. Add this missing check by
converting to lock_mm_and_find_vma().

This is not a critical fix, since the worst that could happen is
WARN_ON_ONCE() in folio_walk_start().

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260717093904.E4A421F00A3E@smtp.kernel.org/
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/fault.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 028aeb9c48d6..d6c58d78edc5 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -456,10 +456,9 @@ void do_secure_storage_access(struct pt_regs *regs)
 		if (faulthandler_disabled())
 			return handle_fault_error_nolock(regs, 0);
 		mm = current->mm;
-		mmap_read_lock(mm);
-		vma = find_vma(mm, addr);
+		vma = lock_mm_and_find_vma(mm, addr, regs);
 		if (!vma)
-			return handle_fault_error(regs, SEGV_MAPERR);
+			return handle_fault_error_nolock(regs, SEGV_MAPERR);
 		folio = folio_walk_start(&fw, vma, addr, 0);
 		if (!folio) {
 			mmap_read_unlock(mm);
-- 
2.53.0

