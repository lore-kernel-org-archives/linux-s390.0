Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3188CDB47E
	for <linux-s390@archiver.kernel.org>; Sat, 14 Oct 2023 00:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjJNAA2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 13 Oct 2023 20:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjJNAA1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 13 Oct 2023 20:00:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0F6C0;
        Fri, 13 Oct 2023 17:00:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D242FC433C9;
        Sat, 14 Oct 2023 00:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697241624;
        bh=kFo4c/EbqDXaAr5wdmeC7WwZTm8WTWty3Y/b3N8NZD8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UG114B4sZrEZ2OUbZYts2ro3NdyB4vqpl5ptb+hhFuI6Gity1Tq8t+Y+9LOjscyA3
         YKd7GiDoUbFs0OoeGHp1LG8c/29QRz+Idv4Z7xHTVtN/heP9/XUMVvbxkzuS4ggjVr
         7iJintb015NXJ1usn8B/bmAShgMcMJUjZh8Z+u8FBDZZqkxi+SZBDA0WHKchZMk5AW
         As3HVELAkVPCMJW8XVza2FYSCWZ2WwpUqW6twNO8rZBEIOwmhgSvP4kbbOI+p7SEOA
         4geo7K5z/oOt9dwCI9YSQtoMScvSu82AYWgcAYYXyVOiycV447BcjHS1Jam6nB1s2Q
         LjleikjqTBpkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B90C3E1F666;
        Sat, 14 Oct 2023 00:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net/smc: fix smc clc failed issue when netdevice not
 in init_net
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169724162475.10042.8870358455598573591.git-patchwork-notify@kernel.org>
Date:   Sat, 14 Oct 2023 00:00:24 +0000
References: <20231011074851.95280-1-huangjie.albert@bytedance.com>
In-Reply-To: <20231011074851.95280-1-huangjie.albert@bytedance.com>
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
        alibuda@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Oct 2023 15:48:51 +0800 you wrote:
> If the netdevice is within a container and communicates externally
> through network technologies such as VxLAN, we won't be able to find
> routing information in the init_net namespace. To address this issue,
> we need to add a struct net parameter to the smc_ib_find_route function.
> This allow us to locate the routing information within the corresponding
> net namespace, ensuring the correct completion of the SMC CLC interaction.
> 
> [...]

Here is the summary with links:
  - [v2,net] net/smc: fix smc clc failed issue when netdevice not in init_net
    https://git.kernel.org/netdev/net/c/c68681ae46ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


