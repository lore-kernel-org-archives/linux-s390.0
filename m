Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2E1C43334
	for <linux-s390@archiver.kernel.org>; Wed, 13 Jul 2022 13:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbiGMNUp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbiGMNUo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 13 Jul 2022 09:20:44 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65632E06;
        Wed, 13 Jul 2022 06:20:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VJE3WgM_1657718437;
Received: from 30.227.73.183(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VJE3WgM_1657718437)
          by smtp.aliyun-inc.com;
          Wed, 13 Jul 2022 21:20:38 +0800
Message-ID: <9c3496de-aa8f-21fa-e3fc-385fafba21e4@linux.alibaba.com>
Date:   Wed, 13 Jul 2022 21:20:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH net-next 5/6] net/smc: Allow virtually contiguous sndbufs
 or RMBs for SMC-R
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1657626690-60367-1-git-send-email-guwen@linux.alibaba.com>
 <1657626690-60367-6-git-send-email-guwen@linux.alibaba.com>
 <20220712205442.22a29fcd@kernel.org>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20220712205442.22a29fcd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 2022/7/13 11:54 pm, Jakub Kicinski wrote:

> On Tue, 12 Jul 2022 19:51:29 +0800 Wen Gu wrote:
>> net/smc: Allow virtually contiguous sndbufs or RMBs for SMC-R
> 
> This one does not build cleanly on 32bit.


Thanks for reminding, I will fix it in v2


Thanks,
Wen Gu
