Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F20C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 19 Apr 2022 10:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbiDSK0Q (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 19 Apr 2022 06:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiDSK0O (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Apr 2022 06:26:14 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF968237FE;
        Tue, 19 Apr 2022 03:23:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VAUn-3l_1650363806;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0VAUn-3l_1650363806)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Apr 2022 18:23:27 +0800
Date:   Tue, 19 Apr 2022 18:23:26 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     yacanliu@163.com
Cc:     kgraul@linux.ibm.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuyacan <liuyacan@corp.netease.com>
Subject: Re: [PATCH] net/smc: sync err info when TCP connection is refused
Message-ID: <Yl6Nnvnrvqv3ofES@TonyMac-Alibaba>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <20220417123307.1094747-1-yacanliu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220417123307.1094747-1-yacanliu@163.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sun, Apr 17, 2022 at 08:33:07PM +0800, yacanliu@163.com wrote:
> From: liuyacan <liuyacan@corp.netease.com>
> 
> In the current implementation, when TCP initiates a connection
> to an unavailable [ip,port], ECONNREFUSED will be stored in the
> TCP socket, but SMC will not. However, some apps (like curl) use
> getsockopt(,,SO_ERROR,,) to get the error information, which makes
> them miss the error message and behave strangely.
> 
> Signed-off-by: liuyacan <liuyacan@corp.netease.com>

This fix works for me. I have tested it with curl for unavailable
address.

This patch missed net or net-next tag, I think net is preferred.

Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>

Thank you,
Tony Lu
