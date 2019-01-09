Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 9 Jan 2019 11:35:41 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] s390/hypfs: Use struct_size() in kzalloc()
Message-ID: <20190109173541.GA16953@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-ID: <linux-s390.vger.kernel.org>

One of the more common cases of allocation size calculations is finding the
size of a structure that has a zero-sized array at the end, along with memory
for some number of elements for that array. For example:

struct foo {
    int stuff;
    void *entry[];
};

instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can now
use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/s390/hypfs/hypfs_diag0c.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_diag0c.c b/arch/s390/hypfs/hypfs_diag0c.c
index cebf05150cc1..9c398bf0ddc6 100644
--- a/arch/s390/hypfs/hypfs_diag0c.c
+++ b/arch/s390/hypfs/hypfs_diag0c.c
@@ -54,8 +54,7 @@ static void *diag0c_store(unsigned int *count)
 	if (!cpu_vec)
 		goto fail_put_online_cpus;
 	/* Note: Diag 0c needs 8 byte alignment and real storage */
-	diag0c_data = kzalloc(sizeof(struct hypfs_diag0c_hdr) +
-			      cpu_count * sizeof(struct hypfs_diag0c_entry),
+	diag0c_data = kzalloc(struct_size(diag0c_data, entry, cpu_count),
 			      GFP_KERNEL | GFP_DMA);
 	if (!diag0c_data)
 		goto fail_kfree_cpu_vec;
-- 
2.20.1
