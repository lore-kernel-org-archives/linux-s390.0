Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A49EC001DE
	for <linux-s390@archiver.kernel.org>; Wed,  2 Aug 2023 09:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjHBJUY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 2 Aug 2023 05:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjHBJUX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Aug 2023 05:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C287A8
        for <linux-s390@vger.kernel.org>; Wed,  2 Aug 2023 02:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDF5C618CC
        for <linux-s390@vger.kernel.org>; Wed,  2 Aug 2023 09:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A41FC433C9;
        Wed,  2 Aug 2023 09:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690968021;
        bh=K+scnvFOeZn+qs2Y4uK06yD8U/KPe7In361cfN7JZ5Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gtXV1xyVIRPuM2jjLJrAvZM7fBS93gqGVuaSfcB+sbAm/Oqy5uKzzDYW7px93JkEa
         WBwnNpR8lL3bvsXTCX2z3Yw43EmcSNST44ZYeAYivCnc7MGX0M4npdDCB367GA38RM
         jUsRZDSqqdvPn16WiQmdDOBlZX5+kOx2h07OMIUWNqiNz7yG0BPw9NWUObiwX0d9Wa
         CguUzHcCB9iQcIwV39DTY70b9mENDhJaLc1QVUMFEcTE4wcb+AUWhfiqJTnXmQ+sxW
         1XU9AhYncRQwDKQlJdxwqidyZpmoeQpWXpXiE55SpdnWr7ELAkxs6L9UBS8ItOcfSF
         hvAQztgyenI6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28D53C6445A;
        Wed,  2 Aug 2023 09:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] s390/qeth: Don't call dev_close/dev_open (DOWN/UP)
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169096802115.5600.7801745258990045314.git-patchwork-notify@kernel.org>
Date:   Wed, 02 Aug 2023 09:20:21 +0000
References: <20230801080016.744474-1-wintera@linux.ibm.com>
In-Reply-To: <20230801080016.744474-1-wintera@linux.ibm.com>
To:     Alexandra Winter <wintera@linux.ibm.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, hca@linux.ibm.com, wenjia@linux.ibm.com
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  1 Aug 2023 10:00:16 +0200 you wrote:
> dev_close() and dev_open() are issued to change the interface state to DOWN
> or UP (dev->flags IFF_UP). When the netdev is set DOWN it loses e.g its
> Ipv6 addresses and routes. We don't want this in cases of device recovery
> (triggered by hardware or software) or when the qeth device is set
> offline.
> 
> Setting a qeth device offline or online and device recovery actions call
> netif_device_detach() and/or netif_device_attach(). That will reset or
> set the LOWER_UP indication i.e. change the dev->state Bit
> __LINK_STATE_PRESENT. That is enough to e.g. cause bond failovers, and
> still preserves the interface settings that are handled by the network
> stack.
> 
> [...]

Here is the summary with links:
  - [net] s390/qeth: Don't call dev_close/dev_open (DOWN/UP)
    https://git.kernel.org/netdev/net/c/1cfef80d4c2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


