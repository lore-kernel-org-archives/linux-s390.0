Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B984CAD;
	Tue, 12 Dec 2023 17:48:53 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VyO3miM_1702432130;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0VyO3miM_1702432130)
          by smtp.aliyun-inc.com;
          Wed, 13 Dec 2023 09:48:51 +0800
Date: Wed, 13 Dec 2023 09:48:47 +0800
From: Tony Lu <tonylu@linux.alibaba.com>
To: Ahelenia =?us-ascii?Q?Ziemia'nska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Karsten Graul <kgraul@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 06/11] net/smc: smc_splice_read: always request
 MSG_DONTWAIT
Message-ID: <ZXkNf9vvtzR7oqoE@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
 <145da5ab094bcc7d3331385e8813074922c2a13c6.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <145da5ab094bcc7d3331385e8813074922c2a13c6.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>

Please add correct tag, for this patch, IIUC, it should be a fix, and
you need add [PATCH net].

On Tue, Dec 12, 2023 at 11:12:47AM +0100, Ahelenia Ziemia'nska wrote:
> Otherwise we risk sleeping with the pipe locked for indeterminate
> lengths of time.
> 
> Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5is2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u

Fixes line is needed.

> Signed-off-by: Ahelenia Ziemia'nska <nabijaczleweli@nabijaczleweli.xyz>
> ---
>  net/smc/af_smc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index bacdd971615e..89473305f629 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -3243,12 +3243,8 @@ static ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
>  			rc = -ESPIPE;
>  			goto out;
>  		}
> -		if (flags & SPLICE_F_NONBLOCK)
> -			flags = MSG_DONTWAIT;
> -		else
> -			flags = 0;
>  		SMC_STAT_INC(smc, splice_cnt);
> -		rc = smc_rx_recvmsg(smc, NULL, pipe, len, flags);
> +		rc = smc_rx_recvmsg(smc, NULL, pipe, len, MSG_DONTWAIT);
>  	}
>  out:
>  	release_sock(sk);
> -- 
> 2.39.2


