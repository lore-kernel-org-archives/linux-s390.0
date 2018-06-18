Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] s390: hypfs: use ktime_get_seconds() instead of get_seconds()
Date: Mon, 18 Jun 2018 12:05:00 +0200
Message-Id: <20180618100534.1857997-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

time_t and get_seconds() are deprecated because they will overflow on
32-bit architectures in the future. This is not a problem on 64-bit s390,
but we should use proper interfaces anyway.

Besides moving to the time64_t based interface, the CLOCK_MONOTONIC
based ktime_get_seconds() is preferred for kernel internal timekeeping
because it does not behave in unexpected ways during leap second changes
or settimeofday() calls.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/hypfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 06b513d192b9..c681329fdeec 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -36,7 +36,7 @@ struct hypfs_sb_info {
 	kuid_t uid;			/* uid used for files and dirs */
 	kgid_t gid;			/* gid used for files and dirs */
 	struct dentry *update_file;	/* file to trigger update */
-	time_t last_update;		/* last update time in secs since 1970 */
+	time64_t last_update;		/* last update, CLOCK_MONOTONIC time */
 	struct mutex lock;		/* lock to protect update process */
 };
 
@@ -52,7 +52,7 @@ static void hypfs_update_update(struct super_block *sb)
 	struct hypfs_sb_info *sb_info = sb->s_fs_info;
 	struct inode *inode = d_inode(sb_info->update_file);
 
-	sb_info->last_update = get_seconds();
+	sb_info->last_update = ktime_get_seconds();
 	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 }
 
@@ -179,7 +179,7 @@ static ssize_t hypfs_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	 *    to restart data collection in this case.
 	 */
 	mutex_lock(&fs_info->lock);
-	if (fs_info->last_update == get_seconds()) {
+	if (fs_info->last_update == ktime_get_seconds()) {
 		rc = -EBUSY;
 		goto out;
 	}
-- 
2.9.0
