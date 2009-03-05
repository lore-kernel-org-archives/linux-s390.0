From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Thu, 05 Mar 2009 11:56:59 +0000
Subject: Re: [PATCH] s390: wraparound when block_len < 2.
Message-Id: <1236254219.9845.3.camel@braunu-laptop>
In-Reply-To: <49AEA2D8.1010408@gmail.com>
References: <49AEA2D8.1010408@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Roel,

thanks for your proposal to avoid wrap-arounds in our ctcm receive
code. 
Since the receive code should tolerate any incoming garbage, your patch 
makes our code more robust. I am going to add your ctcm_fsms.c-patch
and 
come up with an additional ctcm_main.c-patch.

Kind regards, Ursula Braun  


Roel Kluin <roel.kluin@gmail.com> wrote on 04.03.2009 16:45:03:

> From:
> 
> Roel Kluin <roel.kluin@gmail.com>
> 
> To:
> 
> Ursula Braun1/Germany/IBM@IBMDE
> 
> Cc:
> 
> linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
> 
> Date:
> 
> 04.03.2009 16:46
> 
> Subject:
> 
> [PATCH] s390: wraparound when block_len < 2.
> 
> I'm not sure that this is necessary, please review.
>
------------------------------>8-------------8<---------------------------------
> block_len is unsigned so a too large subtraction will cause a
wraparound.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/drivers/s390/net/ctcm_fsms.c
b/drivers/s390/net/ctcm_fsms.c
> index f29c708..4ded9ac 100644
> --- a/drivers/s390/net/ctcm_fsms.c
> +++ b/drivers/s390/net/ctcm_fsms.c
> @@ -410,9 +410,8 @@ static void chx_rx(fsm_instance *fi, int event,
void *arg)
>        priv->stats.rx_length_errors++;
>                    goto again;
>     }
> -   block_len -= 2;
> -   if (block_len > 0) {
> -      *((__u16 *)skb->data) = block_len;
> +   if (block_len > 2) {
> +      *((__u16 *)skb->data) = block_len - 2;
>        ctcm_unpack_skb(ch, skb);
>     }
>   again:
