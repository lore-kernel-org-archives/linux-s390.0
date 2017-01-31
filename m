Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 06/14] s390/qeth: use atomic_dec_not_zero()
References: <20170130184723.18186-1-fabf@skynet.be>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Tue, 31 Jan 2017 12:28:34 +0100
MIME-Version: 1.0
In-Reply-To: <20170130184723.18186-1-fabf@skynet.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Message-Id: <5faaa712-63d3-7462-ad58-39a22ead8e0a@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Fabian Frederick <fabf@skynet.be>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

ACK - compile-tested successfully on s390.

On 01/30/2017 07:47 PM, Fabian Frederick wrote:
> instead of atomic_add_unless(value, -1, 0)
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>  drivers/s390/net/qeth_core_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
> index 315d8a2..9595b90 100644
> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -3278,7 +3278,7 @@ void qeth_queue_input_buffer(struct qeth_card *card, int index)
>  			atomic_set(&card->force_alloc_skb, 3);
>  			count = newcount;
>  		} else {
> -			atomic_add_unless(&card->force_alloc_skb, -1, 0);
> +			atomic_dec_not_zero(&card->force_alloc_skb);
>  		}
> 
>  		if (!count) {
> 
