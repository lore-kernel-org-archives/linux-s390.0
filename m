Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9536C432BE
	for <linux-s390@archiver.kernel.org>; Mon, 30 Aug 2021 21:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB08960E77
	for <linux-s390@archiver.kernel.org>; Mon, 30 Aug 2021 21:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhH3V37 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbhH3V36 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 Aug 2021 17:29:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E586C061575;
        Mon, 30 Aug 2021 14:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g2gXss1DJ1JAJXF0vbtWUIqxsGH+dUvV29MGmlrRUss=; b=HIgSQhBRENQDUeREEfmcXmB96a
        2Nb3sW6HgKHcvb3FTItmfTew+9SRZh7p8azReltCbDPqRMvT23E36oakL43buiTboqrMMDM5l0lLm
        Hdg29kQZGLVKMwvv4jolg19zQx0It9caZyBdhabBtTvXDvNFgMewo3YLRddUm+cB4OOt47JMAfOf4
        TFa4VFGXcZ1ZgrN6omDS47CvUYC+2wSY4wnGdvsJZFyHVmoOZYt/dwtgnG5U72ohBS9XTeRryGI2J
        CFMXz6CNF49EtL/oEHBNsgvlpZbLuKemV0MxWPCaXSGGcnkmosc5S+gdTBJ/pzVxXlBt6wTuYE0DJ
        C72O5J9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKops-00EVqS-0J; Mon, 30 Aug 2021 21:28:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7078300103;
        Mon, 30 Aug 2021 23:28:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC84A2D3EECF8; Mon, 30 Aug 2021 23:28:54 +0200 (CEST)
Date:   Mon, 30 Aug 2021 23:28:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: Linux 5.14
Message-ID: <YS1NltjDz/Xo8nHt@hirez.programming.kicks-ass.net>
References: <CAHk-=wh75ELUu99yPkPNt+R166CK=-M4eoV+F62tW3TVgB7=4g@mail.gmail.com>
 <20210830201225.GA2671970@roeck-us.net>
 <CAHk-=wi2-1PyGj94cb+jYWb4vCcJ3JG6s6Li7c12dPOhdTs1RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi2-1PyGj94cb+jYWb4vCcJ3JG6s6Li7c12dPOhdTs1RA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Aug 30, 2021 at 01:15:37PM -0700, Linus Torvalds wrote:
> On Mon, Aug 30, 2021 at 1:12 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > So far so good, but there is a brand new runtime warning, seen when booting
> > s390 images.
> >
> > [    3.218816] ------------[ cut here ]------------
> > [    3.219010] WARNING: CPU: 1 PID: 0 at kernel/sched/core.c:5779 sched_core_cpu_starting+0x172/0x180
> > [    3.222845] Call Trace:
> > [    3.222992]  [<0000000000186e86>] sched_core_cpu_starting+0x176/0x180
> > [    3.223114] ([<0000000000186dc4>] sched_core_cpu_starting+0xb4/0x180)
> > [    3.223182]  [<00000000001963e4>] sched_cpu_starting+0x2c/0x68
> > [    3.223243]  [<000000000014f288>] cpuhp_invoke_callback+0x318/0x970
> > [    3.223304]  [<000000000014f970>] cpuhp_invoke_callback_range+0x90/0x108
> > [    3.223364]  [<000000000015123c>] notify_cpu_starting+0x84/0xa8
> > [    3.223426]  [<0000000000117bca>] smp_init_secondary+0x72/0xf0
> > [    3.223492]  [<0000000000117846>] smp_start_secondary+0x86/0x90
> >
> > Commit 3c474b3239f12 ("sched: Fix Core-wide rq->lock for uninitialized
> > CPUs") seems to be the culprit. Indeed, the warning is gone after reverting
> > this commit.
> 
> Ouch, not great timing.
> 
> Adding the s390 people to the cc too, just to make sure everybody
> involved is aware.

'Funny' thing, Sven actually tested that on s390. I had already comitted
the patch which is why his tag isn't on the commit:

  https://lkml.kernel.org/r/yt9dy28o8q0o.fsf@linux.ibm.com

Anyway, looks like Thomas found something fishy in their topology code.
Lemme go catch up.
