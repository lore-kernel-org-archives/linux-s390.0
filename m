Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 26 Sep 2020 14:46:50 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH -next] s390/3215: simplify the return expression of
 tty3215_open()
Message-ID: <your-ad-here.call-01601124410-ext-9995@work.hours>
References: <20200921131101.93037-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200921131101.93037-1-miaoqinglang@huawei.com>
List-ID: <linux-s390.vger.kernel.org>
To: Qinglang Miao <miaoqinglang@huawei.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 09:11:01PM +0800, Qinglang Miao wrote:
> Simplify the return expression.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/s390/char/con3215.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
> index 92757f9bd..d8acabbb1 100644
> --- a/drivers/s390/char/con3215.c
> +++ b/drivers/s390/char/con3215.c
> @@ -978,7 +978,6 @@ static int tty3215_install(struct tty_driver *driver, struct tty_struct *tty)
>  static int tty3215_open(struct tty_struct *tty, struct file * filp)
>  {
>  	struct raw3215_info *raw = tty->driver_data;
> -	int retval;
>  
>  	tty_port_tty_set(&raw->port, tty);
>  
> @@ -986,11 +985,7 @@ static int tty3215_open(struct tty_struct *tty, struct file * filp)
>  	/*
>  	 * Start up 3215 device
>  	 */
> -	retval = raw3215_startup(raw);
> -	if (retval)
> -		return retval;
> -
> -	return 0;
> +	return raw3215_startup(raw);
>  }

Applied, thank you.
