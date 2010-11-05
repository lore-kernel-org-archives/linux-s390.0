Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Joe Perches <joe@perches.com>
Subject: [PATCH 04/49] arch/s390: Use vzalloc
Date: Thu,  4 Nov 2010 20:07:28 -0700
Message-Id: <4860ebaf7a0b6851c44d83be77db188e19a5388e.1288925424.git.joe@perches.com>
In-Reply-To: <alpine.DEB.2.00.1011031108260.11625@router.home>
References: <alpine.DEB.2.00.1011031108260.11625@router.home>
In-Reply-To: <cover.1288925424.git.joe@perches.com>
References: <cover.1288925424.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jiri Kosina <trivial@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/s390/hypfs/hypfs_diag.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index cd4a81b..1b1acef 100644
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -570,12 +570,11 @@ static int dbfs_d204_open(struct inode *inode, struct file *file)
 	if (!data)
 		return -ENOMEM;
 	buf_size = PAGE_SIZE * (diag204_buf_pages + 1) + sizeof(d204->hdr);
-	data->base = vmalloc(buf_size);
+	data->base = vzalloc(buf_size);
 	if (!data->base) {
 		rc = -ENOMEM;
 		goto fail_kfree_data;
 	}
-	memset(data->base, 0, buf_size);
 	d204 = page_align_ptr(data->base + sizeof(d204->hdr))
 		- sizeof(d204->hdr);
 	rc = diag204_do_store(&d204->buf, diag204_buf_pages);
-- 
1.7.3.1.g432b3.dirty
