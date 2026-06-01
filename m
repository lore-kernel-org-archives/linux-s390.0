Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E78A3DA7C0;
	Mon,  1 Jun 2026 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329198; cv=none; b=LK9IGDBzEO4BLrYLIbUQiaqsn0b4k7zLXURWGxEuMdFTwY0YAKYCTYzf1PSBf587HyzimpwcOoVF9HhVPM8utKVlsIxYE6LkKOY2PHF1sne2abCN1MRKU9k5YkHTLkkDXw63Ea1NmCpdC6ME2ZQvL7qjifOwihZIH/YaTCe9kuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329198; c=relaxed/simple;
	bh=PnrEukf67GhLri5Qc1JZEk8YVv8PQv4ljqbQ7x5ghUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oS2OsWKynH/cGGZBAdb0/d/JoPbExxpZwjcUZGk0Ks0Hec/xhFRymzGdpX+n+qCIyVRtfDYWmRqTDijZHugVhfPrtihOqq3JA2heEOcBeWGNPGf8yRcAQPTgBLffB2UGfzPNd9LJNEqNoYKAwU9hLFtG/xRnVWCyhJGiEWOTP7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LsZhcbkV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LsZhcbkV"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651AVopZ3662646;
	Mon, 1 Jun 2026 15:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5scKa2
	WGTHxsFXk5ycvWXVQT9CIueGUglRkScoT7Bx4=; b=LsZhcbkV9NIxM6H0cNiHSz
	MLcUg2ihXKrnU6KzNQZ9mXyffyjzd35xaxqPfIhhr9Yy/lAg3GJzEAUvVTgv3OMq
	q7mFZw4WgTkAf6P/y50e3uH9777bZ06A7xG0LczmvHMkl6aKm0p1m2bVP7zFq4gq
	hEZLMm5eJVBuye5kFwi0gmWkAqFAC/CB9ucOtCcZr3mmirzFdvosaRkdH8u7J6K5
	AotCq3tEZ398bmzuxG3jrPujikuMmycZdWgUP0QLbIw7n1XVRc5c81JPOKyNkV2+
	9msqRAYlglUw2oSubpXQyDxImOMrWtFczn7Ug/RTs6HA3Jcl51531GjvslV1Q/9Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjq1jp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 15:52:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Fd5OZ030190;
	Mon, 1 Jun 2026 15:52:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwy6jjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 15:52:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651FqJd223724500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 15:52:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CF9820040;
	Mon,  1 Jun 2026 15:52:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD0EA2004E;
	Mon,  1 Jun 2026 15:52:18 +0000 (GMT)
Received: from p-imbrenda (unknown [9.52.223.175])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon,  1 Jun 2026 15:52:18 +0000 (GMT)
Date: Mon, 1 Jun 2026 17:52:16 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich
 <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Joey Gouly
 <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
        Nico Boehr
 <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch
 <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo
 Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand
 <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon
 <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v1 00/26] KVM: arm64 on s390 System Register Handling
Message-ID: <20260601175216.03c25584@p-imbrenda>
In-Reply-To: <20260529155601.2927240-1-seiden@linux.ibm.com>
References: <20260529155601.2927240-1-seiden@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Mt557e1ApZpJ2gsg3pJz52vcklyZ3oOd
X-Proofpoint-GUID: Mt557e1ApZpJ2gsg3pJz52vcklyZ3oOd
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1daabb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=PyufuR3gDYvOWfpjaVYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE1NiBTYWx0ZWRfX+pJQw3Vu4L1h
 E/IWILvNV/MNNfuiZeTXBKFb1YbzRli6FZFcm0FAN2/J2OBNiz25tirSiLC/VIuBtgiS8+VhNLQ
 P2GdBzyKjhQqVjy3mi8eYpSckwGR/2nTgDQE+gfbf0LvbcYGx2ZdO7UGndFwCiRykgIzncesEwL
 +Kap3bd7RWQvXNuoZuXkV3KGN3rXA0GhW04BzgawFV3PeQwLt8AoMA4t5KsPKnq2qxL1PVMIAsl
 gn7SWi7zmeoV2r4omDx9ad6rQm5ZTcIaCa+AZTEs08iInp4ZEfWMY3Yiyv2IDJuZU0D5K61TXt2
 dZSqBMXWbKKzdL0DTfoG89czlz75Cq6CWCIDuWG+ysc8gtPzu3jt+7+LFVIHtvHVJGYhq++Ph7q
 Jm8gBiBa28OOTGMcAXEzhHYLnirSR00n6yZvE+69CkAizI/C1Ou27Mwl19ft1xz7+SWtOin1oKq
 huiQK5uyyeSEXk24Tiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010156

On Fri, 29 May 2026 17:55:33 +0200
Steffen Eiden <seiden@linux.ibm.com> wrote:

> Add system register handling for KVM/arm64 on s390. Restructure and share
> KVM/arm64 code, introduce ARM guest management functions for s390 hosts,
> and implement host sysreg & exception handling.
> 
> Changes in detail:
> 
> arm64:
> 
> Refactor arm64 feature detection and ID register handling to make it
> generic and reusable across architectures.
> 
> Restructure ID register storage and core register handling. Refactor core
> registers to use functions instead of direct memory access.
> 
> Move arm64-specific definitions (CPU types, cache, KVM features, ID
> registers, system registers) to shared locations for reuse by other
> architectures.
> 
> s390:
> 
> Add s390 instruction support for ARM guest management: easr/sasr for
> system register access, QAAF for feature queries, and ptff extensions
> for guest time handling.
> 
> Implement complete sysreg handling for s390 including feature
> sanitisation, register enumeration and access, exception injection,
> and finalized page fault handling.
> 
> The series builds upon the foundation established in the first series and
> requires the first series v3[1] as base.

the series is now conveniently available on the  sae  branch on
https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git

> 
> 	Steffen
> 
> [1] https://lore.kernel.org/lkml/20260529155050.2902245-1-seiden@linux.ibm.com/
> 
> Andreas Grapentin (1):
>   KVM: arm64: Fix set_oslsr_el1 to write to OSLAR_EL1
> 
> Steffen Eiden (25):
>   KVM: arm64: Extract some feature related changes to kvm_feature.h
>   KVM: arm64: Remove __expand_field_sign_(un)signed
>   KVM: arm64: Generalize get_idreg_field_*()
>   KVM: arm64: Generalize kvm_cmp_feat_*()
>   KVM: arm64: Generalize kvm_has_feat_*
>   KVM: arm64: Remove get_idreg_field_*() and kvm_cmp_feat_*()
>   KVM: arm64: Remove kvm_has_feat_range
>   KVM: arm64: Split up feature sysreg sanitisation
>   KVM: arm64: Refactor idreg caching into dedicated structure
>   KVM: arm64: Move definitions from sys_regs.c to sys_regs.h
>   KVM: arm64: Add PVM_ prefix to avoid name collisions
>   s390: Introduce read/write ARM sysreg instructions
>   s390: Introduce Query Available Arm features
>   s390: Add functions to query arm guest time
>   KVM: s390: arm64: Add sysreg related functions and definitions
>   arm64: Extract cputype definitions.
>   arm64: Extract cache definitions
>   KVM: arm64: Share KVM feature detection macros
>   KVM: arm64: Share ID reg handling
>   KVM: arm64: Share sys-reg handling
>   KVM: arm64: Refactor core reg handling
>   KVM: s390: arm64: Implement feature sanitisation
>   KVM: s390: arm64: Implement sysreg handling
>   KVM: s390: arm64: Implement exception injection
>   KVM: s390: arm64: Finalize page fault handling
> 
>  arch/arm64/include/asm/cache.h                |   19 +-
>  arch/arm64/include/asm/cputype.h              |  246 +---
>  arch/arm64/include/asm/kvm_emulate.h          |    1 +
>  arch/arm64/include/asm/kvm_feature.h          |   27 +
>  arch/arm64/include/asm/kvm_host.h             |  137 +-
>  arch/arm64/include/asm/kvm_nested.h           |    1 +
>  arch/arm64/kvm/arm.c                          |    2 +-
>  arch/arm64/kvm/at.c                           |    1 +
>  arch/arm64/kvm/config.c                       |    3 +-
>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h    |    1 +
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c            |    1 +
>  arch/arm64/kvm/hyp/nvhe/pkvm.c                |    7 +-
>  arch/arm64/kvm/hyp/nvhe/sys_regs.c            |   55 +-
>  arch/arm64/kvm/nested.c                       |    2 +-
>  arch/arm64/kvm/sys_regs.c                     | 1307 +----------------
>  arch/arm64/kvm/sys_regs.h                     |  276 ----
>  arch/arm64/kvm/trace_handle_exit.h            |   36 +-
>  arch/arm64/kvm/vgic-sys-reg-v3.c              |    2 +-
>  arch/arm64/kvm/vgic/vgic-init.c               |    1 +
>  arch/arm64/kvm/vgic/vgic.h                    |    1 +
>  arch/s390/include/asm/kvm_emulate.h           |   34 +
>  arch/s390/include/asm/kvm_feature.h           |  111 ++
>  arch/s390/include/asm/kvm_host_arm64.h        |  168 ++-
>  arch/s390/include/asm/kvm_host_arm64_types.h  |   97 ++
>  arch/s390/include/asm/kvm_nested.h            |    5 +
>  arch/s390/include/asm/sae-asm.h               |   48 +
>  arch/s390/include/asm/sae.h                   |   86 ++
>  arch/s390/include/asm/timex.h                 |   49 +
>  arch/s390/kernel/dis.c                        |    1 +
>  arch/s390/kernel/time.c                       |    1 +
>  arch/s390/kvm/arm64/Makefile                  |    3 +
>  arch/s390/kvm/arm64/arm.c                     |   44 +-
>  arch/s390/kvm/arm64/exception.c               |  105 ++
>  arch/s390/kvm/arm64/feature.c                 |  170 +++
>  arch/s390/kvm/arm64/guest.c                   |   20 +-
>  arch/s390/kvm/arm64/handle_exit.c             |    1 +
>  arch/s390/kvm/arm64/inject_fault.c            |   72 +-
>  arch/s390/kvm/arm64/mmu.c                     |   62 +-
>  arch/s390/kvm/arm64/reset.c                   |    5 +
>  arch/s390/kvm/arm64/sys_regs.c                |  769 ++++++++++
>  arch/s390/kvm/arm64/trace.h                   |   33 +
>  arch/s390/tools/opcodes.txt                   |    3 +
>  include/arch/arm64/asm/cache-defs.h           |   22 +
>  .../arch/arm64/asm/cputype-defs.h             |   92 +-
>  include/arch/arm64/asm/sysreg-defs.h          |    9 +
>  include/kvm/arm64/kvm_feature.h               |   68 +
>  include/kvm/arm64/kvm_host.h                  |   52 +
>  include/kvm/arm64/sys_regs.h                  |  548 +++++++
>  virt/kvm/arm64/Makefile.kvm                   |    1 +
>  virt/kvm/arm64/guest.c                        |  100 +-
>  virt/kvm/arm64/mmio.c                         |    1 +
>  virt/kvm/arm64/sys_regs.c                     | 1039 +++++++++++++
>  virt/kvm/arm64/trace.h                        |   34 +
>  53 files changed, 3838 insertions(+), 2141 deletions(-)
>  create mode 100644 arch/arm64/include/asm/kvm_feature.h
>  delete mode 100644 arch/arm64/kvm/sys_regs.h
>  create mode 100644 arch/s390/include/asm/kvm_feature.h
>  create mode 100644 arch/s390/include/asm/sae-asm.h
>  create mode 100644 arch/s390/kvm/arm64/exception.c
>  create mode 100644 arch/s390/kvm/arm64/feature.c
>  create mode 100644 arch/s390/kvm/arm64/sys_regs.c
>  create mode 100644 arch/s390/kvm/arm64/trace.h
>  create mode 100644 include/arch/arm64/asm/cache-defs.h
>  copy arch/arm64/include/asm/cputype.h => include/arch/arm64/asm/cputype-defs.h (85%)
>  create mode 100644 include/kvm/arm64/kvm_feature.h
>  create mode 100644 include/kvm/arm64/sys_regs.h
>  create mode 100644 virt/kvm/arm64/sys_regs.c
> 
> 
> base-commit: 4095afb932d1a98a6fcb3f4f490964949d0de338

