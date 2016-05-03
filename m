From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2] KVM: halt_polling: provide a way to qualify wakeups during poll
Date: Tue,  3 May 2016 14:37:20 +0200
Message-ID: <1462279041-17028-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Wanpeng Li <kernellwp@gmail.com>, David Matlack <dmatlack@google.com>
List-ID: <linux-s390.vger.kernel.org>

I removed all Reviewed-by/Acks as the patch has changed in several places
- got rid of two new lines in Kconfig
- changed comment in interrupt.c
- added kvm_arch_vcpu_block_finish
- got rid of vcpu_reset_wakeup and vcpu_set_valid_wakeup
- add new kvm_stat 
- adopt tracing
- rebase from 4.5 to kvm/next

Better names/descriptions for
- kvm_stat "halt_poll_no_tuning"
- the trace text
- function names 
are welcome

Christian Borntraeger (1):
  KVM: halt_polling: provide a way to qualify wakeups during poll

 arch/arm/include/asm/kvm_host.h     |  2 ++
 arch/arm64/include/asm/kvm_host.h   |  2 ++
 arch/mips/include/asm/kvm_host.h    |  1 +
 arch/mips/kvm/mips.c                |  1 +
 arch/powerpc/include/asm/kvm_host.h |  2 ++
 arch/powerpc/kvm/book3s.c           |  1 +
 arch/powerpc/kvm/booke.c            |  1 +
 arch/s390/include/asm/kvm_host.h    |  3 +++
 arch/s390/kvm/Kconfig               |  1 +
 arch/s390/kvm/interrupt.c           |  5 +++++
 arch/s390/kvm/kvm-s390.c            |  6 ++++++
 arch/x86/include/asm/kvm_host.h     |  2 ++
 arch/x86/kvm/x86.c                  |  1 +
 include/linux/kvm_host.h            | 15 +++++++++++++++
 include/trace/events/kvm.h          | 11 +++++++----
 virt/kvm/Kconfig                    |  3 +++
 virt/kvm/kvm_main.c                 |  8 ++++++--
 17 files changed, 59 insertions(+), 6 deletions(-)

-- 
2.3.0
