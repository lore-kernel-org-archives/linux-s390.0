Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC46CCA48A
	for <linux-s390@archiver.kernel.org>; Tue, 26 Jul 2022 03:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbiGZDbc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 25 Jul 2022 23:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiGZDbb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 25 Jul 2022 23:31:31 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B1528E33;
        Mon, 25 Jul 2022 20:31:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VKTKzIl_1658806286;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0VKTKzIl_1658806286)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 11:31:27 +0800
Date:   Tue, 26 Jul 2022 11:31:26 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>
Subject: Re: [PATCH net-next 0/4] net/smc: updates 2022-7-25
Message-ID: <Yt9gDrS6Ag0Bd9id@TonyMac-Alibaba>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <20220725141000.70347-1-wenjia@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725141000.70347-1-wenjia@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jul 25, 2022 at 04:09:56PM +0200, Wenjia Zhang wrote:
> Hi Dave & Jakub,
> 
> please apply the following patches to netdev's net-next tree.
> 
> These patches do some preparation to make ISM available for uses beyond
> SMC-D, and a bunch of cleanups.
> 
> Thanks,
> Wenjia

Hello Wenjia,

Making ISM available for others sounds great. I proposed a RFC [1] last
week. The RFC brings an ISM-like device to accelerate inter-VM scenario.
I am wondering the plan about this, which may help us. And hope to hear
from you about the RFC [1]. Thank you.

[1] https://lore.kernel.org/all/20220720170048.20806-1-tonylu@linux.alibaba.com/

Cheers,
Tony Lu
