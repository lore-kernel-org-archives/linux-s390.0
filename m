Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727925AbgLHPJy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Dec 2020 10:09:54 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 0/2] s390x: Move from LGPL 2 to GPL 2
Date: Tue,  8 Dec 2020 10:09:00 -0500
Message-Id: <20201208150902.32383-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

KVM and the KVM unit tests should be able to share code to improve
development speed and the LGPL is currently preventing us from doing
exactly that. Additionally we have a multitude of different licenses
in s390x files: GPL 2 only, GPL 2 or greater, LGPL 2 and LGPL 2.1 or
later.

This patch set tries to move the licenses to GPL 2 where
possible. Also we introduce the SPDX identifiers so the file headers
are more readable.

Janosch Frank (2):
  s390x: Move to GPL 2 and SPDX license identifiers
  s390x: lib: Move to GPL 2 and SPDX license identifiers

 lib/s390x/asm-offsets.c     | 4 +---
 lib/s390x/asm/arch_def.h    | 4 +---
 lib/s390x/asm/asm-offsets.h | 4 +---
 lib/s390x/asm/barrier.h     | 4 +---
 lib/s390x/asm/cpacf.h       | 1 +
 lib/s390x/asm/facility.h    | 4 +---
 lib/s390x/asm/float.h       | 4 +---
 lib/s390x/asm/interrupt.h   | 4 +---
 lib/s390x/asm/io.h          | 4 +---
 lib/s390x/asm/mem.h         | 4 +---
 lib/s390x/asm/page.h        | 4 +---
 lib/s390x/asm/pgtable.h     | 4 +---
 lib/s390x/asm/sigp.h        | 4 +---
 lib/s390x/asm/spinlock.h    | 4 +---
 lib/s390x/asm/stack.h       | 4 +---
 lib/s390x/asm/time.h        | 4 +---
 lib/s390x/css.h             | 4 +---
 lib/s390x/css_dump.c        | 4 +---
 lib/s390x/css_lib.c         | 4 +---
 lib/s390x/interrupt.c       | 4 +---
 lib/s390x/io.c              | 4 +---
 lib/s390x/mmu.c             | 4 +---
 lib/s390x/mmu.h             | 4 +---
 lib/s390x/sclp-console.c    | 5 +----
 lib/s390x/sclp.c            | 4 +---
 lib/s390x/sclp.h            | 5 +----
 lib/s390x/smp.c             | 4 +---
 lib/s390x/smp.h             | 4 +---
 lib/s390x/stack.c           | 4 +---
 lib/s390x/vm.c              | 3 +--
 lib/s390x/vm.h              | 3 +--
 s390x/cmm.c                 | 4 +---
 s390x/cpumodel.c            | 4 +---
 s390x/css.c                 | 4 +---
 s390x/cstart64.S            | 4 +---
 s390x/diag10.c              | 4 +---
 s390x/diag288.c             | 4 +---
 s390x/diag308.c             | 5 +----
 s390x/emulator.c            | 4 +---
 s390x/gs.c                  | 4 +---
 s390x/iep.c                 | 4 +---
 s390x/intercept.c           | 4 +---
 s390x/pfmf.c                | 4 +---
 s390x/sclp.c                | 4 +---
 s390x/selftest.c            | 4 +---
 s390x/skey.c                | 4 +---
 s390x/skrf.c                | 4 +---
 s390x/smp.c                 | 4 +---
 s390x/sthyi.c               | 4 +---
 s390x/sthyi.h               | 4 +---
 s390x/stsi.c                | 4 +---
 s390x/uv-guest.c            | 4 +---
 s390x/vector.c              | 4 +---
 53 files changed, 53 insertions(+), 157 deletions(-)

-- 
2.25.1
