From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2 0/2] KVM: s390: Fine-tuning for kvm_s390_import_bp_data()
Date: Wed, 24 Aug 2016 20:30:12 +0200
Message-ID: <e72e9854-443b-7033-d674-8a2d237600ca@users.sourceforge.net>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
 <bb710b21-d8c4-e172-63d4-b46c80645cb3@users.sourceforge.net>
 <ddb2bbd9-757b-fc62-8642-ce827a7a666d@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ddb2bbd9-757b-fc62-8642-ce827a7a666d@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Walter Harms <wharms@bfs.de>
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Aug 2016 20:20:02 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Improve determination of sizes
  Use memdup_user() rather than duplicating code

 arch/s390/kvm/guestdbg.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

-- 
2.9.3
