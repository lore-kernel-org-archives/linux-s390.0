Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19331C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 11 Feb 2022 09:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348039AbiBKJIo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 11 Feb 2022 04:08:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238422AbiBKJIn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 11 Feb 2022 04:08:43 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECCDC30;
        Fri, 11 Feb 2022 01:08:42 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V48M.tt_1644570517;
Received: from 30.225.24.58(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0V48M.tt_1644570517)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Feb 2022 17:08:38 +0800
Message-ID: <ab5a6be2-a678-0149-b2cc-112c40c05b82@linux.alibaba.com>
Date:   Fri, 11 Feb 2022 17:08:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in smc_fback_error_report
To:     syzbot <syzbot+b425899ed22c6943e00b@syzkaller.appspotmail.com>,
        davem@davemloft.net, kgraul@linux.ibm.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000013ca8105d7ae3ada@google.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <00000000000013ca8105d7ae3ada@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 2022/2/11 2:36 am, syzbot wrote:


> BUG: KASAN: slab-out-of-bounds in smc_fback_error_report+0x96/0xa0 net/smc/af_smc.c:664
> Read of size 8 at addr ffff88801ca31aa8 by task swapper/0/0

Thanks for the report.

I am working on fixing this. It looks like smc_sock has been freed during the
call to smc_fback_error_report().


Thanks,
Wen Gu

