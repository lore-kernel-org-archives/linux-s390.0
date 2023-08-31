Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54158C83F2F
	for <linux-s390@archiver.kernel.org>; Thu, 31 Aug 2023 05:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbjHaFcu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 31 Aug 2023 01:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344994AbjHaFc0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 31 Aug 2023 01:32:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322A01BF;
        Wed, 30 Aug 2023 22:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1wL1JM1HUMzrMrz40L6bCEfG239qdJ5Q6Ey+HfdYI1Q=; b=JQvJbRv4KyDhMDvCqvEAQ2lwoi
        Qp7eD++OVr4T2+slQ6JORF8P6gvE768tNszNKWxC+pNOlg9eoQiskZaOs/dJuzZj8ducNWwTwH9Dh
        7t70YPM+4bZQ/d4gZXQM5OMy4lmkFNxwNRq9MmSBIEJ797CmgS3Vc9uVZxnVfCxgVF9VDfgyw9Llu
        Pdqucvkjzm2CQSYDxZcrTiNhQQmhEqx1rkIwN3RfOqHEmCmbvL6HM2U5p1OkAIurAbQOQ+U3iDFZk
        YDscrjUpx3qoayo7zfDLxB9XFanppPWq7Hw7JGKktxoi38aGSpJTAkvgB+8Moko6VqzDDVqDzB+vv
        TcoYUG2Q==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qbaHu-00Egmo-1b;
        Thu, 31 Aug 2023 05:32:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Subject: [PATCH 4/4] hypfs: free sb->s_fs_info after shutting down the super block
Date:   Thu, 31 Aug 2023 07:31:57 +0200
Message-Id: <20230831053157.256319-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230831053157.256319-1-hch@lst.de>
References: <20230831053157.256319-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

sb->s_fs_info can only be safely freed after generic_shutdown_super was
called and all access to the super_block has stopped.

Thus only free the private data after calling kill_litter_super, which
calls generic_shutdown_super internally.

Also remove the pointless clearing of sb->s_fs_info as the super_block
can't be accessed at this point and will be freed immediately.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/s390/hypfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index ada83149932fec..dbe8a7dcafa922 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -329,9 +329,8 @@ static void hypfs_kill_super(struct super_block *sb)
 		hypfs_delete_tree(sb->s_root);
 	if (sb_info && sb_info->update_file)
 		hypfs_remove(sb_info->update_file);
-	kfree(sb->s_fs_info);
-	sb->s_fs_info = NULL;
 	kill_litter_super(sb);
+	kfree(sb->s_fs_info);
 }
 
 static struct dentry *hypfs_create_file(struct dentry *parent, const char *name,
-- 
2.39.2

