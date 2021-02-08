Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhBHWvn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Feb 2021 17:51:43 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3F1C06178C
        for <linux-s390@vger.kernel.org>; Mon,  8 Feb 2021 14:51:03 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id x23so3846986oop.1
        for <linux-s390@vger.kernel.org>; Mon, 08 Feb 2021 14:51:03 -0800 (PST)
Date: Mon, 8 Feb 2021 14:50:47 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] tmpfs: Disallow CONFIG_TMPFS_INODE64 on s390
In-Reply-To: <20210205160551.cf57c4293ba5ccb8eb648c11@linux-foundation.org>
Message-ID: <alpine.LSU.2.11.2102081446340.4656@eggly.anvils>
References: <20210205230620.518245-1-seth.forshee@canonical.com> <20210205160551.cf57c4293ba5ccb8eb648c11@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-s390.vger.kernel.org>
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, Chris Down <chris@chrisdown.name>, Amir Goldstein <amir73il@gmail.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-mm@kvack.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 5 Feb 2021, Andrew Morton wrote:
> On Fri,  5 Feb 2021 17:06:20 -0600 Seth Forshee <seth.forshee@canonical.com> wrote:
> 
> > This feature requires ino_t be 64-bits, which is true for every
> > 64-bit architecture but s390, so prevent this option from being
> > selected there.
> > 
> 
> The previous patch nicely described the end-user impact of the bug. 
> This is especially important when requesting a -stable backport.
> 
> Here's what I ended up with:
> 
> 
> From: Seth Forshee <seth.forshee@canonical.com>
> Subject: tmpfs: disallow CONFIG_TMPFS_INODE64 on s390
> 
> Currently there is an assumption in tmpfs that 64-bit architectures also
> have a 64-bit ino_t.  This is not true on s390 which has a 32-bit ino_t. 
> With CONFIG_TMPFS_INODE64=y tmpfs mounts will get 64-bit inode numbers and
> display "inode64" in the mount options, but passing the "inode64" mount
> option will fail.  This leads to the following behavior:
> 
>  # mkdir mnt
>  # mount -t tmpfs nodev mnt
>  # mount -o remount,rw mnt
>  mount: /home/ubuntu/mnt: mount point not mounted or bad option.
> 
> As mount sees "inode64" in the mount options and thus passes it in the
> options for the remount.
> 
> 
> So prevent CONFIG_TMPFS_INODE64 from being selected on s390.
> 
> Link: https://lkml.kernel.org/r/20210205230620.518245-1-seth.forshee@canonical.com
> Fixes: ea3271f7196c ("tmpfs: support 64-bit inums per-sb")
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> Cc: Chris Down <chris@chrisdown.name>
> Cc: Hugh Dickins <hughd@google.com>

Thank you Seth: now that you've fixed Kirill's alpha observation too,
Acked-by: Hugh Dickins <hughd@google.com>

> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: <stable@vger.kernel.org>	[5.9+]
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  fs/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/fs/Kconfig~tmpfs-disallow-config_tmpfs_inode64-on-s390
> +++ a/fs/Kconfig
> @@ -203,7 +203,7 @@ config TMPFS_XATTR
>  
>  config TMPFS_INODE64
>  	bool "Use 64-bit ino_t by default in tmpfs"
> -	depends on TMPFS && 64BIT
> +	depends on TMPFS && 64BIT && !S390
>  	default n
>  	help
>  	  tmpfs has historically used only inode numbers as wide as an unsigned
> _
> 
> 
