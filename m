Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 7 Jun 2011 12:27:48 +0200
From: Jan Glauber <jang@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] s390/qdio_debug: Use kstrtoul_from_user
Message-ID: <20110607102748.GA10838@hal>
References: <1307394474-747-1-git-send-email-peterhuewe@gmx.de>
 <1307394474-747-2-git-send-email-peterhuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1307394474-747-2-git-send-email-peterhuewe@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Frank Blaschka <frank.blaschka@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jun 06, 2011 at 11:07:54PM +0200, Peter Huewe wrote:
> This patch replaces the code for getting an unsigned long from a
> userspace buffer by a simple call to kstroul_from_user.
> This makes it easier to read and less error prone.
> 
> Kernel Version: v3.0-rc2
> 
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>

Acked-by: Jan Glauber <jang@linux.vnet.ibm.com>

> ---
>  drivers/s390/cio/qdio_debug.c |   12 +++---------
>  1 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/s390/cio/qdio_debug.c b/drivers/s390/cio/qdio_debug.c
> index f8b03a6..0e615cb 100644
> --- a/drivers/s390/cio/qdio_debug.c
> +++ b/drivers/s390/cio/qdio_debug.c
> @@ -188,19 +188,13 @@ static ssize_t qperf_seq_write(struct file *file, const char __user *ubuf,
>  	struct qdio_irq *irq_ptr = seq->private;
>  	struct qdio_q *q;
>  	unsigned long val;
> -	char buf[8];
>  	int ret, i;
> 
>  	if (!irq_ptr)
>  		return 0;
> -	if (count >= sizeof(buf))
> -		return -EINVAL;
> -	if (copy_from_user(&buf, ubuf, count))
> -		return -EFAULT;
> -	buf[count] = 0;
> -
> -	ret = strict_strtoul(buf, 10, &val);
> -	if (ret < 0)
> +
> +	ret = kstrtoul_from_user(ubuf, count, 10, &val);
> +	if (ret)
>  		return ret;
> 
>  	switch (val) {
> -- 
> 1.7.3.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
