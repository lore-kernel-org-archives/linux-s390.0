From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/1] kernel fix for s390 postcopy hang
Date: Mon, 28 Aug 2017 10:28:06 +0200
Message-ID: <1503908887-67060-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Andrea, David,

here is a patch that fixes my postcopy hang 
(https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg04129.html)

unless there are better ideas or complains, this will go via Martins
tree.

Christian Borntraeger (1):
  s390/mm: avoid empty zero pages for KVM guests to avoid postcopy hangs

 arch/s390/include/asm/pgtable.h |  2 +-
 arch/s390/mm/gmap.c             | 41 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 35 insertions(+), 8 deletions(-)

-- 
2.7.4
