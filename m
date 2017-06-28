From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Wed, 28 Jun 2017 16:12:02 +0000
Subject: [CRIU][PATCH 4/7] criu/mount: Fix flags cast and sizeof(sflags)
Message-Id: <20170628161205.37787-5-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The "args" parameter in apply_sb_flags() is unsigned long. Therefore also
use unsigned long for the cast.

The "sflags" variable in do_new_mount() is unsigned long. Therefore use
sizeof(sflags) instead of sizeof(int).

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 criu/mount.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/criu/mount.c b/criu/mount.c
index b7c4785..5fe2c86 100644
--- a/criu/mount.c
+++ b/criu/mount.c
@@ -1774,8 +1774,8 @@ static char *mnt_fsname(struct mount_info *mi)
 
 static int apply_sb_flags(void *args, int fd, pid_t pid)
 {
+	unsigned long flags = *(unsigned long *) args;
 	int rst = -1, err = -1;
-	long flags = *(int *) args;
 	char path[PSFDS];
 
 	snprintf(path, sizeof(path), "/proc/self/fd/%d", fd);
@@ -1840,10 +1840,9 @@ static int do_new_mount(struct mount_info *mi)
 			pr_perror("Unable to open %s", mi->mountpoint);
 			return -1;
 		}
-
 		sflags |= MS_RDONLY;
 		if (userns_call(apply_sb_flags, 0,
-				&sflags, sizeof(int), fd)) {
+				&sflags, sizeof(sflags), fd)) {
 			pr_perror("Unable to apply mount falgs %d for %s",
 						mi->sb_flags, mi->mountpoint);
 			close(fd);
-- 
2.7.4
