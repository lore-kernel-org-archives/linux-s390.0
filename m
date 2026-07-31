Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7841E22E9;
	Fri, 31 Jul 2026 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502911; cv=none; b=pCFZrAIUd1Rq/umebNjc2fTR3aqbwSh/4BHR8/92JqCepsrSBhtE7AH7POfeEfpJm0inKgp2dyiCKYC9+LBOzlF0mSoU9K4krvo7n8tcVwy8eP5fbiWdd+sazCt7FK1OqHveWwl8K6k7a+vGsOtliNFVVn++CrtczhKwfgEjD5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502911; c=relaxed/simple;
	bh=P03uccBnEaJ1BZ9Nekhpu4UTkcSnKTJJk+BnkvoptRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KytcVOR+MQAu3b/47JKkT0i/U/HFSCC+NFpszetk4k1aNZlam9tb2B+e4xfJn+bl91adL5ADQr8AzzzPs61PcztdPz8QBNpbBa1+RnQF2WQEnt8kADBH/CQ32sX/ae5msrQPvYQ410+RGt7HhD1isczwn95HqIP9UHt2WVj9Y5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m9YjwrIJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m9YjwrIJ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlutw1731148;
	Fri, 31 Jul 2026 13:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=VMy0CVmB1D3jOew6zg+TMqZMyswN2jPyBofcH/Koj
	KM=; b=m9YjwrIJP7s7+mVBZDsxDjPc8ar38DRY5txPBO04SRB+FndoM74jQBv7k
	hh94Dv5ca7ZiX8NuvA9D6TXc6yHL3COmWBRCBIakR2vfCK0D3l5kHCZUXik7oy3R
	MNvcrT2tDZs3Qqoj9QGVWXMbtwpXWl7VFoB+IA/P/3QtgEut5bperLKC7L1I4uCE
	ZYaHCs2kBRokJmcdt3kQUE5uSnPtKmPrFkSk2sTMmBjkr+nSPGhaevbEdVqY62iU
	jbgJ0gHZR77t6boIvXcynNtOLMBYzwSCeo+Ub2pHy1D+vDop5ryklCQkVXcp2JGK
	ufKda7GMYyzBMPRctj8LZnpB7HpIA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7w3f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:01:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuPxN026547;
	Fri, 31 Jul 2026 13:01:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhquvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:01:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD1d6v29950400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:01:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E4AE20043;
	Fri, 31 Jul 2026 13:01:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D12F620040;
	Fri, 31 Jul 2026 13:01:38 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.4.62])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:01:38 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v7 00/14] KVM: s390: Misc fixes
Date: Fri, 31 Jul 2026 15:01:24 +0200
Message-ID: <20260731130138.173983-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IXSngbKukCDI1kaT_yWSR3Hg2Q79LmD5
X-Proofpoint-ORIG-GUID: IXSngbKukCDI1kaT_yWSR3Hg2Q79LmD5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX1EzfpK2SDj5R
 ReeZTeKOF4BUTCQuOtS7QcdA2ArvwrW6nOT1/B0JOJCa8NKdZubXQlFCz8dRfCq4SGtg4L7Q6Kp
 p7Nwd76ZKZYWD6zoHuT1l+nYoQQca4LD0DlbG7j1lgeMHucIBKHSm9pArwtHt6DgqwymFdqqTiu
 6Np5oNio8zXdUa7qmthxHaHSdSKiJjx1B1GOTNsanpLmBlF6ZKeKCqrQFM3lW84JXD6SVXG4tDX
 9AZEHAcpIGb6QjDorVNWJUSFy4eCSAak/p2ZaT5hbDcouazvkNkflkLkyuT1TEFLxud4xGC8MDn
 jVZeHtHleksgskZgPsGlUzLvN9eKsTbbjWhNrpErZiTs1EqrpR2HzhZZxeng6/eRWA/Dbh6Zm0n
 kcmEWQ5mAjCYnNg5Q+elZSSjc9Vsa32NaKfMWb1YHVgef8oiRToKdJmzP0GlqaeIPYMPj1IREjy
 Ta3Dh4oKpb0SEcU+GKQ==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6c9cbb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=O17wmb0z-pt-y8_z3AwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX6QDi/QiELww6
 XGNpVo8mzc78dhwjsx2h4iQYTbUWsx5y3xXdFlUE1WDyeivDkR+f1gsXRercSxUlEN4BUbMP+RG
 gX4OAZmDaA+02wzqTRZ5TCFr8Rvt6p4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310096

Fix a bunch of small issues that came up during the previous round of fixes.

They are mostly extremely unlikely races, but they should be fixed
nonetheless.

v6->v7
* Do not free SCA in kvm_arch_init_vm() if it was not allocated
* Remove a KVM_BUG_ON() that could still be triggered from userspace
  with UCONTROL.
* Remove KVM_BUG_ON() if a memslot change could not be performed.
* Fence KVM_S390_INTERRUPT also for vCPUs for UCONTROL VMs.
* Drop the last patch. Will need a more complex fix, will be done in a
  different series.

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
  KVM: s390: Fix kvm_arch_commit_memory_region() when low on memory

 arch/s390/include/asm/kvm_host.h |   1 +
 arch/s390/kvm/dat.c              |  23 +++--
 arch/s390/kvm/dat.h              |   2 +-
 arch/s390/kvm/faultin.c          |   6 +-
 arch/s390/kvm/interrupt.c        |  19 +++--
 arch/s390/kvm/kvm-s390.c         | 139 ++++++++++++++++++++-----------
 arch/s390/kvm/priv.c             |  10 ++-
 arch/s390/kvm/pv.c               |  43 +++++-----
 8 files changed, 153 insertions(+), 90 deletions(-)

-- 
2.55.0

