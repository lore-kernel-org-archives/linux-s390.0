Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED68AC072A2
	for <linux-s390@archiver.kernel.org>; Wed, 15 Nov 2023 17:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjKORGr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Nov 2023 12:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKORGq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Nov 2023 12:06:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30761FA
        for <linux-s390@vger.kernel.org>; Wed, 15 Nov 2023 09:06:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA66C433C8;
        Wed, 15 Nov 2023 17:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700068002;
        bh=Tlfp2N2A2Hj49oZ8goM0ixR1B8LdhTFDoiNDx/3SHSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i2HmI5/JXx9FJ7u1uteyztnrAQVC+Qt3F3smUFmZ8/j1N+ODQoBMkZ99alJhmXFvD
         QSfGzEWEN9i4WEECeDFvEYprZwQduuGsFyawEMOFzhFtnnDHqw1SkAQd/Uu+9+5Ymf
         tJ97fsvqAh1eA8AexgC+b8aJbZE2calIT0jVuK3YGmP/oQTEybJqkWAccEGXGJyCMg
         dAbQMZzI1lYwswn1toi7Zb+/QL5xJDEIoqqc7HDsFQtxP/XpfoH3hfFmJVwX2+wVbH
         m67p0qiYuWOqn9TRhA6FCye8gn2YRvGUeo5F8KawC9FosgNvO4i/gRxIw5Nni3TBfL
         DfIyBZ0YQvBnA==
Date:   Wed, 15 Nov 2023 17:06:37 +0000
From:   Simon Horman <horms@kernel.org>
To:     Gerd Bayer <gbayer@linux.ibm.com>
Cc:     Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, dust.li@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] s390/ism: ism driver implies smc protocol
Message-ID: <20231115170637.GR74656@kernel.org>
References: <20231115102304.GN74656@kernel.org>
 <20231115155958.3249645-1-gbayer@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115155958.3249645-1-gbayer@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Nov 15, 2023 at 04:59:58PM +0100, Gerd Bayer wrote:
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
> Fixes: a72178cfe855 ("net/smc: Fix dependency of SMC on ISM")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/netdev/afd142a2-1fa0-46b9-8b2d-7652d41d3ab8@infradead.org/
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> ---
>  drivers/s390/net/Kconfig   |  3 +-
>  drivers/s390/net/ism_drv.c | 93 +++++++++++++++++++-------------------
>  2 files changed, 48 insertions(+), 48 deletions(-)
> 
> Hi Simon,
> 
> this is version 2, that removes the unused forward declaration that you
> found in v1 per:
> https://lore.kernel.org/netdev/20231115102304.GN74656@kernel.org/#t
> Other than that the patch is unchanged.

Thanks Gerd,

this version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
