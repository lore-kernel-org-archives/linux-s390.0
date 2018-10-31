From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v1 5/7] s390: kvm: export GIB registration
Date: Wed, 31 Oct 2018 19:12:55 +0100
Message-ID: <1541009577-29656-6-git-send-email-pmorel@linux.ibm.com>
References: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Define the GIB Alert registration for external users
inside the standrd kvm_host.h header file.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 512ea9f200fa..7e76a56da72d 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -902,4 +902,7 @@ static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
 
 void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu);
 
+extern int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc);
+extern int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc);
+
 #endif
-- 
2.17.0
