Return-Path: <linux-kernel-owner@vger.kernel.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] s390/hypfs: Use kmalloc_array() in diag0c_store()
Message-ID: <5fd5f9ef-923f-4655-54f0-874114dc9428@users.sourceforge.net>
Date: Thu, 1 Sep 2016 11:38:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Sep 2016 11:30:58 +0200

A multiplication for the size determination of a memory allocation
indicated that an array data structure should be processed.
Thus use the corresponding function "kmalloc_array".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/hypfs/hypfs_diag0c.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/hypfs/hypfs_diag0c.c b/arch/s390/hypfs/hypfs_diag0c.c
index 0f1927c..61418a8 100644
--- a/arch/s390/hypfs/hypfs_diag0c.c
+++ b/arch/s390/hypfs/hypfs_diag0c.c
@@ -48,7 +48,9 @@ static void *diag0c_store(unsigned int *count)
 
 	get_online_cpus();
 	cpu_count = num_online_cpus();
-	cpu_vec = kmalloc(sizeof(*cpu_vec) * num_possible_cpus(), GFP_KERNEL);
+	cpu_vec = kmalloc_array(num_possible_cpus(),
+				sizeof(*cpu_vec),
+				GFP_KERNEL);
 	if (!cpu_vec)
 		goto fail_put_online_cpus;
 	/* Note: Diag 0c needs 8 byte alignment and real storage */
-- 
2.9.3
