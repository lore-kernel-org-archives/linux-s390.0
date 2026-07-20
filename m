Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14743D649F;
	Mon, 20 Jul 2026 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537931; cv=none; b=fAZ+qWoz3h4yyJRkD76ZjVy0T1bpwgIXljI+jCyeDpr+18LPZlI3M8mh9rG3Ga2bY8CJeWls7QvUv6ahIfXeXjAU9PNIDhlojOISnPWtp0mUGvu257uR8bh/duJ9ed8KTTse5+H+Kkd/8B8Nuz4N9+YLRZFiKulNDr2JNWfScg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537931; c=relaxed/simple;
	bh=eNRidEd65WbskKsNUG374nddQ1yOcZ0etFeG9hNp4bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYecpb59kkctx7Od/0z0rR1oyvNK1SDPvZII8HCx2UE7aCeRYjgrj6lvVzaRVI6Ihcp+rgQzxeSStrFBwse07miY7cSaleDMy83jPrh2+zirFhXIYAwM7CjAjzlU4S5EEUJu68PURZNS0om5pzp8kspH2KBbN2NH6evXWOjzhi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cvVKR8xp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cvVKR8xp"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6gJRM1466769;
	Mon, 20 Jul 2026 08:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iLonAh27KA1dUzRIE
	7qsVRrnDCoMYkRUBsqEvkY4A9Q=; b=cvVKR8xpcjlU9TC2fUZ6znxmtjizZ2bxv
	+q9s1pN5Ho8l5cV1dKfj7KSp2yyr6gQrfOdkjoeWuX60OfVuyDL3sse0IY4n3OpX
	TtcsYdv/nGR20AUUGstizZ72xHoKkMTp+OkCgiTMt3blJVO3Xrbyc/MfDbGytuSR
	WQOw2aRixULuxDD1ycXDtkY1zcUlcQyZB7rsyqYcB9RtuSFA9RMpDdUaSOTdqx6g
	qWQ0mTnt2B0kKJXqjDPvtTdIzPBJbV1Wy43g51c0ke/lJ92izcl5lDe6XFbcumOc
	1pY5l72Z5VWL+ewdQWv/Qw37HF+EqDSVIj8/wvJpGcyZIL+ECNP/Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7agxc55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:58:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K8nobx030895;
	Mon, 20 Jul 2026 08:58:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6vvxdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:58:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66K8wa0750332152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 08:58:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FC362004D;
	Mon, 20 Jul 2026 08:58:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1C2820043;
	Mon, 20 Jul 2026 08:58:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 08:58:35 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/8] s390/mm: Use handle_fault_error() in do_secure_storage_access()
Date: Mon, 20 Jul 2026 10:58:32 +0200
Message-ID: <20260720085834.898025-7-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720085834.898025-1-hca@linux.ibm.com>
References: <20260720085834.898025-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oY2_iXqZ6prIiWbjudJkZzSpS2Qq07Gd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX4LFCql82Fj5+
 Vle2c7tgiydOS8C6I/l2HP6VRZOhFLevRjhG5bQcwcUVLGkGkbVHsW9ETb19RPMH14+tLHXDOXN
 9cjW3K7ZAD3Fsm4lT6QzJesXeme2TOYYa03rZKnudFaY1YE/rmMD70F4EZPUpy01zqP3Ztgi6gw
 wirGV6tuRiwo67NdNAkpZ/UcnaDYoZCphbVREiYcy2Pm6mjg29rTefpjM4t7WaUNANNdcFHcAYe
 CZIzkbvtYnLn+3QhdrcNWqK5c3HTVXmraBmnG/WqIWMt65rmON+vFzkFjCeTcTFTIhmLq+nOZBu
 p2GtQpMYpQZXjHYs1+IkItmq2zIwm1VYqNrB+Vauu3JFmDhsnvHo5xRzM8D3m5VtiJz07xij0De
 ZTNXacs7jrW8ijlrZggMAhtYQy0uKuBVeg3getLvGl2jyMe24AGd3Eyiziq6HHBL52Yi+O2LoUd
 kDpFHcEXFPdDNTjllXQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfXxFJeeLEb8OaQ
 9qwtjd4W3yGM6nt+5Bbp48yZbHGLASJgPdN31MGosHHoAbEYaV8ZvcaM9kws6wR2N6HJGQtTasu
 JtYlfN+ol1Kh7s/FG4GxUWs3J48cRB4=
X-Proofpoint-GUID: oY2_iXqZ6prIiWbjudJkZzSpS2Qq07Gd
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a5de340 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=V6R1L1_PctZKwmwOSmMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200096

Similar to the normal exception handler use handle_fault_error() which
handles accesses from user space and kernel space differently.

This also addresses failing kernel accesses via e.g. copy_from_user()to
user space: instead of an endless loop, the fixup handling is performed.
Even though this could only happen if arch_make_folio_accessible() would
permanently fail, which is not realistic.

Therefore this is rather a cleanup patch.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/fault.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 776549d55c94..2a9b9fb30d09 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -427,10 +427,8 @@ void do_secure_storage_access(struct pt_regs *regs)
 		 * was not supposed to do, e.g. branching into secure
 		 * memory. Trigger a segmentation fault.
 		 */
-		if (user_mode(regs)) {
-			send_sig(SIGSEGV, current, 0);
-			return;
-		}
+		if (user_mode(regs))
+			return handle_fault_error_nolock(regs, SEGV_ACCERR);
 		/*
 		 * The kernel should never run into this case and
 		 * there is no way out of this situation.
@@ -465,7 +463,7 @@ void do_secure_storage_access(struct pt_regs *regs)
 		folio_put(folio);
 		folio_walk_end(&fw, vma);
 		if (rc)
-			send_sig(SIGSEGV, current, 0);
+			return handle_fault_error(regs, SEGV_ACCERR);
 		mmap_read_unlock(mm);
 	}
 }
-- 
2.53.0

