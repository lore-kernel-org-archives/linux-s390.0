Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] arch: um: convert tasklets to use new tasklet_setup() API
References: <20200817091617.28119-1-allen.cryptic@gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <3359192b-8f02-feb4-a9a7-a13b5d876998@cambridgegreys.com>
Date: Mon, 19 Oct 2020 08:39:05 +0100
MIME-Version: 1.0
In-Reply-To: <20200817091617.28119-1-allen.cryptic@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Allen Pais <allen.cryptic@gmail.com>, jdike@addtoit.com, richard@nod.at, 3chas3@gmail.com, axboe@kernel.dk, stefanr@s5r6.in-berlin.de, airlied@linux.ie, daniel@ffwll.ch, sre@kernel.org, James.Bottomley@HansenPartnership.com, kys@microsoft.com, deller@gmx.de, dmitry.torokhov@gmail.com, jassisinghbrar@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de, maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org, mporter@kernel.crashing.org, alex.bou9@gmail.com, broonie@kernel.org, martyn@welchs.me.uk, manohar.vanga@gmail.com, mitch@sfgoth.com, davem@davemloft.net, kuba@kernel.org
Cc: devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, linux-hyperv@vger.kernel.org, Romain Perier <romain.perier@gmail.com>, keescook@chromium.org, linux-parisc@vger.kernel.org, linux-ntb@googlegroups.com, netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-atm-general@lists.sourceforge.net, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-spi@vger.kernel.org, linux-block@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>, linux-input@vger.kernel.org, linux-mmc@vger.kernel.org, openipmi-developer@lists.sourceforge.net, linux1394-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org



On 17/08/2020 10:15, Allen Pais wrote:
> From: Allen Pais <allen.lkml@gmail.com>
> 
> In preparation for unconditionally passing the
> struct tasklet_struct pointer to all tasklet
> callbacks, switch to using the new tasklet_setup()
> and from_tasklet() to pass the tasklet pointer explicitly.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>   arch/um/drivers/vector_kern.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 8735c468230a..06980870ae23 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -1196,9 +1196,9 @@ static int vector_net_close(struct net_device *dev)
>   
>   /* TX tasklet */
>   
> -static void vector_tx_poll(unsigned long data)
> +static void vector_tx_poll(struct tasklet_struct *t)
>   {
> -	struct vector_private *vp = (struct vector_private *)data;
> +	struct vector_private *vp = from_tasklet(vp, t, tx_poll);
>   
>   	vp->estats.tx_kicks++;
>   	vector_send(vp->tx_queue);
> @@ -1629,7 +1629,7 @@ static void vector_eth_configure(
>   	});
>   
>   	dev->features = dev->hw_features = (NETIF_F_SG | NETIF_F_FRAGLIST);
> -	tasklet_init(&vp->tx_poll, vector_tx_poll, (unsigned long)vp);
> +	tasklet_setup(&vp->tx_poll, vector_tx_poll);
>   	INIT_WORK(&vp->reset_tx, vector_reset_tx);
>   
>   	timer_setup(&vp->tl, vector_timer_expire, 0);
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
