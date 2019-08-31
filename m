Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH v2 6/9] sh: numa: check the node id consistently for sh
Date: Sat, 31 Aug 2019 13:58:20 +0800
Message-ID: <1567231103-13237-7-git-send-email-linyunsheng@huawei.com>
In-Reply-To: <1567231103-13237-1-git-send-email-linyunsheng@huawei.com>
References: <1567231103-13237-1-git-send-email-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com, bp@alien8.de, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, jiaxun.yang@flygoat.com, chenhc@lemote.com
Cc: akpm@linux-foundation.org, rppt@linux.ibm.com, anshuman.khandual@arm.com, tglx@linutronix.de, cai@lca.pw, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, len.brown@intel.com, axboe@kernel.dk, dledford@redhat.com, jeffrey.t.kirsher@intel.com, linux-alpha@vger.kernel.org, nfont@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, tbogendoerfer@suse.de, linux-mips@vger.kernel.org, linuxarm@huawei.com

According to Section 6.2.14 from ACPI spec 6.3 [1], the setting
of proximity domain is optional, as below:

This optional object is used to describe proximity domain
associations within a machine. _PXM evaluates to an integer
that identifies a device as belonging to a Proximity Domain
defined in the System Resource Affinity Table (SRAT).

It seems sh does not have real numa support or uncompleted
numa support, this patch still checks node id with the below
case to ensure future support is consistent:
1. if node_id >= nr_node_ids, return cpu_none_mask
2. if node_id < 0, return cpu_online_mask
3. if node_to_cpumask_map[node_id] is NULL, return cpu_online_mask

[1] https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 arch/sh/include/asm/topology.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/topology.h b/arch/sh/include/asm/topology.h
index 1db470e..e71e0a0 100644
--- a/arch/sh/include/asm/topology.h
+++ b/arch/sh/include/asm/topology.h
@@ -6,7 +6,19 @@
 
 #define cpu_to_node(cpu)	((void)(cpu),0)
 
-#define cpumask_of_node(node)	((void)node, cpu_online_mask)
+static inline const struct cpumask *cpumask_of_node(int node)
+{
+	if (node >= nr_node_ids)
+		return cpu_none_mask;
+
+	if (node < 0 || !node_to_cpumask_map[node])
+		return cpu_online_mask;
+
+	/* Should return actual mask based on node_to_cpumask_map
+	 * if sh arch supports real numa node.
+	 */
+	return cpu_online_mask;
+}
 
 #define pcibus_to_node(bus)	((void)(bus), -1)
 #define cpumask_of_pcibus(bus)	(pcibus_to_node(bus) == -1 ? \
-- 
2.8.1
