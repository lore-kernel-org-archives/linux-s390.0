Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C69C433FE
	for <linux-s390@archiver.kernel.org>; Sat,  4 Sep 2021 14:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD1B960FA0
	for <linux-s390@archiver.kernel.org>; Sat,  4 Sep 2021 14:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbhIDOlM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 4 Sep 2021 10:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbhIDOlM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 4 Sep 2021 10:41:12 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA1BC0613CF
        for <linux-s390@vger.kernel.org>; Sat,  4 Sep 2021 07:40:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id d3-20020a17090ae28300b0019629c96f25so1570269pjz.2
        for <linux-s390@vger.kernel.org>; Sat, 04 Sep 2021 07:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rT9D3cD6AK/U9ynMxv4dnPjLHMnSzhI3eW+DvMhMYv4=;
        b=bA7994xBs5m1ZQvCLablElQZ97mYGS2txQ6t1KugHdJ9bOTKQn/g1ykQb6kf+VW1kj
         x53d9bgkmnic8+HM/3c01odPUM/1NaKqTuMfBesS5QBLCQov39J4DsNKc4fDhIo5uKGu
         QmkVEDxUwaKxGfTW9JqRWsG1vFwPPcYyrSs1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rT9D3cD6AK/U9ynMxv4dnPjLHMnSzhI3eW+DvMhMYv4=;
        b=oFIJA8zwC41oFqFU0cg4bEXzWeFoKx5R5uCOTdKr6JNpry5HtXPk/oLZ6+A2BPGmEP
         wniwlrcEvTLZOFjl0so/vKJL1VwLocmOAgefaOqZGy75ZBYVv2yOijTF5XAhrdEOVVGz
         zKShWKXEOlmwHGxGCkFsIRkuU2FLP2AHXru7BJhYoHqpNfN1SVWVasI+7xHlX9A2pWLl
         hPz/c0K4a6B7zRTw5jZas5k361YMTNRxEigBqb5/muEjGPTTSKAhnxJ7d2ad5Du+k4q2
         o4oTb0m5JX5A7klbwUW7DCQsNVmNz8TlVRkzqMVqYrDEM/WBpE0jHVtaEfjxL1CKc+/0
         smYA==
X-Gm-Message-State: AOAM530ugH/ecgNJjajjhzBUFUb8LsdYbwM+sTnuuc2PfJQyZcsbEjH4
        ZBG/0VfuVFd10MR+JU2scXpnOeVk+IEjGg==
X-Google-Smtp-Source: ABdhPJzl0DwgZA0hvjnFBnC+PnasBoLTB/Zs++xSopyABJPyxYKDWg4SZhDJeJK8DjDAcojzCdCxpQ==
X-Received: by 2002:a17:902:a50f:b029:11a:b033:e158 with SMTP id s15-20020a170902a50fb029011ab033e158mr3561213plq.26.1630766410054;
        Sat, 04 Sep 2021 07:40:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u6sm2949081pgr.3.2021.09.04.07.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 07:40:09 -0700 (PDT)
Date:   Sat, 4 Sep 2021 07:40:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 3/4] module: Use a list of strings for ro_after_init
 sections
Message-ID: <202109040739.F973371BD@keescook>
References: <20210901233757.2571878-1-keescook@chromium.org>
 <20210901233757.2571878-4-keescook@chromium.org>
 <20210903064951.to4dhiu7zua7s6dn@treble>
 <202109030932.1358C4093@keescook>
 <20210904040903.tgkkoo2x76zpuj62@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210904040903.tgkkoo2x76zpuj62@treble>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Sep 03, 2021 at 09:09:03PM -0700, Josh Poimboeuf wrote:
> On Fri, Sep 03, 2021 at 09:38:42AM -0700, Kees Cook wrote:
> > On Thu, Sep 02, 2021 at 11:49:51PM -0700, Josh Poimboeuf wrote:
> > > On Wed, Sep 01, 2021 at 04:37:56PM -0700, Kees Cook wrote:
> > > > Instead of open-coding the section names, use a list for the sections that
> > > > need to be marked read-only after init. Unfortunately, it seems we can't
> > > > do normal section merging with scripts/module.lds.S as ld.bfd doesn't
> > > > correctly update symbol tables. For more details, see commit 6a3193cdd5e5
> > > > ("kbuild: lto: Merge module sections if and only if CONFIG_LTO_CLANG
> > > > is enabled").
> > > 
> > > I'm missing what this has to do with section merging.  Can you connect
> > > the dots here, i.e. what sections would we want to merge and how would
> > > that help here?
> > 
> > Right, sorry, if ld.bfd didn't have this issue, we could use section
> > merging in the module.lds.S file the way we do in vmlinux.lds:
> > 
> > #ifndef RO_AFTER_INIT_DATA
> > #define RO_AFTER_INIT_DATA                                              \
> >         . = ALIGN(8);                                                   \
> >         __start_ro_after_init = .;                                      \
> >         *(.data..ro_after_init)                                         \
> >         JUMP_TABLE_DATA                                                 \
> >         STATIC_CALL_DATA                                                \
> >         __end_ro_after_init = .;
> > #endif
> > ...
> >         . = ALIGN((align));                                             \
> >         .rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {           \
> >                 __start_rodata = .;                                     \
> >                 *(.rodata) *(.rodata.*)                                 \
> >                 SCHED_DATA                                              \
> >                 RO_AFTER_INIT_DATA      /* Read only after init */      \
> >                 . = ALIGN(8);                                           \
> >                 __start___tracepoints_ptrs = .;                         \
> >                 KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
> >                 __stop___tracepoints_ptrs = .;                          \
> >                 *(__tracepoints_strings)/* Tracepoints: strings */      \
> >         }                                                               \
> > 
> > Then jump_table and static_call sections could be collected into a
> > new section, as the module loader would only need to look for that
> > single name.
> 
> Hm, that could be a really nice way to converge things for vmlinux and
> module linking.

Agreed! I had really wanted to do more of this, but was stumped by the
weird symbol behavior.

> After some digging, 6a3193cdd5e5 isn't necessarily a linker bug.  It may
> be some kind of undefined behavior when the section address isn't
> specified.  If you just explicitly set the section address to zero then
> the "bug" goes away.

Well that's a nice find! I'll play more with this to see if I can make a
cleaner solution.

Thanks!

-Kees

> 
> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> index 04c5685c25cf..80b09b7d405c 100644
> --- a/scripts/module.lds.S
> +++ b/scripts/module.lds.S
> @@ -30,23 +30,22 @@ SECTIONS {
>  
>  	__patchable_function_entries : { *(__patchable_function_entries) }
>  
> -#ifdef CONFIG_LTO_CLANG
>  	/*
>  	 * With CONFIG_LTO_CLANG, LLD always enables -fdata-sections and
>  	 * -ffunction-sections, which increases the size of the final module.
>  	 * Merge the split sections in the final binary.
>  	 */
> -	.bss : {
> +	.bss 0 : {
>  		*(.bss .bss.[0-9a-zA-Z_]*)
>  		*(.bss..L*)
>  	}
>  
> -	.data : {
> +	.data 0 : {
>  		*(.data .data.[0-9a-zA-Z_]*)
>  		*(.data..L*)
>  	}
>  
> -	.rodata : {
> +	.rodata 0 : {
>  		*(.rodata .rodata.[0-9a-zA-Z_]*)
>  		*(.rodata..L*)
>  	}
> @@ -55,11 +54,10 @@ SECTIONS {
>  	 * With CONFIG_CFI_CLANG, we assume __cfi_check is at the beginning
>  	 * of the .text section, and is aligned to PAGE_SIZE.
>  	 */
> -	.text : ALIGN_CFI {
> +	.text 0 : ALIGN_CFI {
>  		*(.text.__cfi_check)
>  		*(.text .text.[0-9a-zA-Z_]* .text..L.cfi*)
>  	}
> -#endif
>  }
>  
>  /* bring in arch-specific sections */
> 

-- 
Kees Cook
