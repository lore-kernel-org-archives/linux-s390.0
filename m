Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] net/smc: Fix preinitialization of buf_desc in
 __smc_buf_create()
References: <1510831373-31768-1-git-send-email-geert@linux-m68k.org>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Thu, 16 Nov 2017 19:14:34 +0100
MIME-Version: 1.0
In-Reply-To: <1510831373-31768-1-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <f5e533f8-fecb-6dd6-90a7-abf56e4d84fa@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, "David S . Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 11/16/2017 12:22 PM, Geert Uytterhoeven wrote:
> With gcc-4.1.2:
> 
>     net/smc/smc_core.c: In function ‘__smc_buf_create’:
>     net/smc/smc_core.c:567: warning: ‘bufsize’ may be used uninitialized in this function
> 
> Indeed, if the for-loop is never executed, bufsize is used
> uninitialized.  In addition, buf_desc is stored for later use, while it
> is still a NULL pointer.
> 
> Before, error handling was done by checking if buf_desc is non-NULL.
> The cleanup changed this to an error check, but forgot to update the
> preinitialization of buf_desc to an error pointer.
> 
> Update the preinitializatin of buf_desc to fix this.
> 
> Fixes: b33982c3a6838d13 ("net/smc: cleanup function __smc_buf_create()")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> I don't know if this can ever happen, but the old code handled it.

The for-loop is at least executed once; thus there is no real problem.
Nevertheless the warning is ugly, and the current initialization with NULL
meaningless after the smc_buf cleanup. Therefore I add your patch to my list of
coming smc patches. Thanks!

> ---
>  net/smc/smc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index 2578fbd95664af84..453c54467082d93f 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -562,7 +562,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_rmb)
>  {
>  	struct smc_connection *conn = &smc->conn;
>  	struct smc_link_group *lgr = conn->lgr;
> -	struct smc_buf_desc *buf_desc = NULL;
> +	struct smc_buf_desc *buf_desc = ERR_PTR(-ENOMEM);
>  	struct list_head *buf_list;
>  	int bufsize, bufsize_short;
>  	int sk_buf_size;
> 
