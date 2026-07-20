Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDFF3D6476;
	Mon, 20 Jul 2026 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537930; cv=none; b=KUiHFN6fE58fyqri7cDFCeRhgaO22XoHnyshsmrBVk0dmhiq77ydehpKQW+UfiMfSt2AAcn3QEeQp1JgHTlX6thU45MovlJX4kNOk6snHK6Ue9ZjrYFWjp0VwyPaqu9qxkxNCj3MbI8+1A7z7k8e104/Fngp6OBwe6+JiBSCmis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537930; c=relaxed/simple;
	bh=vCmvLDArPZy/NUup35qgdegCw9i5pFNHjjD61YwH2BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fv9uRiQWjwexaWVL4Y6fFAzft+kUEGn59ZgpiObnIzNsEO7WHIRyC4zAYIQAETNUlvgqoX0/09SsEMiRAu4Jwnm13lXf3t+/vg4cDuoA5IZYt/deAX+SOlBdmkokpriOW/46sOcwJqJuamwHuceURR+P0nol6w6ppgD/miBzJXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VCMFBM6J; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VCMFBM6J"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6fsUe1465765;
	Mon, 20 Jul 2026 08:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WQkyUxtVb/VVZMZPX
	rGLYPGKt1Bd9s/iaj5r4la55mE=; b=VCMFBM6Jed4lKXpk0AULDej6bu3a0Px/0
	aFp72LcURQ9QKRpnta1IXSAolJBtxxhWYbG75GXq8P1whp2tpyCanne0jjhm2z7u
	vmSq9RPY3J0e/xzyJsYDT1HyCtu6iyN1ub6K75H60BO02UK7TXib1jhkNw0YM40u
	JbXpVIr0MegbVs1RDVgRNwaVMT/ZY0jT9vQ6ys7lOJPZGx58HeHJ81wuOJXHXQdZ
	EviNyPqu40prya0h6PSRU49/7MMaq0rsrVvXrdulHg1mJ4U/2ZXCqOtSACSxQez8
	ndJRJboSEOLs7H1q3bZ8aXdxNq0DAyTsP1oXVkfzEhPkp59yRkeeg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7agxc4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:58:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K8nn46031500;
	Mon, 20 Jul 2026 08:58:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g4n2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:58:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66K8wZ0W48103694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 08:58:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88C322004E;
	Mon, 20 Jul 2026 08:58:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EA9A2004D;
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
Subject: [PATCH v4 3/8] s390/mm: Use lock_mm_and_find_vma() in do_secure_storage_access()
Date: Mon, 20 Jul 2026 10:58:29 +0200
Message-ID: <20260720085834.898025-4-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: -BWV2YC7uN7sIcbYyppD6uZ0LlbVV1Zx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX/eLwZiI86y8j
 FYvy+BwOXVEdI9XPrTFBZU4mC86q4MX3hMJHO/1K4xur8Ut2te6Z8o5anPEg+QZ1zYn6hJP0FMs
 uMfUFSTRk3zTIzME7u/Q/4wMyLN6Y4PyrAQ1eioocuRnf/jgo2uqmH5QekTf8kl+YgVIENKNXqU
 ghzdZXkedU3rjC1SgDd6c5LXS/pnHJHKQlIrcLqlf/gi0k4baUR4KiJi9Vrjk2KvitT12DXV/P8
 djQDT3/wPVOrjQyTcSiBmI2uTn/EOt3d9A9DixFe9/DX2/zFg2FEEwowoiN548+N/XjMEsK5+jG
 KHW3HgnfgqxKSxNarINVj5xiZ7ccmZ7egwG43FV0qQxxp3CeVnfUjcA52HYMoerEKvUaArmt8/2
 Rt3mQ4sNjhMXO/gLkufK83ragz+uZd3F88TcE2a7wVsfzLUpzBEBmoHa+Ts78Fkj7wACM3a1EUT
 PcRKnkMAzY9utrRUJXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX/A2aAZMDgXRQ
 4WtFR/peyjZRHZoD5VrmD3nF3oQm7DI2mWX2dBN61Hx3ndSOwXibp4iFIrAJnOXZlE7inL3oLhL
 1ONbmdaeGnwcMLiQgJqTMPBYSrSfbL8=
X-Proofpoint-GUID: -BWV2YC7uN7sIcbYyppD6uZ0LlbVV1Zx
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a5de340 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=q1cbuJAsPhdWy6OxXkMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200096

do_secure_storage_access() uses find_vma() without verifying that the
faulting address is within the returned vma. Add this missing check by
converting to lock_mm_and_find_vma().

This is not a critical fix, since the worst that could happen is a
WARN_ON_ONCE() in folio_walk_start().

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260717093904.E4A421F00A3E@smtp.kernel.org/
Link: https://lore.kernel.org/all/20260717093904.E4A421F00A3E@smtp.kernel.org/
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/fault.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 2839d7a64401..f150d97cac2e 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -455,10 +455,9 @@ void do_secure_storage_access(struct pt_regs *regs)
 	} else {
 		if (faulthandler_disabled() || !mm)
 			return handle_fault_error_nolock(regs, 0);
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

