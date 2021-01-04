Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725830AbhADLyk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Jan 2021 06:54:40 -0500
Subject: Re: [PATCH net] smc: fix out of bound access in smc_nl_get_sys_info()
References: <20201230004841.1472141-1-kuba@kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Message-ID: <4ca9487e-2834-1c45-68eb-a6be8be671d3@linux.ibm.com>
Date: Mon, 4 Jan 2021 12:53:49 +0100
MIME-Version: 1.0
In-Reply-To: <20201230004841.1472141-1-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: guvenc@linux.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org, syzbot+f4708c391121cfc58396@syzkaller.appspotmail.com

Thank you Jakub,

this patch solves the out of bounds access due to snprintf() copying size bytes first
and overwriting the last byte with null afterwards.
We will include your patch in our next series for the net tree soon.

Reviewed-by: Karsten Graul <kgraul@linux.ibm.com>

On 30/12/2020 01:48, Jakub Kicinski wrote:
> smc_clc_get_hostname() sets the host pointer to a buffer
> which is not NULL-terminated (see smc_clc_init()).
> 
> Reported-by: syzbot+f4708c391121cfc58396@syzkaller.appspotmail.com
> Fixes: 099b990bd11a ("net/smc: Add support for obtaining system information")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/smc/smc_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index 59342b519e34..8d866b4ed8f6 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -246,7 +246,8 @@ int smc_nl_get_sys_info(struct sk_buff *skb, struct netlink_callback *cb)
>  		goto errattr;
>  	smc_clc_get_hostname(&host);
>  	if (host) {
> -		snprintf(hostname, sizeof(hostname), "%s", host);
> +		memcpy(hostname, host, SMC_MAX_HOSTNAME_LEN);
> +		hostname[SMC_MAX_HOSTNAME_LEN] = 0;
>  		if (nla_put_string(skb, SMC_NLA_SYS_LOCAL_HOST, hostname))
>  			goto errattr;
>  	}
> 

-- 
Karsten

(I'm a dude)
