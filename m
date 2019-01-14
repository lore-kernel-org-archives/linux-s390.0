Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 1/9] agp: efficeon: no need to set PG_reserved on GATT
 tables
Date: Mon, 14 Jan 2019 13:58:55 +0100
Message-Id: <20190114125903.24845-2-david@redhat.com>
In-Reply-To: <20190114125903.24845-1-david@redhat.com>
References: <20190114125903.24845-1-david@redhat.com>
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
Cc: linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@redhat.com>, David Airlie <airlied@linux.ie>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>, linux-m68k@lists.linux-m68k.org, linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

The l1 GATT page table is kept in a special on-chip page with 64 entries.
We allocate the l2 page table pages via get_zeroed_page() and enter them
into the table. These l2 pages are modified accordingly when
inserting/removing memory via efficeon_insert_memory and
efficeon_remove_memory.

Apart from that, these pages are not exposed or ioremap'ed. We can stop
setting them reserved (propably copied from generic code).

Cc: David Airlie <airlied@linux.ie>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/char/agp/efficeon-agp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/agp/efficeon-agp.c b/drivers/char/agp/efficeon-agp.c
index 7f88490b5479..c53f0f9ef5b0 100644
--- a/drivers/char/agp/efficeon-agp.c
+++ b/drivers/char/agp/efficeon-agp.c
@@ -163,7 +163,6 @@ static int efficeon_free_gatt_table(struct agp_bridge_data *bridge)
 		unsigned long page = efficeon_private.l1_table[index];
 		if (page) {
 			efficeon_private.l1_table[index] = 0;
-			ClearPageReserved(virt_to_page((char *)page));
 			free_page(page);
 			freed++;
 		}
@@ -219,7 +218,6 @@ static int efficeon_create_gatt_table(struct agp_bridge_data *bridge)
 			efficeon_free_gatt_table(agp_bridge);
 			return -ENOMEM;
 		}
-		SetPageReserved(virt_to_page((char *)page));
 
 		for (offset = 0; offset < PAGE_SIZE; offset += clflush_chunk)
 			clflush((char *)page+offset);
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
