From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 6/7] KVM: s390: Base infrastructure for enabling capabilities.
Date: Thu, 20 Dec 2012 15:32:11 +0100
Message-ID: <1356013932-23775-7-git-send-email-cornelia.huck@de.ibm.com>
References: <1356013932-23775-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1356013932-23775-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Make s390 support KVM_ENABLE_CAP.

Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
Acked-by: Alexander Graf <agraf@suse.de>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt |  2 +-
 arch/s390/kvm/kvm-s390.c          | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 8a0de30..73bd159 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -913,7 +913,7 @@ documentation when it pops into existence).
 4.37 KVM_ENABLE_CAP
 
 Capability: KVM_CAP_ENABLE_CAP
-Architectures: ppc
+Architectures: ppc, s390
 Type: vcpu ioctl
 Parameters: struct kvm_enable_cap (in)
 Returns: 0 on success; -1 on error
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f718bc6..5ff2603 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -140,6 +140,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 #endif
 	case KVM_CAP_SYNC_REGS:
 	case KVM_CAP_ONE_REG:
+	case KVM_CAP_ENABLE_CAP:
 		r = 1;
 		break;
 	case KVM_CAP_NR_VCPUS:
@@ -808,6 +809,22 @@ int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr)
 	return 0;
 }
 
+static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
+				     struct kvm_enable_cap *cap)
+{
+	int r;
+
+	if (cap->flags)
+		return -EINVAL;
+
+	switch (cap->cap) {
+	default:
+		r = -EINVAL;
+		break;
+	}
+	return r;
+}
+
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg)
 {
@@ -894,6 +911,15 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 			r = 0;
 		break;
 	}
+	case KVM_ENABLE_CAP:
+	{
+		struct kvm_enable_cap cap;
+		r = -EFAULT;
+		if (copy_from_user(&cap, argp, sizeof(cap)))
+			break;
+		r = kvm_vcpu_ioctl_enable_cap(vcpu, &cap);
+		break;
+	}
 	default:
 		r = -ENOTTY;
 	}
-- 
1.7.12.4
