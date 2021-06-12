Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D42BC48BCF
	for <linux-s390@archiver.kernel.org>; Sat, 12 Jun 2021 20:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 224F7611CD
	for <linux-s390@archiver.kernel.org>; Sat, 12 Jun 2021 20:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhFLUME (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 12 Jun 2021 16:12:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhFLUMD (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 12 Jun 2021 16:12:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CB9CA61182;
        Sat, 12 Jun 2021 20:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623528603;
        bh=bSGeHuC5E0SEXTdsjJc9semAvsfO3B1EQwrHEAo6sLE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=s84HIqJR6PdSL6oym6xCWFEdqTecBjhGs9acX8UWzrMw+yA6lRKNphBm7CXb/39Rp
         gHEOv5/rQui7oEg2fU1oGFkIhbM7tAJG0yEqSwDQWAIiMu6CXygmBkZjgnk2hARqTL
         Z9M0CGsnryS+Gy0MFwPoYxuo5Jy4YzUmXfLsZdOnim2Cde018wmarVb210t6yaI0wY
         wc8NzYgacsd/hgTeTQ7omixz07HnDOIDE5+wCrx/f/LvQ03XQ+tEOUD19IIbhrRPIF
         wWOnGgfhnsQtXHSgkWdhy4l5SGhtT/ZWHs8IrWvMPY+fuv4DeaqrW2SHlU7qUNH9w7
         ZgAKYNah6UUaw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] s390/iucv: updates 2021-06-11
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162352860377.1274.17410671840872382469.git-patchwork-notify@kernel.org>
Date:   Sat, 12 Jun 2021 20:10:03 +0000
References: <20210611074502.1719233-1-jwi@linux.ibm.com>
In-Reply-To: <20210611074502.1719233-1-jwi@linux.ibm.com>
To:     Julian Wiedmann <jwi@linux.ibm.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, hca@linux.ibm.com, kgraul@linux.ibm.com
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Fri, 11 Jun 2021 09:45:00 +0200 you wrote:
> Hi Dave & Jakub,
> 
> please apply the following iucv patches to netdev's net-next tree.
> 
> This cleans up a pattern of forward declarations in two iucv drivers,
> so that they stop causing compile warnings with gcc11.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net/af_iucv: clean up some forward declarations
    https://git.kernel.org/netdev/net-next/c/87c272c618c7
  - [net-next,2/2] s390/netiuvc: get rid of forward declarations
    https://git.kernel.org/netdev/net-next/c/fbf179683655

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


