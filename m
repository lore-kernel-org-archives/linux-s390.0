Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F57A12D1F1
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574794; cv=none; b=iM57tIuQyCfD0XtcRZKGcM1oLqQEh+IzkG083oFKBD7t5r841ptTk4GaS67k/KcWDlnwPdRune+CEmscKt3QYOMM/rouy+dmC72W2dSUJdrKUYbPNNFJ7fovstM4nW+Uz4n93rbxH1pObyXeEKAROd5XO06B4Tyr2XrXBwlRy0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574794; c=relaxed/simple;
	bh=yedEBhshbWO1TMRi38E66DDaIEgZM0U6fiL0EQmGlvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fnt0VYMYp41wzA1P6c7XVvbIkwn0NnTxF7YvCL/9KLoGGf/P8Qfj7nqx3lHMA6PNzbIY5sGeztwS7oFY4wLEabmPty70VHyUGyWPPNXBOWaiCHoSeIXPmARX2nSKMbHne8kzOoxrE+CEciEYsL8f3wyLGldhzY1Ig8Yw09RvEgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oWI8ZReA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oWI8ZReA"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1c0C2330021
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 16:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=AN27UEo3G54p4zfyPN1VvWj49ROG9pEcFIDtYLtuX
	Q4=; b=oWI8ZReArpi9QgRhy8l+DjZ1m0R4kXp7VyhCsjdVQUytdIg3bGqSb52ei
	Fe0sZds7aEKM3NkXVrIDVVXJnRU7bx/1Fx/k/XLpH6nf66K860UEY7aV6dVGfikI
	E4Md6tkPZswyYpY/aSaKVnA0yPgvypW+ynxmQuv087bEtrLhbO5BEBlTEY0wl8sU
	iPihxIOt9jZx56f6juSncMTaMUVsjiyUJFfCN4s27/aC3+Y8vYuof8gMDQqb4oXB
	ha1WUO2/KXCHdDoMMPI8Ll1P0RGiS03aegczru1YgsLACHI5ceGdvLf/+ZoJeKJB
	cGFEeLqHDtroATcFiQWb/9ZMTQwtQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqdjh0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 16:06:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GFe6tp1649321
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 16:06:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq03by4r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 16:06:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GG6Q4k47710610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 16:06:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C131820043;
	Wed, 16 Sep 2026 16:06:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3AC720040;
	Wed, 16 Sep 2026 16:06:26 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 16:06:26 +0000 (GMT)
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: [PATCH v2] s390/debug: Fix NULL pointer dereference in debug_info_copy()
Date: Wed, 16 Sep 2026 18:06:26 +0200
Message-ID: <20260916160626.1988684-1-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIxOSBTYWx0ZWRfX+k1rX7a3V+YK
 Gkvn88RBonAV74ovjGBuXkPH72Mq3P3q82OgQ42UCQbVUkBvd9dHOFIBeKaS7KR/sEbLTX+z7Rk
 rtC3HKVN8GzzSycDpXR3cYx4Ffd/m4UhuOmbrelAQdLFgqVHEPH/5sicdgYWFdN0/nWg7sNR/Ad
 Pg7yZ2w5PjaOKOB1ODwkm/zj9lZkiex03JZgZfMRXSkI3VgSjV/DtceOYfrRjFwG05GAfGgQq2N
 e6IQMCv8105HdbJ1+BPH5NmAMfp95dIE4ryYgvy8/JWQBs6zeiEKzP+IDGA3FfbYNj/ypzuW6Ab
 BfZBMSbJ0OHcGVJwB4KLncJc9RnJY0rnWia9j1XLcwe+VTXvPSiDu4jdK/FS3MRPihOtIqk998A
 WDNbFAXTWgRIeVrpkwX9AlghRYrh9UP0v08rwzdASuMzPM2h/fAAMv6uLyTt6zLwZuFtjrctjlO
 WmFWBhyKFQRC+8k64uA==
X-Proofpoint-GUID: qAUFUjOuaaVTJjf18UGRV-mOYq64qMZL
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aaabe87 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=NRoahvz2qwZEzvzsfJcA:9
X-Proofpoint-ORIG-GUID: qAUFUjOuaaVTJjf18UGRV-mOYq64qMZL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIxOSBTYWx0ZWRfX3eRTXcQKCoqH
 WSx/4tM3H8IX/5d4hDvepbTNpMoJuhEVCl/pbYvTFvEdlFK9EXcn42LpxLKjDGr9ypCPnWIbbEf
 9Nm1raKctlRIFaUD/rutl7txsSgHJbk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160219

When debug_register_static() fails, it clears areas, active_pages and
active_entries but leaves the area bounds unchanged. Copying such an
area, either by opening its view file or via debug_dump(), makes
debug_info_copy() dereference the NULL pointers.

Skip the copy loop when the source has no areas.

Closes: https://lore.kernel.org/r/20260903132123.12F271F00A3F@smtp.kernel.org
Fixes: d72541f94512 ("s390/debug: add early tracing support")
Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
v2:
- Different approach: check the areas pointer in debug_info_copy()
  instead of zeroing nr_areas/pages_per_area in debug_register_static().
  Zeroing nr_areas made debug_info_alloc() return ZERO_SIZE_PTR for
  active_pages/active_entries, which debug_to_act_entry() dereferences
  before debug_prev_entry() checks id->areas.
  Checking the pointer also matches what all other readers in this file
  already do.
- v1: https://lore.kernel.org/all/20260910104525.3788362-1-zaslonko@linux.ibm.com/

 arch/s390/kernel/debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index b5bf8284dbfc..d611d0eed1f6 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -434,7 +434,8 @@ static debug_info_t *debug_info_copy(debug_info_t *in, int mode)
 		debug_info_free(rc);
 	} while (1);
 
-	if (mode == NO_AREAS)
+	/* debug_register_static() failure leaves areas NULL, bounds intact */
+	if (mode == NO_AREAS || !in->areas)
 		goto out;
 
 	for (i = 0; i < in->nr_areas; i++) {
-- 
2.55.0

