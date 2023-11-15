Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85630C07548
	for <linux-s390@archiver.kernel.org>; Wed, 15 Nov 2023 10:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjKOKXN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Nov 2023 05:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKOKXN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Nov 2023 05:23:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B501C2
        for <linux-s390@vger.kernel.org>; Wed, 15 Nov 2023 02:23:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AA3C433C7;
        Wed, 15 Nov 2023 10:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700043789;
        bh=DWYELWdhnmyOJkCXuhTFzSkejMRb7zklpUwmxG2CRGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lzRN+vhe015zWHPFTdSqu5jvlbLrYQk4W6HYXNX3lzL9UlQl9yMZnsFuthl1oCQKs
         SAhdmhbkrlNg7hi6myCW/MdrNIRLKqh/eiSsy8tdKOSWkULpjoAnj1VqRqQd9PcZ/5
         hxWaj4cc9mi6WOLzHLWW62YuvN8/N/77X6ABaFZSq3pBxQO+E6wrIGo1HWlJkhqet6
         LTGWIUZnVlvzd0k0bX/r3r1Xl7off4Bl3qodZT7RAhnZ2nP7q69fGq2akd7I1T3qXS
         sA+/QN6h6piiEBXfW5/HkRMLV/NVUmtrPrsrkEd4xxJHDdd1OjEoqwOgPmqDEp4NtT
         63TsJhLhX/yxA==
Date:   Wed, 15 Nov 2023 10:23:04 +0000
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
Subject: Re: [PATCH net] s390/ism: ism driver implies smc protocol
Message-ID: <20231115102304.GN74656@kernel.org>
References: <b152ec7c0e690027da1086b777a3ec512001ba1f.camel@linux.ibm.com>
 <20231114091718.3482624-1-gbayer@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114091718.3482624-1-gbayer@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Nov 14, 2023 at 10:17:18AM +0100, Gerd Bayer wrote:
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

Hi Gerd,

In a similar vein, I am wondering if the forward declaration of ism_ops
could be removed.  In my very light compile test it shows up as unused when
CONFIG_SMC is unset.
