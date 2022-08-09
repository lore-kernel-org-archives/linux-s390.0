Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AABC19F2D
	for <linux-s390@archiver.kernel.org>; Tue,  9 Aug 2022 04:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiHIEAT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 9 Aug 2022 00:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiHIEAS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Aug 2022 00:00:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E942CDF1;
        Mon,  8 Aug 2022 21:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C28261171;
        Tue,  9 Aug 2022 04:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6F11C43142;
        Tue,  9 Aug 2022 04:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660017614;
        bh=Ug/IAXpiHBK+sAnIMDCJGN9SvQA0ec/Ae7K3k5h6t/c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uIXENg0XTuCWKTdSmr0T1D5JhCcTxTPPo1khWflMU/Im230+HG4E1U/PeCESiN8i7
         HObJVaY8jvtj4t967LekY7CesJrfRHwVe2EteWou+m6KK7MWH6Yg54RscOTLqWyqT9
         CNbdotLVROWhI3Q7sZVWZSOBdi7x9J3QFf8u9ppddTFHEDUlBEqiSFxU6tlGzHOWAz
         dakMncB3pxjbt5OIb33Lq/ODjYrFIVCZf43fmCQkLJPu8DflhjXC+fnUK3gh8TIhyl
         vJd6+OnMIIDv5DjpwApUxJdT0VP93zdnfTuti4FtpOlhxkyb3XjmV8oTZSazDj9791
         4DCAaNxptqR5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8DDBFC43145;
        Tue,  9 Aug 2022 04:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] s390/qeth: cache link_info for ethtool
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166001761457.6286.2669966762642326883.git-patchwork-notify@kernel.org>
Date:   Tue, 09 Aug 2022 04:00:14 +0000
References: <20220805155714.59609-1-wintera@linux.ibm.com>
In-Reply-To: <20220805155714.59609-1-wintera@linux.ibm.com>
To:     Alexandra Winter <wintera@linux.ibm.com>
Cc:     davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        hca@linux.ibm.com, twinkler@linux.ibm.com
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Aug 2022 17:57:14 +0200 you wrote:
> Since
> commit e6e771b3d897 ("s390/qeth: detach netdevice while card is offline")
> there was a timing window during recovery, that qeth_query_card_info could
> be sent to the card, even before it was ready for it, leading to a failing
> card recovery. There is evidence that this window was hit, as not all
> callers of get_link_ksettings() check for netif_device_present.
> 
> [...]

Here is the summary with links:
  - [net,v2] s390/qeth: cache link_info for ethtool
    https://git.kernel.org/netdev/net/c/7a07a29e4f67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


