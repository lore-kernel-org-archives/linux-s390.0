From: wei.guo.simon@gmail.com
Subject: [PATCH] KVM: surround kvm_arch_vcpu_async_ioctl() with #ifdef
Date: Wed, 28 Feb 2018 10:31:39 +0800
Message-ID: <1519785099-13808-1-git-send-email-wei.guo.simon@gmail.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, Simon Guo <wei.guo.simon@gmail.com>, linux-mips@linux-mips.org
List-ID: <linux-s390.vger.kernel.org>

From: Simon Guo <wei.guo.simon@gmail.com>

Although CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL is usually on, logically
kvm_arch_vcpu_async_ioctl() definition should be wrapped with
CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL #ifdef.

This patch adds the #ifdef surround.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/mips/kvm/mips.c       | 2 ++
 arch/powerpc/kvm/powerpc.c | 2 ++
 arch/s390/kvm/kvm-s390.c   | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 2549fdd..4d593e5 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -903,6 +903,7 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 	return r;
 }
 
+#ifdef CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL
 long kvm_arch_vcpu_async_ioctl(struct file *filp, unsigned int ioctl,
 			       unsigned long arg)
 {
@@ -922,6 +923,7 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp, unsigned int ioctl,
 
 	return -ENOIOCTLCMD;
 }
+#endif
 
 long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
 			 unsigned long arg)
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 403e642..2adca3c 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1757,6 +1757,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 	return -EINVAL;
 }
 
+#ifdef CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL
 long kvm_arch_vcpu_async_ioctl(struct file *filp,
 			       unsigned int ioctl, unsigned long arg)
 {
@@ -1771,6 +1772,7 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp,
 	}
 	return -ENOIOCTLCMD;
 }
+#endif
 
 long kvm_arch_vcpu_ioctl(struct file *filp,
                          unsigned int ioctl, unsigned long arg)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 77d7818..c499396 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3784,6 +3784,7 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
 	return r;
 }
 
+#ifdef CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL
 long kvm_arch_vcpu_async_ioctl(struct file *filp,
 			       unsigned int ioctl, unsigned long arg)
 {
@@ -3811,6 +3812,7 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp,
 	}
 	return -ENOIOCTLCMD;
 }
+#endif
 
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg)
-- 
1.8.3.1
