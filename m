Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62281C64ED6
	for <linux-s390@archiver.kernel.org>; Wed,  1 Mar 2023 17:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjCAREF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 1 Mar 2023 12:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCAREE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Mar 2023 12:04:04 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4390E4EFD
        for <linux-s390@vger.kernel.org>; Wed,  1 Mar 2023 09:03:26 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso7722166wmq.1
        for <linux-s390@vger.kernel.org>; Wed, 01 Mar 2023 09:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qUHKTRcQh3URDtHGlGaA089RX+46wq6JZY7f9xT1DBI=;
        b=2O6UAvj6zfjZ/qTx+DC1jnzc4oofYRirSDiuT9o8rhJ/6BEiPA4+rcBx4atFEYGEIo
         QVdj2yopC3IIfoL06yzTsC3ziAmJYMHVp28B/iZfCAryxbSMgsa3kgv/phahYvjdTBzb
         Z/2osNzuFnLNlGTIvz/JMmEPzwLmZAOY13uQsvapEDGujowt6lWX6AE8hfelFeGUxisa
         CJNyd0S6acdvftMLIIDqsimJ3mYWYm9fdb/HVEiQhLot1fGCgY3NO75b80K0cta4Mx61
         J5BxMt3zLEk/F+OPrB+G6242679o0jxvLR4EnQao/I7ez0xvSyFY5dK4MelBSfYqGIyZ
         x/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUHKTRcQh3URDtHGlGaA089RX+46wq6JZY7f9xT1DBI=;
        b=qePwOfHRevl7oyrn2PnJY4kM8RFRNx2WUZ7rqtKOBMmAcVIpUxU51uLBKT/EWmQ63l
         9QO1Tn3BAL4FlKDElHcqIR7Stm3rgkbOEFJaQeNvKF7Y9otQqt4iofmYtZBCxR5gWZNc
         JGtRr+q6hd1HrWif5k3DqcOIITy/GvAA92lc37vHfrmGWl+bBl9ueHky7IcEe4oMlSg3
         l1QI8tuyudFoVSF9Kuu9Uzco26Ragip8NMVWMPnLnmfr5LgRnybkBylPdbHSJGFHE8uX
         Rpt5jU1wmxVS+PZuKtlaYZwbr7lJjhWiZ1vSjJ9JfAhhaC/SgbiWzcsJKn0Qmg+L/Td7
         pUZQ==
X-Gm-Message-State: AO0yUKXRpwzUjGDVgQQS0arlrA0sIcv20jEqZhoZAoWwswP6bqRQVZOz
        ZlZ7PYEtwWneNxQEI2wuGG7QUQ==
X-Google-Smtp-Source: AK7set8vQqf910uXvU8gXb+dtW0FrWBh+y0eZXgna9uwh5OHAKzuXs0cw2hHMMTvzp4hl3cfxLpuSQ==
X-Received: by 2002:a05:600c:3093:b0:3eb:3104:efef with SMTP id g19-20020a05600c309300b003eb3104efefmr5425757wmn.31.1677690204651;
        Wed, 01 Mar 2023 09:03:24 -0800 (PST)
Received: from airbuntu (host86-168-251-3.range86-168.btcentralplus.com. [86.168.251.3])
        by smtp.gmail.com with ESMTPSA id z26-20020a1c4c1a000000b003eb395a8280sm107158wmf.37.2023.03.01.09.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 09:03:24 -0800 (PST)
Date:   Wed, 1 Mar 2023 17:03:22 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Juri Lelli <juri.lelli@redhat.com>
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
Message-ID: <20230301170322.xthlso7jfkixlyex@airbuntu>
References: <20230206221428.2125324-1-qyousef@layalina.io>
 <20230223153859.37tqoqk33oc6tv7o@airbuntu>
 <5f087dd8-3e39-ce83-fe24-afa5179c05d9@arm.com>
 <20230227205725.dipvh3i7dvyrv4tv@airbuntu>
 <5a1e58bf-7eb2-bd7a-7e19-7864428a2b83@arm.com>
 <20230228174627.vja5aejq27dsta2u@airbuntu>
 <Y/7/SLzvK8LfB29z@localhost.localdomain>
 <20230301122852.zgzreby42lh2zf6w@airbuntu>
 <Y/9gmDRlGOChIwpf@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/9gmDRlGOChIwpf@localhost.localdomain>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 03/01/23 15:26, Juri Lelli wrote:
> On 01/03/23 12:28, Qais Yousef wrote:
> > On 03/01/23 08:31, Juri Lelli wrote:
> 
> ...
> 
> > > Not ignoring you guys here, but it turns out I'm quite bogged down with
> > > other stuff at the moment. :/ So, apologies and I'll try to get to this
> > > asap. Thanks a lot for all your efforts and time reviewing so far!
> > 
> > Np, I can feel you :-)
> 
> Eh. :/

I hope I did not offend. That was meant as no pressure, I understand.

> 
> BTW, do you have a repro script of some sort handy I might play with?

Sorry no. You'll just need to suspend to ram. I had a simple patch to measure
the time around the call and trace_printk'ed the result.

I was working on a android phone which just suspends to ram if you turn the
screen off and disconnect the usb.

I think you can use rtcwake in normal desktop environment. Something like

	sudo rtcwake -u -s 5 -m mem


Thanks!

--
Qais Yousef
