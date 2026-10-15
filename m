Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804733AAF42;
	Thu, 15 Oct 2026 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084329; cv=none; b=lx/v8U7m1yK68StU5EZJg7z5sH6IqUjOMLuROGcPMvB1KFiy+VdorM90TdN6TTLC08iP3mrKaq450WEyNCrLAnM4u/NcH8TiiT1fR0DB8dwAXrRs8sPqhqtd59xyY7V3pyBUxZkkP00Ohf1zQY+7UP7hfoExZlkWiQEtPemVoQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084329; c=relaxed/simple;
	bh=sedMkyz1/6r+v9BYxI2T82jNuve8cAUmkRvl9UYxbeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pbVoE3IWbO3Nd22JdIvHG3JtCSSZLe8O8yCvPjeOOhPWJW9sXlvQan9A3MIlDgZknKkntFWugJnJ/Se7kNPrh3IYw8pjwCeNd09erA9TFWUgOiXzEZriZhRXiph+JZl/gqn2VQhuM7RHcWrTgwNwrkLRU0rLyVX55liO6Bd48J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZQeGbJQS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZQeGbJQS"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9kD2F667549;
	Thu, 15 Oct 2026 17:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Wr+4KfFpBN/d+mD4C5REdG2z/mL4BLtMypY6Rb5xL
	Sw=; b=ZQeGbJQSIxaDH4NqynQuqh726c5n6DjF6Gwn45f6roaUYHkC0qWj1pZGJ
	3otTIXKi0GbS7Ztmo6kX2MzXfu2CuDOx7PML4SAwnFVYz9B6/bGQVYGfBKqaJikJ
	9rGbZeob6A1JBXajj0tBgEeEZOoZmtplRz0GGOOi8XjYVwAwAwetid7eUMb1HwxU
	VkpG8ri+PWgoXY6g4yefgZaZyount934vSaVwd4NfkXBKys4JEjLJCqPaSSnpyCV
	aCFBZdlkNVnl0yzm2LzcnTCRvrCYw4TuJOezQsQmnmn4CuLhQZdCDC9LQP+GEtbe
	E+4MlAmFLMWGusx1aS6C1US9oiihg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dugu7kh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 17:11:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69FDuHNT709726;
	Thu, 15 Oct 2026 17:11:48 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9wvg89cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 17:11:48 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69FHBjfw27984498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Oct 2026 17:11:46 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D554E5805D;
	Thu, 15 Oct 2026 17:11:45 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CDF45805C;
	Thu, 15 Oct 2026 17:11:41 +0000 (GMT)
Received: from li-d98989cc-2c66-11b2-a85c-93ab83b7dd53.fritz.box (unknown [9.111.57.222])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Oct 2026 17:11:41 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gabriella Seifert <gseifert@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>, Steffen Eiden <seiden@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [GIT PULL] KVM: s390: Changes for 7.4 including arm on s390
Date: Thu, 15 Oct 2026 19:11:40 +0200
Message-ID: <20261015171140.262334-1-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6ad10955 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=U1Dpukk0pk5jbBdTZmcA:9
X-Proofpoint-GUID: uIY7MLkXTNUs4Av4YFvJJtGkHZnMmy8U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA2NiBTYWx0ZWRfX4/gihiYfnEBB
 zSIvgEe/C8LBK9yHNHhD1z33CjJfBQkysR4jozLlgdp0sZLRYaQnxHEeRRyGitPljiNwUfjFUci
 lzoGr1hnSgtA7m57vD0N3BAxzz+Or/3WwSvbIq5SwacxXk5elCnTfXYe/p/iJFu+BoBccrzBoMN
 AsjfdVsEOrDRcQdHwUARWqq05GT7ejW8S53utxVeDoC0XatGhQugStJp+44Gl1ZDvRap+UriJGo
 5wYbPNy6ww1oSseCz398oVVibw2y6fxCDBGbJcHybY7k50y7zhLRvOgcTQC4yQ+SRRvNSY9ZjmG
 fDBqM5AnWfXJf2p2ymXLmcHqrRJphVK5nfbwXcbBkHDYHF9vxhabXbHMEblNuGgtypC7gedSrW0
 Ev0uwP3ECoEdluXKhxuw8WKrp0XRWi30vRuk6qR3yZb8fnpHWKhbxjs8Ged8EnnvJ+KnPHkxiHs
 psvvZTAqv4bVdDUyCgQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA2NiBTYWx0ZWRfX9gxTFNlXMLy4
 tAy21z7K56I90RU31KMVmsoowzD+rZ8NKvNYEhvjGmVwmDteEphVzFOm5I4NmrDakxN+My0Uvuu
 uBHhMsxjvN21M7cVbftXIne2PMLizh0=
X-Proofpoint-ORIG-GUID: tp9VdytwUJqzRoc_LpHha49jY7PAVD5Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150066

From: Christian Borntraeger <borntraeger@linux.ibm.com>

Paolo,

The following changes since commit 439d8f9cb01cb04f9b31910efd0ae8dbdfa4ad97:

  Merge tag 'kvmarm-7.4' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD (2026-10-14 18:26:28 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-7.4-2

for you to fetch changes up to e93fb70b748982fda5e6d97721df35194cacfc4a:

  arm64: Use proper include variant (2026-10-15 13:38:43 +0200)

The last one line patch is in fact a cherry-pick of b64f41a7ace1
("arm64: Use proper include variant") from the arm tree, but necessary
to build.

With that we have the initial arm on s390 support.

----------------------------------------------------------------
KVM: s390: Changes for 7.4

- rework page allocation for secure guest variable storage
- selftests
- documentation
- replace get_zeroed_page with kzalloc
- fix floating interrupt inject for corner cases
- initial arm64 on s390 support

This also contains the patch
"arm64: Use proper include variant"
as a build fix. It is also part of the arm tree.

----------------------------------------------------------------
Eric Farman (1):
      Documentation: Add missing KVM s390 crypto attributes

Gabriella Seifert (1):
      KVM: s390: selftests: Add IRQ injection selftests

Heiko Carstens (1):
      s390/uv: Rework page allocation for guest variable storage area

Hendrik Brueckner (1):
      s390/hwcaps: Report SAE support as hwcap

Janosch Frank (2):
      KVM: s390: Improve floating IRQ injection behavior
      KVM: s390: Kick PV cpus at the right time for service irqs

Mike Rapoport (Microsoft) (4):
      KVM: s390: Replace get_zeroed_page() with kzalloc() for sie_page2 and CMMA
      KVM: s390: Replace get_zeroed_page() with kzalloc() for the GIB
      KVM: s390: Replace get_zeroed_page() with kzalloc() for the STSI buffer
      KVM: s390: Replace get_zeroed_page() with kzalloc() for the STHYI buffer

Steffen Eiden (14):
      s390/Kconfig: remove PCI dependency from HAS_IOMEM
      KVM: s390: Use dedicated function for migration mode
      s390/tools: Use arm64 headers
      KVM: s390: Use arm64 code
      s390: Introduce Start Arm Execution instruction
      KVM: s390: arm64: Introduce host definitions
      KVM: s390: Add basic arm64 kvm module
      KVM: s390: arm64: Implement required functions
      KVM: s390: arm64: Implement vm/vcpu create destroy
      KVM: s390: arm64: Implement vCPU IOCTLs
      KVM: s390: arm64: Implement basic page fault handler
      KVM: s390: arm64: Integrate arm on s390
      MAINTAINERS: Add entry for ARM on s390 KVM
      arm64: Use proper include variant

 Documentation/virt/kvm/devices/vm.rst            |  18 +
 MAINTAINERS                                      |  17 +
 arch/arm64/include/asm/sysreg.h                  |   2 +-
 arch/s390/Kconfig                                |   5 +-
 arch/s390/include/arm64/kvm_emulate.h            | 130 ++++
 arch/s390/include/arm64/kvm_nested.h             |  11 +
 arch/s390/include/arm64/ptrace.h                 |  11 +
 arch/s390/include/arm64/sysreg.h                 |  13 +
 arch/s390/include/asm/asm-prototypes.h           |   1 +
 arch/s390/include/asm/elf.h                      |   2 +
 arch/s390/include/asm/io.h                       |  12 +-
 arch/s390/include/asm/kvm.h                      |   6 +
 arch/s390/include/asm/kvm_host.h                 |   4 +
 arch/s390/include/asm/kvm_host_arm64.h           | 209 +++++++
 arch/s390/include/asm/kvm_host_arm64_types.h     | 124 ++++
 arch/s390/include/asm/kvm_host_types.h           |   4 +
 arch/s390/include/asm/sae.h                      |  49 ++
 arch/s390/include/asm/sclp.h                     |   5 +-
 arch/s390/include/asm/stacktrace.h               |   5 +
 arch/s390/include/uapi/Kbuild                    |   6 +
 arch/s390/kernel/asm-offsets.c                   |   1 +
 arch/s390/kernel/entry.S                         |  22 +
 arch/s390/kernel/processor.c                     |   3 +
 arch/s390/kernel/uv.c                            |  41 +-
 arch/s390/kvm/Kconfig                            |  21 +-
 arch/s390/kvm/Makefile                           |   1 +
 arch/s390/kvm/arm64/.gitignore                   |   2 +
 arch/s390/kvm/arm64/Makefile                     | 110 ++++
 arch/s390/kvm/arm64/Makefile.gen                 |  28 +
 arch/s390/kvm/arm64/arm.c                        | 754 +++++++++++++++++++++++
 arch/s390/kvm/arm64/arm.h                        |  58 ++
 arch/s390/kvm/arm64/copy-arm64c.awk              |  82 +++
 arch/s390/kvm/arm64/guest.c                      | 135 ++++
 arch/s390/kvm/arm64/handle_exit.c                | 161 +++++
 arch/s390/kvm/arm64/handle_exit.h                |   9 +
 arch/s390/kvm/arm64/inject_fault.c               |  21 +
 arch/s390/kvm/arm64/mmio.c                       |  15 +
 arch/s390/kvm/arm64/mmu.c                        | 210 +++++++
 arch/s390/kvm/arm64/reset.c                      |  71 +++
 arch/s390/kvm/arm64/trace.h                      | 101 +++
 arch/s390/kvm/gmap/faultin.c                     |   5 +
 arch/s390/kvm/gmap/gmap.c                        |   4 +
 arch/s390/kvm/gmap/kvm_mmu.c                     |   6 +-
 arch/s390/kvm/gmap/trace_gmap.h                  |  13 +
 arch/s390/kvm/s390/intercept.c                   |  32 +-
 arch/s390/kvm/s390/interrupt.c                   | 130 +++-
 arch/s390/kvm/s390/priv.c                        |  19 +-
 arch/s390/kvm/s390/s390.c                        |  12 +-
 arch/s390/kvm/s390/s390.h                        |   1 +
 arch/s390/tools/Makefile                         |   6 +-
 arch/s390/tools/Makefile.arm64h                  |  55 ++
 arch/s390/tools/copy-arm64h-full.awk             |  50 ++
 arch/s390/tools/copy-arm64h.awk                  |  83 +++
 arch/s390/tools/opcodes.txt                      |   3 +
 drivers/s390/char/sclp_early.c                   |   1 +
 tools/testing/selftests/kvm/Makefile.kvm         |   1 +
 tools/testing/selftests/kvm/s390/irq_injection.c |  74 +++
 57 files changed, 2883 insertions(+), 92 deletions(-)
 create mode 100644 arch/s390/include/arm64/kvm_emulate.h
 create mode 100644 arch/s390/include/arm64/kvm_nested.h
 create mode 100644 arch/s390/include/arm64/ptrace.h
 create mode 100644 arch/s390/include/arm64/sysreg.h
 create mode 100644 arch/s390/include/asm/kvm.h
 create mode 100644 arch/s390/include/asm/kvm_host_arm64.h
 create mode 100644 arch/s390/include/asm/kvm_host_arm64_types.h
 create mode 100644 arch/s390/include/asm/sae.h
 create mode 100644 arch/s390/include/uapi/Kbuild
 create mode 100644 arch/s390/kvm/arm64/.gitignore
 create mode 100644 arch/s390/kvm/arm64/Makefile
 create mode 100644 arch/s390/kvm/arm64/Makefile.gen
 create mode 100644 arch/s390/kvm/arm64/arm.c
 create mode 100644 arch/s390/kvm/arm64/arm.h
 create mode 100644 arch/s390/kvm/arm64/copy-arm64c.awk
 create mode 100644 arch/s390/kvm/arm64/guest.c
 create mode 100644 arch/s390/kvm/arm64/handle_exit.c
 create mode 100644 arch/s390/kvm/arm64/handle_exit.h
 create mode 100644 arch/s390/kvm/arm64/inject_fault.c
 create mode 100644 arch/s390/kvm/arm64/mmio.c
 create mode 100644 arch/s390/kvm/arm64/mmu.c
 create mode 100644 arch/s390/kvm/arm64/reset.c
 create mode 100644 arch/s390/kvm/arm64/trace.h
 create mode 100644 arch/s390/tools/Makefile.arm64h
 create mode 100644 arch/s390/tools/copy-arm64h-full.awk
 create mode 100644 arch/s390/tools/copy-arm64h.awk
 create mode 100644 tools/testing/selftests/kvm/s390/irq_injection.c
