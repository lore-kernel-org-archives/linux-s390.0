From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v1 0/2] KVM: s390: Tracing APCB changes
Date: Fri,  5 Oct 2018 10:31:08 +0200
Message-ID: <1538728270-10340-1-git-send-email-pmorel@linux.ibm.com>
References: <7d147350-4284-8e01-d1fa-0795d2da85c1@de.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7d147350-4284-8e01-d1fa-0795d2da85c1@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: david@redhat.com, linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

In the first patch we define kvm_arch_crypto_set_masks,
a new function to centralize the setup the APCB masks
inside the CRYCB SIE satelite and add KVM_EVENT() to
kvm_arch_crypto_set_masks and kvm_arch_crypto_clear_masks.

In the second patch we replace the vfio_ap_mdev_copy_masks()
by the new kvm_arch_crypto_set_masks() function.


Pierre Morel (2):
  KVM: s390: Tracing APCB changes
  s390: vfio-ap: setup APCB mask using KVM dedicated function

 arch/s390/include/asm/kvm_host.h  |  2 ++
 arch/s390/kvm/kvm-s390.c          | 41 +++++++++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c | 33 +++----------------------------
 3 files changed, 46 insertions(+), 30 deletions(-)

-- 
2.7.4
