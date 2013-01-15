From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH] Bugfix for kvm/s390.
Date: Tue, 15 Jan 2013 11:17:28 +0100
Message-ID: <1358245049-37155-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi,

here's another s390 bugfix for kvm-next. Please apply.

Cong Ding (1):
  KVM: s390: kvm/sigp.c: fix memory leakage

 arch/s390/kvm/sigp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
1.7.12.4
