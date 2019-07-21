Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:35733 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGUMdq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 21 Jul 2019 08:33:46 -0400
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] s390/hypfs: fix a typo in the name of a function
Date: Sun, 21 Jul 2019 14:33:21 +0200
Message-Id: <20190721123321.12879-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, gregkh@linuxfoundation.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Everything is about hypfs_..., except 'hpyfs_vm_create_guest()'
s/hpy/hyp/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/s390/hypfs/hypfs_vm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_vm.c b/arch/s390/hypfs/hypfs_vm.c
index 42f2375c203e..e1fcc03159ef 100644
--- a/arch/s390/hypfs/hypfs_vm.c
+++ b/arch/s390/hypfs/hypfs_vm.c
@@ -118,7 +118,7 @@ do { \
 		return PTR_ERR(rc); \
 } while(0)
 
-static int hpyfs_vm_create_guest(struct dentry *systems_dir,
+static int hypfs_vm_create_guest(struct dentry *systems_dir,
 				 struct diag2fc_data *data)
 {
 	char guest_name[NAME_LEN + 1] = {};
@@ -219,7 +219,7 @@ int hypfs_vm_create_files(struct dentry *root)
 	}
 
 	for (i = 0; i < count; i++) {
-		rc = hpyfs_vm_create_guest(dir, &(data[i]));
+		rc = hypfs_vm_create_guest(dir, &(data[i]));
 		if (rc)
 			goto failed;
 	}
-- 
2.20.1
