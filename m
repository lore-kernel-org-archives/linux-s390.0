Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
From: xiaolinkui <xiaolinkui@kylinos.cn>
Subject: [PATCH] arch: s390: use struct_size() in kmalloc()
Date: Fri, 17 May 2019 15:15:17 +0800
Message-Id: <1558077317-12201-1-git-send-email-xiaolinkui@kylinos.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn
List-ID: <linux-s390.vger.kernel.org>

Use the new struct_size() helper to keep code simple.

Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>
---
 arch/s390/include/asm/idals.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/idals.h b/arch/s390/include/asm/idals.h
index 15578fd..6fb7ace 100644
--- a/arch/s390/include/asm/idals.h
+++ b/arch/s390/include/asm/idals.h
@@ -122,8 +122,7 @@ idal_buffer_alloc(size_t size, int page_order)
 
 	nr_ptrs = (size + IDA_BLOCK_SIZE - 1) >> IDA_SIZE_LOG;
 	nr_chunks = (4096 << page_order) >> IDA_SIZE_LOG;
-	ib = kmalloc(sizeof(struct idal_buffer) + nr_ptrs*sizeof(void *),
-		     GFP_DMA | GFP_KERNEL);
+	ib = kmalloc(struct_size(ib, data, nr_ptrs), GFP_DMA | GFP_KERNEL);
 	if (ib == NULL)
 		return ERR_PTR(-ENOMEM);
 	ib->size = size;
-- 
2.7.4
