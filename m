Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8082CC54EE9
	for <linux-s390@archiver.kernel.org>; Wed, 28 Sep 2022 02:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiI1CAV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 27 Sep 2022 22:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiI1CAU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 27 Sep 2022 22:00:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB1A1616F2;
        Tue, 27 Sep 2022 19:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2923661B30;
        Wed, 28 Sep 2022 02:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EAB0C433D6;
        Wed, 28 Sep 2022 02:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664330418;
        bh=PSkT84+kLIOyET1QVrc8xAtKCtLxdBnnOFxQ+LAf9zo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=m+SRhqt6l9/qk2xlfHKESN4o+fL1gq5HmysFZJSiHmUBPqSeCJKtPjnzarP42uF2J
         cgJPqcGsopj98nk8d2dxuYoaCnhxIRbZMgXJXf1cAgXfjlV4icdVIaGs7K08CApe4N
         GoEZu/nyqJVCJeEoyHeiDhjbZnGcgGJzyBu8Ny4oKVkFY8WVDpRHHVXnEkQwH/1J/T
         8kTfgtISlLD9U08kSLIt+Mi2slAGcAU17X4QnjFRLyHn/COrdJv/ZHGBacKsKSqQ16
         NBfUds5C9yXfmA2Vh0AMdCejyFbNfw8fUiSobxa1n4937sCExDII4lVz6WuUbiVVaD
         xDGuad+F9exwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A3C4C04E59;
        Wed, 28 Sep 2022 02:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] s390/qeth: Split memcpy() of struct qeth_ipacmd_addr_change
 flexible array
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166433041836.32421.4705173383339135260.git-patchwork-notify@kernel.org>
Date:   Wed, 28 Sep 2022 02:00:18 +0000
References: <20220927003953.1942442-1-keescook@chromium.org>
In-Reply-To: <20220927003953.1942442-1-keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Sep 2022 17:39:53 -0700 you wrote:
> To work around a misbehavior of the compiler's ability to see into
> composite flexible array structs (as detailed in the coming memcpy()
> hardening series[1]), split the memcpy() of the header and the payload
> so no false positive run-time overflow warning will be generated.
> 
> [1] https://lore.kernel.org/linux-hardening/20220901065914.1417829-2-keescook@chromium.org/
> 
> [...]

Here is the summary with links:
  - s390/qeth: Split memcpy() of struct qeth_ipacmd_addr_change flexible array
    https://git.kernel.org/netdev/net-next/c/8f1e1658d365

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


