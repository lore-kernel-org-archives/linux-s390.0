Return-Path: <SRS0=+MMY=S7=vger.kernel.org=kvm-owner@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 09/12] KVM: polling: add architecture backend to disable polling
Date: Mon, 29 Apr 2019 11:09:59 +0200
In-Reply-To: <20190429091002.71164-1-borntraeger@de.ibm.com>
References: <20190429091002.71164-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190429091002.71164-10-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

There are cases where halt polling is unwanted. For example when running
KVM on an over committed LPAR we rather want to give back the CPU to
neighbour LPARs instead of polling. Let us provide a callback that
allows architectures to disable polling.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/kvm_host.h | 10 ++++++++++
 virt/kvm/Kconfig         |  3 +++
 virt/kvm/kvm_main.c      |  2 +-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9d55c63db09b..b3aff1a3f633 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1305,6 +1305,16 @@ static inline bool vcpu_valid_wakeup(struct kvm_vcpu *vcpu)
 }
 #endif /* CONFIG_HAVE_KVM_INVALID_WAKEUPS */
 
+#ifdef CONFIG_HAVE_KVM_NO_POLL
+/* Callback that tells if we must not poll */
+bool kvm_arch_no_poll(struct kvm_vcpu *vcpu);
+#else
+static inline bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+#endif /* CONFIG_HAVE_KVM_NO_POLL */
+
 #ifdef CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL
 long kvm_arch_vcpu_async_ioctl(struct file *filp,
 			       unsigned int ioctl, unsigned long arg);
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index ea434ddc8499..aad9284c043a 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -57,3 +57,6 @@ config HAVE_KVM_VCPU_ASYNC_IOCTL
 
 config HAVE_KVM_VCPU_RUN_PID_CHANGE
        bool
+
+config HAVE_KVM_NO_POLL
+       bool
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 55fe8e20d8fd..23aec2f4ba71 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2253,7 +2253,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 	u64 block_ns;
 
 	start = cur = ktime_get();
-	if (vcpu->halt_poll_ns) {
+	if (vcpu->halt_poll_ns && !kvm_arch_no_poll(vcpu)) {
 		ktime_t stop = ktime_add_ns(ktime_get(), vcpu->halt_poll_ns);
 
 		++vcpu->stat.halt_attempted_poll;
-- 
2.19.1
