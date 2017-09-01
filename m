From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL v2] KVM: s390: Fixes and features for 4.14
Date: Fri,  1 Sep 2017 09:46:45 +0200
Message-ID: <1504252008-102471-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

since you have not yet pulled my old patch queue, I use this as 
a chance to add some more patches. So here are 3 patches on top
of my old pull request. The new tag replaces the old one (tags/kvm-s390-next-4.14-1)

diffstat/patches in reply are on top and only for the additional patches,
but the new tag (tags/kvm-s390-next-4.14-2) contains the description
of all changes from -1 as well.
So please pull this one instead.

The following changes since commit 1935222dc2f22ea885e7a7ece6d1be586aafe4a1:

  KVM: s390: we are always in czam mode (2017-08-29 16:50:20 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.14-2

for you to fetch changes up to c95c895303ed13e883e0e6386e0b978174329210:

  KVM: s390: vsie: cleanup mcck reinjection (2017-08-31 13:49:40 +0200)

----------------------------------------------------------------
KVM: s390: Fixes and features for 4.14

- merge of topic branch tlb-flushing from the s390 tree to get the
  no-dat base features
- merge of kvm/master to avoid conflicts with additional sthyi fixes
- wire up the no-dat enhancements in KVM
- multiple epoch facility (z14 feature)
- Configuration z/Architecture Mode
- more sthyi fixes
- gdb server range checking fix
- small code cleanups

----------------------------------------------------------------
David Hildenbrand (3):
      KVM: s390: guestdbg: fix range check
      KVM: s390: use WARN_ON_ONCE only for checking
      KVM: s390: vsie: cleanup mcck reinjection

 arch/s390/kvm/guestdbg.c  | 2 +-
 arch/s390/kvm/interrupt.c | 6 ++++--
 arch/s390/kvm/vsie.c      | 6 +-----
 3 files changed, 6 insertions(+), 8 deletions(-)
