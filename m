Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015C0EB64D7
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jun 2023 10:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjFWKU5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Jun 2023 06:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjFWKUd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 23 Jun 2023 06:20:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D021A3
        for <linux-s390@vger.kernel.org>; Fri, 23 Jun 2023 03:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C4FE61968
        for <linux-s390@vger.kernel.org>; Fri, 23 Jun 2023 10:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 096ABC433C9;
        Fri, 23 Jun 2023 10:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687515621;
        bh=0G4VLzTwApRcDkGPRDhlojw0Eo5X0jKO6ZzUVDxIObY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=m8pI2SWIcB9SbcC3pdSlMHA+8Vff6xrOzA2M7NtUyoJ9JlN4SsU+FiAkqCPUf52FF
         FiyYZgEV/wuXx6pgQJT+kkG2mKVE0/ZpvK8XEne/M0ko7Xf4viQZnIXDUhlH+hJoQJ
         aCy/GMvs7XvuwVaANTzvHnULYp0DXa0db4oy15uzEmFtNEWKcxVkabSV/gV2bouXf5
         5wBwZKyQHJY2PW94Y1+6WWV2zElJ82onnl7fse4V3sNVg3U877RtoKnsB5xD87Plz3
         LF+9QZbkJPGK34JN06D53l1U/NkCY6wf55e+4VVQMUPvUq/m76h8Yy9AULOpMzWp1t
         m+fQMXs4bX0Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DBD8EC43143;
        Fri, 23 Jun 2023 10:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] s390/net: updates 2023-06-10
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168751562089.32220.265545719667206181.git-patchwork-notify@kernel.org>
Date:   Fri, 23 Jun 2023 10:20:20 +0000
References: <20230621134921.904217-1-wintera@linux.ibm.com>
In-Reply-To: <20230621134921.904217-1-wintera@linux.ibm.com>
To:     Alexandra Winter <wintera@linux.ibm.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, hca@linux.ibm.com
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 Jun 2023 15:49:17 +0200 you wrote:
> Please apply the following patch series for s390's ctcm and lcs drivers
> to netdev's net-next tree.
> 
> Just maintenance patches, no functional changes.
> 
> Thanks,
> Alexandra
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] s390/lcs: Convert sysfs sprintf to sysfs_emit
    https://git.kernel.org/netdev/net-next/c/d3f0c7fa0993
  - [net-next,v2,2/4] s390/lcs: Convert sprintf to scnprintf
    https://git.kernel.org/netdev/net-next/c/1a079f3e9529
  - [net-next,v2,3/4] s390/ctcm: Convert sysfs sprintf to sysfs_emit
    https://git.kernel.org/netdev/net-next/c/d585e4b74806
  - [net-next,v2,4/4] s390/ctcm: Convert sprintf/snprintf to scnprintf
    https://git.kernel.org/netdev/net-next/c/1471d85ffba7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


