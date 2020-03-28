Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-co1nam11on2090.outbound.protection.outlook.com ([40.107.220.90]:41121
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726937AbgC1ScK (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 28 Mar 2020 14:32:10 -0400
From: Hoan Tran <Hoan@os.amperecomputing.com>
Subject: [PATCH v3 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA
Date: Sat, 28 Mar 2020 11:31:17 -0700
Message-Id: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
Content-Type: text/plain
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Mike Rapoport <rppt@linux.ibm.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, lho@amperecomputing.com, mmorana@amperecomputing.com, Hoan Tran <Hoan@os.amperecomputing.com>

In NUMA layout which nodes have memory ranges that span across other nodes,
the mm driver can detect the memory node id incorrectly.

For example, with layout below
Node 0 address: 0000 xxxx 0000 xxxx
Node 1 address: xxxx 1111 xxxx 1111

Note:
 - Memory from low to high
 - 0/1: Node id
 - x: Invalid memory of a node

When mm probes the memory map, without CONFIG_NODES_SPAN_OTHER_NODES
config, mm only checks the memory validity but not the node id.
Because of that, Node 1 also detects the memory from node 0 as below
when it scans from the start address to the end address of node 1.

Node 0 address: 0000 xxxx xxxx xxxx
Node 1 address: xxxx 1111 1111 1111

This layout could occur on any architecture. Most of them enables
this config by default with CONFIG_NUMA. This patch, by default, enables
CONFIG_NODES_SPAN_OTHER_NODES or uses early_pfn_in_nid() for NUMA.

v3:
 * Revise the patch description

V2:
 * Revise the patch description

Hoan Tran (5):
  mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA
  powerpc: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
  x86: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
  sparc: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
  s390: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES

 arch/powerpc/Kconfig | 9 ---------
 arch/s390/Kconfig    | 8 --------
 arch/sparc/Kconfig   | 9 ---------
 arch/x86/Kconfig     | 9 ---------
 mm/page_alloc.c      | 2 +-
 5 files changed, 1 insertion(+), 36 deletions(-)

-- 
1.8.3.1
