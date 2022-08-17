Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB38C25B08
	for <linux-s390@archiver.kernel.org>; Wed, 17 Aug 2022 18:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbiHQSkH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 Aug 2022 14:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbiHQSkG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 17 Aug 2022 14:40:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218069F1B1
        for <linux-s390@vger.kernel.org>; Wed, 17 Aug 2022 11:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660761604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vFVqNNb0hcNnzpCN6Usam55O8PiDZUdmPvKKh6BjScw=;
        b=GzK3d4jVswbxB9rEoLlpdZYbzmv5TIunlnFmPSWNwt+MIGjKX2FSk+mOBQAPwi05UPw4vG
        NatA9xPUj0TaiqZl/Zfg43vAHguo29q2YlWhOWK5J3Lurfw8NCUch7td6FY61vf4KD6dGZ
        2q3/s7nXlI9NUx4mt3u/Wr2sYDwRhgk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-122-vjQuGo5RPuqkhG-b6MNuNg-1; Wed, 17 Aug 2022 14:40:02 -0400
X-MC-Unique: vjQuGo5RPuqkhG-b6MNuNg-1
Received: by mail-qv1-f70.google.com with SMTP id o6-20020ad443c6000000b00495d04028a6so2742855qvs.18
        for <linux-s390@vger.kernel.org>; Wed, 17 Aug 2022 11:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=vFVqNNb0hcNnzpCN6Usam55O8PiDZUdmPvKKh6BjScw=;
        b=hBO2h9cDRFzOyTdeZXCUiqmUBMadNuh1DHGK0fPE2R7lguA8Fnhr3TcOXfoCkR8Csk
         UToPJ3d9gJ+pGp+PcodWzufKkL37WPRXXvewt/tWFA7i1Dw+lJ7nkdRaqQsoHBo9vaUj
         cNSyE8EbSKi8yGyi/DqEmA49ZOymlW0/D0LwGd2zw9IdTPuPxdEVDyn6juRtGwzBF5xr
         sg1HYbd1hRFVHn0qoQfqiHyaZxi42m3oUxvcO40ZWYrn+JrtEgUXKUJ/NUNzcRKCpXey
         KJSEZMplb+oaEDboJuAeW6sF1E5xX3zCqHjlE4z2QbtfP69f6nZGJUxVy2q6KKBKcG/8
         +7fg==
X-Gm-Message-State: ACgBeo1p9E0IUhyPV8+Tr/8iQz/onb24dhlG2iuTRiKSSpi3S9xY0roi
        /lUm/63qdGArElx2407w3vGj9tzZBIgB/NGmYxtRo4EcuTMntn+DsjRfCka4KSuoP9tWbCeGpXh
        +1d01QMsOYmD1Q9p/lAhmUw==
X-Received: by 2002:a05:620a:244d:b0:6b2:538f:ffda with SMTP id h13-20020a05620a244d00b006b2538fffdamr19403186qkn.218.1660761601568;
        Wed, 17 Aug 2022 11:40:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7QZCIq/LkhZu/7gJ28ZdNfz4GfEx4k6PFRys0DC5W3FPAtzpSOPoW806jLp7Gro+1d2zowoA==
X-Received: by 2002:a05:620a:244d:b0:6b2:538f:ffda with SMTP id h13-20020a05620a244d00b006b2538fffdamr19403167qkn.218.1660761601238;
        Wed, 17 Aug 2022 11:40:01 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id c3-20020a05620a268300b006b58d8f6181sm15028256qkp.72.2022.08.17.11.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 11:40:00 -0700 (PDT)
Date:   Wed, 17 Aug 2022 14:39:58 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH] s390: fix double free of GS and RI CBs on fork() failure
Message-ID: <Yv01/i4KFdgmCpsD@bfoster>
References: <20220816155407.537372-1-bfoster@redhat.com>
 <20220817130906.0ce40da1@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817130906.0ce40da1@thinkpad>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Aug 17, 2022 at 01:09:06PM +0200, Gerald Schaefer wrote:
> On Tue, 16 Aug 2022 11:54:07 -0400
> Brian Foster <bfoster@redhat.com> wrote:
> 
> > The pointers for guarded storage and runtime instrumentation control
> > blocks are stored in the thread_struct of the associated task. These
> > pointers are initially copied on fork() via arch_dup_task_struct()
> > and then cleared via copy_thread() before fork() returns. If fork()
> > happens to fail after the initial task dup and before copy_thread(),
> > the newly allocated task and associated thread_struct memory are
> > freed via free_task() -> arch_release_task_struct(). This results in
> > a double free of the guarded storage and runtime info structs
> > because the fields in the failed task still refer to memory
> > associated with the source task.
> > 
> > This problem can manifest as a BUG_ON() in set_freepointer() (with
> > CONFIG_SLAB_FREELIST_HARDENED enabled) or KASAN splat (if enabled)
> > when running trinity syscall fuzz tests on s390x. To avoid this
> > problem, clear the associated pointer fields in
> > arch_dup_task_struct() immediately after the new task is copied.
> > Note that the RI flag is still cleared in copy_thread() because it
> > resides in thread stack memory and that is where stack info is
> > copied.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> > 
> > Hi all,
> > 
> > Note that I'm not subscribed to the list so please CC on reply. Further,
> > I'm not terribly familiar with these associated features and so have not
> > run any kind of functional testing here. My testing was purely around
> > producing/preventing the double free issue. Any thoughts, reviews or
> > further testing is appreciated. Thanks.
> > 
> > Brian
> > 
> >  arch/s390/kernel/process.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
> > index 89949b9f3cf8..d5119e039d85 100644
> > --- a/arch/s390/kernel/process.c
> > +++ b/arch/s390/kernel/process.c
> > @@ -91,6 +91,18 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
> >  
> >  	memcpy(dst, src, arch_task_struct_size);
> >  	dst->thread.fpu.regs = dst->thread.fpu.fprs;
> > +
> > +	/*
> > +	 * Don't transfer over the runtime instrumentation or the guarded
> > +	 * storage control block pointers. These fields are cleared here instead
> > +	 * of in copy_thread() to avoid premature freeing of associated memory
> > +	 * on fork() failure. Wait to clear the RI flag because ->stack still
> > +	 * refers to the source thread.
> > +	 */
> > +	dst->thread.ri_cb = NULL;
> > +	dst->thread.gs_cb = NULL;
> > +	dst->thread.gs_bc_cb = NULL;
> > +
> >  	return 0;
> >  }
> >  
> > @@ -150,13 +162,11 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
> >  	frame->childregs.flags = 0;
> >  	if (new_stackp)
> >  		frame->childregs.gprs[15] = new_stackp;
> > -
> > -	/* Don't copy runtime instrumentation info */
> > -	p->thread.ri_cb = NULL;
> > +	/*
> > +	 * Clear the runtime instrumentation flag after the above childregs
> > +	 * copy. The CB pointer was already cleared in arch_dup_task_struct().
> > +	 */
> >  	frame->childregs.psw.mask &= ~PSW_MASK_RI;
> > -	/* Don't copy guarded storage control block */
> > -	p->thread.gs_cb = NULL;
> > -	p->thread.gs_bc_cb = NULL;
> >  
> >  	/* Set a new TLS ?  */
> >  	if (clone_flags & CLONE_SETTLS) {
> 
> Thanks Brian, nice catch! Looks good to me. For completeness, we should
> add stable / Fixes tags, like this:
> 
> Fixes: 8d9047f8b967c ("s390/runtime instrumentation: simplify task exit handling")
> Fixes: 7b83c6297d2fc ("s390/guarded storage: simplify task exit handling")
> Cc: <stable@vger.kernel.org> # 4.15
> 
> Not 100% sure about the Fixes tags, Heiko should also have a look when
> he returns next week.
> 
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> 

Hi Gerald,

Sounds good, thanks for the review. I'll wait a bit so Heiko has a
chance to take a look and then follow up with the tag updates and any
other necessary changes..

Brian

