From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/1] KVM: s390: virtio-ccw: Fix config space values
Date: Mon, 29 Jun 2015 16:44:00 +0200
Message-ID: <1435589041-36194-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, mst@redhat.com, Eric Farman <farman@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

here is fix targetted for kvm/master (4.2) that fixes an issue with
virtio config space on s390. It mostly manifests in vhost-scsi
not working properly on s390. The problem itself might affect other
things as well so cc stable/target 4.2.

@Michael FYI, sending this via Paolo as most virtio-ccw kernel
things went this way.

Cornelia Huck (1):
  KVM: s390: virtio-ccw: don't overwrite config space values

 drivers/s390/kvm/virtio_ccw.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.3.0
