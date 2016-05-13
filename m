From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/2] halt polling changes
Date: Fri, 13 May 2016 12:16:34 +0200
Message-ID: <1463134596-19470-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

here is the updated version of halt polling patches that improves s390.
Lots of uperf/iperf measurements showed several improvements without
things going over board. So I would like to go with this approach.
Patch 1 was several days in linux-next (I just added Radims ACk
from an earlier version), so it does not seem to break mips,arm,power and
x86.

Still ok for 4.7 or shall I defer this for 4.8?

Christian Borntraeger (2):
  KVM: halt_polling: provide a way to qualify wakeups during poll
  KVM: s390: set halt polling to 80 microseconds

 arch/arm/include/asm/kvm_host.h     |  2 ++
 arch/arm64/include/asm/kvm_host.h   |  2 ++
 arch/mips/include/asm/kvm_host.h    |  2 ++
 arch/mips/kvm/mips.c                |  1 +
 arch/powerpc/include/asm/kvm_host.h |  2 ++
 arch/powerpc/kvm/book3s.c           |  1 +
 arch/powerpc/kvm/booke.c            |  1 +
 arch/s390/include/asm/kvm_host.h    |  5 ++++-
 arch/s390/kvm/Kconfig               |  1 +
 arch/s390/kvm/interrupt.c           |  5 +++++
 arch/s390/kvm/kvm-s390.c            |  6 ++++++
 arch/x86/include/asm/kvm_host.h     |  2 ++
 arch/x86/kvm/x86.c                  |  1 +
 include/linux/kvm_host.h            | 15 +++++++++++++++
 include/trace/events/kvm.h          | 11 +++++++----
 virt/kvm/Kconfig                    |  3 +++
 virt/kvm/kvm_main.c                 |  8 ++++++--
 17 files changed, 61 insertions(+), 7 deletions(-)

-- 
2.5.5
