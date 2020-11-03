Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgKCNpH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Nov 2020 08:45:07 -0500
From: YiFei Zhu <zhuyifei1999@gmail.com>
Subject: [PATCH seccomp 0/8] seccomp: add bitmap cache support on remaining arches and report cache in procfs
Date: Tue,  3 Nov 2020 07:42:56 -0600
Message-Id: <cover.1604410035.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: containers@lists.linux-foundation.org
Cc: YiFei Zhu <yifeifz2@illinois.edu>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, David Laight <David.Laight@aculab.com>, Dimitrios Skarlatos <dskarlat@cs.cmu.edu>, Giuseppe Scrivano <gscrivan@redhat.com>, Hubertus Franke <frankeh@us.ibm.com>, Jack Chen <jianyan2@illinois.edu>, Jann Horn <jannh@google.com>, Josep Torrellas <torrella@illinois.edu>, Kees Cook <keescook@chromium.org>, Tianyin Xu <tyxu@illinois.edu>, Tobin Feldman-Fitzthum <tobin@ibm.com>, Tycho Andersen <tycho@tycho.pizza>, Valentin Rothberg <vrothber@redhat.com>, Will Drewry <wad@chromium.org>

From: YiFei Zhu <yifeifz2@illinois.edu>

This patch series enables bitmap cache for the remaining arches with
SECCOMP_FILTER, other than MIPS.

I was unable to find any of the arches having subarch-specific NR_syscalls
macros, so generic NR_syscalls is used. SH's syscall_get_arch seems to
only have the 32-bit subarch implementation. I'm not sure if this is
expected.

This series has not been tested; I have not built all the cross compilers
necessary to build test, let alone run the kernel or benchmark the
performance, so help on making sure the bitmap cache works as expected
would be appreciated. The series applies on top of Kees's for-next/seccomp
branch.

YiFei Zhu (8):
  csky: Enable seccomp architecture tracking
  parisc: Enable seccomp architecture tracking
  powerpc: Enable seccomp architecture tracking
  riscv: Enable seccomp architecture tracking
  s390: Enable seccomp architecture tracking
  sh: Enable seccomp architecture tracking
  xtensa: Enable seccomp architecture tracking
  seccomp/cache: Report cache data through /proc/pid/seccomp_cache

 arch/Kconfig                       | 15 ++++++++
 arch/csky/include/asm/Kbuild       |  1 -
 arch/csky/include/asm/seccomp.h    | 11 ++++++
 arch/parisc/include/asm/Kbuild     |  1 -
 arch/parisc/include/asm/seccomp.h  | 22 +++++++++++
 arch/powerpc/include/asm/seccomp.h | 21 +++++++++++
 arch/riscv/include/asm/seccomp.h   | 10 +++++
 arch/s390/include/asm/seccomp.h    |  9 +++++
 arch/sh/include/asm/seccomp.h      | 10 +++++
 arch/xtensa/include/asm/Kbuild     |  1 -
 arch/xtensa/include/asm/seccomp.h  | 11 ++++++
 fs/proc/base.c                     |  6 +++
 include/linux/seccomp.h            |  7 ++++
 kernel/seccomp.c                   | 59 ++++++++++++++++++++++++++++++
 14 files changed, 181 insertions(+), 3 deletions(-)
 create mode 100644 arch/csky/include/asm/seccomp.h
 create mode 100644 arch/parisc/include/asm/seccomp.h
 create mode 100644 arch/xtensa/include/asm/seccomp.h


base-commit: 38c37e8fd3d2590c4234d8cfbc22158362f0eb04
--
2.29.2
