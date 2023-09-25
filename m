Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D41FCE7A81
	for <linux-s390@archiver.kernel.org>; Mon, 25 Sep 2023 13:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjIYN5c (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 25 Sep 2023 09:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjIYN5b (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 25 Sep 2023 09:57:31 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9351C107;
        Mon, 25 Sep 2023 06:57:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VstgA6a_1695650236;
Received: from 30.221.129.66(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VstgA6a_1695650236)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 21:57:17 +0800
Message-ID: <86612166-ab0c-1fcd-9c76-db8b2fc25be4@linux.alibaba.com>
Date:   Mon, 25 Sep 2023 21:57:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4 09/18] net/smc: introduce SMC-D loopback
 device
To:     Alexandra Winter <wintera@linux.ibm.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     schnelle@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <1695568613-125057-10-git-send-email-guwen@linux.alibaba.com>
 <3febdf3e-e213-7acf-7dd4-75d177676c3e@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <3febdf3e-e213-7acf-7dd4-75d177676c3e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 2023/9/25 19:50, Alexandra Winter wrote:
> 
> 
> On 24.09.23 17:16, Wen Gu wrote:
>> This patch introduces a kind of loopback device for SMC-D. The device
>> is created when SMC module is loaded and destroyed when the SMC module
>> is unloaded. The loopback device is a kernel device used only by the
>> SMC module and is not restricted by net namespace, so it can be used
>> for local inter-process or inter-container communication.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>   net/smc/Kconfig        |  13 ++++
>>   net/smc/Makefile       |   2 +-
>>   net/smc/af_smc.c       |  12 +++-
>>   net/smc/smc_loopback.c | 165 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   net/smc/smc_loopback.h |  33 ++++++++++
>>   5 files changed, 223 insertions(+), 2 deletions(-)
>>   create mode 100644 net/smc/smc_loopback.c
>>   create mode 100644 net/smc/smc_loopback.h
> 
> 
> Hello Wen Gu,
> 
> thank you for adding the Kconfig, so the distributions can decide when to offer this feature.
> 
> I propose you add some kind of runtime switch as well. Not every user who loads the SMC module
> may want to exploit smcd-loopback. Especially in native environements without containers.
> 
> If no RoCE interfaces or no ISM interfaces exist, the respective handling is skipped in SMC.
> If loopback is always created unconditionally, there is no way to opt-out.

Yes, I need to think about this. Make a runtime switch to enable/disable the loopback-ism just
like ip link up/down. An rough idea is to add an smc-tools command, like 'smcd device disable/enable loopback'.

Thank you very much.

Regards,
Wen Gu
