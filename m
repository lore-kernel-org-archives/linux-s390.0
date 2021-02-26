Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1D1C433DB
	for <linux-s390@archiver.kernel.org>; Fri, 26 Feb 2021 16:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6569364EE1
	for <linux-s390@archiver.kernel.org>; Fri, 26 Feb 2021 16:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBZQW2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 26 Feb 2021 11:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhBZQW0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 26 Feb 2021 11:22:26 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C7FC06174A
        for <linux-s390@vger.kernel.org>; Fri, 26 Feb 2021 08:21:44 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id q85so9568483qke.8
        for <linux-s390@vger.kernel.org>; Fri, 26 Feb 2021 08:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wKhee+wwyY8wAQtAwhfFGxIYlymbanXy7c8d3WGe9uw=;
        b=UbX00wvuuvMEYhRJX3nCu4zXb85v13Cqv2r7hy9O+bowY1FaIbOHtDcePeLY0/B0Da
         SF2Rt/j2i5vqV+2nd6y/YV7vdWi7UcnYCo6GUDusZkQq2I/4QAMG5NnybLXlvhoAWc4E
         CB07JSKy/zS1mTJuVrl1tmyNn9/lGP5fKjyqtPqmEH+ZLIUFG0B2e4C+3p28fkRswuxC
         hFXweOu/200WMxTdg7r9jyhUcvqhegxsjllPJTsf9QRFCspOmTW4FmlmbibPyeQkxmm0
         eTduKaFz+s5eAm4qAnHn5719bNNg6/TZ7O3TMvWSTpqPFuHHbDX0UTpRpz8DWGQYjFaf
         L6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wKhee+wwyY8wAQtAwhfFGxIYlymbanXy7c8d3WGe9uw=;
        b=lmQvJuwOmNQbfux2mf7p3/bhN1Khub7geGJZH5Rla5lsBfE13gUjZPpFWet7paR1KB
         jBhJ9mG+sALz7gA9G7G3EnXA1Yrv33a9wQWI2IhO8jl3RFIY1/XKp53AbV3lo4HNlIPw
         t2gPKPS63rrvf8vm8Matuj28+BusHWk1wGflLfiA5So3i02uN3JuHo1ZQa+Tjij1MrE3
         7FnfTpxjX3Tgd+fIEGakqEFzFM7i/DNLM8sLcSynC6vz8x2h5FGYPN7dwKTYdcjE29eh
         b6JqOpIA2kkwCjXgEf/fKeorYSPCqY5ReY2Z/82tryce9pI9ijMUNtIHL9rPAJvxTE45
         +/8g==
X-Gm-Message-State: AOAM531+1ZQHNLjwznJV3p+B5zAyH9pDnU6R/bmcJAvSlLMg56J4nZ5H
        7wf16/9h+8yEmNn4/HaPGHJ0Ww==
X-Google-Smtp-Source: ABdhPJwJdZL4xF23yJV09qXQ0a4Ybxm3pNDa6pceKSCI9bofx7wUXwpD/kCLchRD1oPm3hWZue3Zhg==
X-Received: by 2002:a37:dc41:: with SMTP id v62mr3158437qki.457.1614356503934;
        Fri, 26 Feb 2021 08:21:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id x3sm6801311qkd.94.2021.02.26.08.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 08:21:43 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lFfs7-000yvy-1U; Fri, 26 Feb 2021 12:21:43 -0400
Date:   Fri, 26 Feb 2021 12:21:43 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Freeing page tables through RCU
Message-ID: <20210226162143.GW2643399@ziepe.ca>
References: <20210225205820.GC2858050@casper.infradead.org>
 <20210226144200.GV2643399@ziepe.ca>
 <20210226160354.GE2723601@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226160354.GE2723601@casper.infradead.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Feb 26, 2021 at 04:03:54PM +0000, Matthew Wilcox wrote:
> On Fri, Feb 26, 2021 at 10:42:00AM -0400, Jason Gunthorpe wrote:
> > On Thu, Feb 25, 2021 at 08:58:20PM +0000, Matthew Wilcox wrote:
> > 
> > > I'd like to hear better ideas than this.
> > 
> > You didn't like my suggestion to put a sleepable lock around the
> > freeing of page tables during flushing?
> > 
> > I still don't see how you convert the sleepable page walkers to use
> > rcu??
> 
> I don't want to convert the sleepable ones to use RCU ... I want to
> convert the non-sleeping ones to use RCU.  

Why? Convert them to use the normal page table spinlocks?

It makes everything much more understandable if it is locked properly.

The lockless walks should be reserved for special places because they
are actually hard to do properly.

> A page_table_free_lock might work, but it might have its own
> problems later (eg a sleeping lock can't be acquired under RCU or
> spinlock, and it can't be a spinlock because it'd have to be held
> while we wait for IPIs).

The mmap_sem today is serving the function of the page_table_free_lock
idea, so I think a sleepable lock is already proven to work?

Jason
