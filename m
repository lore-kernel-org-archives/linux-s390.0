Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9543409619;
	Fri, 29 May 2026 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070206; cv=none; b=SKZ1WhZIJbydHDpg8oZaQ9a03jdpSogZ5MS90OY9Lqfu5jUzw6NW3pz5WMiCn5Mg2ZwYT5cdL7KnZH16zC2dubfWIvcAaM0SO5f5s4oSWO7rPwYwZ+keHiKjXl8bVrQnNMjccPcY4ll5TEpy8OUxg95wfny+UeOSEpJaNi5nP1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070206; c=relaxed/simple;
	bh=C98rQCqcgkcYhiYGLyfnIFkl9C7h1OpPWa7EBGxY+f4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PSK2vXPx5Wgzum6QjpJ/mcVB15Jedy0xPT4gBvaVuiFK+vZVFPhcB9hIm60k8Wf/dt/AMeFSpIwVmwFyw4v+e2LC6XxVsvZ9uNuZA+xEKFpBMnkDaZtTw/killUcs6AuW0p1Na6tB+GQ7n+3fO8CNX0LSSFj2NsykJKnSRlx98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QblZmF79; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QblZmF79"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TF20CR2418232;
	Fri, 29 May 2026 15:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=KFWGTod/Hb30Jg5nGx1OXx0QlYfmVGBc741mC5/G7
	B8=; b=QblZmF79W2mAJFeoiCLGMOMqm8eqKf/4o2MocZ4eKg+hpsYl1IJErqwIB
	scHNZYogxHHIzX99muDksigweZ91kt0U2IREzTdfN4eZDZ6PbnAFApc3NBtE2EHQ
	ccCxUGSmHvCwtP3PxLG5QXd1St+g+KKtiUjvhPef+oCXXpeNcAH2s36c6DEQR2wE
	rKxCn10WHV2GJvCD5RS2Gn2LD8yGuWhmJIawe9sU7NwkWAOroHAT70DlWZtmdV4C
	Kh/FRhme4pw2+qEancDmIVvpDXv+3q29fZ0vFd7L5aZH+QB0f94XR95QEhkxpel2
	slANEtsp9arI+jcR8s6gDeTiAGg+A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884vkm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFs7dm023024;
	Fri, 29 May 2026 15:56:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc0k0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFu2sb50594184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:56:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E6132004B;
	Fri, 29 May 2026 15:56:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6F8D20040;
	Fri, 29 May 2026 15:56:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:56:01 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v1 00/26] KVM: arm64 on s390 System Register Handling
Date: Fri, 29 May 2026 17:55:33 +0200
Message-ID: <20260529155601.2927240-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a19b71a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=SYefhmQwoCRZZBh0FkwA:9
X-Proofpoint-ORIG-GUID: ElVShckdVUTBxAneIkY6-NTlIwU94kG9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX91eGG6WRN1wh
 AKG6wPMJVHwkG5vuTm759aRP+kfvwDLJNNslsjnytwLbxvnIqvE3ZPNfiqK4J+He0P27a3CQL3S
 UQa0zh2DhIsFo+3+ZrOtKzuqnuVuYfglr8e6KLzvWfek/u3pqgW8mC3fP/N4HvN9Uovh+8aD6I6
 hZGChDW2I32TTwMeN5Fzp+dnq5hQ2a6uAfVyJYmSOx2g/quWfJjgJ63tXj6p2jpgrkyiTGs7htb
 ox3uM0L3S85O8Xc3NbsWlhC0kTlpfwpCVvks08YUlZTnmzm9UujFbs/fASjN2wwk00O2pL5vK7M
 x3W4BPonn8DjdZVkrwH0v1uPQpPN03snfOQx1tUAELqOoH4Zce7805UM7d9ZCiQFKOgr8RuWGOH
 eH4lpDUprF1TyN7YmuKlxWQnYd1jhaSG9erh0vwo5O40gnn8R/IH+ulI3/QN+wEPgVWeP6fG8gn
 h3nSC+Qu9f5Y0S/ZHkQ==
X-Proofpoint-GUID: ElVShckdVUTBxAneIkY6-NTlIwU94kG9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290156

Add system register handling for KVM/arm64 on s390. Restructure and share
KVM/arm64 code, introduce ARM guest management functions for s390 hosts,
and implement host sysreg & exception handling.

Changes in detail:

arm64:

Refactor arm64 feature detection and ID register handling to make it
generic and reusable across architectures.

Restructure ID register storage and core register handling. Refactor core
registers to use functions instead of direct memory access.

Move arm64-specific definitions (CPU types, cache, KVM features, ID
registers, system registers) to shared locations for reuse by other
architectures.

s390:

Add s390 instruction support for ARM guest management: easr/sasr for
system register access, QAAF for feature queries, and ptff extensions
for guest time handling.

Implement complete sysreg handling for s390 including feature
sanitisation, register enumeration and access, exception injection,
and finalized page fault handling.

The series builds upon the foundation established in the first series and
requires the first series v3[1] as base.

	Steffen

[1] https://lore.kernel.org/lkml/20260529155050.2902245-1-seiden@linux.ibm.com/

Andreas Grapentin (1):
  KVM: arm64: Fix set_oslsr_el1 to write to OSLAR_EL1

Steffen Eiden (25):
  KVM: arm64: Extract some feature related changes to kvm_feature.h
  KVM: arm64: Remove __expand_field_sign_(un)signed
  KVM: arm64: Generalize get_idreg_field_*()
  KVM: arm64: Generalize kvm_cmp_feat_*()
  KVM: arm64: Generalize kvm_has_feat_*
  KVM: arm64: Remove get_idreg_field_*() and kvm_cmp_feat_*()
  KVM: arm64: Remove kvm_has_feat_range
  KVM: arm64: Split up feature sysreg sanitisation
  KVM: arm64: Refactor idreg caching into dedicated structure
  KVM: arm64: Move definitions from sys_regs.c to sys_regs.h
  KVM: arm64: Add PVM_ prefix to avoid name collisions
  s390: Introduce read/write ARM sysreg instructions
  s390: Introduce Query Available Arm features
  s390: Add functions to query arm guest time
  KVM: s390: arm64: Add sysreg related functions and definitions
  arm64: Extract cputype definitions.
  arm64: Extract cache definitions
  KVM: arm64: Share KVM feature detection macros
  KVM: arm64: Share ID reg handling
  KVM: arm64: Share sys-reg handling
  KVM: arm64: Refactor core reg handling
  KVM: s390: arm64: Implement feature sanitisation
  KVM: s390: arm64: Implement sysreg handling
  KVM: s390: arm64: Implement exception injection
  KVM: s390: arm64: Finalize page fault handling

 arch/arm64/include/asm/cache.h                |   19 +-
 arch/arm64/include/asm/cputype.h              |  246 +---
 arch/arm64/include/asm/kvm_emulate.h          |    1 +
 arch/arm64/include/asm/kvm_feature.h          |   27 +
 arch/arm64/include/asm/kvm_host.h             |  137 +-
 arch/arm64/include/asm/kvm_nested.h           |    1 +
 arch/arm64/kvm/arm.c                          |    2 +-
 arch/arm64/kvm/at.c                           |    1 +
 arch/arm64/kvm/config.c                       |    3 +-
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h    |    1 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |    1 +
 arch/arm64/kvm/hyp/nvhe/pkvm.c                |    7 +-
 arch/arm64/kvm/hyp/nvhe/sys_regs.c            |   55 +-
 arch/arm64/kvm/nested.c                       |    2 +-
 arch/arm64/kvm/sys_regs.c                     | 1307 +----------------
 arch/arm64/kvm/sys_regs.h                     |  276 ----
 arch/arm64/kvm/trace_handle_exit.h            |   36 +-
 arch/arm64/kvm/vgic-sys-reg-v3.c              |    2 +-
 arch/arm64/kvm/vgic/vgic-init.c               |    1 +
 arch/arm64/kvm/vgic/vgic.h                    |    1 +
 arch/s390/include/asm/kvm_emulate.h           |   34 +
 arch/s390/include/asm/kvm_feature.h           |  111 ++
 arch/s390/include/asm/kvm_host_arm64.h        |  168 ++-
 arch/s390/include/asm/kvm_host_arm64_types.h  |   97 ++
 arch/s390/include/asm/kvm_nested.h            |    5 +
 arch/s390/include/asm/sae-asm.h               |   48 +
 arch/s390/include/asm/sae.h                   |   86 ++
 arch/s390/include/asm/timex.h                 |   49 +
 arch/s390/kernel/dis.c                        |    1 +
 arch/s390/kernel/time.c                       |    1 +
 arch/s390/kvm/arm64/Makefile                  |    3 +
 arch/s390/kvm/arm64/arm.c                     |   44 +-
 arch/s390/kvm/arm64/exception.c               |  105 ++
 arch/s390/kvm/arm64/feature.c                 |  170 +++
 arch/s390/kvm/arm64/guest.c                   |   20 +-
 arch/s390/kvm/arm64/handle_exit.c             |    1 +
 arch/s390/kvm/arm64/inject_fault.c            |   72 +-
 arch/s390/kvm/arm64/mmu.c                     |   62 +-
 arch/s390/kvm/arm64/reset.c                   |    5 +
 arch/s390/kvm/arm64/sys_regs.c                |  769 ++++++++++
 arch/s390/kvm/arm64/trace.h                   |   33 +
 arch/s390/tools/opcodes.txt                   |    3 +
 include/arch/arm64/asm/cache-defs.h           |   22 +
 .../arch/arm64/asm/cputype-defs.h             |   92 +-
 include/arch/arm64/asm/sysreg-defs.h          |    9 +
 include/kvm/arm64/kvm_feature.h               |   68 +
 include/kvm/arm64/kvm_host.h                  |   52 +
 include/kvm/arm64/sys_regs.h                  |  548 +++++++
 virt/kvm/arm64/Makefile.kvm                   |    1 +
 virt/kvm/arm64/guest.c                        |  100 +-
 virt/kvm/arm64/mmio.c                         |    1 +
 virt/kvm/arm64/sys_regs.c                     | 1039 +++++++++++++
 virt/kvm/arm64/trace.h                        |   34 +
 53 files changed, 3838 insertions(+), 2141 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_feature.h
 delete mode 100644 arch/arm64/kvm/sys_regs.h
 create mode 100644 arch/s390/include/asm/kvm_feature.h
 create mode 100644 arch/s390/include/asm/sae-asm.h
 create mode 100644 arch/s390/kvm/arm64/exception.c
 create mode 100644 arch/s390/kvm/arm64/feature.c
 create mode 100644 arch/s390/kvm/arm64/sys_regs.c
 create mode 100644 arch/s390/kvm/arm64/trace.h
 create mode 100644 include/arch/arm64/asm/cache-defs.h
 copy arch/arm64/include/asm/cputype.h => include/arch/arm64/asm/cputype-defs.h (85%)
 create mode 100644 include/kvm/arm64/kvm_feature.h
 create mode 100644 include/kvm/arm64/sys_regs.h
 create mode 100644 virt/kvm/arm64/sys_regs.c


base-commit: 4095afb932d1a98a6fcb3f4f490964949d0de338
-- 
2.53.0

