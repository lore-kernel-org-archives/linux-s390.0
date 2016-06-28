Return-Path: <xinhui.pan@linux.vnet.ibm.com>
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v2 2/4] powerpc/spinlock: support vcpu preempted check
Date: Tue, 28 Jun 2016 10:43:09 -0400
In-Reply-To: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Message-Id: <1467124991-13164-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, waiman.long@hpe.com, will.deacon@arm.com, boqun.feng@gmail.com, dave@stgolabs.net, schwidefsky@de.ibm.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This is to fix some lock holder preemption issues. Some other locks
implementation do a spin loop before acquiring the lock itself. Currently
kernel has an interface of bool vcpu_is_preempted(int cpu). It take the cpu
as parameter and return true if the cpu is preempted. Then kernel can break
the spin loops upon on the retval of vcpu_is_preempted.

As kernel has used this interface, So lets support it.

Only pSeries need supoort it. And the fact is powerNV are built into same
kernel image with pSeries. So we need return false if we are runnig as
powerNV. The another fact is that lppaca->yiled_count keeps zero on
powerNV. So we can just skip the machine type.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/spinlock.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 523673d..3ac9fcb 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -52,6 +52,24 @@
 #define SYNC_IO
 #endif
 
+/*
+ * This support kernel to check if one cpu is preempted or not.
+ * Then we can fix some lock holder preemption issue.
+ */
+#ifdef CONFIG_PPC_PSERIES
+#define vcpu_is_preempted vcpu_is_preempted
+static inline bool vcpu_is_preempted(int cpu)
+{
+	/*
+	 * pSeries and powerNV can be built into same kernel image. In
+	 * principle we need return false directly if we are running as
+	 * powerNV. However the yield_count is always zero on powerNV, So
+	 * skip such machine type check
+	 */
+	return !!(be32_to_cpu(lppaca_of(cpu).yield_count) & 1);
+}
+#endif
+
 static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 {
 	return lock.slock == 0;
-- 
2.4.11
