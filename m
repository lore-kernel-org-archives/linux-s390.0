Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99839C433ED
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 18:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B744608FE
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 18:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhECScf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 3 May 2021 14:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhECScf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 May 2021 14:32:35 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5287DC06174A
        for <linux-s390@vger.kernel.org>; Mon,  3 May 2021 11:31:42 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id h7so3320781plt.1
        for <linux-s390@vger.kernel.org>; Mon, 03 May 2021 11:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0/hWcwo9TS13pUp1+O10yqL/kJKQwaLNvFMdvfj5k14=;
        b=h6p86q5cPgC2FXATOaK+r3McZi4uNjqo9Ys2Y7TNLnK/uHY6mua3MJCdBi3u4z8Nq0
         mtDHv4RHwatiLLwrYcqanbyWDiZwLjtuLNO2cWTMspGtThR4CFqRQjeiYyKi1o5p2fmd
         txC8MACd9vnEZOlqtTmaj0PBLMlkF0hBBOy6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0/hWcwo9TS13pUp1+O10yqL/kJKQwaLNvFMdvfj5k14=;
        b=hT3UDLqzv4U2d8EI8mwbJngrWdwJCu+1nyQdgR53/fpd8Q3Yg+gxnvZOITmuJrmPZu
         50NFIQhTJKHDsvbqXbrxXh50ExyCeO045A+0bwKX0/ZNhIfj3NNEX3Qcim2URZwtr7GD
         MW6Dq6o97hiD0HlKRpahjt5ddj2zv3nXs7W9ZhdCrdZuiJfTeHjQJiROoDCd7TDs6Jjp
         5wlNjDYHlBkfVae2Ryf5adIoXD+ivEZlQ6FIwt/L2JbFooQctHkzJ9W3BLUQm0o+/NH0
         aGjEzcHZnhN9LAautvioQ6WNaLFt5tf3bXTUJfKNvKQGq/bU/cT+PLtfI3pheEe2fTR9
         el9Q==
X-Gm-Message-State: AOAM532G+nqpkzgnPH2teIahZJmwKs1gg6wR4G8oMFMOMqxkCJfMtgHl
        sauGb02v4DMmomD5Sq6asaC36g==
X-Google-Smtp-Source: ABdhPJzI51g7uKSjmebEIJLdWALfiSVATzyupi6IGhNvNGsd98k+oWQth5iTpFdl+c2Gm1MCb+9cPg==
X-Received: by 2002:a17:903:4091:b029:ec:fbd2:3192 with SMTP id z17-20020a1709034091b02900ecfbd23192mr21455699plc.21.1620066701913;
        Mon, 03 May 2021 11:31:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lb2sm135899pjb.53.2021.05.03.11.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 11:31:41 -0700 (PDT)
Date:   Mon, 3 May 2021 11:31:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/entry: add support for syscall stack randomization
Message-ID: <202105031131.864506CE31@keescook>
References: <20210429091451.1062594-1-svens@linux.ibm.com>
 <202104301007.5D0C6F9386@keescook>
 <yt9deeeojpce.fsf@linux.ibm.com>
 <yt9dk0ogi3j6.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dk0ogi3j6.fsf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, May 03, 2021 at 11:13:01AM +0200, Sven Schnelle wrote:
> Hi Kees,
> 
> Sven Schnelle <svens@linux.ibm.com> writes:
> 
> > Kees Cook <keescook@chromium.org> writes:
> >
> >> On Thu, Apr 29, 2021 at 11:14:51AM +0200, Sven Schnelle wrote:
> >>> enough and has much less performance penalty compared to using
> >>> get_random_int(). The patch also adds randomization in pgm_check_handler()
> >>> as the sigreturn/rt_sigreturn system calls might be called from there.
> >>
> >> Ah, interesting. Is this path to syscalls unique to s390? (As in, should
> >> x86 and arm64 gain coverage over a path that got missed?)
> >
> > Yes, it's unique to s390. So there should be no need to do anything
> > similar on other architectures.
> 
> I was a bit short with my reponse, so let me explain this a bit
> further. On s390, when a signal handler needs to be called, we put a
> 'svc (system call) instruction on the Stack and set the address in the
> register holding the return address (r14) to that address. That worked
> fine until non-executable stacks where introduced. With non-executable
> stacks, we get a program check instead when trying to execute the svc.
> The kernel than checks whether the instruction that caused the fault
> is the svc instruction, and if yes, it will redirect to the systemm call
> code to execute the {rt_}sigreturn syscall. So we need to do the stack
> offset randomization also in the program check handler to cover that path.

Ah-ha; thanks for the details! I appreciate it. :)

> >>> +static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
> >>> +						  unsigned long ti_work)
> >>> +{
> >>> +	choose_random_kstack_offset(get_tod_clock_fast() & 0xff);
> >>
> >> What's the stack alignment on s390? Or, better question, what's the
> >> expected number of entropy bits?
> >
> >
> > The stack alignement on s390 is 8 bytes, so this should give us 5 bits
> > of entropy.

Sounds good!

-- 
Kees Cook
