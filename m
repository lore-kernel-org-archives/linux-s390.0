Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF2030C368;
	Wed, 29 Jul 2026 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338989; cv=none; b=st6BoyRyTRkWiIfedQWBfx8xv0lUDCgS4HBOpOXncSi7Wwy2UJ8KLbTPnMhjHqI8NaMOgMI3j5xaKQp/72iB3Jt+6wkvGKrMWOKdCuC2VWzkJqNugVOEUFCjTP55AwNiL6ZOCdCHa5Zjkw4pYJR2qJtUAzHIKiNMNr7CvdhTNaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338989; c=relaxed/simple;
	bh=I2us5/0QAhLh76ChgnneM5JJpx+SIG/kurn2ki0wyWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SwF16xDdAgNfHKRI1ckc6EbfJAhIfAMXC8z3hm4+7HTlC7XtFoFHIrZXMaYk8uPUF4v5YwLMz8tD3pb8O7GAtwXGUeY20leDN2o5gDEUzXMEU69BG7p00yipzbxv40CptLigDJ+hM0tUxqx7dYziQW7l+hChrctGRZY47feWysM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CYGIejIa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CYGIejIa"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHipr388692;
	Wed, 29 Jul 2026 15:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vSZ5mL3JQ+oiFst4K7RbDHJ8R2KRrZDefzGcfv6uX
	yM=; b=CYGIejIasbl096UBBiabhNLsZeZP3J78VshOqM8M7TTgLj1iQUFX9Tp0j
	v5+ushQpIMqtejg+KnN0cxszxw2r2lNDeb+yi+zP7Oiiuo9jZdSf+2IHz7klFNJH
	SPi9W1B/tbjw0l5YBZ2XghQKzeY0jDdb41MdBAzKaYZsHncc4TIyyBlH1FMd0VM5
	Gx1BgUxR3Dl0O7/usjJlTHUjHk5QPcfshvlLy1SpAhoLY8RewDKDGL7g2VS4SjaY
	dSBzsaxInte/o0f273CNLWEmzDMJQmjhJx0yiUtP1t+MfO1CMPftnd6LI6P01Zez
	7KnYaU34phcGYAgH60s1Rq6JFYZ2A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xuefe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFQL7M028810;
	Wed, 29 Jul 2026 15:29:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhf6cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFTcDE51839402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:29:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8537520043;
	Wed, 29 Jul 2026 15:29:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E3F320040;
	Wed, 29 Jul 2026 15:29:38 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:29:38 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v5 00/13] KVM: s390: Misc fixes
Date: Wed, 29 Jul 2026 17:29:25 +0200
Message-ID: <20260729152938.782383-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Lv9NdKW50SnfLTKBk1F1RXsANFu6CBCs
X-Proofpoint-ORIG-GUID: Lv9NdKW50SnfLTKBk1F1RXsANFu6CBCs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX5V1v4UWQsCKV
 J0lgpUfbXkWC2zGrmNm+3Z5kof0cuX94JRDck9geFjZn2piTx29Tl51kBhFH/B1Xh/D6ZmNFlPH
 p9gkTvdKoebEYohcdetPqiXnLNsXfxE=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6a1c6a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=aWu7778oA4-70mMxV74A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX9PrktLJQRNI0
 JL+s927qLk2f1j8wnltt9GuriS2N3BPPCSOWEHfz/O4OLb95fQMrLLQmV7A9pOg/QgwZ4/wFW5O
 2dE7xm2Fg6siYL+UEiKEtscpcZtn1B37JGYvrCrAPHNM6O9RmIED223vlFM7F9/TDs6nZurhsXU
 40I/LRLdizjoL7s3xQ4d8IKa27y33DEoBniLpoBumQ8zT7iFw5D0DQm95HQt6zWGyxk1RCLr1fb
 cPAlk8re5oktDylfrYoBGuLL3eZaODXLe7Nje8xOl9vNNckM+4WnsOAe5Vkx1BbGIBJckGD4IBH
 kDqlf/8Ic0IvyVEKdbyC+Hb0HzVfq9hSNf4RGfUmsowaP+bnPeNJq+LIL9kc983iNT5NVOGUD1/
 X0u+B1McM0LEIi9UZHp49WNlgV7HTtJkkT/pyOUM2wUZB8SYopGst1aUTREPLsR5vovOUdAyICk
 YrGOWXjzwAmW6boiw+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290123

Fix a bunch of small issues that came up during the previous round of fixes.

They are mostly extremely unlikely races, but they should be fixed
nonetheless.

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

Claudio Imbrenda (13):
  KVM: s390: Fix unlikely NULL gmap dereference
  KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
  KVM: s390: Fix overclearing ESCA in case of error
  KVM: s390: ucontrol: Fix sca_clear_ext_call()
  KVM: s390: Fix leaking of PGM_ADDRESSING to userspace
  KVM: s390: Fix race in __do_essa()
  KVM: s390: cmma: Fix dirty tracking when removing memslot
  KVM: s390: ucontrol: Add missing locking around gmap_remove_child()
  KVM: s390: Free the mmu cache when kvm_arch_vcpu_create() fails
  KVM: s390: Return -EINTR if a signal was pending while faulting-in
  KVM: s390: Fix ordering when adding to SCA
  KVM: s390: Fix cleanup in kvm_s390_pv_create_cpu()
  KVM: s390: Fix kvm_arch_commit_memory_region() when low on memory

 arch/s390/include/asm/kvm_host.h |   1 +
 arch/s390/kvm/dat.c              |  23 ++++--
 arch/s390/kvm/dat.h              |   2 +-
 arch/s390/kvm/faultin.c          |   6 +-
 arch/s390/kvm/interrupt.c        |  11 ++-
 arch/s390/kvm/kvm-s390.c         | 133 +++++++++++++++++++------------
 arch/s390/kvm/priv.c             |  10 ++-
 arch/s390/kvm/pv.c               |  43 +++++-----
 8 files changed, 142 insertions(+), 87 deletions(-)

-- 
2.55.0

