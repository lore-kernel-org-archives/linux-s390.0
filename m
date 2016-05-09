From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 00/10] KVM: s390: features and fixes for 4.7 part2
Date: Mon,  9 May 2016 11:20:11 +0200
Message-ID: <1462785621-12600-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

here is the 2nd bunch of s390 patches for 4.7 (kvm/next).
I did not add the wait polling patches yet, so maybe we have a 3rd
round later this week (or we just defer it to 4.8) - depending
on some performance results.

Please pull

The following changes since commit 05b1159e641fa45e885aec8bf8e515117c8977d9:

  Merge tag 'kvms390-20160420' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into next (2016-04-20 15:28:51 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.7-2

for you to fetch changes up to be7c9d7ba9e405ccdcd1892a899539ce730935b0:

  KVM: s390: Populate mask of non-hypervisor managed facility bits (2016-05-04 10:57:43 +0200)

----------------------------------------------------------------
KVM: s390: features and fixes for 4.7 part2

- Use hardware provided information about facility bits that do not
  need any hypervisor activitiy
- Add missing documentation for KVM_CAP_S390_RI
- Some updates/fixes for handling cpu models and facilities

----------------------------------------------------------------
Alexander Yarygin (3):
      KVM: s390: Enable all facility bits that are known good for passthrough
      s390/sclp: Add hmfai field
      KVM: s390: Populate mask of non-hypervisor managed facility bits

David Hildenbrand (7):
      KVM: s390: cmma: don't check entry content
      KVM: s390: support NQ only if the facility is enabled for the guest
      KVM: s390: enable PFMFI only if guest hast EDAT1
      KVM: s390: enable SRS only if enabled for the guest
      KVM: s390: cleanup cpuid handling
      KVM: s390: force ibc into valid range
      KVM: s390: document KVM_CAP_S390_RI

 Documentation/virtual/kvm/api.txt |  8 ++++++
 arch/s390/include/asm/kvm_host.h  |  6 +----
 arch/s390/include/asm/sclp.h      |  1 +
 arch/s390/include/asm/sigp.h      |  1 +
 arch/s390/kvm/kvm-s390.c          | 55 +++++++++++++++++++++++++++++----------
 arch/s390/kvm/priv.c              | 21 +++++----------
 arch/s390/kvm/sigp.c              |  6 +++++
 drivers/s390/char/sclp_early.c    |  6 ++++-
 8 files changed, 70 insertions(+), 34 deletions(-)
