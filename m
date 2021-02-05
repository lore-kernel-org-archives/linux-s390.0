Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:50915 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhBFDP5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 Feb 2021 22:15:57 -0500
Received: from mail-ot1-f70.google.com ([209.85.210.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1l8ABD-00085F-5u
        for linux-s390@vger.kernel.org; Fri, 05 Feb 2021 23:06:23 +0000
Received: by mail-ot1-f70.google.com with SMTP id f15so4343994oto.9
        for <linux-s390@vger.kernel.org>; Fri, 05 Feb 2021 15:06:23 -0800 (PST)
From: Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH] tmpfs: Disallow CONFIG_TMPFS_INODE64 on s390
Date: Fri,  5 Feb 2021 17:06:20 -0600
Message-Id: <20210205230620.518245-1-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>
Cc: Chris Down <chris@chrisdown.name>, Amir Goldstein <amir73il@gmail.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-mm@kvack.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

This feature requires ino_t be 64-bits, which is true for every
64-bit architecture but s390, so prevent this option from being
selected there.

Fixes: ea3271f7196c ("tmpfs: support 64-bit inums per-sb")
Cc: <stable@vger.kernel.org> # v5.9+
Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 fs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index aa4c12282301..3347ec7bd837 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -203,7 +203,7 @@ config TMPFS_XATTR
 
 config TMPFS_INODE64
 	bool "Use 64-bit ino_t by default in tmpfs"
-	depends on TMPFS && 64BIT
+	depends on TMPFS && 64BIT && !S390
 	default n
 	help
 	  tmpfs has historically used only inode numbers as wide as an unsigned
-- 
2.29.2
