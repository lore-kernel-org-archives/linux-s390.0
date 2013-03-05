From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/8] s390/kvm: memory mgmt related fixes/cleanups
Date: Tue,  5 Mar 2013 13:14:39 +0100
Message-ID: <1362485687-2799-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tossati <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Marcelo, Gleb,

here are some patches to cleanup/fix some aspects of the KVM
memory management on s390. Since these patches mostly touch
files names */kvm*/ lets push them via the kvm tree.
Please queue for 3.10.

The patch queue applies on 3.9-rc1

Heiko Carstens (8):
  s390/kvm,gaccess: fix guest access return code handling
  s390/mm,gmap: implement gmap_translate()
  s390/kvm,tprot: use new gmap_translate() function
  s390/kvm: remove explicit -EFAULT return code checking on guest access  s390/kvm,gaccess: shorten put/get_guest code
  s390/kvm,gaccess: shorten copy_to/from_guest code
  s390/kvm: cleanup/fix handle_tpi()
  s390/kvm,gaccess: add address space annotations

 arch/s390/include/asm/pgtable.h |   2 +
 arch/s390/kvm/gaccess.h         | 429 +++++++---------------------------------
 arch/s390/kvm/intercept.c       |  10 +-
 arch/s390/kvm/interrupt.c       | 245 +++++++----------------
 arch/s390/kvm/priv.c            |  89 +++++----
 arch/s390/mm/pgtable.c          | 107 +++++++---
 6 files changed, 284 insertions(+), 598 deletions(-)

-- 
1.8.0.1
