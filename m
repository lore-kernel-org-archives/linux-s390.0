From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [BUG Fix Patch 5/6] Bug fix: Fix the wrong comments of map_entries.
Date: Tue, 15 Jan 2013 18:54:26 +0800
Message-ID: <1358247267-18089-6-git-send-email-tangchen@cn.fujitsu.com>
References: <1358247267-18089-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1358247267-18089-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: akpm@linux-foundation.org, rientjes@google.com, len.brown@intel.com, benh@kernel.crashing.org, paulus@samba.org, cl@linux.com, minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, wujianguo@huawei.com, wency@cn.fujitsu.com, tangchen@cn.fujitsu.com, hpa@zytor.com, linfeng@cn.fujitsu.com, laijs@cn.fujitsu.com, mgorman@suse.de, yinghai@kernel.org, glommer@parallels.com, jiang.liu@huawei.com
Cc: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-ia64@vger.kernel.org, cmetcalf@tilera.com, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Now we have a map_entries_lock to protect map_entries list.
So we need to update the comments.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 drivers/firmware/memmap.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/memmap.c b/drivers/firmware/memmap.c
index 940c4e9..ae823b4 100644
--- a/drivers/firmware/memmap.c
+++ b/drivers/firmware/memmap.c
@@ -108,11 +108,7 @@ static struct kobj_type memmap_ktype = {
  * Registration functions ------------------------------------------------------
  */
 
-/*
- * Firmware memory map entries. No locking is needed because the
- * firmware_map_add() and firmware_map_add_early() functions are called
- * in firmware initialisation code in one single thread of execution.
- */
+/* Firmware memory map entries. */
 static LIST_HEAD(map_entries);
 static DEFINE_SPINLOCK(map_entries_lock);
 
-- 
1.7.1

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
