Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2A4EB64D9
	for <linux-s390@archiver.kernel.org>; Wed, 14 Jun 2023 08:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243189AbjFNIDQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 14 Jun 2023 04:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243245AbjFNICz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 14 Jun 2023 04:02:55 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8806926AE;
        Wed, 14 Jun 2023 01:02:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vl5mv5K_1686729718;
Received: from 30.221.128.250(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vl5mv5K_1686729718)
          by smtp.aliyun-inc.com;
          Wed, 14 Jun 2023 16:01:59 +0800
Message-ID: <09856bfa-516f-c876-b577-21be940f5911@linux.alibaba.com>
Date:   Wed, 14 Jun 2023 16:01:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] MAINTAINERS: add reviewers for SMC Sockets
To:     Jan Karcher <jaka@linux.ibm.com>
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Nils Hoppmann <niho@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
References: <20230614065456.2724-1-jaka@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20230614065456.2724-1-jaka@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 2023/6/14 14:54, Jan Karcher wrote:

> adding three people from Alibaba as reviewers for SMC.
> They are currently working on improving SMC on other architectures than
> s390 and help with reviewing patches on top.
> 
> Thank you D. Wythe, Tony Lu and Wen Gu for your contributions and
> collaboration and welcome on board as reviewers!
> 
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> Signed-off-by: Jan Karcher <jaka@linux.ibm.com>
> ---
>   MAINTAINERS | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f794002a192e..6992b7cc7095 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19140,6 +19140,9 @@ SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
>   M:	Karsten Graul <kgraul@linux.ibm.com>
>   M:	Wenjia Zhang <wenjia@linux.ibm.com>
>   M:	Jan Karcher <jaka@linux.ibm.com>
> +R:	D. Wythe <alibuda@linux.alibaba.com>
> +R:	Tony Lu <tonylu@linux.alibaba.com>
> +R:	Wen Gu <guwen@linux.alibaba.com>
>   L:	linux-s390@vger.kernel.org
>   S:	Supported
>   F:	net/smc/

Thank you Jan. It's an honor to contribute to the community and
I will do my best.

Acked-by: Wen Gu <guwen@linux.alibaba.com>
