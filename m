From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 0/3] kvm/s390 patches for 3.6
Date: Mon, 11 Jun 2012 16:06:56 +0200
Message-ID: <1339423619-42299-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Avi, Marcelo,

here are some s390 patches for the next release. A bugfix, a tracing
related update (real tracing support for s390 will follow once we
have sorted out the architectural vs. internal tracepoint split),
and a patch used for console detection.

Christian Borntraeger (1):
  s390/kvm: Set CPU in stopped state on initial cpu reset

Cornelia Huck (1):
  kvm: trace events: update list of exit reasons

Heinz Graalfs (1):
  s390/kvm: Perform early event mask processing during boot.

 arch/s390/include/asm/sclp.h  |    2 ++
 arch/s390/kernel/setup.c      |   12 +++++++++---
 arch/s390/kvm/kvm-s390.c      |    1 +
 drivers/s390/char/sclp.c      |   10 ----------
 drivers/s390/char/sclp.h      |   10 ++++++++++
 drivers/s390/char/sclp_cmd.c  |   38 ++++++++++++++++++++++++++++++++++++++
 drivers/s390/kvm/kvm_virtio.c |    3 ++-
 include/trace/events/kvm.h    |    3 ++-
 8 files changed, 64 insertions(+), 15 deletions(-)

-- 
1.7.10.4
