From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v3 0/3] KVM: s390: vsie: Consolidate CRYCB validation
Date: Thu, 23 Aug 2018 12:25:53 +0200
Message-ID: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: david@redhat.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Before adapting the CRYCB shadowing for a guest supporting
the AP instructions we want to clean the CRYCB shadowing code.

First patch seem obvious.

Second patch introduce a change in the behavior of
the virtual machine in that the CRYCB is validated
whenever we use or not the key masks to mimic the
real machine.

Patch 3 does not correct the compiled code but make
more clear what is done concerning the formating of
the CRYCB in the guest original CRYCB and in the
shadow CRYCB.

Pierre Morel (3):
  KVM: s390: vsie: copy wrapping keys to right place
  KVM: s390: vsie: Do the CRYCB validation first
  KVM: s390: vsie: Make use of CRYCB FORMAT2 clear

 arch/s390/kvm/vsie.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

-- 
2.7.4

Changelog from V2:
- Suppress two useless/broken patches
- Change a patch on CRYCB format to a modification of the comment
- modified the first patch title as expected
- added R-Bs

Changelog from v1
- split into severall small patches
- insert the first cleaning patch ahead
- add a new patch to allow a host not having AP
  instructions
