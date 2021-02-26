Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9AFC433DB
	for <linux-s390@archiver.kernel.org>; Fri, 26 Feb 2021 14:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7287264E20
	for <linux-s390@archiver.kernel.org>; Fri, 26 Feb 2021 14:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBZOmp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 26 Feb 2021 09:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhBZOmn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 26 Feb 2021 09:42:43 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6112FC06174A
        for <linux-s390@vger.kernel.org>; Fri, 26 Feb 2021 06:42:03 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id d20so8231579qkc.2
        for <linux-s390@vger.kernel.org>; Fri, 26 Feb 2021 06:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aiCmYhXNlLmYvqysrua9w657uIfuMXAdivhZFAKEpXA=;
        b=NpKzeFXzuOhQbPo6fKVGMdf8+6iELovgUdCKZpMjN2+fdRPxMj98bWKMPa5Y7KF4/N
         vdL3T58tWpe6je0uydaDGpnNIAtNYbCDXb3HxGBOzIghdhU4d87IipH4ECbR6hIuHYL2
         OE4vaDcL+OI76JrDT110BgkIXDKANwC6gCSc9nelFg1RXHfxsTBuTo2BHt3HTkq+empV
         emd0QwJTTpMSsuAj4VMYxzsN04yBeIGuNxeQNqGKbXDSLy2e/LLZE2oB5yAYKcSuV1DG
         aecXjS/f39eZ6dU0YumxMHbEXGM5IPG7jTLpdrY6p3P4TFb7KAt2gn4o2nh2Yv5IT7vh
         IYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aiCmYhXNlLmYvqysrua9w657uIfuMXAdivhZFAKEpXA=;
        b=dv47ErsOT7RupbeVgyO5fzslb09b2zKKntHzvJlUay62B7tRWfq/FgP17qQjD+WvdB
         Xy1Cg7DcIl2qbHoNIwnnNGx6FijZcAW7IloyC0MnK5x76COqR+q00K33fT1sSen1WqvI
         lK+xNyd/SCRhNG2mqA6Ez454Yr0wUlwn++iBcKgGauYFVOa68VGjOj51LG1tsU+ckRLp
         kKSbCYKj8/ZRg80s7oBSv3ySkc3/I4aXi14DDUECcSRP5i9Q4wcEV7DSXBDFXlrAn36y
         Q5oFZ7kZqKMVbvZPSt0g9+TEiVjfnG3GRpaMqfnZO3AvMNnXB2ie58UEvoa+hYp7nBGO
         VlPg==
X-Gm-Message-State: AOAM532HT6BKGewgTkmvjYvSEC6GoN1FokQsOEtveX3wT730I9eoJtfB
        Qmn80b76hEkcBAj4M9R5Imaw7Q==
X-Google-Smtp-Source: ABdhPJy2NOOfE5ZleC1vNC6+D2fTtJXEm1J15WIn4t802EjUbQ4eaTkrRyQ86tK+Y+nBiiCdVzv/WQ==
X-Received: by 2002:a37:7c8:: with SMTP id 191mr2908942qkh.53.1614350522094;
        Fri, 26 Feb 2021 06:42:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id t71sm6437470qka.86.2021.02.26.06.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 06:42:01 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lFeJc-000tBv-SJ; Fri, 26 Feb 2021 10:42:00 -0400
Date:   Fri, 26 Feb 2021 10:42:00 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Freeing page tables through RCU
Message-ID: <20210226144200.GV2643399@ziepe.ca>
References: <20210225205820.GC2858050@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225205820.GC2858050@casper.infradead.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Feb 25, 2021 at 08:58:20PM +0000, Matthew Wilcox wrote:

> I'd like to hear better ideas than this.

You didn't like my suggestion to put a sleepable lock around the
freeing of page tables during flushing?

I still don't see how you convert the sleepable page walkers to use
rcu??

Jason
 
