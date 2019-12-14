Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725872AbfLNMK1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 14 Dec 2019 07:10:27 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBEC7Mfa054825
        for <linux-s390@vger.kernel.org>; Sat, 14 Dec 2019 07:10:26 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wvvrm3ya0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 14 Dec 2019 07:10:25 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Sat, 14 Dec 2019 12:10:24 -0000
Date: Sat, 14 Dec 2019 13:10:19 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.5-rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Message-Id: <your-ad-here.call-01576325419-ext-4863@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.5-rc2.

Thank you,
Vasily

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.5-3

for you to fetch changes up to 3e39ce266a273e5751e5792aee248cb8d9630c8b:

  s390/kasan: add KASAN_VMALLOC support (2019-12-11 19:56:59 +0100)

----------------------------------------------------------------
s390 updates for 5.5-rc2

- Add support for KASAN_VMALLOC feature.

- Remove the last user of problematic diag 0x44 call.

- Adjust sampling interval and avoid sample data block overflow condition
  on pressure in perf code.

- Prefer EOPNOTSUPP over ENOTSUPP and comments fixes.

----------------------------------------------------------------
Christian Borntraeger (1):
      s390/uv: use EOPNOTSUPP instead of ENOTSUPP

Colin Ian King (1):
      s390/test_unwind: fix spelling mistake "reqister" -> "register"

Heiko Carstens (1):
      s390: remove last diag 0x44 caller

Thomas Richter (2):
      s390/cpum_sf: Adjust sampling interval to avoid hitting sample limits
      s390/cpum_sf: Avoid SBD overflow condition in irq handler

Vasily Gorbik (2):
      s390/spinlock: remove confusing comment in arch_spin_lock_wait
      s390/kasan: add KASAN_VMALLOC support

 arch/s390/Kconfig               |  1 +
 arch/s390/include/asm/setup.h   |  2 --
 arch/s390/include/asm/uv.h      |  2 +-
 arch/s390/kernel/early.c        | 16 ----------
 arch/s390/kernel/perf_cpum_sf.c | 22 +++++++++----
 arch/s390/kernel/smp.c          | 13 +++-----
 arch/s390/lib/spinlock.c        |  1 -
 arch/s390/lib/test_unwind.c     |  2 +-
 arch/s390/mm/kasan_init.c       | 68 +++++++++++++++++++++++++++++++++--------
 9 files changed, 80 insertions(+), 47 deletions(-)
