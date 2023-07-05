Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E9FC001B0
	for <linux-s390@archiver.kernel.org>; Wed,  5 Jul 2023 09:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjGEJud (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 Jul 2023 05:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjGEJuc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Jul 2023 05:50:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4474D1710
        for <linux-s390@vger.kernel.org>; Wed,  5 Jul 2023 02:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6B97614D8
        for <linux-s390@vger.kernel.org>; Wed,  5 Jul 2023 09:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 356D6C433C8;
        Wed,  5 Jul 2023 09:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688550621;
        bh=aBZJ37AQ3B6gDkew2/GdvBukbROjBz5nfjoFvF/MOF0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rxoflrXlIT3aLpjSc37URPSqzNseuT8ivjTqIdxqNUw1WBK2WiyWYrNWsQNLPBTrb
         ra0voMvkwJ5oZOPLwyJPE7LNGrxazGJfWVM3ZO4Ii4ozcVmpLCPfxqi/JVIUsxiAQq
         4qgYRdCZVOHFFBDVPWUXgGC6gewl+y8HZ8QS4qYO+qZXVYBJ18uIHIlyvzII9A9GPX
         5ENQBiygkPSEswqDYjbMj+cw+eYl4myewikjdRm5dZ/T/a53Ee62vzQGKOpfVdKLg0
         fkPbIZq5oafSIG2HlUEqY/MBuv4hNchHhzvloP1Tde1Zbe1CtbMU9Fy61iOaeuQZiJ
         u9v4c6ah5o8gg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 109B8C561EE;
        Wed,  5 Jul 2023 09:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] s390/qeth: Fix vipa deletion
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168855062106.9766.9208321463101789168.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Jul 2023 09:50:21 +0000
References: <20230704144121.3737032-1-wintera@linux.ibm.com>
In-Reply-To: <20230704144121.3737032-1-wintera@linux.ibm.com>
To:     Alexandra Winter <wintera@linux.ibm.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, hca@linux.ibm.com,
        twinkler@linux.ibm.com, wenjia@linux.ibm.com
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  4 Jul 2023 16:41:21 +0200 you wrote:
> From: Thorsten Winkler <twinkler@linux.ibm.com>
> 
> Change boolean parameter of function "qeth_l3_vipa_store" inside the
> "qeth_l3_dev_vipa_del4_store" function from "true" to "false" because
> "true" is used for adding a virtual ip address and "false" for deleting.
> 
> Fixes: 2390166a6b45 ("s390/qeth: clean up L3 sysfs code")
> 
> [...]

Here is the summary with links:
  - [net] s390/qeth: Fix vipa deletion
    https://git.kernel.org/netdev/net/c/80de809bd35e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


