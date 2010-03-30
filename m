Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [patch] s390: potential buffer overflow
References: <20100330094342.GJ5069@bicker>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 30 Mar 2010 09:25:01 -0700
In-Reply-To: <20100330094342.GJ5069@bicker> (Dan Carpenter's message of "Tue\, 30 Mar 2010 12\:43\:42 +0300")
Message-ID: <m1k4strd42.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Hans-Joachim Picht <hans@linux.vnet.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Dan Carpenter <error27@gmail.com> writes:

> "len" hasn't been properly range checked so we shouldn't use it as an
> array offset.  This can only be written to by root but it would still be
> annoying to accidentally write more than 3 characters and corrupt your
> memory.
>
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> I don't have a cross compile environment to compile this.  Sorry.  :/
>
> diff --git a/drivers/s390/char/sclp_async.c b/drivers/s390/char/sclp_async.c
> index f449c69..72c2e90 100644
> --- a/drivers/s390/char/sclp_async.c
> +++ b/drivers/s390/char/sclp_async.c
> @@ -84,7 +84,7 @@ static int proc_handler_callhome(struct ctl_table *ctl, int write,
>  		rc = copy_from_user(buf, buffer, sizeof(buf));
>  		if (rc != 0)
>  			return -EFAULT;
> -		buf[len - 1] = '\0';
> +		buf[sizeof(buf) - 1] = '\0';
>  		if (strict_strtoul(buf, 0, &val) != 0)
>  			return -EINVAL;
>  		if (val != 0 && val != 1)
> @@ -99,6 +99,7 @@ static int proc_handler_callhome(struct ctl_table *ctl, int write,
>  static struct ctl_table callhome_table[] = {
>  	{
>  		.procname	= "callhome",
> +		.maxlen		= 3,
>  		.mode		= 0644,
>  		.proc_handler	= proc_handler_callhome,
>  	},

Setting maxlen won't do any good as proc_handler_callhome doesn't look at it.

Eric
