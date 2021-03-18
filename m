Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464F4C433E6
	for <linux-s390@archiver.kernel.org>; Thu, 18 Mar 2021 23:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F7D764D74
	for <linux-s390@archiver.kernel.org>; Thu, 18 Mar 2021 23:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhCRXaK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 18 Mar 2021 19:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231938AbhCRXaJ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Mar 2021 19:30:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4383664F3B;
        Thu, 18 Mar 2021 23:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616110209;
        bh=MbnUdDqu/BvfLKkrOyaq+Ui14UNXdEuaXNsxbFc74UM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aXdKSbXFA02bEX/S7GIhWzIaNijobykZT4dogyLfBhAvp/LLz3HKtMcUHvXFbfcIU
         QJMVHigYBGTcWpbShJ8Zr4iyG5+RUG2luqBFNfhCy25NC6doOpqV8FX6iWOsb1N+fV
         oIESOy161bpSYI6o7i24jWoLNNHi1w+us2aNJCUsZ0/L/J+tDobkZhoOyIaCenj/+7
         Xf7wPEnhPppmqEHfwLeQLn+YN8k2b6M4ttzLUl+9RUSWqBuz4gnb+9N6SJvTojXMbh
         78PD3UPL1PfY9Bck2mDBhW3XvI9VevToZDSDo1kuB7EaDnmqm58LpfJ+G9b2NfEvIu
         CsUphzRU/026Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] s390/qeth: updates 2021-03-18
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161611020921.24048.622039848889756120.git-patchwork-notify@kernel.org>
Date:   Thu, 18 Mar 2021 23:30:09 +0000
References: <20210318185456.2153426-1-jwi@linux.ibm.com>
In-Reply-To: <20210318185456.2153426-1-jwi@linux.ibm.com>
To:     Julian Wiedmann <jwi@linux.ibm.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, hca@linux.ibm.com, kgraul@linux.ibm.com
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Thu, 18 Mar 2021 19:54:53 +0100 you wrote:
> Hi Dave & Jakub,
> 
> please apply the following patch series for qeth to netdev's net-next
> tree.
> 
> This brings two small optimizations (replace a hard-coded GFP_ATOMIC,
> pass through the NAPI budget to enable napi_consume_skb()), and removes
> some redundant VLAN filter code.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] s390/qeth: allocate initial TX Buffer structs with GFP_KERNEL
    https://git.kernel.org/netdev/net-next/c/e47ded97f972
  - [net-next,2/3] s390/qeth: enable napi_consume_skb() for pending TX buffers
    https://git.kernel.org/netdev/net-next/c/ad4bbd7285ad
  - [net-next,3/3] s390/qeth: remove RX VLAN filter stubs in L3 driver
    https://git.kernel.org/netdev/net-next/c/d96a8c693d0a

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


