Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 6 Jul 2017 12:29:40 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 12/18] drivers: s390: Move static and inline before
 return type
References: <cover.1499284835.git.joe@perches.com>
 <3f980cd89084ae09716353aba3171e4b3815e690.1499284835.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f980cd89084ae09716353aba3171e4b3815e690.1499284835.git.joe@perches.com>
Message-Id: <20170706102940.GG3217@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Julian Wiedmann <jwi@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jul 05, 2017 at 01:02:21PM -0700, Joe Perches wrote:
> Make the code like the rest of the kernel.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/s390/net/ctcm_main.c    | 2 +-
>  drivers/s390/net/qeth_l3_main.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)


> diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
> index 3062cde33a3d..8975cd321390 100644
> --- a/drivers/s390/net/qeth_l3_main.c
> +++ b/drivers/s390/net/qeth_l3_main.c
> @@ -2408,7 +2408,7 @@ static int qeth_l3_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
>  	return rc;
>  }
> 
> -int inline qeth_l3_get_cast_type(struct qeth_card *card, struct sk_buff *skb)
> +inline int qeth_l3_get_cast_type(struct qeth_card *card, struct sk_buff *skb)
>  {

Actually the function could be made static, and "inline" should be removed,
considering the large function body.
