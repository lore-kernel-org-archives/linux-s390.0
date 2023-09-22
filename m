Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32218CD4945
	for <linux-s390@archiver.kernel.org>; Fri, 22 Sep 2023 12:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbjIVMSx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 22 Sep 2023 08:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbjIVMSx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 22 Sep 2023 08:18:53 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E288E100;
        Fri, 22 Sep 2023 05:18:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VsdUGbw_1695385120;
Received: from 30.221.128.225(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsdUGbw_1695385120)
          by smtp.aliyun-inc.com;
          Fri, 22 Sep 2023 20:18:41 +0800
Message-ID: <714eadf7-1d4f-2379-bc2b-7b89d01987b3@linux.alibaba.com>
Date:   Fri, 22 Sep 2023 20:18:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next v3 00/18] net/smc: implement virtual ISM
 extension and loopback-ism
To:     Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1695302360-46691-1-git-send-email-guwen@linux.alibaba.com>
 <be68eac1-f22e-1ff6-dbaf-8cbd09315454@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <be68eac1-f22e-1ff6-dbaf-8cbd09315454@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 2023/9/22 07:31, Wenjia Zhang wrote:

> 
> Hi Wen,
> 
> Thank you for the effort!

Thank you very much for review, Wenjia.

> You can find my comments in the respective patches. One general question from our team, could you please add a Kconfig 
> option to turn off/on loopback-ism?

Sure, I will add an option to turn off/on loopback-ism.

> 
> BTW, I'm in vacation next week, my colleagues will follow on the answer and update.

Thank you. Enjoy the vacation!

Regards,
Wen Gu

> 
> Thanks,
> Wenjia
> 

