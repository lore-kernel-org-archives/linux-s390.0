Return-Path: <linux-kernel-owner+w=401wt.eu-S1758725AbYH0Ny7@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 05/59] CRED: Wrap task credential accesses in the S390 arch
Date: Wed, 27 Aug 2008 14:46:08 +0100
Message-ID: <20080827134607.19980.15480.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080827134541.19980.61042.stgit@warthog.procyon.org.uk>
References: <20080827134541.19980.61042.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, David Howells <dhowells@redhat.com>, Serge Hallyn <serue@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Wrap access to task credentials so that they can be separated more easily from
the task_struct during the introduction of COW creds.

Change most current->(|e|s|fs)[ug]id to current_(|e|s|fs)[ug]id().

Change some task->e?[ug]id to task_e?[ug]id().  In some places it makes more
sense to use RCU directly rather than a convenient wrapper; these will be
addressed by later patches.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: James Morris <jmorris@namei.org>
Acked-by: Serge Hallyn <serue@us.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---

 arch/s390/hypfs/inode.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 7383781..5a11c77 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -280,8 +280,8 @@ static int hypfs_fill_super(struct super_block *sb, void *data, int silent)
 	if (!sbi)
 		return -ENOMEM;
 	mutex_init(&sbi->lock);
-	sbi->uid = current->uid;
-	sbi->gid = current->gid;
+	sbi->uid = current_uid();
+	sbi->gid = current_gid();
 	sb->s_fs_info = sbi;
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
