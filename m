From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [PATCH 0/2] KVM: s390: Refactor host interpretation facilities controls
Date: Fri, 16 Feb 2018 12:16:13 +0100
Message-ID: <1518779775-256056-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, alifm@linux.vnet.ibm.com, imbrenda@linux.vnet.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The host interpretation controls and usage indication variables need
some renaming, so one can actually distinguish them by name. For the
sake of completeness and later expected use, we introduce controls for
pfmfi and the storage key facility (skf).

Janosch Frank (2):
  KVM: s390: Refactor host cmma and pfmfi interpretation controls
  KVM: s390: Add storage key facility interpretation control

 arch/s390/include/asm/kvm_host.h    |  2 ++
 arch/s390/include/asm/mmu.h         |  6 +++---
 arch/s390/include/asm/mmu_context.h |  4 ++--
 arch/s390/include/asm/pgtable.h     |  4 ++--
 arch/s390/kvm/kvm-s390.c            | 26 ++++++++++++++------------
 arch/s390/kvm/priv.c                | 26 +++++++++++++++-----------
 arch/s390/mm/gmap.c                 |  6 +++---
 arch/s390/mm/pgtable.c              |  4 ++--
 8 files changed, 43 insertions(+), 35 deletions(-)

-- 
2.7.4
