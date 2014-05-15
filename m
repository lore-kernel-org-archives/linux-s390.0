From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/1] KVM: s390: announce irqfd capability
Date: Thu, 15 May 2014 11:02:51 +0200
Message-ID: <1400144571-17011-2-git-send-email-borntraeger@de.ibm.com>
References: <1400144571-17011-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1400144571-17011-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

s390 has acquired irqfd support with commit "KVM: s390: irq routing for
adapter interrupts" (84223598778ba08041f4297fda485df83414d57e) but
failed to announce it. Let's fix that.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt | 2 +-
 arch/s390/kvm/kvm-s390.c          | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index a9380ba5..b4f5365 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2126,7 +2126,7 @@ into the hash PTE second double word).
 4.75 KVM_IRQFD
 
 Capability: KVM_CAP_IRQFD
-Architectures: x86
+Architectures: x86 s390
 Type: vm ioctl
 Parameters: struct kvm_irqfd (in)
 Returns: 0 on success, -1 on error
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index b3ecb8f..9ae6664 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -158,6 +158,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_ONE_REG:
 	case KVM_CAP_ENABLE_CAP:
 	case KVM_CAP_S390_CSS_SUPPORT:
+	case KVM_CAP_IRQFD:
 	case KVM_CAP_IOEVENTFD:
 	case KVM_CAP_DEVICE_CTRL:
 	case KVM_CAP_ENABLE_CAP_VM:
-- 
1.8.4.2
