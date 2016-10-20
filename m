From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v5 6/9] x86, kvm: support vcpu preempted check
Date: Thu, 20 Oct 2016 17:27:51 -0400
Message-ID: <1476998874-2089-7-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com, will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com, pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com, borntraeger@de.ibm.com, rkrcmar@redhat.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Support the vcpu_is_preempted() functionality under KVM. This will
enhance lock performance on overcommitted hosts (more runnable vcpus
than physical cpus in the system) as doing busy waits for preempted
vcpus will hurt system performance far worse than early yielding.

Use one field of struct kvm_steal_time to indicate that if one vcpu
is running or not.

unix benchmark result:
host:  kernel 4.8.1, i5-4570, 4 cpus
guest: kernel 4.8.1, 8 vcpus

        test-case                       after-patch       before-patch
Execl Throughput                       |    18307.9 lps  |    11701.6 lps
File Copy 1024 bufsize 2000 maxblocks  |  1352407.3 KBps |   790418.9 KBps
File Copy 256 bufsize 500 maxblocks    |   367555.6 KBps |   222867.7 KBps
File Copy 4096 bufsize 8000 maxblocks  |  3675649.7 KBps |  1780614.4 KBps
Pipe Throughput                        | 11872208.7 lps  | 11855628.9 lps
Pipe-based Context Switching           |  1495126.5 lps  |  1490533.9 lps
Process Creation                       |    29881.2 lps  |    28572.8 lps
Shell Scripts (1 concurrent)           |    23224.3 lpm  |    22607.4 lpm
Shell Scripts (8 concurrent)           |     3531.4 lpm  |     3211.9 lpm
System Call Overhead                   | 10385653.0 lps  | 10419979.0 lps

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/x86/include/uapi/asm/kvm_para.h |  3 ++-
 arch/x86/kernel/kvm.c                | 12 ++++++++++++
 arch/x86/kvm/x86.c                   | 18 ++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 94dc8ca..b3fec56 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -45,7 +45,8 @@ struct kvm_steal_time {
 	__u64 steal;
 	__u32 version;
 	__u32 flags;
-	__u32 pad[12];
+	__u8 preempted;
+	__u32 pad[11];
 };
 
 #define KVM_STEAL_ALIGNMENT_BITS 5
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index edbbfc8..0b48dd2 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -415,6 +415,15 @@ void kvm_disable_steal_time(void)
 	wrmsr(MSR_KVM_STEAL_TIME, 0, 0);
 }
 
+static bool kvm_vcpu_is_preempted(int cpu)
+{
+	struct kvm_steal_time *src;
+
+	src = &per_cpu(steal_time, cpu);
+
+	return !!src->preempted;
+}
+
 #ifdef CONFIG_SMP
 static void __init kvm_smp_prepare_boot_cpu(void)
 {
@@ -471,6 +480,9 @@ void __init kvm_guest_init(void)
 	if (kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
 		has_steal_clock = 1;
 		pv_time_ops.steal_clock = kvm_steal_clock;
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+		pv_lock_ops.vcpu_is_preempted = kvm_vcpu_is_preempted;
+#endif
 	}
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6c633de..a627537 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2057,6 +2057,8 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 		&vcpu->arch.st.steal, sizeof(struct kvm_steal_time))))
 		return;
 
+	vcpu->arch.st.steal.preempted = 0;
+
 	if (vcpu->arch.st.steal.version & 1)
 		vcpu->arch.st.steal.version += 1;  /* first time write, random junk */
 
@@ -2810,8 +2812,24 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
 }
 
+static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
+{
+	if (!(vcpu->arch.st.msr_val & KVM_MSR_ENABLED))
+		return;
+
+	if (unlikely(kvm_read_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
+			&vcpu->arch.st.steal, sizeof(struct kvm_steal_time))))
+		return;
+
+	vcpu->arch.st.steal.preempted = 1;
+
+	kvm_write_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
+			&vcpu->arch.st.steal, sizeof(struct kvm_steal_time));
+}
+
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
+	kvm_steal_time_set_preempted(vcpu);
 	kvm_x86_ops->vcpu_put(vcpu);
 	kvm_put_guest_fpu(vcpu);
 	vcpu->arch.last_host_tsc = rdtsc();
-- 
2.4.11
