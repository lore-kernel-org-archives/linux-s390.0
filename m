Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA64C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 28 Mar 2022 09:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbiC1J5o (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 28 Mar 2022 05:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbiC1J5n (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Mar 2022 05:57:43 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7304F475;
        Mon, 28 Mar 2022 02:56:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V8R2xSD_1648461360;
Received: from 30.225.24.58(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0V8R2xSD_1648461360)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 28 Mar 2022 17:56:01 +0800
Message-ID: <da663f43-a593-6acc-d4ec-9bd932637bee@linux.alibaba.com>
Date:   Mon, 28 Mar 2022 17:55:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH net] net/smc: Send out the remaining data in sndbuf before
 close
To:     dust.li@linux.alibaba.com, kgraul@linux.ibm.com,
        davem@davemloft.net, kuba@kernel.org
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1648447836-111521-1-git-send-email-guwen@linux.alibaba.com>
 <20220328090411.GI35207@linux.alibaba.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20220328090411.GI35207@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Thanks for your comments.

On 2022/3/28 5:04 pm, dust.li wrote:
> 
> I think this issue should also happen if TCP_CORK is set and
> autocorking is not enabled ?

Yes, setting TCP_CORK also works.
> 
> Autocorking and delaying the TX from BH to smc_release_cb() greatly
> increased the probability of this problem.
>
Thanks,
Wen Gu
