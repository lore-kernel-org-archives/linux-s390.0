Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56940C197A0
	for <linux-s390@archiver.kernel.org>; Fri, 17 Nov 2023 00:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345613AbjKQAk2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 16 Nov 2023 19:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345611AbjKQAk1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Nov 2023 19:40:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29621AD
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 16:40:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46E9AC433C7;
        Fri, 17 Nov 2023 00:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700181623;
        bh=D9mJhKQTheELXxLPtK1TMo1qKHE3Q8g2bys3rN1R6f0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=C13M6DUW33oCrKlgi/MSolPxf1bvzzbMTY7ZDF1s7dQeiwipAcLYD7fsgLrHipMcY
         4Kp6XBgNgFe+FqmR4WQADOYMzv6dslZkxIBuvyRk4MvQrhWErQev1cm2MIIcYLP6NV
         UDbORZYiqnciwtT9dEMHHqKWf05+iIpnLRC4HVjvlhgL8LtCHqh6e6jX6ERjHD+1pa
         bV7No7347PsDIS+fCU6s/FmOYGkthIVYaUe1E/85UzH6nkEoM7Oc6GtzeQc5lGesqz
         JDIHeAVTT0A7aOBygHlkWY8q3JZO3wFXb7h5T9mA2cY34JZ2hUsxEwaI6KB32Iir8q
         Jy7nd22ncPmSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C111E00090;
        Fri, 17 Nov 2023 00:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] s390/ism: ism driver implies smc protocol
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170018162317.17554.15888902026228306856.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Nov 2023 00:40:23 +0000
References: <20231115155958.3249645-1-gbayer@linux.ibm.com>
In-Reply-To: <20231115155958.3249645-1-gbayer@linux.ibm.com>
To:     Gerd Bayer <gbayer@linux.ibm.com>
Cc:     wintera@linux.ibm.com, wenjia@linux.ibm.com, horms@kernel.org,
        pabeni@redhat.com, guwen@linux.alibaba.com, rdunlap@infradead.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 15 Nov 2023 16:59:58 +0100 you wrote:
> Since commit a72178cfe855 ("net/smc: Fix dependency of SMC on ISM")
> you can build the ism code without selecting the SMC network protocol.
> That leaves some ism functions be reported as unused. Move these
> functions under the conditional compile with CONFIG_SMC.
> 
> Also codify the suggestion to also configure the SMC protocol in ism's
> Kconfig - but with an "imply" rather than a "select" as SMC depends on
> other config options and allow for a deliberate decision not to build
> SMC. Also, mention that in ISM's help.
> 
> [...]

Here is the summary with links:
  - [net,v2] s390/ism: ism driver implies smc protocol
    https://git.kernel.org/netdev/net/c/d565fa4300d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


