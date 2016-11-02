From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v7 04/11] powerpc/spinlock: support vcpu preempted check
Date: Wed,  2 Nov 2016 05:08:31 -0400
Message-ID: <1478077718-37424-5-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Cc: kernellwp@gmail.com, jgross@suse.com, dave@stgolabs.net, David.Laight@ACULAB.COM, rkrcmar@redhat.com, peterz@infradead.org, benh@kernel.crashing.org, konrad.wilk@oracle.com, will.deacon@arm.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, pbonzini@redhat.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com
List-ID: <linux-s390.vger.kernel.org>

This is to fix some lock holder preemption issues. Some other locks
implementation do a spin loop before acquiring the lock itself.
Currently kernel has an interface of bool vcpu_is_preempted(int cpu). It
takes the cpu as parameter and return true if the cpu is preempted. Then
kernel can break the spin loops upon the retval of vcpu_is_preempted.

As kernel has used this interface, So lets support it.

Only pSeries need support it. And the fact is PowerNV is built into same
kernel image with pSeries. So we need return false if we are runnig as
PowerNV. The another fact is that lppaca->yiled_count keeps zero on
PowerNV. So we can just skip the machine type check.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/spinlock.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index fa37fe9..8c1b913 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -52,6 +52,14 @@
 #define SYNC_IO
 #endif
 
+#ifdef CONFIG_PPC_PSERIES
+#define vcpu_is_preempted vcpu_is_preempted
+static inline bool vcpu_is_preempted(int cpu)
+{
+	return !!(be32_to_cpu(lppaca_of(cpu).yield_count) & 1);
+}
+#endif
+
 static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 {
 	return lock.slock == 0;
-- 
2.4.11
