Return-Path: <linux-arch-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 31/31] dma-mapping-common: skip kmemleak checks for page-less SG entries
Date: Wed, 12 Aug 2015 09:05:50 +0200
Message-ID: <1439363150-8661-32-git-send-email-hch@lst.de>
In-Reply-To: <1439363150-8661-1-git-send-email-hch@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20150812070550.1aJYMla-hPqtiGw2j2RultlLA3OrKwQ7aFotz1zyU4o@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: torvalds@linux-foundation.org, axboe@kernel.dk
Cc: dan.j.williams@intel.com, vgupta@synopsys.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, dhowells@redhat.com, monstr@monstr.eu, x86@kernel.org, dwmw2@infradead.org, alex.williamson@redhat.com, grundler@parisc-linux.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-nvdimm@ml01.01.org, linux-media@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/asm-generic/dma-mapping-common.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/dma-mapping-common.h b/include/asm-generic/dma-mapping-common.h
index 940d5ec..afc3eaf 100644
--- a/include/asm-generic/dma-mapping-common.h
+++ b/include/asm-generic/dma-mapping-common.h
@@ -51,8 +51,10 @@ static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 	int i, ents;
 	struct scatterlist *s;
 
-	for_each_sg(sg, s, nents, i)
-		kmemcheck_mark_initialized(sg_virt(s), s->length);
+	for_each_sg(sg, s, nents, i) {
+		if (sg_has_page(s))
+			kmemcheck_mark_initialized(sg_virt(s), s->length);
+	}
 	BUG_ON(!valid_dma_direction(dir));
 	ents = ops->map_sg(dev, sg, nents, dir, attrs);
 	BUG_ON(ents < 0);
-- 
1.9.1
