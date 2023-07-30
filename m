Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98DEC001DF
	for <linux-s390@archiver.kernel.org>; Sun, 30 Jul 2023 17:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjG3RZs (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 30 Jul 2023 13:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG3RZr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 30 Jul 2023 13:25:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFCA126;
        Sun, 30 Jul 2023 10:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78EA860C95;
        Sun, 30 Jul 2023 17:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32ADAC433C7;
        Sun, 30 Jul 2023 17:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690737945;
        bh=bh6u2MzpdMnVE6tLD8Ry8Qo9sUET08WImS5mG9hAsUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V3DYeWUxkkTtvJPmLrvSEdvr6G+VBhrYIDWO+DlnsJN8cLlwTChpbSrNyyMSBjP0l
         3Eg4ZO9P+j4YuMDnAfPexv6pDEG9GzKoXseXB1GT7ZLP+/MBzuTM9EtNO9eVxUeddc
         OFrqIKtF8ZuWzVvvIy7igqCoo5nsLiQXzSIRySt7kGTe3YrTghhdQzDCoF2ZKkXwXh
         +VWqz7VbLI1eUq/BqA4FTGFeHqh2iGQaw+jMrUJajudaYRDiVmTGBkmdq2gShkCXvZ
         kn1sj7nzZKdWDcfeiuSzU5hazyKAnYWxnRYQ9gWjcq5BMB2EJ3E/5TGl3dQLqVv98A
         H+vSi/e6FIMfA==
Date:   Sun, 30 Jul 2023 19:25:41 +0200
From:   Simon Horman <horms@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/smc: Remove unused function declarations
Message-ID: <ZMadFUMmqgVXvjMe@kernel.org>
References: <20230729121929.17180-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729121929.17180-1-yuehaibing@huawei.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, Jul 29, 2023 at 08:19:29PM +0800, Yue Haibing wrote:
> commit f9aab6f2ce57 ("net/smc: immediate freeing in smc_lgr_cleanup_early()")
> left behind smc_lgr_schedule_free_work_fast() declaration.
> And since commit 349d43127dac ("net/smc: fix kernel panic caused by race of smc_sock")
> smc_ib_modify_qp_reset() is not used anymore.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

