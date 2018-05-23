Return-Path: <owner-linux-mm@kvack.org>
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFCv2 3/4] s390: numa: implement memory_add_physaddr_to_nid()
Date: Wed, 23 May 2018 20:24:03 +0200
Message-Id: <20180523182404.11433-4-david@redhat.com>
In-Reply-To: <20180523182404.11433-1-david@redhat.com>
References: <20180523182404.11433-1-david@redhat.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The common interface to be used with add_memory().

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-s390@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/numa/numa.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/s390/numa/numa.c b/arch/s390/numa/numa.c
index 06a80434cfe6..8902652ab3e5 100644
--- a/arch/s390/numa/numa.c
+++ b/arch/s390/numa/numa.c
@@ -44,6 +44,18 @@ int numa_pfn_to_nid(unsigned long pfn)
 	return mode->__pfn_to_nid ? mode->__pfn_to_nid(pfn) : 0;
 }
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+int memory_add_physaddr_to_nid(u64 addr)
+{
+	int nid = numa_pfn_to_nid(PFN_DOWN(addr));
+
+	if (nid < 0)
+		return 0;
+	return nid;
+}
+EXPORT_SYMBOL(memory_add_physaddr_to_nid);
+#endif
+
 void numa_update_cpu_topology(void)
 {
 	if (mode->update_cpu_topology)
-- 
2.17.0
