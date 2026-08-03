Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA0632AAA0;
	Mon,  3 Aug 2026 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760852; cv=none; b=P9GCeKnVATPuXx6b0F5sortUAjxOJHDcnY6Lju0SKsIe4IYiWEURigezRRgIaJ4Y0P5Tig4NBgiAKWLkgyUad2buxHr6p8J3e8OkNsQcvRywV38J39QdWOHWRZuqfuGfV7wAROmcSTKl4P92P1TNGsXnIg7cWafuy+t2N3Y4zYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760852; c=relaxed/simple;
	bh=OvFJHF9yBnH5Jsc9A+P1+U0XMJGxsOkWlaBWpZwG+aE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ja2QxJogVjLsnewMzHQlBTCTnHfEyrNTyL1ckc2FvG4348Sj00MU3zCfVD5e748UTwp9YbiQuVoDcVOPlLJJocSJMB6ilDqQ8522oAmIN9URH6JxbYwQwnxQdwtbNRLQ2Nsu5x6F4bpKn1GhMHbZW2l57Z6+uVsjrJnCb+UWxVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NnfAaVBs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NnfAaVBs"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CHZXX151061;
	Mon, 3 Aug 2026 12:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=7bUfJyMtvmbC11mVPOrGspOyVw/DJoh0ILhhn37Fv
	OE=; b=NnfAaVBsmIaoeow3BeqCj2X+RmC4abIMIzN6E0SZKJAJbUuGZ+NwDdrnx
	RND46NUNcCBCavrBqw5ulFO0eBUcmG9vsRDtVsnsASCKWMFFJ3J/2/cFlF95uEGg
	GzYlewTfoYBe5PMgV+i4wAinMxZBBO8pab8kfdxJ2I7lpofFeBHeFspOwAunABy4
	5QGI0ailMyt+aLWkGGSmOJlESMML4ibCphgKybomBIef0q/zuXeMbzXWN/bvSCDe
	b0ik5WjUsRCW3XhRjdtBA3aZx6P/1Q2oqLXlQ4z+4vN4TTisl7Ajv3fb6XUhdaM8
	bKGjqRWSbPyhsmXqjXEEKE5ekECSQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqgqew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CQKsl009779;
	Mon, 3 Aug 2026 12:40:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh59sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673CefSq16384448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 12:40:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36D092004E;
	Mon,  3 Aug 2026 12:40:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B83F20040;
	Mon,  3 Aug 2026 12:40:40 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 12:40:40 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v8 00/13] KVM: s390: Misc fixes
Date: Mon,  3 Aug 2026 14:40:27 +0200
Message-ID: <20260803124040.126471-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AIEb5YsWyINLKEGjiH-DXj2rpkI1LuuD
X-Proofpoint-ORIG-GUID: AIEb5YsWyINLKEGjiH-DXj2rpkI1LuuD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX5qtfFKLCElZG
 NSlfHAkt78Si4udLzl0pIhnDfp5VdfLeq0KUPAeSqThmEqkdmBPD0wtEZU4JoTh2a8iuG+/lfri
 3SFGKS8FzOJ+79USsZEKUmoXMgSRxyM=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a708c51 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=O17wmb0z-pt-y8_z3AwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfXxF0twvgA8n2L
 deMNgX5MbDF1fEyXFR7ACKYY6zbJM5DSdyIvj4rs3194ShcY6WDVVVGwpeWSbKuD3pe49r/3HIX
 3MQ8yNYYaLlpWdB8XBL5cFxf36F5zWuNrc9EYNtky1E/pRROZ+g3HzpEmx04I1PXSziDqfhCbsu
 K4JKO4zupptgHiI8hWbuC/Wt+RH25qfDOFr20kie/ifTWbAGVlRNiZSg/5031mpIUFdJnZIF3ot
 IHJB3anPHV8GoAZHliHmvRrTjl+7zLBdBuoBQLcLPhWKJvOvL3abe1FQYrLnOOUcEAc01U9DEQi
 lmJh+QnPYtG5c0B1A9uI1y/3FcHQUPBlzqTd5G2LddrxOP9Hd4g0c5SzVvzUyurdxdcl2CRNe+3
 XjPlLhCUawm4FCB40jj65b9WNgJNsDIA3s6UTiQGkFRkvrruTsfrnM01EcbjnZq+MkjyO0ae/2U
 W7ggN2ASSZ5GdFeajMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030110

Fix a bunch of small issues that came up during the previous round of fixes.

They are mostly extremely unlikely races, but they should be fixed
nonetheless.

v7->v8
* Fix some patch descriptions.
* Remove KVM_BUG_ON() from code that should not be reached but could
  still be reached. Just return an appropriate error code.
* Drop the last patch. Will need a more complex fix, will be done in a
  different series.

v6->v7
* Do not free SCA in kvm_arch_init_vm() if it was not allocated
* Remove a KVM_BUG_ON() that could still be triggered from userspace
  with UCONTROL.
* Remove KVM_BUG_ON() if a memslot change could not be performed.
* Fence KVM_S390_INTERRUPT also for vCPUs for UCONTROL VMs.

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

Claudio Imbrenda (13):
  KVM: s390: Fix unlikely NULL gmap dereference
  KVM: s390: Do not free SCA if it was not allocated
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

 arch/s390/include/asm/kvm_host.h |   1 +
 arch/s390/kvm/dat.c              |  23 ++++--
 arch/s390/kvm/dat.h              |   2 +-
 arch/s390/kvm/faultin.c          |   6 +-
 arch/s390/kvm/interrupt.c        |  19 +++--
 arch/s390/kvm/kvm-s390.c         | 125 ++++++++++++++++++++-----------
 arch/s390/kvm/priv.c             |  10 ++-
 arch/s390/kvm/pv.c               |  43 +++++------
 8 files changed, 144 insertions(+), 85 deletions(-)

-- 
2.55.0

