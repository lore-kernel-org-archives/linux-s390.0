Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169E4408602;
	Mon, 31 Aug 2026 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188209; cv=none; b=GkYg3JbKrAUNiLhcVV+nreio+KX5Fa9C+Tb4QbjRG0zme6lnxAFawJFGnQicl53NbTXb5u+smWM0WOIsQrOiW/mDmM49tyVoFAq3gVfDjOjSzC7p7+5ST1656xvOKtxPs/kM60Y3WHuIbCPSM5me+RHW8hE6h7b3ED6oDjd6ApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188209; c=relaxed/simple;
	bh=WZjamilbCMJPaTTbvjkSxyv/scS+RGLVZu4hRj1Tp+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=an3hiKgwnlMlXXmAfF+6YtdPhVJZvhCvYBSZz+SNdMFh6OEQvwp92YIiHmnZqLgcXN5zWqBlGs+DAVHuNHfjX8/bqMxYAeq5o1TmBVUttsCR7v+o5iYjSG/1ldn8CHtSrg4TO6WF94UXwqqsmwTEnBGvhKX79Gx88EW22mvdeYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JVcwVY35; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JVcwVY35"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZO9S2583494;
	Mon, 31 Aug 2026 14:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=jqRJhkvqT1GsTrtGqK3664E13XbR/rXj6jqyCh2zY
	jY=; b=JVcwVY35n4jwqEA0UWuDiKZ9x3gg+OsGgaDZMwHKCNhCb6ny3l6mRyq4H
	yQcdFtB779GwIwUGQFvITeZAEMCe7xfyDCYjOokxLkOddE4dU+5ZQ/4xNNXcky6J
	m4ROX6aEh57yj8j2Zc6hbQZin66hDFmsLIqKf05TF/bDa/EO6xi0MXelPVYFQVw4
	rcyqfV4UaBPfF7bkAk8f3TiOac4goG+67TjWkA6ACAPiIhEvHifwLFAtTOv9+jPR
	X5UrSvIibgRoXbokLX0v33YTXJEjaYhLE9zXkfXE7/zLnKtOcPqWIcihV4wgsPyg
	dzz+PqVAPf6MTyyXT0lmHp3fOH7KA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t1u9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfgY9016964;
	Mon, 31 Aug 2026 14:55:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h6dp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEtbAZ16122264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:55:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 623AB20043;
	Mon, 31 Aug 2026 14:55:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE8FD20040;
	Mon, 31 Aug 2026 14:55:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:55:36 +0000 (GMT)
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
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
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
Subject: [PATCH v2 00/20] KVM: arm64 on s390 System Register Handling
Date: Mon, 31 Aug 2026 16:55:15 +0200
Message-ID: <20260831145536.913567-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a9595f1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=EfswLKZZKe3xjtufmi4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX/ptxmNmaUZLq
 YyLjS+vnjR8bdNRIthOyGpGtPX7R2UOFeXT7drKghjhhmn9SM1sXQ5Hcw/Otfdbv6hG8FfsIzBq
 +15SXukCbLp5Tf9Pkn2/1nx9Tvq9z9A=
X-Proofpoint-ORIG-GUID: tJk3lHyBuCvFyK4D4Jm4WJo_l80TsR5g
X-Proofpoint-GUID: PpKGMHsad5exdoUBflKzHUK-XjjSTErS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX/F0k6ufohfpi
 sNIX5dnxVHYr97GY/wHpjiYKI48RDKSVfU3P5s1vXw4IF1lIS1URRjA/WN9sZeRfAxD+X7lPJpU
 HucYtaqXGj4UJmdPGRtR3FrxtbSDGurpIfLFMlEaRX3FyEDLKiS8B4jS+IXnCjsSOdSczdhhLxa
 S4enEBWnRJ+s+fFvNZqS6nE7gKRpC0m/BM9hmC6SpOomp4fmbsiF4Dyki5A/8ZWZhCoP2qi+pCW
 H2JH665DnZEJrgziNuP0GPDqZdLTn7rULDyePay9gOhAMGB5D1Ip8KM0PwP/JETzqBMBKnk/to9
 /V779lnMM+Zg6Yd1EmZufXGMYYovQBX3YrGYR+MDT4zUtUB0Lok/63B1bgasDjvq+bqAenaQdmJ
 4VQYy3UTnKT90mA4ZePwjHDJBON3ioIwwaRtOueE+1kyxtQuf5ESM2NdZ+plu4BzXDnC1yofonq
 C4Yom/xKV4pb/tjQofw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310125

Add system register handling for KVM/arm64 on s390. Share KVM/arm64 code,
introduce ARM guest management functions for s390 hosts, and implement host
sysreg & exception handling.

This is a complete rework of v1 using sharing markers and not moving code to a
shared location.

Changes in detail:

arm64:

Refactor the id register fields in arch_vcpu into a dedicated structure such
that it can be reused by s390. Refactor detection of the number of sysregs.
Mark sysreg related code as shared.

s390:

Add s390 instruction support for ARM guest management: easr/sasr for
system register access, QAAF for feature queries, and ptff extensions
for guest time handling.

Implement complete sysreg handling for s390 including feature
sanitisation, register enumeration and access, exception injection,
and finalized page fault handling.

The series builds upon the foundation established in the first series and
requires the first series v7[1] as base. A branch at kernel.org is available [2].

Some in-between steps will trigger compile warnings (mostly unused warnings in
shared code) but of course always compile. After the last commit of this series
will trigger no compiler warnings.

	Steffen

[1] https://lore.kernel.org/all/20260831144802.834315-1-seiden@linux.ibm.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/log/?h=sae

Steffen Eiden (20):
  KVM: arm64: Refactor idreg caching into dedicated structure
  KVM: arm64: Extract number of sys_reg_desc into a constant
  arm64: sysreg: Define OSLSR_EL1_OSLK_MASK
  arm64: Share more arm64 headers with s390
  KVM: s390: arm64: Prepare for sharing more arm64 code
  KVM: arm64: Prepare sys_regs.c for sharing with s390
  KVM: arm64: Share more arm64 code with s390
  s390: tools: Allow sharing arm64/kvm headers
  s390: Introduce read/write ARM sysreg instructions
  s390: Add functions to query arm guest time
  KVM: s390: arm64: Query Available Arm features
  KVM: s390: arm64: Implement feature sanitisation
  KVM: s390: arm64: Implement arm sysreg managing infrastructure
  KVM: s390: arm64: Integrate sysreg into the host
  KVM: s390: arm64: Use QAAF init save area
  KVM: s390: arm64: Implement exception injection
  KVM: s390: arm64: Finalize page fault handling
  KVM: s390: arm64: Implement SVE for arm guests
  KVM: s390: arm64: Promote PTRAUTH capability
  s390: Report AEF features to sysfs

 arch/arm64/include/asm/cache.h               |   3 +
 arch/arm64/include/asm/cputype.h             |   3 +
 arch/arm64/include/asm/kvm_emulate.h         |   5 +-
 arch/arm64/include/asm/kvm_host.h            |  68 +-
 arch/arm64/include/asm/spectre.h             |   7 +
 arch/arm64/include/asm/sysreg.h              |   1 +
 arch/arm64/kvm/arm.c                         |   3 +
 arch/arm64/kvm/config.c                      |   2 +-
 arch/arm64/kvm/guest.c                       |  11 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c               |   7 +-
 arch/arm64/kvm/hyp/nvhe/sys_regs.c           |   4 +-
 arch/arm64/kvm/sys_regs.c                    | 164 ++--
 arch/arm64/kvm/sys_regs.h                    |   1 +
 arch/s390/include/arm64/kvm_hyp.h            |  18 +
 arch/s390/include/arm64/kvm_nested.h         |   5 +
 arch/s390/include/arm64/sys_regs.h           |   9 +
 arch/s390/include/asm/aef.h                  |  28 +
 arch/s390/include/asm/kvm_host_arm64.h       | 237 +++++-
 arch/s390/include/asm/kvm_host_arm64_types.h | 111 +++
 arch/s390/include/asm/sae-asm.h              |  48 ++
 arch/s390/include/asm/sae.h                  |  83 ++
 arch/s390/include/asm/timex.h                |  49 ++
 arch/s390/kernel/Makefile                    |   2 +-
 arch/s390/kernel/aef.c                       | 187 +++++
 arch/s390/kernel/dis.c                       |   1 +
 arch/s390/kvm/arm64/Makefile                 |   5 +
 arch/s390/kvm/arm64/Makefile.gen             |   1 +
 arch/s390/kvm/arm64/arm.c                    |  73 +-
 arch/s390/kvm/arm64/exception.c              | 105 +++
 arch/s390/kvm/arm64/feature.c                | 190 +++++
 arch/s390/kvm/arm64/feature.h                | 102 +++
 arch/s390/kvm/arm64/guest.c                  | 222 +++++-
 arch/s390/kvm/arm64/handle_exit.c            |   1 +
 arch/s390/kvm/arm64/inject_fault.c           |  73 +-
 arch/s390/kvm/arm64/mmu.c                    |  68 +-
 arch/s390/kvm/arm64/qaaf.c                   |  74 ++
 arch/s390/kvm/arm64/qaaf.h                   |  11 +
 arch/s390/kvm/arm64/reset.c                  |  69 +-
 arch/s390/kvm/arm64/spectre.c                |  14 +
 arch/s390/kvm/arm64/sys_regs.c               | 750 +++++++++++++++++++
 arch/s390/kvm/arm64/trace.h                  |  51 ++
 arch/s390/tools/Makefile.arm64h              |  11 +-
 arch/s390/tools/opcodes.txt                  |   3 +
 43 files changed, 2724 insertions(+), 156 deletions(-)
 create mode 100644 arch/s390/include/arm64/kvm_hyp.h
 create mode 100644 arch/s390/include/arm64/sys_regs.h
 create mode 100644 arch/s390/include/asm/aef.h
 create mode 100644 arch/s390/include/asm/sae-asm.h
 create mode 100644 arch/s390/kernel/aef.c
 create mode 100644 arch/s390/kvm/arm64/exception.c
 create mode 100644 arch/s390/kvm/arm64/feature.c
 create mode 100644 arch/s390/kvm/arm64/feature.h
 create mode 100644 arch/s390/kvm/arm64/qaaf.c
 create mode 100644 arch/s390/kvm/arm64/qaaf.h
 create mode 100644 arch/s390/kvm/arm64/spectre.c
 create mode 100644 arch/s390/kvm/arm64/sys_regs.c


base-commit: ab80750cee6e09e0036ac43f257059122a05a71d
-- 
2.53.0

