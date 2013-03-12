Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 12 Mar 2013 08:25:23 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 11/18] driver: s390: net: remove cast for kzalloc return
 value
Message-ID: <20130312072523.GD4148@osiris>
References: <513EB23D.7020303@cn.fujitsu.com>
 <513EBBA0.60804@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <513EBBA0.60804@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: Ursula Braun <ursula.braun@de.ibm.com>, Frank Blaschka <blaschka@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux390@de.ibm.com, linux-s390@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Mar 12, 2013 at 01:22:40PM +0800, Zhang Yanfei wrote:
> remove cast for kzalloc return value.
> 
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
>  drivers/s390/net/qeth_core_main.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
> index 0d8cdff..754a54f 100644
> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -316,7 +316,7 @@ static inline int qeth_alloc_cq(struct qeth_card *card)
>  
>  		card->qdio.no_in_queues = 2;
>  
> -		card->qdio.out_bufstates = (struct qdio_outbuf_state *)
> +		card->qdio.out_bufstates =

Applied, thanks.
