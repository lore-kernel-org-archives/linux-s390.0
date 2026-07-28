Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F0439CCED;
	Tue, 28 Jul 2026 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258440; cv=none; b=EL9ogKfSN6h3xkPhvkf70IlpMKZeeWm8jtDxm9vdUESFmx1PNfQFJWVGESOc+wz8pqLfm9G2KoHnDnUyTwn+Qt3qm/vwa8+iDnCd8FP46u7kW6hZcSj/oea89dfRh5govcKUw0mX+Q5QEg+g3PjZnTQk2akxzVX44TCCuTyiWPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258440; c=relaxed/simple;
	bh=8lHyAoLmNaGSw/SdyDBgtMYsQ6bdcDfz6SYQwUXNZgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/RkatjGs5AAOMXvE0kvJ7hczV6W/Htwyv/da+xsONBCIqm/0kA964ASIT/2ZLkV1wdsf6bMFXHbQipfstuS1nnGCL72nCadDOBPHYZxkdmY/t3uQMqiJwV6LkQM5LJkttGPrJJPTTZkcnWkpYXLGCiEgI/cSi/X6eiX4sZzDDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CW9F2RL9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CW9F2RL9"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SElY6i3788533;
	Tue, 28 Jul 2026 17:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=aY7vD1lL9K3FjE96NMCDK6JXUZXmdaNWvixLBSP19
	9w=; b=CW9F2RL9uQm3XSkGnasJzjT0I+MQi7t5PqDXKFt30hto3Nx4+H/OxbJCp
	rcnbNzPLkYeqZ2zJ5NGSZ1ULMfcAfZF85D0H7dBSjLdm2T/USEiEQQPx1SP6sFyR
	+S3oDcu1/YRuLamdxgmS1rOlPNv7xSt6v/KzoW15xkv2uGbmy7Z54SZoYQXml8sP
	3W99e02hLZXbO37ZB/nVbdVBQTO0dGoR8LPA2YBCWpGNlM1LRwPJAwWh1sutSpr/
	1hmiARkxvYd6mPaVxapfjPmiu6/v8yNnGsrvCxZgxLkRGQpfkfz5CxOCaI8mQ4nX
	f7DLN/LNSZbrOBxnuo1NhyM4AZoQw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycefyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SGuHUG030198;
	Tue, 28 Jul 2026 17:07:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw33a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SH79NI31261134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 17:07:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A7ED20040;
	Tue, 28 Jul 2026 17:07:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA80220049;
	Tue, 28 Jul 2026 17:07:08 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.73.241])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 17:07:08 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v4 00/13] KVM: s390: Misc fixes
Date: Tue, 28 Jul 2026 19:06:55 +0200
Message-ID: <20260728170708.294400-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Uhpi7ro2W9SxadMVv7PwHpfzbLsRpZoG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfX5XVosBIt35M1
 7M7jTT5bOuCgTEC06Iy7niJm+G1FmG1b7DW8DXj77eznT41crR4GzpB5JVHRiqs0x2t/vy/d/88
 /tBfXFvg8FUb7uwYz48KqKfqdCEi5T/lmDcHI5pNm0FxnKpMPgt0dSsHlFS3Yx3J2arLyJZWgDL
 ASfdx7HEkOgmI/Fv62tMajTxO5fu70YDPja+HzPKQWLia9Oyq8NjGSVWntIbe57hIsx8LaqXg5a
 0BuPp4+tE65Wo9e52qo6s6qMlSSuM4F6L4P5hLiEGfyQ9wlg2ILbKp+8vJUys+inj20iH/tVPY7
 ABGa/g7N2Ny9AkFmREOxj+BsWWa5gPV6/Cy2z9rjXR43kBq+7B3pIK98ja9CqmgUXgWjLjGpZMV
 omRMgErofsIJGISPq5Z0mL0zoMzDpwDOEMWwxzuveCSn0F+KrwpaeQjvbb1DKhBFUFl/Jjua4KA
 8VSZf66BWYVGUEmpRZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfXxlyAqJAvi/hX
 6mhqn3qohQ7u1tHk/mK64qzz4wGu+ko1m+/ZKfukaUv5d+2x5MWTgDw3//jbqGeGBjzFu71NMwd
 9YPjhKoCBsIS+WUT3SQVLs1iy8IzS1I=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a68e1c5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=aWu7778oA4-70mMxV74A:9
X-Proofpoint-GUID: Uhpi7ro2W9SxadMVv7PwHpfzbLsRpZoG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280149

Fix a bunch of small issues that came up during the previous round of fixes.

They are mostly extremely unlikely races, but they should be fixed
nonetheless.

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
  KVM: s390: Fix leaking of PGM_ADDRESSING to userspace
  KVM: s390: Fix race in __do_essa()
  KVM: s390: cmma: Fix dirty tracking when removing memslot
  KVM: s390: ucontrol: Add missing locking around gmap_remove_child()
  KVM: s390: Fix overclearing ESCA in case of error
  KVM: s390: Return -EINTR if a signal was pending while faulting-in
  KVM: s390: Free the mmu cache when kvm_arch_vcpu_create() fails
  KVM: s390: Fix ordering when adding to SCA
  KVM: s390: Fix cleanup in kvm_s390_pv_create_cpu()
  KVM: s390: Fix kvm_arch_commit_memory_region() when low on memory
  KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
  KVM: s390: Fix sca_clear_ext_call() for UCONTROL

 arch/s390/include/asm/kvm_host.h |   1 +
 arch/s390/kvm/dat.c              |  23 ++++--
 arch/s390/kvm/dat.h              |   2 +-
 arch/s390/kvm/faultin.c          |   4 +-
 arch/s390/kvm/intercept.c        |  23 +++---
 arch/s390/kvm/interrupt.c        |   7 +-
 arch/s390/kvm/kvm-s390.c         | 121 +++++++++++++++++++------------
 arch/s390/kvm/priv.c             |  10 ++-
 arch/s390/kvm/pv.c               |  43 +++++------
 9 files changed, 141 insertions(+), 93 deletions(-)

-- 
2.55.0

