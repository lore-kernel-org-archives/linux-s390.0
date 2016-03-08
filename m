From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/1] KVM: s390: last minute fix for 4.5
Date: Tue,  8 Mar 2016 12:24:29 +0100
Message-ID: <1457436270-93409-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

one last fixup for KVM on s390 for 4.5. It fixes the
sigp store status of floating registers with older QEMU
versions that still rely on the kernel for doing so.

David Hildenbrand (1):
  KVM: s390: correct fprs on SIGP (STOP AND) STORE STATUS

 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.3.0
