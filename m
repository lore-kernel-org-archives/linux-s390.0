From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 0/3] KVM: s390: Trace events support.
Date: Mon, 23 Jul 2012 17:20:27 +0200
Message-ID: <1343056830-45290-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Avi, Marcelo,

here's a patch set that introduces trace events for kvm/s390.

It's split into two parts:

- Trace points for architecture-defined events, like intercepts.
  This patch calls into the disassembler via the interface provided
  by the first patch. These trace points show up under events/kvm/.
- Trace points for implementation-specific events like interrupt
  injection. These show up under a new trace system, kvm-s390.

Cornelia Huck (3):
  s390/dis: Instruction decoding interface.
  KVM: s390: Add architectural trace events.
  KVM: s390: Add implementation-specific trace events.

 arch/s390/include/asm/processor.h |   1 +
 arch/s390/kernel/dis.c            |  27 +++
 arch/s390/kvm/diag.c              |   4 +
 arch/s390/kvm/intercept.c         |  11 ++
 arch/s390/kvm/interrupt.c         |  23 +++
 arch/s390/kvm/kvm-s390.c          |  10 ++
 arch/s390/kvm/priv.c              |   9 +-
 arch/s390/kvm/sigp.c              |   2 +
 arch/s390/kvm/trace-s390.h        | 210 +++++++++++++++++++++++
 arch/s390/kvm/trace.h             | 341 ++++++++++++++++++++++++++++++++++++++
 10 files changed, 637 insertions(+), 1 deletion(-)
 create mode 100644 arch/s390/kvm/trace-s390.h
 create mode 100644 arch/s390/kvm/trace.h

-- 
1.7.11.2
