Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Huaisheng Ye <yehs2007@zoho.com>
Subject: [PATCH v2 3/4] s390/block/dcssblk: check the validity of the pointer pfn
Date: Thu,  5 Jul 2018 00:38:22 +0800
Message-Id: <20180704163823.9980-4-yehs2007@zoho.com>
In-Reply-To: <20180704163823.9980-1-yehs2007@zoho.com>
References: <20180704163823.9980-1-yehs2007@zoho.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Cc: ross.zwisler@linux.intel.com, willy@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, viro@zeniv.linux.org.uk, martin.petersen@oracle.com, axboe@kernel.dk, gregkh@linuxfoundation.org, bart.vanassche@wdc.com, jack@suse.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, colyli@suse.de, chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
List-ID: <linux-s390.vger.kernel.org>

From: Huaisheng Ye <yehs1@lenovo.com>

direct_access needs to check the validity of pointer pfn for NULL
assignment. If pfn equals to NULL, it doesn't need to calculate the value.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 drivers/s390/block/dcssblk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 0a312e4..5cdfa02 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -916,7 +916,8 @@ static DEVICE_ATTR(save, S_IWUSR | S_IRUSR, dcssblk_save_show,
 
 	dev_sz = dev_info->end - dev_info->start + 1;
 	*kaddr = (void *) dev_info->start + offset;
-	*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset),
+	if (pfn)
+		*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset),
 			PFN_DEV|PFN_SPECIAL);
 
 	return (dev_sz - offset) / PAGE_SIZE;
-- 
1.8.3.1
