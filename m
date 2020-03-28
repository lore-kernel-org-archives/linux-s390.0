Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-co1nam11on2105.outbound.protection.outlook.com ([40.107.220.105]:37857
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727286AbgC1Sby (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 28 Mar 2020 14:31:54 -0400
From: Hoan Tran <Hoan@os.amperecomputing.com>
Subject: [PATCH v3 3/5] x86: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
Date: Sat, 28 Mar 2020 11:31:20 -0700
Message-Id: <1585420282-25630-4-git-send-email-Hoan@os.amperecomputing.com>
In-Reply-To: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
References: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
Content-Type: text/plain
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Mike Rapoport <rppt@linux.ibm.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, lho@amperecomputing.com, mmorana@amperecomputing.com, Hoan Tran <Hoan@os.amperecomputing.com>

Remove CONFIG_NODES_SPAN_OTHER_NODES as it's enabled
by default. It is now enabled for x86(32 bit) configurations
and do not depend on X64_64_ACPI_NUMA config.
Because of that, on NUMA enabled system, early_pfn_in_nid() 
function is called by memmap_init_zone() during boot-time.
It doesn't affect the performance at run-time.

Signed-off-by: Hoan Tran <Hoan@os.amperecomputing.com>
---
 arch/x86/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5e89499..a938738 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1581,15 +1581,6 @@ config X86_64_ACPI_NUMA
 	---help---
 	  Enable ACPI SRAT based node topology detection.
 
-# Some NUMA nodes have memory ranges that span
-# other nodes.  Even though a pfn is valid and
-# between a node's start and end pfns, it may not
-# reside on that node.  See memmap_init_zone()
-# for details.
-config NODES_SPAN_OTHER_NODES
-	def_bool y
-	depends on X86_64_ACPI_NUMA
-
 config NUMA_EMU
 	bool "NUMA emulation"
 	depends on NUMA
-- 
1.8.3.1
