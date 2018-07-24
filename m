Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Huaisheng Ye <yehs2007@zoho.com>
Subject: [PATCH 5/5] dax/super: Do not request a pointer kaddr when not required
Date: Tue, 24 Jul 2018 16:45:10 +0800
Message-Id: <20180724084510.6104-6-yehs2007@zoho.com>
In-Reply-To: <20180724084510.6104-1-yehs2007@zoho.com>
References: <20180724084510.6104-1-yehs2007@zoho.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Cc: ross.zwisler@linux.intel.com, willy@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, viro@zeniv.linux.org.uk, martin.petersen@oracle.com, axboe@kernel.dk, gregkh@linuxfoundation.org, bart.vanassche@wdc.com, jack@suse.cz, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
List-ID: <linux-s390.vger.kernel.org>

From: Huaisheng Ye <yehs1@lenovo.com>

Some functions within driver/dax don't need to get pointer kaddr from
direct_access. In support of allowing memmap initialization to run in
the background elide requests for pointer kaddr when not required.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/dax/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 2b2332b..fad68d2 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -88,7 +88,6 @@ int __bdev_dax_supported(struct super_block *sb, int blocksize)
 	struct dax_device *dax_dev;
 	pgoff_t pgoff;
 	int err, id;
-	void *kaddr;
 	pfn_t pfn;
 	long len;
 
@@ -113,7 +112,7 @@ int __bdev_dax_supported(struct super_block *sb, int blocksize)
 	}
 
 	id = dax_read_lock();
-	len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn);
+	len = dax_direct_access(dax_dev, pgoff, 1, NULL, &pfn);
 	dax_read_unlock(id);
 
 	put_dax(dax_dev);
-- 
1.8.3.1
