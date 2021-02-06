Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhBFCvW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 Feb 2021 21:51:22 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16296C08EE7E
        for <linux-s390@vger.kernel.org>; Fri,  5 Feb 2021 16:40:11 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z22so11065763edb.9
        for <linux-s390@vger.kernel.org>; Fri, 05 Feb 2021 16:40:11 -0800 (PST)
Date: Sat, 6 Feb 2021 00:40:08 +0000
From: Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH] tmpfs: Disallow CONFIG_TMPFS_INODE64 on s390
Message-ID: <YB3laM3HQUM7u/Wo@chrisdown.name>
References: <20210205230620.518245-1-seth.forshee@canonical.com>
 <20210205160551.cf57c4293ba5ccb8eb648c11@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210205160551.cf57c4293ba5ccb8eb648c11@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Seth Forshee <seth.forshee@canonical.com>, Hugh Dickins <hughd@google.com>, Amir Goldstein <amir73il@gmail.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-mm@kvack.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Andrew Morton writes:
>Currently there is an assumption in tmpfs that 64-bit architectures also
>have a 64-bit ino_t.  This is not true on s390 which has a 32-bit ino_t.
>With CONFIG_TMPFS_INODE64=y tmpfs mounts will get 64-bit inode numbers and
>display "inode64" in the mount options, but passing the "inode64" mount
>option will fail.  This leads to the following behavior:
>
> # mkdir mnt
> # mount -t tmpfs nodev mnt
> # mount -o remount,rw mnt
> mount: /home/ubuntu/mnt: mount point not mounted or bad option.
>
>As mount sees "inode64" in the mount options and thus passes it in the
>options for the remount.
>
>
>So prevent CONFIG_TMPFS_INODE64 from being selected on s390.
>
>Link: https://lkml.kernel.org/r/20210205230620.518245-1-seth.forshee@canonical.com
>Fixes: ea3271f7196c ("tmpfs: support 64-bit inums per-sb")
>Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
>Cc: Chris Down <chris@chrisdown.name>
>Cc: Hugh Dickins <hughd@google.com>
>Cc: Amir Goldstein <amir73il@gmail.com>
>Cc: Heiko Carstens <hca@linux.ibm.com>
>Cc: Vasily Gorbik <gor@linux.ibm.com>
>Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>Cc: <stable@vger.kernel.org>	[5.9+]
>Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Either of the two ways presented looks fine to me, no real preference. Thanks!

Acked-by: Chris Down <chris@chrisdown.name>

>---
>
> fs/Kconfig |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>--- a/fs/Kconfig~tmpfs-disallow-config_tmpfs_inode64-on-s390
>+++ a/fs/Kconfig
>@@ -203,7 +203,7 @@ config TMPFS_XATTR
>
> config TMPFS_INODE64
> 	bool "Use 64-bit ino_t by default in tmpfs"
>-	depends on TMPFS && 64BIT
>+	depends on TMPFS && 64BIT && !S390
> 	default n
> 	help
> 	  tmpfs has historically used only inode numbers as wide as an unsigned
>_
>
