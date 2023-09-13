Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCC4EE0212
	for <linux-s390@archiver.kernel.org>; Wed, 13 Sep 2023 22:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjIMWHc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 13 Sep 2023 18:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjIMWHb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 13 Sep 2023 18:07:31 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C8519A0
        for <linux-s390@vger.kernel.org>; Wed, 13 Sep 2023 15:07:27 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bf7423ef3eso2234305ad.3
        for <linux-s390@vger.kernel.org>; Wed, 13 Sep 2023 15:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694642847; x=1695247647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxDfuaaCOGIkY/J7UCucAcZfBxGD0O7N2E+zpPv/A2A=;
        b=jOHPy3ruaBE5qFzc9ldCHn0VON770hgjGuV8uGeSixVmPSAAx6XwxyvPZ6c8qvm/li
         bsB48BIioFGP5F4W67eldUtaIPc/fYEZADn/8YFBtFgXdVm9AD1W0A7JzBf+choJwFzj
         w9/fi9bS8xWE9HoMFdwluFoKdGgTUC5vDOT8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694642847; x=1695247647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxDfuaaCOGIkY/J7UCucAcZfBxGD0O7N2E+zpPv/A2A=;
        b=gcLMBVz1ycZOAGNtzoZ9LmQ3CrrY7+oOadJsbpOsx/cZ1LU4bWpZ8IUVPzmTN4zCFb
         av4Hb/yx1u+Mk4yYNspmp4dOIoW5QnHk1yuaDpFE/EpUEJQ2z0mPrNqRzSffku8lFpHD
         K0JHYWRtHnTikFVSnxKCOGocPLVAId1GFwzD0BLljVBqxvfJMWzSwatglC4i1o4cYTTu
         sICywTPcdwiBsjXvjha9dM6UN1xUpNhOsfvdBQg1bDuQ/K94tmB9riiq3ZKsFn0EfTRB
         z5V30EPN7sQ4UKhShPpQkbJn0KVI0ewPFB7oihoTceKFFFue8gvvGR8pTDY8wH4pBFlD
         gBlg==
X-Gm-Message-State: AOJu0YyU4jExn0AAoOGyrZ7DDGo2i8SlHjcT4lg5oey2ZVk/WkOkzjcg
        TgodQ8dfHOTV/M/dtsruVP6ogg==
X-Google-Smtp-Source: AGHT+IHxaT5/+ccui2vnFiQVAeKtjd2URt+LuOsqD0F5iWtHIS5/zUtL5g0V6xehNx6RA+H3QM0vDQ==
X-Received: by 2002:a17:902:ecca:b0:1c4:62a:e4a with SMTP id a10-20020a170902ecca00b001c4062a0e4amr576300plh.64.1694642846953;
        Wed, 13 Sep 2023 15:07:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001bf095dfb76sm97776pld.237.2023.09.13.15.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 15:07:26 -0700 (PDT)
Date:   Wed, 13 Sep 2023 15:07:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 08/19] pstore: shrink the pstore_sb_lock critical section
 in pstore_kill_sb
Message-ID: <202309131507.E20F3AA130@keescook>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913111013.77623-9-hch@lst.de>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Sep 13, 2023 at 08:10:02AM -0300, Christoph Hellwig wrote:
> ->kill_sb can't race with creating ->fill_super because pstore is a
> _single file system that only ever has a single sb instance, and we wait
> for the previous one to go away before creating a new one.  Reduce
> the critical section so that is is not held over generic_shutdown_super.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for the refactoring!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
