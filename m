From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 3/6] kvm: add kvm_enable_cap_{vm,vcpu}
Date: Tue, 25 Feb 2014 18:25:17 +0100
Message-ID: <1393349120-18228-4-git-send-email-cornelia.huck@de.ibm.com>
References: <1393349120-18228-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1393349120-18228-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, pbonzini@redhat.com, gleb@kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Provide helper functions for enabling capabilities (on a vcpu and on a vm).

Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 include/sysemu/kvm.h |    4 ++++
 kvm-all.c            |   19 ++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 3b25f27..9d2df88 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -272,6 +272,10 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cpu);
 
 int kvm_check_extension(KVMState *s, unsigned int extension);
 
+int kvm_enable_cap_vm(KVMState *s, unsigned int capability);
+
+int kvm_enable_cap_vcpu(CPUState *cpu, unsigned int capability);
+
 uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
                                       uint32_t index, int reg);
 
diff --git a/kvm-all.c b/kvm-all.c
index 2ca9143..6e6a804 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -499,7 +499,24 @@ int kvm_check_extension(KVMState *s, unsigned int extension)
     return ret;
 }
 
-static int kvm_set_ioeventfd_mmio(int fd, hwaddr addr, uint32_t val,
+int kvm_enable_cap_vm(KVMState *s, unsigned int capability)
+{
+    struct kvm_enable_cap cap = {};
+
+    cap.cap = capability;
+    return kvm_vm_ioctl(s, KVM_ENABLE_CAP, &cap);
+}
+
+int kvm_enable_cap_vcpu(CPUState *cpu, unsigned int capability)
+{
+    struct kvm_enable_cap cap = {};
+
+    cap.cap = capability;
+    return kvm_vcpu_ioctl(cpu, KVM_ENABLE_CAP, &cap);
+}
+
+
+static int kvm_set_ioeventfd_mmio(int fd, uint32_t addr, uint32_t val,
                                   bool assign, uint32_t size, bool datamatch)
 {
     int ret;
-- 
1.7.9.5
