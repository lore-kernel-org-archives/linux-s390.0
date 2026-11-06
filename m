Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981327;
	b=Wzj9hORB9CMgRnQ4p+EZjMIWnYKosqNw5VFrmKryCqZVnt9p9x4+rr1s5NoYdgQbsqYI
	 Py22iKKTDedhLgY0XxBENes+rbBTK/aHaFtDXDWfCutNCqXX16eQZDMjT5+YQQzTZKu2P
	 bgUiuUaG2gpBdJNhianyZhdA0dlfF3uVAqZPShleW62MnVF4L7JrXEm7ta4Qmk9cQbcUl
	 koeKUbPwTCmlZufvnT8/2iIL6e0HamaoQ9XgTppoyThYC2s96A6S1TyL77cuaz7rBh33v
	 sJCKOe5wmXMuWor6bP/0IrlloFSYnUXXOj0bG20rguknHZAyyMXyGbnuYl0dkdfJsFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981327;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/dP4aEks1fyriMp468Oxpw0W1XOkgZkRNh9psiSBnLI=;
	b=L5fjd7h/VkAZLCE9N2uc6fI7WoPCJQA5rOV8eFebCjUqXfnC4pMw1WymmgyZ7pIXP/Ro
	 L/Tsdbvkdj8bvDB0NoX9tvUjYlIeivlLv0lTSug0QCAL92cd1VqxyPRdMQ2XCw2nvEeTk
	 5+XptYf1IvLw0lVNUiD5sJxn/Y26bpYWENfLDSLxh0u/GppEIYkmKPOOQulVE9lIB/b4t
	 5v3xKRzPnvhkIjc1OfLs2J2q/8pM2asjOooNZTfpYTOGYR3eCCxpGUS3XDUzwg1MCz4Ou
	 WuB4ybL5Iq4NAjK9OR9Dj3JrJfhYHYfQ3Qm5On2oECVcJx7FqAeFfJGaEjqz1RnJu7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FZfnxBIJ;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A2E606A335;
	Fri,  6 Nov 2026 16:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3A2E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FZfnxBIJ
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEcJF2936351;
	Fri, 6 Nov 2026 16:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=/dP4aEks1fyriMp468Oxpw0W1XOk
	gZkRNh9psiSBnLI=; b=FZfnxBIJe/bTE55kd5Qk0eUW9NBn7vZTodw1ckvNKxpf
	u7HVT6JJyVNWML7Rilw9LCiqAE2oSYp2iQ+GcHONA5UFRXEd23BmXdXFgemx0NML
	znVzNCsbTzr9mG+F/w+B9pjtSqmsMHrREJgEyvKcqXbxVV8oqitIa+/5dkl5Q8Eu
	hjpUUtlS2+BnknW6Us9X59qeYtA7+GXzxnqsCxqLuN3MxjKT8YVbyixz5obR+c2a
	RQBzniY078mTV9YAl4U+pJrv7wU6FZjys+rE/3ElyoK03FnDc7Os2F1RutIhMoNk
	HLTXwlT3SVwHdfbj9WS3/vfDb+U8+5wUcpm25LI4JA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rcdhfh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FKC8Y3577994;
	Fri, 6 Nov 2026 16:08:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqv1v871c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6G8DTI43123118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:08:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D689D2004F;
	Fri,  6 Nov 2026 16:08:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60B512004B;
	Fri,  6 Nov 2026 16:08:13 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:08:13 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Subject: [PATCH v3 00/23] KVM: arm64 on s390 System Register Handling
Date: Fri, 06 Nov 2026 17:07:33 +0100
Message-Id: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42QzW7DIBCEX8Xi3LUA2/jnlPeoIgvDkqIWkrIxS
 hXl3Uvs3tpDbzurnW9Hc2eEySOxqbqzhNmTP8cimpeKmTcdTwjeFs0kl0oIroC+KOEJrNLWcWO
 b1rasHF8SOn/bQK/HXSf8XAvvui9ZQCK98abqh9YANSOfdQqqnd9zmAtivRBkARykMI1yaO3QD
 4cPH9db7ZdQm3N4/vuD1oGPFCFLEOCc7Meh11oK+U/zXkSxbhnkM4SArnPdiMq0pl9+cxZNCGU
 O/jpVua9bSEaw4+PxDUeZLWRXAQAA
X-Change-ID: 20261106-sysreg-d6adf0cd34d4
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FiGXOlQOLrJnB4YX0otAKtKTNMqu476Y
X-Authority-Analysis: v=2.4 cv=A635rKWG c=1 sm=1 tr=0 ts=6aedfb77 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=wOoSFcw9qmqRSFHi1-gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FiGXOlQOLrJnB4YX0otAKtKTNMqu476Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfXwLsAYE5GmRyV
 MVtu/PXc7WLqXmdrTzb/jAanAUY92aKcIzfdXfGI/t3SS9y51bC5QLV/6pfqaK391T2wUUv5vtP
 ngdFeXRHHHHBKpK7XKumk+IIz1MfMP/TMcH0hy1ZG9NK4BmUmtJ5YJgqS2FwyZrUhn7uwrR9JF8
 iPBYE5ddvvg8DCY5KgsA6nmGqnFq3wpfKlrWAhvIbrGQPY2Hgrk1T8S8TP5+FVTzv958awea5Wk
 ZyykhbgdXpob2SKCUy2Msi72OMlG8USuCNh7m8cBj0FWglH5hvST9A36StDb8w3frcl64fxGTbg
 yBR0CVOYBmvroRItz44e0xrrbBoRjwHJS4X2eFDEWBT5QyLKfmLmhaUHcQ4KMndrQdX0c8Qv1Qp
 WL10w+CqoLHpws8tR5/Eud5irkSs9yWySj/jEjZy3gDW0rRXO+bXswLxUzx6myTiEAT8ijvq3AK
 7EJy1RHlyQwoBdNE1vA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX2bbMwCvzbDWr
 sJg0HxUJuubdWE3fU9z7U30XHW2yJ9kxfl1MOqOTkOqicikn8t2s0VykRiXBPsEsoIQfVPAWGbH
 svImrzu++cl6Tki0Q+D0sDu/sU/yxv0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060062

Add system register handling for KVM/arm64 on s390. Share KVM/arm64
code, introduce ARM guest management functions for s390 hosts, and
implement host system register & exception handling.

This is the second series on the way to arm64 guests on s390. The first
series laid the KVM foundation (basic module, vCPU run, simple page
faults) and is included in v7.4. This series builds the system register
layer on top and closes the biggest of the remaining gaps towards a
functional guest support.

This series requires 5 fixup patches not yet merged in order to build
clean.

[PATCH 0/3] KVM: s390: arm64: Fixes for arm64 KVM support [0]
[PATCH v2] s390: Guard emitting assembler macros for insn-common-asm.h [1]
[PATCH] KVM: s390: arm64: Tolerate unused functions in extracted source [2]

The series applies without those patches on 7.4-rc1 but the build will
fail or trigger warnings w/o those patches.

Changes in detail:

arm64:

Refactor the id register fields in arch_vcpu into a dedicated structure
such that it can be reused by s390. Refactor detection of the number of
sysregs. Mark sysreg related code as shared.

A few code pieces are moved inside arm headers/code to reduce the amount
of shared sections. This adds a bit of churn in the diff but reduces the
shared marker __churn__ at the end.

The shared regions deliberately contain more code and more headers than
s390 currently needs. Larger contiguous regions mean less churn whenever
the surrounding arm64 code changes. Some of this code will be used by
later series anyways. Some of the shared code will probably never be
reused by s390 at all; I trust the compiler to remove it. The reduced
churn outweighs this drawback. Since unused function checking is
disabled for shared code [3], sharing more than required does not
introduce warnings once everything is merged.

s390:

Add s390 instruction support for ARM guest management: easr/sasr for
system register access, QAAF for feature queries, and ptff extensions
for guest time handling.

Implement complete sysreg handling for s390 including feature
sanitisation, register enumeration and access, exception injection,
and finalized page fault handling.

Emulation:

Guest accesses to ID registers are trapped and served from a sanitized
copy of the QAAF query results, using the ID register sanitisation and
finalisation infrastructure shared with arm64. Userspace sees and
controls guest ID registers with the usual semantics; after the first
vCPU run the values are final. All other system registers live in the
SAE save area and are accessed by the host via EASR/SASR, either on
guest traps or through the one-reg/two-reg UAPI. The save area itself is
initialized from the QAAF-provided initial save area.

Exception handling:

Unsupported or invalid guest actions now raise proper arm64 exceptions
instead of failing exits. Page faults beyond the guest's address limits
are injected as address size faults or synchronous external aborts,
mirroring arm64's kvm_handle_guest_abort(); injected faults re-enter the
guest with the pending exception instead of exiting to userspace.

Features and userspace:

SVE is offered to guests at 128-bit vector length, backed by s390's
Vector Extension, and pointer authentication is passed through where
hardware support exists. The AEF capabilities are reported under
/sys/firmware/aef/, including the raw QAAF query results; the interface
is documented in Documentation/ABI.

For merging we will need a feature branch.

A branch  with patches [0,1,2] + this series is available at
kernel.org [3].

	Steffen

[0] https://lore.kernel.org/all/20261103-s390_arm64_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com/
[1] https://lore.kernel.org/all/20261105-insn-v2-1-ff27987aa212@linux.ibm.com
[2] https://lore.kernel.org/all/20261105-series1-fixups2-v1-1-55f59e6c4c7b@linux.ibm.com
[3] https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/log/?h=sae

---
Changes in v3:
- rebase into 7.4-rc2 (including the first batch of arm on s390 patches)
- guard style changed from `#ifdef ARM64_S390_COMMON` to `#if ARM64_S390_COMMON == 1`
- Improve and clarify commit messages
 arm64:
- generate OSLSR definitions
- consolidate more shared sections by:
  - moving some code in beforehand
  - deliberately adding more code/header than required.
    due to [3] there will not be any unused warnings when merged.
- reduce sharing churn

s390
- streamline sasr/easr instruction generation and use
- aef_info() aggregate removed; new minimal aef_usable()/aef_gisrsa() API
- qaaf enum numbering reorganized, on reserved field was incorrectly
  identified as a register.
- aef.c no longer aggregates or gates on CONFIG_KVM_S390_ARM64.
- spectre.c stubs replaced with real queries of sanitized ID regs.
- Many new sys_reg_descs entries
- QAAF init save area: save area now memcpy'd from cached aef_gisrsa()
  instead of kvm_vcpu_init_save_area()
- improved pagefault handling
- reworked SVE helpers
- fixed various smaller bugs
- Link to v2: https://lore.kernel.org/all/20260831145536.913567-1-seiden@linux.ibm.com/

Changes in v2:
- rework the entire sharing code concept to use marker instead of moving
  code.

---
Steffen Eiden (23):
      KVM: arm64: Refactor idreg caching into dedicated structure
      KVM: arm64: Extract number of sys_reg_desc into a constant
      arm64: sysreg: Convert OSLSR to automatic register generation
      arm64: Prepare headers for sysreg sharing with s390
      arm64: Share system register related headers and functions with s390
      KVM: s390: arm64: Prepare for sharing arm64 SVE and ftr-reg code
      KVM: arm64: Prepare sys_regs.c for sharing with s390
      KVM: arm64: Share system register code with s390
      s390: tools: Share arm64/kvm headers
      s390: Add range check asm macro
      s390: Read/write ARM system registers
      s390: Query arm guest time
      KVM: s390: arm64: Query Available Arm features
      KVM: s390: arm64: Verify machine feature set before loading
      KVM: s390: arm64: Implement feature sanitisation
      KVM: s390: arm64: Implement arm sysreg managing infrastructure
      KVM: s390: arm64: Integrate sysreg into the host
      KVM: s390: arm64: Use QAAF init save area
      KVM: s390: arm64: Implement exception injection
      KVM: s390: arm64: Finalize page fault handling
      KVM: s390: arm64: Implement SVE for arm guests
      KVM: s390: arm64: Promote PTRAUTH capability
      s390: Report AEF features to sysfs

 Documentation/ABI/testing/sysfs-firmware-aef |  70 +++
 arch/arm64/include/asm/cache.h               |   3 +
 arch/arm64/include/asm/cputype.h             |   3 +
 arch/arm64/include/asm/kvm_emulate.h         |   5 +-
 arch/arm64/include/asm/kvm_host.h            |  64 ++-
 arch/arm64/include/asm/spectre.h             |  13 +-
 arch/arm64/include/asm/sysreg.h              |  12 +-
 arch/arm64/kvm/arm.c                         |   3 +
 arch/arm64/kvm/config.c                      |  10 +-
 arch/arm64/kvm/guest.c                       |  11 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c               |   7 +-
 arch/arm64/kvm/hyp/nvhe/sys_regs.c           |   4 +-
 arch/arm64/kvm/sys_regs.c                    | 109 ++--
 arch/arm64/kvm/sys_regs.h                    |   1 +
 arch/arm64/tools/sysreg                      |  14 +
 arch/s390/include/arm64/kvm_hyp.h            |  18 +
 arch/s390/include/arm64/kvm_nested.h         |   5 +
 arch/s390/include/arm64/sys_regs.h           |   9 +
 arch/s390/include/asm/aef.h                  |  12 +
 arch/s390/include/asm/insn-common-asm.h      |  28 +
 arch/s390/include/asm/kvm_host_arm64.h       | 237 +++++++-
 arch/s390/include/asm/kvm_host_arm64_types.h | 115 ++++
 arch/s390/include/asm/sae-asm.h              |  45 ++
 arch/s390/include/asm/sae.h                  |  93 +++
 arch/s390/include/asm/timex.h                |  53 ++
 arch/s390/kernel/Makefile                    |   2 +-
 arch/s390/kernel/aef.c                       | 207 +++++++
 arch/s390/kernel/dis.c                       |   1 +
 arch/s390/kvm/arm64/Makefile                 |   7 +-
 arch/s390/kvm/arm64/Makefile.gen             |   3 +-
 arch/s390/kvm/arm64/arm.c                    | 101 +++-
 arch/s390/kvm/arm64/exception.c              | 109 ++++
 arch/s390/kvm/arm64/feature.c                | 188 ++++++
 arch/s390/kvm/arm64/feature.h                |  97 ++++
 arch/s390/kvm/arm64/guest.c                  | 268 ++++++++-
 arch/s390/kvm/arm64/handle_exit.c            |   1 +
 arch/s390/kvm/arm64/inject_fault.c           |  65 ++-
 arch/s390/kvm/arm64/mmu.c                    |  74 ++-
 arch/s390/kvm/arm64/qaaf.c                   |  85 +++
 arch/s390/kvm/arm64/qaaf.h                   |  12 +
 arch/s390/kvm/arm64/reset.c                  |  71 +++
 arch/s390/kvm/arm64/spectre.c                |  51 ++
 arch/s390/kvm/arm64/sys_regs.c               | 826 +++++++++++++++++++++++++++
 arch/s390/kvm/arm64/trace.h                  |  50 ++
 arch/s390/tools/Makefile.arm64h              |  11 +-
 arch/s390/tools/opcodes.txt                  |   3 +
 include/kvm/arm_arch_timer.h                 |   3 +
 47 files changed, 3030 insertions(+), 149 deletions(-)

base-commit: bc71431221f5ba8bb33918399552636e059c2c45
change-id: 20261106-sysreg-d6adf0cd34d4
prerequisite-message-id: 20261103-s390_arm64_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com
prerequisite-patch-id: 93d5fe93939c707a0d0c57a847270c706a9bae29
prerequisite-patch-id: af10f106ab88b2632aa77e739bf8f64e8f3b5499
prerequisite-patch-id: cf8d158bdbb43de4ae2d524efe9005f9e42ead1f
prerequisite-message-id: 20261105-insn-v2-1-ff27987aa212@linux.ibm.com
prerequisite-patch-id: ed28ef94c9056cb81bb738f1b54745d012cb613f
prerequisite-message-id: 20261105-series1-fixups2-v1-1-55f59e6c4c7b@linux.ibm.com
prerequisite-patch-id: a1648acb9dedea7550a5bfcce937a21016d569a8

