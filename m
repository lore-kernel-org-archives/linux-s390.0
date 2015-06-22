From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/1] KVM: s390: One small fix for post 4.1
Date: Mon, 22 Jun 2015 13:20:11 +0200
Message-ID: <1434972012-68554-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

here is a small fixup for KVM on s390. It is also necessary for
4.1 which I am a bit late for - so cc stable.
No pull request as it is only one patch.


Jens Freimann (1):
  KVM: s390: clear floating interrupt bitmap and parameters

 arch/s390/kvm/interrupt.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.3.0

--
To unsubscribe from this list: send the line "unsubscribe kvm" in
