Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 2/5 v2] s390/setup: use memblock_first_region_size helper
Date: Tue,  1 Sep 2015 20:27:24 +0600
Message-Id: <1441117644-30644-1-git-send-email-kuleshovmail@gmail.com>
In-Reply-To: <1441117527-30466-1-git-send-email-kuleshovmail@gmail.com>
References: <1441117527-30466-1-git-send-email-kuleshovmail@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

The 0a11142e commit (mm/memblock: Introduce memblock_first_region_size()
helper) introduced memblock_first_region_size() helper for the getting
size of the first memblock region. Let's use it instead of directly access
to structure.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 arch/s390/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index ca070d2..69c3859 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -563,7 +563,7 @@ static void __init reserve_crashkernel(void)
 	if (rc || crash_size == 0)
 		return;
 
-	if (memblock.memory.regions[0].size < crash_size) {
+	if (memblock_first_region_size() < crash_size) {
 		pr_info("crashkernel reservation failed: %s\n",
 			"first memory chunk must be at least crashkernel size");
 		return;
-- 
2.5.0
