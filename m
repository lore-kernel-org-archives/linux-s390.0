Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 23 Sep 2010 13:42:01 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 04/13] drivers/s390: Remove unnecessary casts of
 private_data
In-Reply-To: <ffd65b5efc206c3bb180addeeab41a26f15991a7.1283650107.git.joe@perches.com>
Message-ID: <alpine.LNX.2.00.1009231341490.26813@pobox.suse.cz>
References: <cover.1283650107.git.joe@perches.com> <ffd65b5efc206c3bb180addeeab41a26f15991a7.1283650107.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, 4 Sep 2010, Joe Perches wrote:

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/s390/char/vmcp.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/char/vmcp.c b/drivers/s390/char/vmcp.c
> index 04e532e..19a14d9 100644
> --- a/drivers/s390/char/vmcp.c
> +++ b/drivers/s390/char/vmcp.c
> @@ -47,7 +47,7 @@ static int vmcp_release(struct inode *inode, struct file *file)
>  {
>  	struct vmcp_session *session;
>  
> -	session = (struct vmcp_session *)file->private_data;
> +	session = file->private_data;
>  	file->private_data = NULL;
>  	free_pages((unsigned long)session->response, get_order(session->bufsize));
>  	kfree(session);
> @@ -94,7 +94,7 @@ vmcp_write(struct file *file, const char __user *buff, size_t count,
>  		return -EFAULT;
>  	}
>  	cmd[count] = '\0';
> -	session = (struct vmcp_session *)file->private_data;
> +	session = file->private_data;
>  	if (mutex_lock_interruptible(&session->mutex)) {
>  		kfree(cmd);
>  		return -ERESTARTSYS;
> @@ -136,7 +136,7 @@ static long vmcp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	int __user *argp;
>  	int temp;
>  
> -	session = (struct vmcp_session *)file->private_data;
> +	session = file->private_data;
>  	if (is_compat_task())
>  		argp = compat_ptr(arg);
>  	else

Not present in linux-next as of today. Applied, thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
