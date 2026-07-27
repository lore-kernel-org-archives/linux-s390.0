Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79D041B8F2;
	Mon, 27 Jul 2026 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164586; cv=none; b=HixvV2fYPL6byb3XB4aWr988d+4y6nj96ljqtSOLvtImpIuEUO1utXk7T7KbUlFlL6TPNqMf4fKVnW4sGYo1cQ4m6/btVuojEWqpvnYhwDZqkyOZdgTUUFXs4+rgyt2BzbxOeAQ2SytcsYjjbevtfdZXPrOaxgFozlITtDKbqfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164586; c=relaxed/simple;
	bh=qHPf4Rmp+aX5xas1wI/BLlLdGE6+D5+OX13PsClvMNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BGjxHzyTzTTqC6GQOcozXZwX+B2ZY7B8OoXh0HisL6vxZcaon2OpEUMxmNfKyohZYCSF2WjGqye7NqReEpwb3znz+E4nNS5MkvbbXJ6kTulrg/8e/G4+3iDdqXLwLobaY7x6NrP840vkv6VSpsYVQIQiizRJzYqtvc4lD9r4pZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a1VnSe4p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a1VnSe4p"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDmuXm2407018;
	Mon, 27 Jul 2026 15:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=mjIwUXcnJlNqMKkvQHKHyUFBeD3mjrxcLVjt8SwPu
	dk=; b=a1VnSe4p8qZLMs7yXEMGMWLnF1lus2aWXmWf8ppI8aqq/3hC18RPLhujM
	s9y5ZNErrRSpSdC52DdOIl5FSSckfun/V3IRLNnD3pdaQV7iuWKwIfEj7FbzBGCl
	uly5LE+BlIdxntXALVaFHTmRZBp12pd+96hCOA4o6lpKKCYiXWaSUeEkAjmRg+OT
	ccvdv83DG10VZoylvIZnMRQk8eXpl1PJqoCLll6BNymLUIuTaaOB8+ejOeSySjJg
	LZZJ4PYWZcO5YnafutkwI1ypadfTs+55vg8UysIVxQ+i7NcY/y2J99FsxNg78qje
	MrBkLRfDOqlq/ccmLMnM3QT+1+Euw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xgn0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:03:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66REuOZW030066;
	Mon, 27 Jul 2026 15:03:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjwud7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:03:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RF2ttC46727458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 15:02:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C708200F7;
	Mon, 27 Jul 2026 15:02:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D923200F4;
	Mon, 27 Jul 2026 15:02:54 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.1.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 15:02:54 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 00/10] KVM: s390: Misc fixes
Date: Mon, 27 Jul 2026 17:02:44 +0200
Message-ID: <20260727150254.236021-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iWUfcyvtdrsSOyV9NdFxHvOahWVnIf7X
X-Proofpoint-ORIG-GUID: iWUfcyvtdrsSOyV9NdFxHvOahWVnIf7X
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfX+CqSNvxK0XC7
 j7Vf4iV/IdtpctB6/ntJ2DhojAw7M7ncdE7VcRJ0nAmgn+ttxJTwKuBDxtCDhbc7UJbhinNRrIx
 Y9V74X4uz40rPBcDZGYxchCQf+BvP78=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a677326 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=wo0HmtkIjTO4S1HvodoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfX8DPXEQ8d1xd9
 59u2+x6wA+ZJt/fd3JVEs1/3wdqF4gXvESIx3DiCUR4R+vhodhQH0ifW50tqCyw07WAUZERtiul
 TrJ3oPRkkDjDxCTXIcfY8jwR6dIxlsC5/j6kNADmt0XsKxojUsYzk77Og0ByIZsrYK0/VmNegsZ
 RAUhHGzOFKDA3pEuqoxbPwatl79Sw/I9nFkPEg2h3cVD9+a/U91SANiD2wso9Tnmip+frtCZ6Zk
 sqkdpOhN5OGAMRMOelfwT/L9tx0tHMTed29iFavKNhKMLqvvG1L70MRiEpdzYHcM0MikmfBY5x2
 XA4TwKj4kpk+2L3Br9xzwOPS+He27ZIywHQjcCYkfQYK5ODldSZfwMvTLN8BW2Cz+Y9Kk/aCJ7p
 70rdotJDUan/0RukK2LUrx1wNj2Spx5xttBavCYGExnhypnPJNCSDJV+Hv0sB5I3DBKERKnEJFe
 jIKkhZ/G+9f7km0IiBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270140

Fix a bunch of small issues that came up during the previous round of fixes.

They are mostly extremely unlikely races, but they should be fixed
nonetheless.

v2->v3
* Use READ_ONCE to pair with WRITE_ONCE in the first patch
* Fix leaking PGM_ADDRESSING also in kvm_s390_keyop() and related functions
* Fix and improve commit messages
* Use slots_arch_lock instead of slots_lock for ESSA operations
* Use normal spin_{,un}lock() functions instead of scoped_guard to avoid
  mixing the two styles
* Use the newly introduced vcpu->arch.initialized to determine whether the
  SCA entry needs to be cleared
* Improve handling of -EINTR; handle_mvpg_pei() needed some refactoring to
  deal with it properly
* Three new patches:
  - Free the mmu cache when kvm_arch_vcpu_create() fails
  - Fix ordering when adding to SCA
  - Fix cleanup in kvm_s390_pv_create_cpu()

v1->v2
* Drop some patches that have been picked upstream in the meantime.
* Drop patch 3, as it was trying to fix a bug that does not exist
* Avoid the NULL gmap dereference by using a flag
* Fix the return value of kvm_s390_[gp]et_skeys too
* Use kvm->slots_arch_lock instead of kvm->slots_lock for CMMA and ESSA
  handling, to avoid potential deadlocks with the RCU.
* Three new patches to fix other issues that came out while fixing the
  other issues

Claudio Imbrenda (10):
  KVM: s390: Fix unlikely NULL gmap dereference
  KVM: s390: Fix leaking of PGM_ADDRESSING to userspace
  KVM: s390: Fix race in __do_essa()
  KVM: s390: cmma: Fix dirty tracking when removing memslot
  KVM: s390: ucontrol: Add missing locking around gmap_remove_child()
  KVM: s390: Fix overclearing ESCA in case of error
  KVM: s390: Return -EINTR if a signal was pending while faulting-in
  KVM: s390: Free the mmu cache when kvm_arch_vcpu_create() fails
  KVM: s390: Fix ordering when adding to SCA
  KVM: s390: Fix cleanup in kvm_s390_pv_create_cpu()

 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/dat.c              | 23 ++++++----
 arch/s390/kvm/dat.h              |  2 +-
 arch/s390/kvm/faultin.c          |  4 +-
 arch/s390/kvm/intercept.c        | 18 ++++----
 arch/s390/kvm/interrupt.c        |  2 +-
 arch/s390/kvm/kvm-s390.c         | 72 ++++++++++++++++++++++----------
 arch/s390/kvm/priv.c             | 10 +++--
 arch/s390/kvm/pv.c               | 43 +++++++++----------
 9 files changed, 106 insertions(+), 69 deletions(-)

-- 
2.55.0

