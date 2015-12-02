From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 12/23] KVM: s390: Enable up to 248 VCPUs per VM
Date: Wed,  2 Dec 2015 12:06:13 +0100
Message-ID: <1449054384-76374-13-git-send-email-borntraeger@de.ibm.com>
References: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: "Eugene (jno) Dvurechenski" <jno@linux.vnet.ibm.com>

This patch allows s390 to have more than 64 VCPUs for a guest (up to
248 for memory usage considerations), if supported by the underlaying
hardware (sclp.has_esca).

Signed-off-by: Eugene (jno) Dvurechenski <jno@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 2 +-
 arch/s390/kvm/kvm-s390.c         | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 86c3386..12e9291 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -27,7 +27,7 @@
 
 #define KVM_S390_BSCA_CPU_SLOTS 64
 #define KVM_S390_ESCA_CPU_SLOTS 248
-#define KVM_MAX_VCPUS KVM_S390_BSCA_CPU_SLOTS
+#define KVM_MAX_VCPUS KVM_S390_ESCA_CPU_SLOTS
 #define KVM_USER_MEM_SLOTS 32
 
 /*
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 5e884aa..16c19fb 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -246,7 +246,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		break;
 	case KVM_CAP_NR_VCPUS:
 	case KVM_CAP_MAX_VCPUS:
-		r = KVM_MAX_VCPUS;
+		r = sclp.has_esca ? KVM_S390_ESCA_CPU_SLOTS
+				  : KVM_S390_BSCA_CPU_SLOTS;
 		break;
 	case KVM_CAP_NR_MEMSLOTS:
 		r = KVM_USER_MEM_SLOTS;
-- 
2.3.0
