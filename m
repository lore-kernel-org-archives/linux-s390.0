From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/1] KVM: s390: Fix for kvm/next (4.8) part 3
Date: Tue,  5 Jul 2016 14:21:18 +0200
Message-ID: <1467721279-206526-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

The following changes since commit 196f20ca52e8c7281932663c348fa54b82d03914:

  KVM: vmx: fix missed cancellation of TSC deadline timer (2016-07-01 11:03:42 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.8-3

for you to fetch changes up to 5ffe466cd3a33543306c37a0789e2116286367f1:

  KVM: s390: inject PER i-fetch events on applicable icpts (2016-07-05 12:02:56 +0200)

----------------------------------------------------------------
KVM: s390: Fix for kvm/next (4.8) part 3

This contains a fix for PER ifetch events. As we now have a handler
for a problem state instruction (sthyi) that could be stepped with a
debugger we should try to do the right thing regarding PER in our
instruction handlers.  With this fix the handling for intercepted
instructions is fixed in general, thus fixing other oddball cases as
well (e.g. kprobes single stepping)

----------------------------------------------------------------
David Hildenbrand (1):
      KVM: s390: inject PER i-fetch events on applicable icpts

 arch/s390/kvm/guestdbg.c  | 17 +++++++++++++++++
 arch/s390/kvm/intercept.c | 17 ++++++++++++++---
 arch/s390/kvm/kvm-s390.h  |  3 +++
 3 files changed, 34 insertions(+), 3 deletions(-)
