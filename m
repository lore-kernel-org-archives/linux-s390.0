From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 0/1] KVM: s390: virtio-ccw bugfix
Date: Thu,  6 Mar 2014 10:35:50 +0100
Message-ID: <1394098551-20023-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heinz Graalfs <graalfs@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The following changes since commit 96b14536d935848cffd904f583f67c66169002d8:

  virtio-ccw: virtio-ccw adapter interrupt support. (2014-03-04 10:41:04 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-20140306

for you to fetch changes up to 79629b208fc0484ee448c4acfa3762f0350e97ce:

  virtio_ccw: fix hang in set offline processing (2014-03-06 10:22:40 +0100)

----------------------------------------------------------------
One fix for virtio-ccw, fixing a problem introduced with
"virtio_ccw: fix vcdev pointer handling issues" and noticed just
after it went into git.

----------------------------------------------------------------

Heinz Graalfs (1):
  virtio_ccw: fix hang in set offline processing

 drivers/s390/kvm/virtio_ccw.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

-- 
1.7.9.5
