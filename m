Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 5 Jan 2016 18:17:53 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] s390: drop smp_mb in vdso_init
Message-ID: <1452010645-25380-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The initial s390 vdso code is heavily influenced by the powerpc version
which does have a smp_wmb in vdso_init right before the vdso_ready=1
assignment. s390 has no need for that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Untested.

 arch/s390/kernel/vdso.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 59eddb0..a1cfd37 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -299,8 +299,6 @@ static int __init vdso_init(void)
 
 	get_page(virt_to_page(vdso_data));
 
-	smp_mb();
-
 	return 0;
 }
 early_initcall(vdso_init);
-- 
MST
