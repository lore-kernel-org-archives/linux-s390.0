Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875E1C6FA8B
	for <linux-s390@archiver.kernel.org>; Thu, 22 Sep 2022 08:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiIVIaD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 22 Sep 2022 04:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiIVI37 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 22 Sep 2022 04:29:59 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9EB12AC6;
        Thu, 22 Sep 2022 01:29:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VQRkpTA_1663835375;
Received: from 30.221.128.159(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VQRkpTA_1663835375)
          by smtp.aliyun-inc.com;
          Thu, 22 Sep 2022 16:29:36 +0800
Message-ID: <cd996f1e-5ebf-c253-6a87-ce0e055b84c8@linux.alibaba.com>
Date:   Thu, 22 Sep 2022 16:29:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH net] net/smc: Stop the CLC flow if no link to map buffers
 on
From:   Wen Gu <guwen@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1663656189-32090-1-git-send-email-guwen@linux.alibaba.com>
In-Reply-To: <1663656189-32090-1-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 2022/9/20 14:43, Wen Gu wrote:

> There might be a potential race between SMC-R buffer map and
> link group termination.
> 
> smc_smcr_terminate_all()     | smc_connect_rdma()
> --------------------------------------------------------------
>                               | smc_conn_create()
> for links in smcibdev        |
>          schedule links down  |
>                               | smc_buf_create()
>                               |  \- smcr_buf_map_usable_links()
>                               |      \- no usable links found,
>                               |         (rmb->mr = NULL)
>                               |
>                               | smc_clc_send_confirm()
>                               |  \- access conn->rmb_desc->mr[]->rkey
>                               |     (panic)
> 
> During reboot and IB device module remove, all links will be set
> down and no usable links remain in link groups. In such situation
> smcr_buf_map_usable_links() should return an error and stop the
> CLC flow accessing to uninitialized mr.
> 
> Fixes: b9247544c1bc ("net/smc: convert static link ID instances to support multiple links")
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/smc_core.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index ebf56cd..df89c2e 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -2239,7 +2239,7 @@ static struct smc_buf_desc *smcr_new_buf_create(struct smc_link_group *lgr,
>   static int smcr_buf_map_usable_links(struct smc_link_group *lgr,
>   				     struct smc_buf_desc *buf_desc, bool is_rmb)
>   {
> -	int i, rc = 0;
> +	int i, rc = 0, cnt = 0;
>   
>   	/* protect against parallel link reconfiguration */
>   	mutex_lock(&lgr->llc_conf_mutex);
> @@ -2252,9 +2252,12 @@ static int smcr_buf_map_usable_links(struct smc_link_group *lgr,
>   			rc = -ENOMEM;
>   			goto out;
>   		}
> +		cnt++;
>   	}
>   out:
>   	mutex_unlock(&lgr->llc_conf_mutex);
> +	if (!rc && !cnt)
> +		rc = -EINVAL;
>   	return rc;
>   }
>   

Any comments or reviews are welcome and appreciated.

Thanks,
Wen Gu
