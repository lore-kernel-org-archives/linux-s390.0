Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F2043D515;
	Thu, 30 Jul 2026 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428845; cv=none; b=ZhzylA+AlbAW30wqRGPoCq1DRRqlHH2UH1mHzYqXPEbK+uOnXQ0jrleuzJC39vIbSZQpANmiHpNiEidCVM1t4oI2EeMtv4O2AI6BLbeFquMpnfiI88ByCGddtIBemL39ybP4t712t+i5o9DaC5g8lcvIye5anuoUHAz7LYfvTjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428845; c=relaxed/simple;
	bh=sFq+xZGpTGYfQufRT7O3HurU5LO9biuFSYgiN9sVpnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JgW93APE/WXcccPb8eTAlWT8cEe0ebMHl8w9VQ4zlCCu9CsEyDX5Q4/k+7sLREgus+kkcdLymjxdvBSt4cugkRmQPscj5kOjr7Banekg4n7zdDXQj2td549Mlke1Mvgsrc90uE5F+mvyqWBA3hNK/XkB6jz7sVB7w7LcP+y6GqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EDtRqjwV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EDtRqjwV"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFm2aL3457188;
	Thu, 30 Jul 2026 16:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=r+aDBJn+NROp5Miwd1e2/JBjbwUkei7e2HQf4RM0G
	dw=; b=EDtRqjwVxzgRQz9lbq64z+OUSsCyPFEL/yN3U88MZ5O9k+pmsWEq14mbs
	NQYWsI6GTtwje9n1p3C4g+8yi1pkrLe2KFL9rnthAgE6RhMUfSsZwGb26qP8ySeA
	qu2bRWb9hkkvbZERHNMeUDgmAPVSSo8zz/rHD1uNhVyZpToPhWY0jKDEcSm2Q2BY
	BqznyIh0zOwhNtII8GY3pvNZTv84lY6T9LppZU5C8tZo9Mkdg8NoXf4lafmS/wNA
	V05PdcgnCyykTE1U/TjGvb3q0PLrFI0JdClwtH0pjce3suF650BAjvBuc1e/Nceq
	OtlcyDzzKTpmIJJSAqJIRZ3RxzgsQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0y0tbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UGQJn1001524;
	Thu, 30 Jul 2026 16:27:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkc55t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UGRFCu32768314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 16:27:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEAC520043;
	Thu, 30 Jul 2026 16:27:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7F0820040;
	Thu, 30 Jul 2026 16:27:14 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 16:27:14 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v6 00/14] KVM: s390: Misc fixes
Date: Thu, 30 Jul 2026 18:27:00 +0200
Message-ID: <20260730162714.133327-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JaZwBYV60fWF7K7J4JfrrdLt_tDIE67W
X-Proofpoint-ORIG-GUID: JaZwBYV60fWF7K7J4JfrrdLt_tDIE67W
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX6/ldAmJFHH4g
 G6HOQl5LlnARWlRiJnc5DxC1x76k1uEe0O7dMNtO3ouslCw7YtE9oYTScho7Rpr/9VSMhH8c1eG
 ru3J4XPneLILs2UlNN0ymWtIErxWzQU=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6b7b6a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=aWu7778oA4-70mMxV74A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX2P1Nxu46UNym
 8RNcyqPS4EVMa3RGgQsoEnDxAfrNAu/Yui+8828t9ibYSGtSNbUSRy3TZ3VSkr7Z+hIYyiXIDyZ
 9rJADPuVrEKrUE2N6SsnlLQ6HUSkSBhNYVRKjmrFnT9KiuLeK3d+aIDDPYCFKSFCiOhLquDM/9v
 aRVwuDgmIqBDDzKchZh/2QhpwJ9VGgLAOIRn6bNixxC+sQe2OwHCmJr7791QbQJK3mA6izgwazO
 40g9nyIAa/1iAPoCFzwa/Y6GIFxTDTxjpxzFUu41hcLMntlrc5eJPUacYuaLHP29JYx4lSAzvwD
 6ip3AwAnGzJQKFlFrj/LbVriVrIrKAY8fAAbrpM9SACC2OHIchoWakMReu+dCGMut2ZzsjmOHw8
 9sPcpx0ctzLulHuW4l5UM1KwLBsMwwO6qkA2twaXjXuqo0Wo4CA0Fr81AW9ZJ3b//C7nHrXKj+n
 3mE3zmEaAVrDEj+auoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300123

Fix a bunch of small issues that came up during the previous round of fixes.

They are mostly extremely unlikely races, but they should be fixed
nonetheless.

v5->v6
* Move the memory accesses in sca_ext_call_pending() and
  sca_inject_ext_call() so that they only happen after the newly
  introduced checks. Otherwise an out of bounds access was still possible.
* Completely fence the KVM_S390_INTERRUPT ioctl for UCONTROL VMs.
* Move page table updates from kvm_arch_commit_memory_region() to
  kvm_arch_prepare_memory_region(), so that failures are not ignored.

v4->v5
* Improve / fix some comments
* Undo handle_mvpg_pei() changes
* cmma_d_count_pte() now clears the cmma_d bit, to avoid double counting
* Improve some patch descriptions
* Trigger KVM_BUG_ON() in sca_ext_call_pending() and
  sca_inject_ext_call() if called on UCONTROL vCPUs
* Reshuffle the order of the patches to hopefully get fewer false
  positives from sashiko
* Check and free cbrlo only if it's not zero

v3->v4
* Improve patch descriptions, add comments
* Use smp_store_release and smp_load_acquire in the first patch
* Multiple fixes in patch 4: potential NULL pointer dereference,
  incorrect behaviour in low memory condition
* Rework patch 8 to use scope-based cleanup instead of gotos.
* Three new patches:
  - KVM: s390: Fix kvm_arch_commit_memory_region() when low on memory
  - KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
  - KVM: s390: Fix sca_clear_ext_call() for UCONTROL

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


Claudio Imbrenda (14):
  KVM: s390: Fix unlikely NULL gmap dereference
  KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
  KVM: s390: Fix overclearing ESCA in case of error
  KVM: s390: ucontrol: Fix sca_clear_ext_call()
  KVM: s390: Fix leaking of PGM_ADDRESSING to userspace
  KVM: s390: Fix race in __do_essa()
  KVM: s390: cmma: Fix dirty tracking when removing memslot
  KVM: s390: ucontrol: Add missing locking around gmap_remove_child()
  KVM: s390: Free the mmu cache when kvm_arch_vcpu_create() fails
  KVM: s390: Return -EINTR if a signal is pending while faulting-in
  KVM: s390: Fix ordering when adding to SCA
  KVM: s390: Fix cleanup in kvm_s390_pv_create_cpu()
  KVM: s390: Fix kvm_arch_commit_memory_region() when low on memory
  KVM: s390: Move DAT table updates to kvm_arch_prepare_memory_region()

 arch/s390/include/asm/kvm_host.h |   1 +
 arch/s390/kvm/dat.c              |  23 ++--
 arch/s390/kvm/dat.h              |   2 +-
 arch/s390/kvm/faultin.c          |   6 +-
 arch/s390/kvm/interrupt.c        |  19 +++-
 arch/s390/kvm/kvm-s390.c         | 187 ++++++++++++++++++-------------
 arch/s390/kvm/priv.c             |  10 +-
 arch/s390/kvm/pv.c               |  43 +++----
 8 files changed, 172 insertions(+), 119 deletions(-)

-- 
2.55.0

