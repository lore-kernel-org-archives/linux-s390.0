Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC 5/7] m68k/mm: use __ClearPageReserved()
Date: Wed,  5 Dec 2018 13:28:49 +0100
Message-Id: <20181205122851.5891-6-david@redhat.com>
In-Reply-To: <20181205122851.5891-1-david@redhat.com>
References: <20181205122851.5891-1-david@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: linux-mm@kvack.org
Cc: linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>, linux-m68k@lists.linux-m68k.org, linux-mediatek@lists.infradead.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

The PG_reserved flag is cleared from memory that is part of the kernel
image (and therefore marked as PG_reserved). Avoid using PG_reserved
directly.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/m68k/mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/mm/memory.c b/arch/m68k/mm/memory.c
index b86a2e21693b..227c04fe60d2 100644
--- a/arch/m68k/mm/memory.c
+++ b/arch/m68k/mm/memory.c
@@ -51,7 +51,7 @@ void __init init_pointer_table(unsigned long ptable)
 	pr_debug("init_pointer_table: %lx, %x\n", ptable, PD_MARKBITS(dp));
 
 	/* unreserve the page so it's possible to free that page */
-	PD_PAGE(dp)->flags &= ~(1 << PG_reserved);
+	__ClearPageReserved(PD_PAGE(dp));
 	init_page_count(PD_PAGE(dp));
 
 	return;
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
