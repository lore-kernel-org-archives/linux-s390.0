Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991603DBD7F;
	Thu, 11 Jun 2026 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781174950; cv=none; b=G2hOVh4ZViyhgXsvq9u4hdVikDgS0dfsU4RqmiyEMBIHn8fA3BGQXh/08RH7RJ2NZ6t/UpoeIriPAuxmw+GHQ/A7hguktop7eCXfb70gMhGy8ywHGLlBaFPC7kG3IKlr3acK9cNVZsyG/OHAoaf7mpZT0XY1sLZmAmFWAYOccVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781174950; c=relaxed/simple;
	bh=OeoK1/c5Y8NDBBKRFtRPObLogELcREvw68TWKF6DYoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MIYNHoWWLs1fZLJ7IgfubJ6gnRH9oOIx41Gvkh2JwJlrl8Uw3lcbXb31tve7vccT+Po5hPva9xW0odtE1HH+FoE0cdJy1IaMTSJNExtlVgwmCvtWkopKqLasgZTdoo7/iNDZSPoNFSX3pCJnSr8tHgxWrUf1deRpgCJSEqbsSAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RF0CMy9B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RF0CMy9B"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJu5bp3872855;
	Thu, 11 Jun 2026 10:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=YcJctyJ0GLABpTbqhvqwLK2KqmmdTtJ8Cd01viH7z
	zk=; b=RF0CMy9BmUJGmo/hWqfWLRqWG+4GhI7MihVUxW0F1qAqSzmAi+ZLftZKd
	KSeAIGAzJ3iDTDC3jXN7yz8tTvI9hzc8MJZ1NWCvEAdVEQhHo0UQdhzdmquvh1+Y
	ltIn/jQ6jIKJgDRri0mmyfUuYg7Dvevl9uTLYOd7zM4nMJh7mtDqHxCa9MRXniEJ
	9rnRqFe55Y8BDQBFbA5h5enp1S4vRqUuB5jW59gPEnik5FyqU7YsM4TBjVr590HV
	a2lMs8W3APRUSTI352+poZ4L+OvdnB//L8m1ViIgwRzLEckKF61Bivhf1GVfU6ZA
	r6BIgZ8Y6tW8wyf/kc9cp00kqHbKw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8etxru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 10:48:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BAYaiB012894;
	Thu, 11 Jun 2026 10:48:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09jthe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 10:48:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BAmpRg42009078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 10:48:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D22020043;
	Thu, 11 Jun 2026 10:48:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BB5420040;
	Thu, 11 Jun 2026 10:48:51 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 10:48:51 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v3 0/5] KVM: s390: A few misc gmap fixes.
Date: Thu, 11 Jun 2026 12:48:45 +0200
Message-ID: <20260611104850.110313-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEwNiBTYWx0ZWRfX6kyCKvA1DX+O
 QafAbYqVfTCLrokPLV/ib8X6K5C5KoCIvQt+59NIUa2sMqvduMuNGUZPGj+igKUWCf/GxvjxzbG
 xaEXeDuMZpYFNsJ6wATHSS/ckYDOUc1UxlfjmHBN1zHdz/rXs0z21r6c4zGu8fJ3fSQXa7HpNq3
 bdhVDCwMkC0GbRHBGoh+iTRv+3nUsPFwqcbei6PgnT+HHgp56XsvwCY8rloTfrcUiig8m809phD
 yWG7f2PW3LsLkqmRvyf5AMq7dmXVtm0DJzwRvPalx2XGcs5InOzGrAElqyBQlt2riHaNn53TUsV
 2ABIQ6PfD9J+7UrQjNxxMR+hCtG/gyb2XMkF+bgIV/BfE2f1JrhbLjnbasarfCA5l8EXvS4bgLo
 ViLAXKjGhNhDKh4wr2TD/d6inT2whVsANheYZttsoXpsMg0NIEJYktgFO26AP0h/DMK7AaGeVNO
 amZGexN660QYDtOslYA==
X-Authority-Analysis: v=2.4 cv=dr7rzVg4 c=1 sm=1 tr=0 ts=6a2a929a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=l5uwbmALUGG8tN2VU34A:9
X-Proofpoint-ORIG-GUID: UMO89zqXLm6DW1LxDX--ZEquOPKlY3l5
X-Proofpoint-GUID: UMO89zqXLm6DW1LxDX--ZEquOPKlY3l5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEwNiBTYWx0ZWRfX3AatneWRADzE
 xS5oVxMmMFXDjwtlSCtQLL99QkD6+7IPmbNPZNUk+c0szsO82t6/hdr7gmIC39TsIyJDSq0Ckhr
 wZBqcGdf6F4vzJMs9kIz5n+4FnbSbxs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110106

A few more minor gmap fixes.

v2->v3:
* Fix allocation size of struct vsie_rmap in kvm_s390_mmu_cache_topup()
* Account for the possible failure of radix_tree_preload()
* Move kvm_s390_mmu_cache_topup() inside the retry loop in
  _gaccess_shadow_fault(), to guarantee forward progress

v1->v2:
* Improve suppression of __must_check, by using a pointless if instead
  of casting to (void)
* Fix allocation size for struct vsie_rmap in kvm_s390_mmu_cache_topup()
* Add missing radix_tree_preload() in _gaccess_shadow_fault()

Claudio Imbrenda (5):
  KVM: s390: Silence potential warnings in _gmap_crstep_xchg_atomic()
  KVM: s390: Fix unlikely race in try_get_locked_pte()
  KVM: s390: vsie: Fix allocation of struct vsie_rmap
  KVM: s390: vsie: Add missing radix_tree_preload() in
    _gaccess_shadow_fault()
  KVM: s390: vsie: Use mmu cache to allocate rmap

 arch/s390/kvm/dat.c         |  2 +-
 arch/s390/kvm/gaccess.c     | 73 ++++++++++++++++++++++---------------
 arch/s390/kvm/gmap.c        |  7 ++--
 arch/s390/kvm/gmap.h        | 14 ++++++-
 arch/s390/mm/gmap_helpers.c |  6 +--
 5 files changed, 63 insertions(+), 39 deletions(-)

-- 
2.54.0

