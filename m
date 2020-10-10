Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 10 Oct 2020 10:37:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 1/2] net: smc: fix missing brace warning for old
 compilers
Message-ID: <20201010103746.3c05e1f4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201008121929.1270-1-shipujin.t@gmail.com>
References: <20201008121929.1270-1-shipujin.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Pujin Shi <shipujin.t@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hankinsea@gmail.com

On Thu,  8 Oct 2020 20:19:28 +0800 Pujin Shi wrote:
> For older versions of gcc, the array = {0}; will cause warnings:
> 
> net/smc/smc_llc.c: In function 'smc_llc_send_link_delete_all':
> net/smc/smc_llc.c:1317:9: warning: missing braces around initializer [-Wmissing-braces]
>   struct smc_llc_msg_del_link delllc = {0};
>          ^
> net/smc/smc_llc.c:1317:9: warning: (near initialization for 'delllc.hd') [-Wmissing-braces]
> 
> 1 warnings generated
> 
> Fixes: f3811fd7bc97 ("net/smc: send DELETE_LINK, ALL message and wait for send to complete")
> Signed-off-by: Pujin Shi <shipujin.t@gmail.com>

Applied both, thanks!
