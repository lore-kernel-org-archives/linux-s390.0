From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 0/2] KVM: s390: Bugfixes for virtio-ccw.
Date: Mon,  7 Jan 2013 15:51:50 +0100
Message-ID: <1357570312-32074-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi,

Christian discovered some problems with regard to serialization
in the virtio-ccw guest driver. Per-device data structures might
contain data obtained by channel programs issued later on, leading
to confusing behaviour. We cannot rely on the common I/O layer
serialization here.

Rather than adding extra serialization, we decided to keep it simple
with per-request allocated data structures and retries on busy.
These patches have been run in our internal testing without problems
for a bit now.

Please apply to kvm-next.

Christian Borntraeger (1):
  KVM: s390: Gracefully handle busy conditions on ccw_device_start

Cornelia Huck (1):
  KVM: s390: Dynamic allocation of virtio-ccw I/O data.

 drivers/s390/kvm/virtio_ccw.c | 291 ++++++++++++++++++++++++++----------------
 1 file changed, 181 insertions(+), 110 deletions(-)

-- 
1.7.12.4
