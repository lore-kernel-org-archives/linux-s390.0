From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 00/14 v2] KVM: s390: Fixes and features for 4.11 (via kvm/next)
Date: Mon,  6 Feb 2017 12:46:30 +0100
Message-ID: <1486381592-12949-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

since my old request is not yet processed, here is an  updated one with
2 additional patches on top.
See patches 13 and 14 as reply to this one for the new ones. All other
patches are as in the first pull request.



The following changes since commit 49def1853334396f948dcb4cedb9347abb318df5:

  Linux 4.10-rc4 (2017-01-15 16:21:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.11-2

for you to fetch changes up to fb7dc1d4ddce744c8d8e1aca19d4982102cf72e1:

  KVM: s390: detect some program check loops (2017-02-06 12:35:53 +0100)

----------------------------------------------------------------
KVM: s390: Fixes and features for 4.11 (via kvm/next)

- enable some simd extensions for guests
- enable nx for guests
- debug log for cpu model
- PER fixes
- remove bitwise annotation from ar_t
- detect guests in operation exception program check loops
- fix potential null-pointer dereference for ucontrol guests

- also contains merge for fix that went into 4.10 to avoid conflicts

----------------------------------------------------------------
Christian Borntraeger (6):
      KVM: s390: do not expose random data via facility bitmap
      KVM: s390: gaccess: add ESOP2 handling
      KVM: s390: Get rid of ar_t
      Merge tag 'kvm-s390-master-4.10-1' of git://git.kernel.org/.../kvms390/linux into kernelorgnext
      KVM: s390: Add debug logging to basic cpu model interface
      KVM: s390: detect some program check loops

David Hildenbrand (3):
      KVM: s390: guestdbg: filter i-fetch events on icpts
      KVM: s390: prepare to read random guest instructions
      KVM: s390: guestdbg: filter PER i-fetch on EXECUTE properly

Guenther Hutzl (1):
      KVM: s390: Introduce BCD Vector Instructions to the guest

Heiko Carstens (1):
      KVM: s390: get rid of bogus cc initialization

Janosch Frank (3):
      KVM: s390: instruction-execution-protection support
      KVM: s390: Fix RRBE return code not being CC
      KVM: s390: Disable dirty log retrieval for UCONTROL guests

Maxim Samoylov (1):
      KVM: s390: Introduce Vector Enhancements facility 1 to the guest

 arch/s390/kvm/gaccess.c          |  26 +++++----
 arch/s390/kvm/gaccess.h          |  19 ++++---
 arch/s390/kvm/guestdbg.c         | 120 ++++++++++++++++++++++++++++++++++-----
 arch/s390/kvm/intercept.c        |  25 +++++++-
 arch/s390/kvm/kvm-s390.c         |  46 +++++++++++++--
 arch/s390/kvm/kvm-s390.h         |  12 ++--
 arch/s390/kvm/priv.c             |  30 +++++-----
 arch/s390/kvm/vsie.c             |   3 +
 arch/s390/mm/pgtable.c           |   2 +-
 arch/s390/tools/gen_facilities.c |   2 +
 10 files changed, 225 insertions(+), 60 deletions(-)
