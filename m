From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v7 09/11] x86, kernel/kvm.c: support vcpu preempted check
Date: Wed,  2 Nov 2016 05:08:36 -0400
Message-ID: <1478077718-37424-10-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com, will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com, pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com, borntraeger@de.ibm.com, rkrcmar@redhat.com, David.Laight@ACULAB.COM, dave@stgolabs.net, konrad.wilk@oracle.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Support the vcpu_is_preempted() functionality under KVM. This will
enhance lock performance on overcommitted hosts (more runnable vcpus
than physical cpus in the system) as doing busy waits for preempted
vcpus will hurt system performance far worse than early yielding.

struct kvm_steal_time::preempted indicate that if one vcpu is running or
not after commit("x86, kvm/x86.c: support vcpu preempted check").

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
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kernel/kvm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

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
-- 
2.4.11
