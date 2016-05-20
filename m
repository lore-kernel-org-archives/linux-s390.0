Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 20 May 2016 15:41:06 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2] ks390/keyboard: use memdup_user_nul().
Message-ID: <20160520134106.GF3461@osiris>
References: <1463750488-12565-1-git-send-email-falakreyaz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1463750488-12565-1-git-send-email-falakreyaz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Muhammad Falak R Wani <falakreyaz@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Jan Kara <jack@suse.cz>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, May 20, 2016 at 06:51:20PM +0530, Muhammad Falak R Wani wrote:
> Use memdup_user_nul to duplicate a memory region from user-space
> to kernel-space and terminate with a NULL, instead of open coding
> using kmalloc + copy_from_user and explicitly NULL terminating.
> 
> Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
> ---
>  drivers/s390/char/keyboard.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/s390/char/keyboard.c b/drivers/s390/char/keyboard.c
> index ef04a9f..f82a7dc 100644
> --- a/drivers/s390/char/keyboard.c
> +++ b/drivers/s390/char/keyboard.c
> @@ -438,18 +438,13 @@ do_kdgkb_ioctl(struct kbd_data *kbd, struct kbsentry __user *u_kbs,
>  			return -EFAULT;
>  		if (len > sizeof(u_kbs->kb_string))
>  			return -EINVAL;
> -		p = kmalloc(len, GFP_KERNEL);
> -		if (!p)
> -			return -ENOMEM;
> -		if (copy_from_user(p, u_kbs->kb_string, len)) {
> -			kfree(p);
> -			return -EFAULT;
> -		}
> +		p = memdup_user_nul(u_kbs->kb_string, len);
> +		if (IS_ERR(p))
> +			return PTR_ERR(p);
>  		/*
>  		 * Make sure the string is terminated by 0. User could have
>  		 * modified it between us running strnlen_user() and copying it.
>  		 */
> -		p[len - 1] = 0;

I removed the comment above as well and folded that into your patch.
Applied, thanks!
