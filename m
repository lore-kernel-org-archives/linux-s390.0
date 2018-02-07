Return-Path: <schwidefsky@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 0/6] s390: improve speculative execution handling v3
Date: Wed,  7 Feb 2018 08:00:05 +0100
Message-Id: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>, Dominik Brodowski <linux@dominikbrodowski.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Version 3 of the speculative execution improvements for s390.

Changes to v2:

* Dropped the prctl to introduce the PR_ISOLATE_BP control and simply
  added two exported functions s390_isolate_bp and s390_isolate_bp_guest.
  There is currently no caller for these functions, for now an out-of-tree
  module can be used until an acceptable upstream solution for the user
  space interface is found.

* Added an optimized version for the the array_index_mask_nospec
  function based on subtract with borrow for the spectre v1 defense.

* Introduce "expoline", the s390 version of a retpoline. As s390 does
  not have a return instruction and the associate return stack we use
  an execute-type instruction on an indirect branch to get unpredicatable
  branches. This requires gcc support for -mindirect-branch=thunk /
  -mfunction-return=thunk.  To be able to disable expolines there is
  another gcc option -mindirect-branch-table to keep a list of PC relative
  locations of calls to the execute thunks. With spectre_v2=off the call
  will be replaced with the original indirect branch and a nop.

Martin Schwidefsky (6):
  s390: scrub registers on kernel entry and KVM exit
  s390: add optimized array_index_mask_nospec
  s390/alternative: use a copy of the facility bit mask
  s390: add options to change branch prediction behaviour for the kernel
  s390: run user space and KVM guests with modified branch prediction
  s390: introduce execute-trampolines for branches

 arch/s390/Kconfig                     |  45 ++++++
 arch/s390/Makefile                    |  12 ++
 arch/s390/include/asm/barrier.h       |  24 ++++
 arch/s390/include/asm/facility.h      |  18 +++
 arch/s390/include/asm/lowcore.h       |   9 +-
 arch/s390/include/asm/nospec-branch.h |  18 +++
 arch/s390/include/asm/processor.h     |   4 +
 arch/s390/include/asm/thread_info.h   |   4 +
 arch/s390/kernel/Makefile             |   4 +
 arch/s390/kernel/alternative.c        |  26 +++-
 arch/s390/kernel/early.c              |   5 +
 arch/s390/kernel/entry.S              | 249 ++++++++++++++++++++++++++++++----
 arch/s390/kernel/ipl.c                |   1 +
 arch/s390/kernel/module.c             |  62 +++++++--
 arch/s390/kernel/nospec-branch.c      | 100 ++++++++++++++
 arch/s390/kernel/processor.c          |  18 +++
 arch/s390/kernel/setup.c              |   8 +-
 arch/s390/kernel/smp.c                |   7 +-
 arch/s390/kernel/vmlinux.lds.S        |  14 ++
 drivers/s390/char/Makefile            |   2 +
 20 files changed, 591 insertions(+), 39 deletions(-)
 create mode 100644 arch/s390/include/asm/nospec-branch.h
 create mode 100644 arch/s390/kernel/nospec-branch.c

-- 
2.7.4
