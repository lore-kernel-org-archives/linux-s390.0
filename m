Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Huaisheng Ye <yehs2007@zoho.com>
Subject: [PATCH 4/5] filesystem-dax: Do not request a pointer kaddr when not required
Date: Tue, 24 Jul 2018 16:45:09 +0800
Message-Id: <20180724084510.6104-5-yehs2007@zoho.com>
In-Reply-To: <20180724084510.6104-1-yehs2007@zoho.com>
References: <20180724084510.6104-1-yehs2007@zoho.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Cc: ross.zwisler@linux.intel.com, willy@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, viro@zeniv.linux.org.uk, martin.petersen@oracle.com, axboe@kernel.dk, gregkh@linuxfoundation.org, bart.vanassche@wdc.com, jack@suse.cz, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
List-ID: <linux-s390.vger.kernel.org>

From: Huaisheng Ye <yehs1@lenovo.com>

Some functions within fs/dax don't need to get pointer kaddr from
direct_access. In support of allowing memmap initialization to run
in the background elide requests for pointer kaddr when not required.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 fs/dax.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index aaec72de..abdb9e2 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -870,7 +870,6 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
 {
 	const sector_t sector = dax_iomap_sector(iomap, pos);
 	pgoff_t pgoff;
-	void *kaddr;
 	int id, rc;
 	long length;
 
@@ -879,7 +878,7 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
 		return rc;
 	id = dax_read_lock();
 	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
-				   &kaddr, pfnp);
+				   NULL, pfnp);
 	if (length < 0) {
 		rc = length;
 		goto out;
-- 
1.8.3.1
