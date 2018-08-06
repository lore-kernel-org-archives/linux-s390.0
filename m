Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH] s390/qeth: use true and false for boolean values
References: <20180805005903.GA5509@embeddedor.com>
From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Mon, 6 Aug 2018 07:39:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180805005903.GA5509@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f5054c99-2db0-85df-6c40-b20c9e604d29@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ursula Braun <ubraun@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 08/05/2018 02:59 AM, Gustavo A. R. Silva wrote:
> Return statements in functions returning bool should use true or false
> instead of an integer value.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Queued up for net-next, thanks.

> ---
>  drivers/s390/net/qeth_l3_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
> index 1833e75..7175086 100644
> --- a/drivers/s390/net/qeth_l3_main.c
> +++ b/drivers/s390/net/qeth_l3_main.c
> @@ -117,9 +117,9 @@ static bool qeth_l3_is_addr_covered_by_ipato(struct qeth_card *card,
>  	int rc = 0;
>  
>  	if (!card->ipato.enabled)
> -		return 0;
> +		return false;
>  	if (addr->type != QETH_IP_TYPE_NORMAL)
> -		return 0;
> +		return false;
>  
>  	qeth_l3_convert_addr_to_bits((u8 *) &addr->u, addr_bits,
>  				  (addr->proto == QETH_PROT_IPV4)? 4:16);
> 
