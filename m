Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6723CC678D5
	for <linux-s390@archiver.kernel.org>; Wed,  8 Mar 2023 10:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjCHKUI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 8 Mar 2023 05:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjCHKUE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Mar 2023 05:20:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979E4B4820
        for <linux-s390@vger.kernel.org>; Wed,  8 Mar 2023 02:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678270754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oj8X+oVpalTPTCAltQyKK/P/y4ZD06O85L5kpsJEEdg=;
        b=KywT+M53Y7Hxkgahi8VlEHIvh9MiJheCT1wqaplCWA+wRBbbNKLqkmNlRgouIullRKcpDP
        spWpCWJRVhTVXLEyBz+MCqCkdwbF4Yy+tjByILRBWFOjjpo7byUmQP7Xg1p89KpmBNZ8GS
        UW+j3jpH7LKJmqtMlPgMF1Z6JOMtQw0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-ATRJGoTWOleu_1qYpmapew-1; Wed, 08 Mar 2023 05:19:13 -0500
X-MC-Unique: ATRJGoTWOleu_1qYpmapew-1
Received: by mail-qt1-f199.google.com with SMTP id w16-20020ac843d0000000b003bfe50a4105so8836579qtn.10
        for <linux-s390@vger.kernel.org>; Wed, 08 Mar 2023 02:19:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678270753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oj8X+oVpalTPTCAltQyKK/P/y4ZD06O85L5kpsJEEdg=;
        b=u39R074ESgACoFDhTtrPUSg660JBVSHnPrNZrdZuFJoeeZ6tV0XT7UBjqfC5nxUmof
         5FCbfYc86rtZoAp+GqqmZrQJKuahyZ8qoBEXM1dCE4AATrjiTN23eeo+bjMBYYWzUe+p
         hgkGiFQPhgYr3CtFxK3RTXGrqbRmnNFSngSZDWXAgVEQ7ujDa9KqfIccr9gf43Weyk4m
         4gRH/0ZmoyeLxrLFFsT3vlOhJluJi1h+z0nlHK+NLquDKpqpeCLcg8+Cz8AgtoHqjOjD
         t2iSRis8t/N+0r4sMiYLAJGxFyERwMn8vB/AE/xDNLlp91XZEOi7HCK6wPLs/Dofhoc1
         HldQ==
X-Gm-Message-State: AO0yUKVlhmgHEApPkiqfqFdf4szs34N2LPWLFFygyvgOKTQda76gBVZB
        n+gOugmH35uF1Asn6u4Ah03LPuHFR68jaEQH6zsmdUQccTrHfzvcz44wkPImclUWJF6um+ttYJK
        f2AtePcDiev+o9lI+L0dp1w==
X-Received: by 2002:a05:622a:296:b0:3b8:2ce4:3e9 with SMTP id z22-20020a05622a029600b003b82ce403e9mr2589378qtw.32.1678270753274;
        Wed, 08 Mar 2023 02:19:13 -0800 (PST)
X-Google-Smtp-Source: AK7set/LL640GoLzKxvWa0khcVjeXxW1ACJtg1i5ABO802iOBx9DYnk4+UTJC6G6xesFIWMGPhLmHQ==
X-Received: by 2002:a05:622a:296:b0:3b8:2ce4:3e9 with SMTP id z22-20020a05622a029600b003b82ce403e9mr2589355qtw.32.1678270752972;
        Wed, 08 Mar 2023 02:19:12 -0800 (PST)
Received: from localhost.localdomain ([151.29.151.163])
        by smtp.gmail.com with ESMTPSA id d17-20020ac800d1000000b003b848759ed8sm11263243qtg.47.2023.03.08.02.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 02:19:12 -0800 (PST)
Date:   Wed, 8 Mar 2023 11:19:06 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Zefan Li <lizefan.x@bytedance.com>, linux-s390@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v3] sched: cpuset: Don't rebuild root domains on
 suspend-resume
Message-ID: <ZAhhGi55BkYkc3ss@localhost.localdomain>
References: <20230206221428.2125324-1-qyousef@layalina.io>
 <20230223153859.37tqoqk33oc6tv7o@airbuntu>
 <5f087dd8-3e39-ce83-fe24-afa5179c05d9@arm.com>
 <20230227205725.dipvh3i7dvyrv4tv@airbuntu>
 <5a1e58bf-7eb2-bd7a-7e19-7864428a2b83@arm.com>
 <20230228174627.vja5aejq27dsta2u@airbuntu>
 <Y/7/SLzvK8LfB29z@localhost.localdomain>
 <20230301122852.zgzreby42lh2zf6w@airbuntu>
 <Y/9gmDRlGOChIwpf@localhost.localdomain>
 <20230301170322.xthlso7jfkixlyex@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301170322.xthlso7jfkixlyex@airbuntu>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 01/03/23 17:03, Qais Yousef wrote:
> On 03/01/23 15:26, Juri Lelli wrote:
> > On 01/03/23 12:28, Qais Yousef wrote:
> > > On 03/01/23 08:31, Juri Lelli wrote:
> > 
> > ...
> > 
> > > > Not ignoring you guys here, but it turns out I'm quite bogged down with
> > > > other stuff at the moment. :/ So, apologies and I'll try to get to this
> > > > asap. Thanks a lot for all your efforts and time reviewing so far!
> > > 
> > > Np, I can feel you :-)
> > 
> > Eh. :/
> 
> I hope I did not offend. That was meant as no pressure, I understand.

No offence at all! I meant "we are all on the same boat it seems". :)

> > BTW, do you have a repro script of some sort handy I might play with?
> 
> Sorry no. You'll just need to suspend to ram. I had a simple patch to measure
> the time around the call and trace_printk'ed the result.
> 
> I was working on a android phone which just suspends to ram if you turn the
> screen off and disconnect the usb.

Looks like I could come up with the following

https://github.com/jlelli/linux.git deadline/rework-cpusets
https://github.com/jlelli/linux/tree/deadline/rework-cpusets

which I don't think it's at a point that I feel comfortable to propose
as an RFC (not even sure if it actually makes sense), but it survived my
very light testing.

Could you please take a look and, if it makes some sense in theory, give
it a try on your end?

Thanks!
Juri

