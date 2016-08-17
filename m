From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/4] KVM-S390: Fine-tuning for kvm_s390_import_bp_data()
Date: Wed, 17 Aug 2016 20:02:53 +0200
Message-ID: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 17 Aug 2016 19:49:29 +0200

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Improve determination of sizes
  Use memdup_user()
  Less function calls after error detection
  Delete an unnecessary initialisation

 arch/s390/kvm/guestdbg.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

-- 
2.9.3
