Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB46C71134
	for <linux-s390@archiver.kernel.org>; Fri, 25 Aug 2023 18:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjHYSVE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 25 Aug 2023 14:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjHYSUg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 25 Aug 2023 14:20:36 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C3DE50
        for <linux-s390@vger.kernel.org>; Fri, 25 Aug 2023 11:20:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-26f3e26e59cso896772a91.0
        for <linux-s390@vger.kernel.org>; Fri, 25 Aug 2023 11:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692987633; x=1693592433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GYd1wVFPRI7NiM/Sx4/tad/ZtbY6g9sye8P5AXqu+fc=;
        b=E4mC5YAXMMgmUHgfRiWFcSZjAFYw1waD0EqZCNwtYhRSRtgJoFZVlCS3JG3wV7FXjd
         sXVU7RTKIYiV68OaJT+pNyPhtCG1CpcRdXA82AG5ofhhqR/vSGm3tvd1mpbR6M1weagG
         NwWQJu1Josu1pkUS1L/DPphW0b+C0Nzy+d45c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692987633; x=1693592433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYd1wVFPRI7NiM/Sx4/tad/ZtbY6g9sye8P5AXqu+fc=;
        b=Cso8UphB48mbIfj2vLB8QyevWxbhCaLs5Afgj/N1nF9U/6XHRTMv/IIiYb+rb3T6yl
         2/8Li8DTC8PF3DjbB9bGkxVmma2SBn7KMsVgiUvl5EW9RXISyfaPkSZw0surSByDRYGT
         TFixedYvjopjy8q5yqhKox24ds6xsAM+B56W3KNI9Pnsd61Zt6eFr1XhpLLblfA6UOkM
         YkKGhiGpgDxOYm3UoypyTy9ITfF6be+7GcxVXqG3aOPEA5W7S30ztLPrFx9aXlXFkfAg
         X1rh/DLQjldsMIM5aCteIA35gK0u7rJw/nkwTaCYooIEEMc5tR0eAj/Z791/p8dZjDKW
         +DSQ==
X-Gm-Message-State: AOJu0YxbRMI4MBqj3nltJ+ppuxjd0TeaP7vmA9EHshEyHX3WLXXkcQ1Y
        ty+hNheJ2VhOvkRHCJWzbVz9wQ==
X-Google-Smtp-Source: AGHT+IF6DSGG+sLTemEr6zFswCsdJsrOmZC3VrMrE6v1fI8J4N4rJsVzak2qfPMHQ2MCnkGlwtuaPA==
X-Received: by 2002:a17:90a:c08d:b0:267:f8f4:73ab with SMTP id o13-20020a17090ac08d00b00267f8f473abmr28444155pjs.16.1692987633516;
        Fri, 25 Aug 2023 11:20:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d12-20020a17090a628c00b0026b3f76a063sm1910536pjj.44.2023.08.25.11.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 11:20:32 -0700 (PDT)
Date:   Fri, 25 Aug 2023 11:20:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kbuild: Show Kconfig fragments in "help"
Message-ID: <202308251119.B93C95A3A7@keescook>
References: <20230824223606.never.762-kees@kernel.org>
 <21193a52-0425-f5ae-90f0-10e4c578ae90@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21193a52-0425-f5ae-90f0-10e4c578ae90@infradead.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Aug 24, 2023 at 05:04:02PM -0700, Randy Dunlap wrote:
> Hi Kees,
> 
> On 8/24/23 15:36, Kees Cook wrote:
> > Doing a "make help" would show only hard-coded Kconfig targets and
> > depended on the archhelp target to include ".config" targets. There was
> > nothing showing global kernel/configs/ targets. Solve this by walking
> > the wildcard list and include them in the output, using the first comment
> > line as the help text.
> > 
> > Update all Kconfig fragments to include help text and adjust archhelp
> > targets to avoid redundancy.
> > 
> > Adds the following section to "help" target output:
> > 
> > Configuration fragment targets (for enabling various Kconfig items):
> >   debug.config         - Debugging for CI systems and finding regressions
> >   kvm_guest.config     - Bootable as a KVM guest
> >   nopm.config          - Disable Power Management
> >   rust.config          - Enable Rust
> >   tiny-base.config     - Minimal options for tiny systems
> >   tiny.config          - Smallest possible kernel image
> >   x86_debug.config     - Debugging options for tip tree testing
> >   xen.config           - Bootable as a Xen guest
> >   tiny.config          - x86-specific options for a small kernel image
> >   xen.config           - x86-specific options for a Xen virtualization guest
> 
> ISTM that you are missing the "why" part of this change in the commit
> description.

I want to see what fragments are available without needing to know the
source tree layout for their locations. :)

> "make tinyconfig" is the real target here.  The other (tiny.) files are just
> implementation details.
> We can't put all implementation details into help messages and it's not
> difficult to find that the (tiny.) config files are merged to make the
> final .config file.

Yeah, this seems true for much of the ppc stuff to, as pointed out by
mpe. I'll go answer there...

-- 
Kees Cook
