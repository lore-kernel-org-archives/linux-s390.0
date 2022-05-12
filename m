Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F48DC433EF
	for <linux-s390@archiver.kernel.org>; Thu, 12 May 2022 03:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344515AbiELDnt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 11 May 2022 23:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbiELDns (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 May 2022 23:43:48 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E8473547;
        Wed, 11 May 2022 20:43:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VCyzSpy_1652327023;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0VCyzSpy_1652327023)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 May 2022 11:43:43 +0800
Date:   Thu, 12 May 2022 11:43:42 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc:     kgraul@linux.ibm.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net/smc: non blocking recvmsg() return
 -EAGAIN when no data and signal_pending
Message-ID: <YnyCblJuPf+UAvjY@TonyMac-Alibaba>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <20220512031156.74054-1-guangguan.wang@linux.alibaba.com>
 <20220512031156.74054-2-guangguan.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512031156.74054-2-guangguan.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, May 12, 2022 at 11:11:55AM +0800, Guangguan Wang wrote:
> Non blocking sendmsg will return -EAGAIN when any signal pending
> and no send space left, while non blocking recvmsg return -EINTR
> when signal pending and no data received. This may makes confused.
> As TCP returns -EAGAIN in the conditions described above. Align the
> behavior of smc with TCP.
> 
> Fixes: 846e344eb722 ("net/smc: add receive timeout check")
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>

I see that you have already sent this patch to net, so this patch is a
duplicate. There is no need to send it again to net-next.

Thanks,
Tony Lu
