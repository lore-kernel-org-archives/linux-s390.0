Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E2DC433EF
	for <linux-s390@archiver.kernel.org>; Thu, 30 Jun 2022 14:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbiF3Og4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiF3Ogm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Jun 2022 10:36:42 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EC758FCB;
        Thu, 30 Jun 2022 07:29:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VHtSBLe_1656599393;
Received: from 30.43.105.96(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VHtSBLe_1656599393)
          by smtp.aliyun-inc.com;
          Thu, 30 Jun 2022 22:29:54 +0800
Message-ID: <d2195919-1cae-b667-c137-8398848fa43b@linux.alibaba.com>
Date:   Thu, 30 Jun 2022 22:29:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH net-next v2] net/smc: align the connect behaviour with TCP
Content-Language: en-US
To:     Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     davem@davemloft.net, Karsten Graul <kgraul@linux.ibm.com>,
        liuyacan@corp.netease.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com
References: <26d43c65-1f23-5b83-6377-3327854387c4@linux.ibm.com>
 <20220524125725.951315-1-liuyacan@corp.netease.com>
 <3bb9366d-f271-a603-a280-b70ae2d59c00@linux.ibm.com>
 <8a15e288-4534-501c-8b3d-c235ae93238f@linux.ibm.com>
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <8a15e288-4534-501c-8b3d-c235ae93238f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 2022/6/30 04:09, Wenjia Zhang wrote:
> 
> Since Karsten's suggestion, we didn't hear from you any more. We just want to know:
> 
> - What do you think about the commit (86434744)? Could it be the trigger of the problem you met?
> 
> - Have you ever tried to just remove the following lines from smc_connection(), and check if your scenario could run correctly?
> 
> if (smc->use_fallback)
>               goto out;
> 
> In our opinion, we don't see the necessity of the patch, if partly reverting the commit (86434744) could solve the problem.

I'm so sorry I missed the last emails for this discussion.

Yes, commit (86434744) is the trigger of the problem described in 
https://lore.kernel.org/linux-s390/45a19f8b-1b64-3459-c28c-aebab4fd8f1e@linux.alibaba.com/#t .

And I have tested just remove the following lines from smc_connection() can solve the above problem. 
if (smc->use_fallback)
     goto out;

I aggree that partly reverting the commit (86434744) is a better solution.

Thanks,
Guangguan Wang
