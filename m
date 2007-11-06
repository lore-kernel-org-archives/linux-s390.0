Return-Path: <linux-kernel-owner+w=401wt.eu-S1755501AbXKFUIv@vger.kernel.org>
Date: Wed, 7 Nov 2007 01:38:07 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: [PATCH] mm snapshot broken-out-2007-11-06-02-32 - conflict in vxfs_iget ()
Message-ID: <20071106200807.GC13674@linux.vnet.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org, linux390@de.ibm.com, linux-s390@vger.kernel.org, dhowells@redhat.com, hch@lst.de, apw@shadowen.org
List-ID: <linux-s390.vger.kernel.org>

Hi Andrew,

The kernel build fails on S390, with error 

 CC [M]  fs/freevxfs/vxfs_inode.o
fs/freevxfs/vxfs_inode.c:298: error: conflicting types for 'vxfs_iget'
fs/freevxfs/vxfs_extern.h:61: error: previous declaration of 'vxfs_iget' was here
fs/freevxfs/vxfs_inode.c:298: error: conflicting types for 'vxfs_iget'
fs/freevxfs/vxfs_extern.h:61: error: previous declaration of 'vxfs_iget' was here
make[2]: *** [fs/freevxfs/vxfs_inode.o] Error 1
make[1]: *** [fs/freevxfs] Error 2
make: *** [fs] Error 2

This error is caused by iget-stop-freevxfs-from-using-iget-and-read_inode.patch,
where the function proto type is declared as 
vxfs_iget(struct super_block *, unsigned long) and defined as 
vxfs_iget(struct super_block *sbp, ino_t ino)

This patch has been tested for the buid failure.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
--
--- linux-2.6.24-rc1/fs/freevxfs/vxfs_extern.h	2007-11-06 17:04:04.000000000 +0530
+++ linux-2.6.24-rc1/fs/freevxfs/~vxfs_extern.h	2007-11-07 00:45:09.000000000 +0530
@@ -58,7 +58,7 @@ extern struct inode *		vxfs_get_fake_ino
 extern void			vxfs_put_fake_inode(struct inode *);
 extern struct vxfs_inode_info *	vxfs_blkiget(struct super_block *, u_long, ino_t);
 extern struct vxfs_inode_info *	vxfs_stiget(struct super_block *, ino_t);
-extern struct inode *		vxfs_iget(struct super_block *, unsigned long);
+extern struct inode *		vxfs_iget(struct super_block *sbp, ino_t ino);
 extern void			vxfs_clear_inode(struct inode *);
 
 /* vxfs_lookup.c */

--
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
