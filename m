From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/1] KVM: s390/mm: fix for 4.6
Date: Mon,  4 Apr 2016 09:41:31 +0200
Message-ID: <1459755692-126047-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

here is a fix of a "merge issue" breaking some 
kvm configurations on s390.

since Martin is away this week, lets push this fix via your
tree. (this has the additional advantage that this fix will
probably be part of kvm/next, making 4.7 patch handling
easier). Ok?

Heiko, can you ack this fix?


Christian Borntraeger (1):
  s390/mm/kvm: fix mis-merge in gmap handling

 arch/s390/mm/gmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.5.5
