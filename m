From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v2 0/5] KVM: s390: vsie: Consolidate CRYCB validation
Date: Wed, 22 Aug 2018 18:51:52 +0200
Message-ID: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: david@redhat.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Before adapting the CRYCB shadowing for a guest supporting
the AP instructions we want to clean the CRYCB shadowing code.


Pierre Morel (5):
  KVM: s390: vsie: BUG correction by shadow_crycb
  KVM: s390: vsie: Only accept FORMAT1 CRYCB for guest2
  KVM: s390: vsie: Allow support for a host without AP
  KVM: s390: vsie: Always test the crycbd for NULL
  KVM: s390: vsie: Do the CRYCB validation first

 arch/s390/kvm/vsie.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

-- 
2.7.4

Changelog from v1
- split into severall small patches
- insert the first cleaning patch ahead
- add a new patch to allow a host not having AP
  instructions
