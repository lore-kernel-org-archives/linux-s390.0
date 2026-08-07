Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA1E364942;
	Fri,  7 Aug 2026 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096674; cv=none; b=ZZPndu+/kMcWhHWrVzVIDv4c8MAyo3u0+gef1DKzUQfkPXJ3qxN4ih5GrGonqc2S1l1KSRrFWmxOyZTersdco9l20U++A6Q1dohEiLQSBtCXZkg9JPi1UJvVNoPPviI2MJcad/GrIVL16xGXCDCcQRBOIRiODeoQeRZWaGLMx6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096674; c=relaxed/simple;
	bh=3cNesFnIzLmLBMVSyeXFT8L1UmBHO2VqUwi+CiC3WxI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T9PSpbsOZyTFKGQ9j85SgbReOCw2S2CuKSNg9aI/LqHNZ7OJxqznV3DypXo4XRVIxz6Qn2HA0PC2ySm4JXfMPasWJQHlhsnhmAelW4vPJ9frMLiRkqAif9iHgiA0avgwfK8lzbqZSAAs32YdLnqx5BSbn6q51X0yB0xOLdd5370=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GxdIl3O8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GxdIl3O8"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HkXs4068145;
	Fri, 7 Aug 2026 09:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=GMAJIKrg5/udRoAp7OV0KiKgmBqf
	04sal2k/thM3pCg=; b=GxdIl3O84ol6KYAoq0inx37CyAg93yi+5JZc9dzCbhfL
	ZPCykIrjWRgAz+1o7Czl5dvNYHlvCnwe7/+VtnPYPBi7bCBtmIai9Tzt4/KBnMcb
	L+l0gKTBKC1+8aZ+awBTOVRRi8oacb528xuBPhGf0koovznIbRsda9c8x0+GBsi1
	S6NwRbSrW5E7meDTOIeZIdBbHaKWiM07NFP2oeJyMVYP/PQMf4pNkLtvm9OaxrD2
	lstdajVhbD6KrD65PNxZg/3gIaOFnin9DI94BSCRFZbSeeexCk+J50A0aJpuLRYK
	OErx1te3dn9oWmCdo5fhaZhsaLkaFms6nPm2FqwpUA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy0236rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 09:57:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6779uQo4019209;
	Fri, 7 Aug 2026 09:57:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyxy1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 09:57:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6779vjFC24445478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 09:57:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76F562004B;
	Fri,  7 Aug 2026 09:57:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC44420040;
	Fri,  7 Aug 2026 09:57:44 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.87.136.120])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 09:57:44 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [PATCH 0/6] KVM: s390: vsie: Small VSIE cleanup and improvements
Date: Fri, 07 Aug 2026 11:57:41 +0200
Message-Id: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBAAv1L2bDCtkGq/Ij1s41oXTFJ30yKU/
 t1gjjMws4OSMCkMzQ5CGyunWKA9NeBfGGcy/CgMne2c7VtnNmUy/k0Y18VUa67uZifs0V8IoZS
 L0JO//+t9rCz0Wcs8VwkTarmkEDgPTRKeOZ4DaiaB8Th+iEG0I5YAAAA=
X-Change-ID: 20260716-vsie-cleanup-202607-8690ba7ac3ea
To: kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1410;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=3cNesFnIzLmLBMVSyeXFT8L1UmBHO2VqUwi+CiC3WxI=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFmla8Q37rqdcJd34rRtKxSnPP4lslnabUumsbm5eayVY
 teOGJ2PHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAExk3RRGhimdnTGlbe8PRvsw
 T+gTYfXzN/T6u/x5R9w54d/Mh+UPnWD4K91Y+PXrVLni5qsllTvdxeTnae5Zt8eLsfJbi2TtNIX
 NnAA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cd9nwLCUtNHkDg_GA3KPmJR6yRndBPyv
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a75ac1e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=_3_SjggJ8OKSSNPurAUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cd9nwLCUtNHkDg_GA3KPmJR6yRndBPyv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3NCBTYWx0ZWRfX1coDJ0AMY5NL
 YY16Kk3O+EFGEbZqi5WO+HqmNo2Tbu2TJwFRntWpb36jmt+7h0khLMBJqvcwhVvJe6txhn1Vnp1
 4rhCHZhrDzDrrQ0o54c3B0gMO12iQI0NsqFPmAlESeg9zLVgpe7tOrhN/gOAlEpLt6EXkC07fuU
 sSZtlgdHGbiTK9Kdf45WWxln5JeS+Hfb9ReYBZAaZGPr+zy2fzOimI+Hxy9HzxS7i26Wuwrra8/
 ZfsNNA0lA1n5GUd3VtaHApFpdcDH0HAdX8WSDkac7jGHEBNfvzujzvyABxd2tlcMA1AgiW20bT8
 JaFBZzk/vJ6EkydQ8QzdQItNJKzi42eCfqis22Onp9w+WIhT2yEqcdwaFtlPrJtCP5Bflr/yhQ9
 UpGBth81qmNK0TWk9sTIuFrBH3u635gTuGRUA+VWr32sKmwzc+DpryESoC+yj8IwWRrkbGIcuro
 bLa+1361PCKcHbys3RQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3NCBTYWx0ZWRfXzudMWj7yQTp+
 j9qoikXfb/yfVqywkIWNAIWmkA89F97+hg1VX+v4vFRgRUkO0qBZQZ6wNpF3srINFbuZEPbXZ5l
 nmzpsg1imjlfsksNL58NnxGCLWowAno=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070074

Some patches previously sent in series
"KVM: s390: vsie: Add VSIE SIGP Interpretation (vsie_sigpi) v1"

Link: https://lore.kernel.org/r/20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com

now in its own series as proposed by Janosch in

Link: https://lore.kernel.org/all/77387525-cf7b-4617-a492-d81b6c1cef17@linux.ibm.com/

As well as some small additions like some of the offsets in struct
vsie_page do have in page offset or alignment requirements. Adding
assertions can actually prevent bad code changes as well as provide
clarity for the requirements.

And introduction of simple SCB_ALIGNMENT_SHIFT constant.

---
Christoph Schlameuss (6):
      KVM: s390: Remove double 64bscao feature check
      KVM: s390: vsie: Remove duplicate assertion
      KVM: s390: vsie: Convert shift to phys_to_pfn()
      KVM: s390: vsie: Assert mcck_info offset in vsie_page
      KVM: s390: vsie: Assert crycb alignment in vsie_page
      KVM: s390: vsie: Create constant SCB_ALIGNMENT_SHIFT

 arch/s390/include/asm/kvm_host_types.h |  2 ++
 arch/s390/kvm/kvm-s390.c               |  3 +--
 arch/s390/kvm/vsie.c                   | 19 +++++++++----------
 3 files changed, 12 insertions(+), 12 deletions(-)
---
base-commit: f9a2394a23482bfd330911e9c8295b71724feacd
change-id: 20260716-vsie-cleanup-202607-8690ba7ac3ea

Best regards,
-- 
Christoph Schlameuss <schlameuss@linux.ibm.com>

