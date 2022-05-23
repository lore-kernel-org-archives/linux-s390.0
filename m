Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3C2C4332F
	for <linux-s390@archiver.kernel.org>; Mon, 23 May 2022 19:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiEWTnT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 23 May 2022 15:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbiEWTmU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 23 May 2022 15:42:20 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65F711C03
        for <linux-s390@vger.kernel.org>; Mon, 23 May 2022 12:39:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id b5so6949752plx.10
        for <linux-s390@vger.kernel.org>; Mon, 23 May 2022 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9i0mf5EWjId+dJhDG42zI0t8gO1U5xR/fPTtg8h/guQ=;
        b=G67mgEOcbKAzzfRqWT2tyqM6K9pitcq9pbTVcwT0LjmKZNi0oiqVsX8V97hEFwl2hf
         AMnpF3tfbp0thJvNCE4CX5dI4O8ELTGwmxs1K5fhCNP737yCqZGbfIr/xW9c33Xf+LOK
         scdJ+18kS7hWnfRSUS9ItgijmeteaopgZF3uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9i0mf5EWjId+dJhDG42zI0t8gO1U5xR/fPTtg8h/guQ=;
        b=Pcp01eSQBsYq+1shLT73U4iCm1SU2fMacoZkppaFoe2xDvqYrLb88pDqMrD8QrP7tW
         J8kz/5d5BHch6c1DAFAbX2COWW9a+GzeXC3X46v01Ud1RkxJNwRlYPXUG2iKXYbzMWUg
         66i+BzFocpbLDM2dNpjTguZRVyWIbW9c6mmiL8CV/GPYezyEM/qdYQdkgyvDG/f9eBD3
         NR0/aIB98beDJY6ADhtZG9jlMq0kNHML9e/wYa17T/tebMvmjJ1fdPQ/WKH5Sayk4sia
         8nNY1FM6Z5UYa1YmvCGBavnXN1jEp7SY9epmeMyvW1f7AXPjjdikISt+jlOl4Q3U2Ptq
         Q5pA==
X-Gm-Message-State: AOAM533rHEOpyDMQVpfnUYoUS883r+VqTwjaE6fR1VRavgz0W3ntiPux
        vxbrWhcYO/Skow1o4n4ew8H0eg==
X-Google-Smtp-Source: ABdhPJwpmlrfLvCqOEAWUHk/iFb9vTBCFvDV+XiSslGuIShWmQMdDaruCMB2aTz4o4uZEjpK38rAug==
X-Received: by 2002:a17:902:f605:b0:14d:9e11:c864 with SMTP id n5-20020a170902f60500b0014d9e11c864mr24236615plg.54.1653334755308;
        Mon, 23 May 2022 12:39:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a9-20020a62bd09000000b0051827128aeasm7543246pff.131.2022.05.23.12.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 12:39:14 -0700 (PDT)
Date:   Mon, 23 May 2022 12:39:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Maninder Singh <maninder1.s@samsung.com>, pmladek@suse.com,
        bcain@quicinc.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, satishkh@cisco.com, sebaddel@cisco.com,
        kartilak@cisco.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        mcgrof@kernel.org, jason.wessel@windriver.com,
        daniel.thompson@linaro.org, dianders@chromium.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, akpm@linux-foundation.org, arnd@arndb.de,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-modules@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, v.narang@samsung.com,
        onkarnath.1@samsung.com
Subject: Re: [PATCH 0/5] kallsyms: make kallsym APIs more safe with scnprintf
Message-ID: <202205231238.FAF6D28@keescook>
References: <CGME20220520083715epcas5p400b11adef4d540756c985feb20ba29bc@epcas5p4.samsung.com>
 <20220520083701.2610975-1-maninder1.s@samsung.com>
 <YonTOL4zC4CytVrn@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YonTOL4zC4CytVrn@infradead.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, May 21, 2022 at 11:07:52PM -0700, Christoph Hellwig wrote:
> On Fri, May 20, 2022 at 02:06:56PM +0530, Maninder Singh wrote:
> > kallsyms functionality depends on KSYM_NAME_LEN directly.
> > but if user passed array length lesser than it, sprintf
> > can cause issues of buffer overflow attack.
> > 
> > So changing *sprint* and *lookup* APIs in this patch set
> > to have buffer size as an argument and replacing sprintf with
> > scnprintf.
> 
> This is still a pretty horrible API.  Passing something like
> a struct seq_buf seems like the much better API here.  Also with
> the amount of arguments and by reference passing it might be worth
> to pass them as a structure while you're at it.

Yeah, I agree. It really seems like seq_buf would be nicer.

-- 
Kees Cook
