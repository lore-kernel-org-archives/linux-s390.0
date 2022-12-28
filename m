Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A266C3DA7D
	for <linux-s390@archiver.kernel.org>; Wed, 28 Dec 2022 12:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbiL1MUW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Dec 2022 07:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiL1MUV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 28 Dec 2022 07:20:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4D5654E;
        Wed, 28 Dec 2022 04:20:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E01C2CE12CF;
        Wed, 28 Dec 2022 12:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6E57C433F1;
        Wed, 28 Dec 2022 12:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672230015;
        bh=BF8pGi2+TlK5BZ4zCkFeHhTghrWTuL6n7RHTNforA+s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=J0PicxVU03gLawjfOSUaldlJ2VGBNQkt8XnFjEBv7a6Pl5qCAZ36A26wtOCgW75Nm
         UFpqmCrt6BovwvaNcvMhuZEy/ZScrlLtle4RSqWgxOmZxgLMg9z4LLVs4oBg4fQodB
         oE85uA+xuLKZQuvvhkC7+1qq/5dAftE/BZjeS0N3MJDP7olkbGjot3NHVB9XcLy/9c
         yBv2rVjlG2s2CvtUxnqNzk4lJERYwU1C8NKzgNDeEBSED0jVCk+6gGxULkCww7RdNJ
         UpcSOc/CXXiVqeI3GQJfAkGz7NcgNNfuLuvk289AGL9mso75yjoLzhq9RK0K0W0Wzr
         BYJCim2x4pyZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD6E9E50D70;
        Wed, 28 Dec 2022 12:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] s390/qeth: convert sysfs snprintf to sysfs_emit
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167223001583.30539.3371420401703338150.git-patchwork-notify@kernel.org>
Date:   Wed, 28 Dec 2022 12:20:15 +0000
References: <20221227110352.1436120-1-zhangxuezhi3@gmail.com>
In-Reply-To: <20221227110352.1436120-1-zhangxuezhi3@gmail.com>
To:     Xuezhi Zhang <zhangxuezhi3@gmail.com>
Cc:     zhangxuezhi1@coolpad.com, wintera@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Tue, 27 Dec 2022 19:03:52 +0800 you wrote:
> From: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst
> and show() should only use sysfs_emit() or sysfs_emit_at()
> when formatting the value to be returned to user space.
> 
> Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
> 
> [...]

Here is the summary with links:
  - s390/qeth: convert sysfs snprintf to sysfs_emit
    https://git.kernel.org/netdev/net/c/c2052189f19b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


