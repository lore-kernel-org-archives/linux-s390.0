Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH v2 3/7] s390/topology: Remove the unused parent_node() macro
Date: Fri, 1 Sep 2017 10:56:35 +0800
Message-ID: <1504234599-29533-4-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1504234599-29533-1-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1504234599-29533-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Commit a7be6e5a7f8d ("mm: drop useless local parameters of
__register_one_node()") removes the last user of parent_node().

The parent_node() macro in S390 platform is unnecessary.

Remove it for cleanup.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/topology.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/s390/include/asm/topology.h b/arch/s390/include/asm/topology.h
index fa1bfce..5222da1 100644
--- a/arch/s390/include/asm/topology.h
+++ b/arch/s390/include/asm/topology.h
@@ -77,12 +77,6 @@ static inline const struct cpumask *cpumask_of_node(int node)
 	return &node_to_cpumask_map[node];
 }
 
-/*
- * Returns the number of the node containing node 'node'. This
- * architecture is flat, so it is a pretty simple function!
- */
-#define parent_node(node) (node)
-
 #define pcibus_to_node(bus) __pcibus_to_node(bus)
 
 #define node_distance(a, b) __node_distance(a, b)
-- 
2.5.5
