Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E3F3CAE99;
	Mon, 22 Jun 2026 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144469; cv=none; b=BdKDh7pikw7/QW8xMk29j3oJvGT8RFDh6ElEactFY0GDjpxGzFg4QPRs43g+VgIdNLHUSaT+7yU3QuG1gJo4zMbdvrQBxgpgJ57Oc3i3MvLuyGhyCUOKdP5dQKfEdJCS7hlsNPE1X7viFuD07Gcjl2Rzc0jxAMS7ml99wyC+tjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144469; c=relaxed/simple;
	bh=RPc5Ic793/z7cn6hA/e7InmdXAzoxr6XhhsCqtxW8tE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i8ns14wFMnwIySWAhnyM2WcKscjj3THdBqtl7zN5VrxQzOKMSc0/q0HB8OXiD5QZJq6PEbv2MdJJKDEG6I/UCdXhRJ/5JpJcuaUcd3zKx65HVe2mVppuL6qrUOqOGj0hakpTYFsRTgHWcxqxoFxMon65CGQsm8+//6CYaKDVxN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cLF0DcEv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cLF0DcEv"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MFmM203331642;
	Mon, 22 Jun 2026 16:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=bys3rid3fx5UP9EQzGhYVNCJBvWKx8yysDoEvMlf2
	No=; b=cLF0DcEvEzY0bd0A4gknO8XzQvmcxVHshLb+eQZQOzS0GAXItcO0c8lZ+
	WPd6OJqnhFT2V20zzYsPXBDVEtqWz8U4XHSqm9+zSV3+8gjxT7DZUN+K59NN6mHV
	1FCItZWWuqDCpD6zIqT7gRxwFXE4MgnenmACqFSH5CVEa900v0gIFx3tdTSPic82
	HNXUlV4cWQqddMEOSUQDS3qE7sKiHP6zuCr6PToumgh9amPG6BcR5FuQFYiA3Bml
	87XwDgQiKniyW4KVJgriZNiC/4RB2UQvsu1VCTMgFzluIPLTQhUyeZqyleniIXnk
	nxCj91gDi7lImDECvCXPfTz2Sgdmg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsj2jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:07:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MG4j2H028118;
	Mon, 22 Jun 2026 16:07:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56q76we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:07:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MG7eR943319682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 16:07:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BC9620049;
	Mon, 22 Jun 2026 16:07:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BA4A20040;
	Mon, 22 Jun 2026 16:07:40 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 16:07:39 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v5 0/9] KVM: s390: A bunch of gmap-related fixes
Date: Mon, 22 Jun 2026 18:07:30 +0200
Message-ID: <20260622160739.202044-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfX0VWQvWd2avHJ
 q0CNwjJ7n0x3PERRl8CvWVKwNb4GXfjnwKfevuvRG1b7ObjkcD4AwHxHjn3VSMU5cPMBj5hKdTw
 m0b/DR+mcFlhCAanhUm6eRV6PnzYB6z5fFClTXpCgKK1v1Bg6Ha1AUxWn1CJu0i+ZYOFbqa/jSG
 rIL+zUt7AWAdVaXRc0rStAWWPxDTs3nRbalm0MeIO/egLpel6Qd6JKlq1bMFSF/bnTQQ8a+1SYd
 w9/7gqKNF+wWKi2wKJ64c0YIwahezpJypiHI72vXmDHbbb5EY0Fn6x13OZRttG+HDEf6IfGYlAd
 tcrI7Cnp2hpYUTKUrGK6bD1ootaojQ99sDX3C+qBFZ9fbBnOrU8/2aesslVrBRDo3jvFc1mMDvb
 akaI7Cog33SGFj01FNj7VAJ+96E1LkQfdRkHnnHzBI98trOY6j9x7Nd9PLVXPg9UyHK2bTNDfdY
 dMO9NYJbQU/AUvjB5+w==
X-Proofpoint-GUID: 4CzJyn1B7TZZ-LQPS9vi_RlrSzy7zWj-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfX3PpAUPPjptx2
 yv141+pZyaAWaRf8xfMsro0S7aNoECCC+7GP4F9hZrr4Tt8YveROU3kYVQiHE/1UBuqjpCHYSPm
 P19pruf8fz4XLnJQ1eWxHaB56nDi5Qo=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a395dd0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=ucjmMn6u_Xy7mvBSwZ0A:9
X-Proofpoint-ORIG-GUID: 4CzJyn1B7TZZ-LQPS9vi_RlrSzy7zWj-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220157

Fix handling of _PAGE_UNUSED pte bit. The bit was lingering around
longer than it should have, causing issues. This is yet a different
approach from the previous version.

Fix some cmma dirty tracking functions.

Also fix a few other small issues in gmap.

v4-v5:
* Make sure the counter of cmma-dirty pages does not explode
* Improve comments in cmma selftest
* Rework and fix locking in kvm_s390_set_mem_control()
* Do not return success if an allocation in kvm_s390_set_cmma_bits() fails

v3->v4:
* Improve/fix descriptions of patches 1 and 3
* Fix handle_{sske,pfmf} under memory pressure
* Fix cmma dirty tracking and its selftest

v2->v3:
* Fix _PAGE_UNUSED in yet a different way
* Fix a potential overflow in dat_peek_cmma()
* Some minor gmap fixes that are not actual bugs yet

v1->v2:
* Completely different approach, entirely new patch

Claudio Imbrenda (9):
  s390/mm: Fix handling of _PAGE_UNUSED pte bit
  KVM: s390: Fix dat_peek_cmma() overflow
  KVM: s390: Do not set special large pages dirty
  KVM: s390: Fix code typo in gmap_protect_asce_top_level()
  KVM: s390: Fix handle_{sske,pfmf} under memory pressure
  KVM: s390: Fix locking in kvm_s390_set_mem_control()
  KVM: s390: Fix cmma dirty tracking
  KVM: s390: selftests: Fix cmma selftest
  KVM: s390: Return failure in case of failure in
    kvm_s390_set_cmma_bits()

 arch/s390/include/asm/pgtable.h              |  4 +--
 arch/s390/kvm/dat.c                          |  5 ++-
 arch/s390/kvm/gmap.c                         | 15 ++++++---
 arch/s390/kvm/kvm-s390.c                     | 35 ++++++++------------
 arch/s390/kvm/priv.c                         | 10 ++++--
 arch/s390/mm/gmap_helpers.c                  |  3 +-
 tools/testing/selftests/kvm/s390/cmma_test.c |  6 ++++
 7 files changed, 46 insertions(+), 32 deletions(-)

-- 
2.54.0

