Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31063C433B4
	for <linux-s390@archiver.kernel.org>; Mon, 17 May 2021 22:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 063F761263
	for <linux-s390@archiver.kernel.org>; Mon, 17 May 2021 22:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242691AbhEQWb1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 17 May 2021 18:31:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238209AbhEQWb0 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 May 2021 18:31:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A423D611CA;
        Mon, 17 May 2021 22:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621290609;
        bh=FUoBJhupcvdKtho7QFp36o8gahZxNsNfuHuyznCWcnQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BNWG93lg5Eki5TTLu3xnfI0D9X2R9SFDEFBASrlzLWKR16/UKggjrO2bGDY9OvnOq
         DWul8jeX4GNZqvG7c+cGoIoiHeegalFpqxbiIeY7rmtaba+V1esD7yImsWpbtgZP8o
         yRj2BYrm+nX2MlRahv5EPo5NBAlnq+D/LLwmS60+T7ylJTLYE//mc0n3wyf8nZFVHA
         ObbBbepH6AKtnBqzcRwM/BKcMlDkNtxDdhNc5F8J+woJoPO/lvN9Bq2D5gz8MyBHyI
         34eVxV1l9zCu6ktRtj1XGu/70Go/0WIyY6U6/qTqxd1UJxiElLBScKVcA8DRsMLczl
         Lu3pygCLcTf9w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: remove device from smcd_dev_list after failed
 device_add()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162129060962.6973.2951105480766864399.git-patchwork-notify@kernel.org>
Date:   Mon, 17 May 2021 22:30:09 +0000
References: <20210517084706.1620399-1-kgraul@linux.ibm.com>
In-Reply-To: <20210517084706.1620399-1-kgraul@linux.ibm.com>
To:     Karsten Graul <kgraul@linux.ibm.com>
Cc:     davem@davemloft.net, kuba@kernel.org, hca@linux.ibm.com,
        raspl@linux.ibm.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Mon, 17 May 2021 10:47:06 +0200 you wrote:
> From: Julian Wiedmann <jwi@linux.ibm.com>
> 
> If the device_add() for a smcd_dev fails, there's no cleanup step that
> rolls back the earlier list_add(). The device subsequently gets freed,
> and we end up with a corrupted list.
> 
> Add some error handling that removes the device from the list.
> 
> [...]

Here is the summary with links:
  - [net] net/smc: remove device from smcd_dev_list after failed device_add()
    https://git.kernel.org/netdev/net/c/444d7be9532d

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


