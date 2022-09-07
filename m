Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD48C54EE9
	for <linux-s390@archiver.kernel.org>; Wed,  7 Sep 2022 23:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiIGXrj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 7 Sep 2022 19:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiIGXri (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Sep 2022 19:47:38 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1161BB99FD
        for <linux-s390@vger.kernel.org>; Wed,  7 Sep 2022 16:47:36 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d12so16125349plr.6
        for <linux-s390@vger.kernel.org>; Wed, 07 Sep 2022 16:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=QA7YsklnD2cfDCjZnRS3vgbzndyD3I08QYNTHl1zCqo=;
        b=ZLBdFbRl5paMgO0B2nkuSUB92aTwmtmqanZFesgw5UFus70dkXrDyjCNdhChN3pJI2
         t8e2tFazYgcQ2/I+HCWkNpNnhTL+sGFQ2IQmiy8gFk422S7/bBjOweZRLDXszByhh4xi
         VaMpTtbZBDMm4nqrs2mAgMKZ9VkS11Y3DZbhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=QA7YsklnD2cfDCjZnRS3vgbzndyD3I08QYNTHl1zCqo=;
        b=cc8jrH8JQ7VydMwAwEhLp6f+2k7GAPSKNMMXzxsIZ9gAFwrLFtmW4vE2FwWIWzF3TJ
         boOScDCVu8bKcTmZ0drKI1bp7yV3YBMTlnfPN1K4t2FnAV8UHFt6EhkBAjJwGY+Gyj5S
         EHrGbMvixPtpn3pMIdUsIfbKZf7r/Bj8E4Wb3L+Z1/4L3mYtE6bboddanvIvzorSQK2O
         j/aEfwhE1i5M9Yg/BX1sK0NTbw9lUKrLC9x7gITFnnOnMltq2gHRZpywvAUzxugUF5Oe
         6omiCr722ugNdoZOqqrW92SHhERZh0LLAqwm93V/CEBGSwzTi3YHWHENyrfvYAfuxn3f
         n+Mw==
X-Gm-Message-State: ACgBeo3bPmWamPauvsFrHLWiLsdl6Zqrum27FFC+cja8PiM7v0ja2Akd
        2jgy7i0W52Rw/iNNFAagsIgUPQ==
X-Google-Smtp-Source: AA6agR6FxJPicYC0Cds/ZMsA1yhEHsGrUHcNbVNraLL0wYnkuXuYdtKZvewZkYvWfNoqDsOEyKfeIg==
X-Received: by 2002:a17:903:556:b0:176:84c9:df3 with SMTP id jo22-20020a170903055600b0017684c90df3mr6335255plb.98.1662594455557;
        Wed, 07 Sep 2022 16:47:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r28-20020aa79edc000000b0053e38ac0ff4sm4585765pfq.115.2022.09.07.16.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:47:34 -0700 (PDT)
Date:   Wed, 7 Sep 2022 16:47:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.0-rc4
Message-ID: <202209071646.A95761A@keescook>
References: <CAHk-=wiqix9N5P0BXrSSOXjPZxMh=wDDRJ3sgf=hutoTUx0nZQ@mail.gmail.com>
 <20220905071915.2312316-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2209050944290.964530@ramsan.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2209050944290.964530@ramsan.of.borg>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Sep 05, 2022 at 09:46:01AM +0200, Geert Uytterhoeven wrote:
> On Mon, 5 Sep 2022, Geert Uytterhoeven wrote:
> > JFYI, when comparing v6.0-rc4[1] to v6.0-rc3[3], the summaries are:
> >  - build errors: +3/-16
> 
>   + /kisskb/src/arch/sh/kernel/machvec.c: error: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Werror=array-bounds]:  => 105:33
> 
> sh4-gcc11/sh-allyesconfig (-Werror)

Sent a patch for this:
https://lore.kernel.org/linux-hardening/20220907234345.96798-1-keescook@chromium.org/

>   + /kisskb/src/include/linux/fortify-string.h: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]:  => 258:25
> 
> s390x-gcc11/s390-allyesconfig (inlined from 'copy_process' at /kisskb/src/kernel/fork.c:2200:2)

This error appears to have vanished?

> > [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b90cb1053190353cc30f0fef0ef1f378ccc063c5/ (all 135 configs)

Status	Date/time	Target
OK	Sep 7, 13:54	linus/s390-allyesconfig/s390x-gcc11

-- 
Kees Cook
