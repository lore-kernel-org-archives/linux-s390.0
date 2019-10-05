Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8196 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbfJEPi6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 5 Oct 2019 11:38:58 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x95FahYJ088278
        for <linux-s390@vger.kernel.org>; Sat, 5 Oct 2019 11:38:56 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vep00h7rm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 05 Oct 2019 11:38:56 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Sat, 5 Oct 2019 16:38:54 +0100
Date: Sat, 5 Oct 2019 17:38:47 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.4-rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Message-Id: <your-ad-here.call-01570289927-ext-8803@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.4-rc2.

Thank you,
Vasily

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-3

for you to fetch changes up to d0dea733f60efe94257d08ae6eba81d0b511d0a9:

  KVM: s390: mark __insn32_query() as __always_inline (2019-10-05 13:51:22 +0200)

----------------------------------------------------------------
s390 updates for 5.4-rc2

- Default configs updates.

- Fix build errors with CC_OPTIMIZE_FOR_SIZE due to usage of "i" constraint
  for function arguments. Two kvm changes acked-by Christian Borntraeger.

- Fix -Wunused-but-set-variable warnings in mm code.

- Avoid a constant misuse in qdio.

- Handle a case when cpumf is temporarily unavailable.

----------------------------------------------------------------
Heiko Carstens (8):
      s390/atomic,bitops: mark function(s) __always_inline
      s390/cpu_mf: mark function(s) __always_inline
      s390/jump_label: mark function(s) __always_inline
      s390/mm: mark function(s) __always_inline
      s390/pci: mark function(s) __always_inline
      s390: update defconfigs
      KVM: s390: fix __insn32_query() inline assembly
      KVM: s390: mark __insn32_query() as __always_inline

Jiri Kosina (1):
      s390: mark __cpacf_query() as __always_inline

Julian Wiedmann (1):
      s390/qdio: clarify size of the QIB parm area

Qian Cai (1):
      s390/mm: fix -Wunused-but-set-variable warnings

Thomas Richter (3):
      s390/cpumf: Use consistant debug print format
      s390/cpumsf: Check for CPU Measurement sampling
      s390/cpumf: Fix indentation in sampling device driver

 arch/s390/configs/debug_defconfig    | 24 ++++++++++++++++--------
 arch/s390/configs/defconfig          | 25 ++++++++++++++++---------
 arch/s390/configs/zfcpdump_defconfig |  2 +-
 arch/s390/include/asm/atomic_ops.h   |  2 +-
 arch/s390/include/asm/bitops.h       |  8 ++++----
 arch/s390/include/asm/cpacf.h        |  2 +-
 arch/s390/include/asm/cpu_mf.h       |  8 ++++++--
 arch/s390/include/asm/hugetlb.h      |  9 +++++++--
 arch/s390/include/asm/jump_label.h   |  4 ++--
 arch/s390/include/asm/pgtable.h      | 25 +++++++++++++------------
 arch/s390/include/asm/qdio.h         |  2 +-
 arch/s390/kernel/perf_cpum_cf_diag.c |  4 ++--
 arch/s390/kernel/perf_cpum_sf.c      |  8 +++++++-
 arch/s390/kvm/kvm-s390.c             |  6 +++---
 arch/s390/pci/pci_clp.c              |  2 +-
 drivers/s390/cio/qdio_setup.c        |  2 +-
 drivers/s390/net/qeth_core_main.c    |  3 +--
 17 files changed, 83 insertions(+), 53 deletions(-)
