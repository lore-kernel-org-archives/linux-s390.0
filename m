Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789456;
	b=zFY6Ft/q5xCFynKAdr4tubpEeTVS4DkdltBHfK/Cz4j6MXoaN0h5VXwmi97k5oR/5R15
	 EY62HNf65ArXcdIEHpeF3lvsFqETCBrfXQTJ3bXoTusjCtXAUQWeZd8e3X7fLvZXSjCuJ
	 UnhEV6I8gdpQZv6IIdnWaX43KrIyXO+HR4KKCbdATr0y5K1SPtdy6hrllX8fx0beB6NKb
	 KZYPF2+snfSeQCTgpq9Gq7uGcnvDnlyIbr7sf9HtJw9TdBjpBYYiIX1eweDD+Wj0O1pQW
	 EKa/DJjlTLYI9NFmvWPAuTIcP7DA86GAZQxnYZQ0rj9XplP/gYxNpLoT73bdWlDhF/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789456;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=I7ipft8ccF5DWs1bN8+TKjsglJrOTii7BfVW/XkIIoY=;
	b=uQ7otHX09XmYqM65lb0uJ2AdqXamHy9MtrghlX+1popD91XG4aJVIy55Spb8N8l7TnOR
	 DqDH7Z72zB0Scko5LPDZ3zSTFwx734AnGxxVM+jZs//Zy3J0Icllf6B7Js4ag+MMe7Gl7
	 Icv0gHovFKSWlGeJw+u9OLgYAf3zOT+WEzBwx+rOgtqhQUH718OSc4aVK+pjtkjqt2ahA
	 X6+n/fvms4VJO+XsTuEl6zFDKV+SsFMHiSS/2e6xBKprjzDaiOfBmfacUOV/C8Ehn1Rq3
	 4wUgvMsofEyB0R9d22+ilaFs5cvjRBhj7Gp0bBMqXDinWJhyz17GfCsaSVoCGsBaZyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="C9CSu/dA";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE07606B197;
	Fri, 27 Nov 2026 14:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FE07606B197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=C9CSu/dA
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4Ysa3266051;
	Fri, 27 Nov 2026 14:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=I7ipft8ccF5DWs1bN8+TKjsglJrO
	Tii7BfVW/XkIIoY=; b=C9CSu/dAJ+d7T19aDQU7zLhG0jlXTkz9iW6fO5Pvsg0b
	jfatzc5g+Sy9LDnTEKEH3b5g4woph9Inp56/90VTIZDI5Grn8kTPDnzdi0yjWf6V
	+HRHdXqs0AffgL90zydZhme9Q0yGUuAJxp82x/QfWvClMe1gfiUH8bOY1pXg9vgG
	tJ8GL0fMaQHxSvDHa/7rJuy8wKSRQGlJDcVbBSUJ5pRo/RSrpdiNHqz+L4uTTIIR
	QRlRruU9HWSvUWKNTapGiWtM3qQlyBIpfZc24tVj3XsJtqrNohAbekmTwfKGp6Rk
	iqzBDvhryaw6RWNhf+WkO3179gNE9H3UkN2lrjD+zw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkx6t3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4H6f3245407;
	Fri, 27 Nov 2026 14:23:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxx950s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARENDZv33161638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 14:23:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8842620063;
	Fri, 27 Nov 2026 14:23:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C39A42005A;
	Fri, 27 Nov 2026 14:23:12 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 14:23:12 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Subject: [PATCH v4 00/25] KVM: s390: arm64: System Registers
Date: Fri, 27 Nov 2026 15:22:03 +0100
Message-Id: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12Pyw6CMBBFf4V07Zi2QHms/A/jotCpTiJFO0A0h
 n+3oit3cyaTc+e+BGMkZNFmLxFxIaYxJCh2megvNpwRyCUWWmqjlDTAT454Bmes87J3eeEKkY5
 vET09NtHx9OWI9zn5pu9SDMhsN1+b/WwlUOAAiwYF3uuqqStrtdKHK4X5sadu2Pfj8NF3lhHSP
 NDUZk2RV4h1Z3pvxCfsQjyN8bmVWPIt7f/fJQcJVYlN2dTSd0r+ZZzWdX0D/vaPpg0BAAA=
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX7BfDXMaJE4yI
 bdsm+8Z/TjrN5C4bP+W4KgySCAZ8dyBwIVswqds5g6JSVd3NXfxkgFQUpM1eiTPEXLmWe4dS0hE
 QMZLvkQ2Rkfuy4siXlqLLXVnKjoBrIJDpbLb8cmwL+s5TMJjtXnAo/aZ8IZMEyl9j1LyfMo6m8w
 6FXFoSI1SI0GmZ8/Oi6pWYV8qFG6idBc5X+N2CU9yemxWzEXXwG8L4NHGYs2MjKOYR0z4Xz1xQd
 a4y+jzHcdsVv5d0y3sYdNGLPPp/fihplfAd90SFb+qApkCwDAqzYt5NhC47gx9KxkLGrMbXxWVp
 Xz27tJAZEAGE0JfH3qICwRFoqt4pGknLEZvbt3EFBGlM5bp4lHnxTYfzUGDeFYVfCA8790MKYV5
 sNaVPgiwW+v8NfA6NB6WYKqyP66Md5BWPjRQxJQAjh/LFQ19K+FDw79DBp2H20ADQjFI4acf6DE
 SOk/WyMfap6z2E+QObQ==
X-Proofpoint-ORIG-GUID: EoOg-8QWHs53qVsuuFrTRhKNfwdhx_8G
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX0PDRse9Cpcq0
 O/et+xDb0EQvHhDh5zL6OcB/3+dsttNHb8Zdk0a+itg6bxQgOj4n7yu7kXcB2ibSO9/ISeDm9RP
 UY2/88gdBFMSh2fPrnG4BSexuZxkXYY=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b099260 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=G9GR8zF88hX0ni67BboA:9 a=tp4kGABQoYN-z-1a:21
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EoOg-8QWHs53qVsuuFrTRhKNfwdhx_8G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270056

Add system register handling for KVM/arm64 on s390. Share KVM/arm64
code, introduce ARM guest management functions for s390 hosts, and
implement host system register & exception handling.

This is the second series on the way to arm64 guests on s390. The first
series laid the KVM foundation (basic module, vCPU run, simple page
faults) and is included in v7.4. This series builds the system register
layer on top and closes the biggest of the remaining gaps towards a
functional guest support.

On top of master this series requires one patch[1] not yet merged in
order to build clean.

The series applies without those patches on master but the build will
fail or trigger warnings w/o those patches.

Regarding merging: 

Patches 1-10 can/should go via the KVM/arm64 tree. Note that PATCH 8 is
an s390 patch but is is required so be at this position. Otherwise, s390
will not compile when patch 10 is applied until patch 18. And I cannot
palce it before as the patch needs some stuff from the just shared
headers in PATCH 07.

Patches 11-25 can then be picked by KVM/s390. Those require the
perquisite patch [1] mentioned above.

A branch  with the prerequisite and this series is available at
kernel.org [2]. Another series may be added on top to that branch soon. 

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
reused by s390 at all. I trust the compiler to remove it. The reduced
churn outweighs this drawback. Since unused function checking is
disabled for shared code [3], sharing more than required does not
introduce warnings once everything is merged.

s390:

Add s390 instruction support for ARM guest management: easr/sasr for
system register access, QAAF for feature queries, and ptff extensions
for guest time handling.

Implement complete sysreg handling for s390 including feature
sanitisation, register enumeration and access, exception injection, and
finalized page fault handling. For now s390 maintains its own sysreg
table but I intend to share the table with arm as soon as possible.

Emulation:

Guest accesses to ID registers are trapped and served from a sanitized
copy of the QAAF query results, using the ID register sanitisation and
finalisation infrastructure shared with arm64. Userspace sees and
controls guest ID registers with the usual semantics. After the first
vCPU run the values are final. All other system registers live in the
SAE save area and are accessed by the host via EASR/SASR, either on
guest traps or through the one-reg/two-reg UAPI. The save area itself is
initialized from the QAAF-provided initial save area.

Exception handling:

Unsupported or invalid guest actions now raise proper arm64 exceptions
instead of failing exits. Page faults beyond the guest's address limits
are injected as address size faults or synchronous external aborts,
mirroring arm64's kvm_handle_guest_abort() injected faults re-enter the
guest with the pending exception instead of exiting to userspace.

Features and userspace:

SVE is offered to guests at 128-bit vector length, backed by s390's
Vector Extension. Pointer authentication is passed through where
hardware support exists. The AEF capabilities are reported under
/sys/firmware/aef/, including the raw QAAF query results.

	Steffen

[1] https://lore.kernel.org/all/20261105-insn-v2-1-ff27987aa212@linux.ibm.com
[2] https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/log/?h=sae

---
Changes in v4:
arm64:
- split up id register refactroing into two: defineing helpers, then
  creating the new struct (marc)
- New patch "arm64: vdso: Define ARM64_S390_COMMON=1 for all vdso builds"
  to fix the arm64 (compat) vDSO build, which dies on -Wundef/-Werror
  when the sharing marker is unset.
- OSLSR conversion: also update the tools copy of sysreg.h

s390:
- The guest PT offset (EPD) is now tracked per-VM instead of per-vcpu.
- vcpu_reset_hcrx() is now non-static, runs after the feature set has
  been restricted (vcpu run pid change), and sets HCRX_EL2_MSCEn
  unconditionally, depending on MOPS
- Feature sanitisation: ARM64_HAS_HCR_NV1 no longer probes
  ID_AA64MMFR4_EL1.E2H0 and reports false, matching the other
  non-emulatable capabilities.
- AEF sysfs: dropped the redundant sae_avail/ptff_avail/edat2_avail
  attributes
- Authorship fixes: range-check asm macro patch is solely authored by
  Jens Remus. SVE patch authorship now credits Friedrich Welter.
- more smaller issues resolved

- Collected Reviewed-by tags from Joey Goulyand rebased onto master
- Link to v3: https://lore.kernel.org/r/20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com

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
Friedrich Welter (1):
      KVM: s390: arm64: Implement SVE for arm guests

Jens Remus (1):
      s390: Add range check asm macro

Steffen Eiden (23):
      KVM: arm64: Route VM ID register accesses through helpers
      KVM: arm64: Refactor idreg caching into dedicated structure
      KVM: arm64: Extract number of sys_reg_desc into a constant
      arm64: sysreg: Convert OSLSR to automatic register generation
      arm64: vdso: Define ARM64_S390_COMMON=1 for all vdso builds
      arm64: Prepare headers for sysreg sharing with s390
      arm64: Share system register related headers and functions with s390
      KVM: s390: arm64: Prepare for sharing arm64 SVE and ftr-reg code
      KVM: arm64: Prepare sys_regs.c for sharing with s390
      KVM: arm64: Share system register code with s390
      s390: tools: Share arm64/kvm headers
      s390: Read/write ARM system registers
      s390: Query arm guest time
      KVM: s390: arm64: Query Available Arm features
      KVM: s390: arm64: Verify machine feature set before loading
      KVM: s390: arm64: Implement feature sanitisation
      KVM: s390: arm64: Implement arm system register managing infrastructure
      KVM: s390: arm64: Integrate system registers into the host
      KVM: s390: arm64: Use QAAF init save area
      KVM: s390: arm64: Implement exception injection
      KVM: s390: arm64: Finalize page fault handling
      KVM: s390: arm64: Promote PTRAUTH capability
      s390: Report AEF features to sysfs

 Documentation/ABI/testing/sysfs-firmware-aef |  51 ++
 arch/arm64/include/asm/cache.h               |   3 +
 arch/arm64/include/asm/cputype.h             |   3 +
 arch/arm64/include/asm/kvm_emulate.h         |   5 +-
 arch/arm64/include/asm/kvm_host.h            | 101 +++-
 arch/arm64/include/asm/spectre.h             |  13 +-
 arch/arm64/include/asm/sysreg.h              |  12 +-
 arch/arm64/kernel/vdso32/Makefile            |   2 +
 arch/arm64/kvm/arm.c                         |   3 +
 arch/arm64/kvm/config.c                      |  12 +-
 arch/arm64/kvm/guest.c                       |  11 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c               |  10 +-
 arch/arm64/kvm/hyp/nvhe/sys_regs.c           |   5 +-
 arch/arm64/kvm/sys_regs.c                    | 113 ++--
 arch/arm64/kvm/sys_regs.h                    |   1 +
 arch/arm64/tools/sysreg                      |  14 +
 arch/s390/include/arm64/kvm_emulate.h        |   2 +
 arch/s390/include/arm64/kvm_hyp.h            |  18 +
 arch/s390/include/arm64/kvm_nested.h         |   5 +
 arch/s390/include/arm64/sys_regs.h           |   9 +
 arch/s390/include/asm/aef.h                  |  12 +
 arch/s390/include/asm/insn-common-asm.h      |  28 +
 arch/s390/include/asm/kvm_host_arm64.h       | 238 +++++++-
 arch/s390/include/asm/kvm_host_arm64_types.h | 115 ++++
 arch/s390/include/asm/sae-asm.h              |  45 ++
 arch/s390/include/asm/sae.h                  |  93 +++
 arch/s390/include/asm/timex.h                |  53 ++
 arch/s390/kernel/Makefile                    |   2 +-
 arch/s390/kernel/aef.c                       | 192 +++++++
 arch/s390/kernel/dis.c                       |   1 +
 arch/s390/kvm/arm64/Makefile                 |   7 +-
 arch/s390/kvm/arm64/Makefile.gen             |   3 +-
 arch/s390/kvm/arm64/arm.c                    | 107 +++-
 arch/s390/kvm/arm64/exception.c              | 109 ++++
 arch/s390/kvm/arm64/feature.c                | 178 ++++++
 arch/s390/kvm/arm64/feature.h                |  97 ++++
 arch/s390/kvm/arm64/guest.c                  | 268 ++++++++-
 arch/s390/kvm/arm64/handle_exit.c            |   1 +
 arch/s390/kvm/arm64/inject_fault.c           |  65 ++-
 arch/s390/kvm/arm64/mmu.c                    |  74 ++-
 arch/s390/kvm/arm64/qaaf.c                   |  85 +++
 arch/s390/kvm/arm64/qaaf.h                   |  12 +
 arch/s390/kvm/arm64/reset.c                  |  72 +++
 arch/s390/kvm/arm64/spectre.c                |  51 ++
 arch/s390/kvm/arm64/sys_regs.c               | 831 +++++++++++++++++++++++++++
 arch/s390/kvm/arm64/trace.h                  |  50 ++
 arch/s390/tools/Makefile.arm64h              |  11 +-
 arch/s390/tools/opcodes.txt                  |   3 +
 include/kvm/arm_arch_timer.h                 |   3 +
 tools/arch/arm64/include/asm/sysreg.h        |  12 +-
 50 files changed, 3052 insertions(+), 159 deletions(-)

base-commit: 9437ee8b6cf607e883b36e44bd755968daaebd48
change-id: 20261106-sysreg-d6adf0cd34d4
prerequisite-message-id: 20261105-insn-v2-1-ff27987aa212@linux.ibm.com
prerequisite-patch-id: ed28ef94c9056cb81bb738f1b54745d012cb613f

