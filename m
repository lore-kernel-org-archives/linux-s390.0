From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] KVM: s390: Fix for kvm/master (target 4.1)
Date: Wed, 15 Apr 2015 12:27:03 +0200
Message-ID: <1429093624-49611-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

here is a small fix for a regression that came in during the
merge window. If affects only guests older than 3.12 when
running on z196 or newer and transparent huge pages are used
in the guest.

As it is only one patch I prepared no signed tag - let me
know if you prefer to have one.

Christian
