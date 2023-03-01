Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A1AC6FA9D
	for <linux-s390@archiver.kernel.org>; Wed,  1 Mar 2023 14:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjCAO1k (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 1 Mar 2023 09:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjCAO1j (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Mar 2023 09:27:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43AC3CE24
        for <linux-s390@vger.kernel.org>; Wed,  1 Mar 2023 06:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677680804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dFfI+7W5JfA3qjbiFdEfsYsg+z7lgNEBSS9MtpBoNwc=;
        b=hBKp9PuuOofTVXuA+tLcO9i3AHLhhtk1uie9xLf/H/Qsjqlsm68c1ay10SBQvLP4S4zZn8
        e+TEsoclWl+v5L/2i2scGZM0qvgi++6Ft7AbXtpboyjb2phwIRHpP5YZQu4yEPPw+KsStQ
        YY8MJwTbqH2jY+VEaXCBVrDyyf7MwOw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-479--v6-BiM4PNKJsbERfkD1kg-1; Wed, 01 Mar 2023 09:26:41 -0500
X-MC-Unique: -v6-BiM4PNKJsbERfkD1kg-1
Received: by mail-qk1-f198.google.com with SMTP id d10-20020a05620a240a00b0073baf1de8ebso8102182qkn.19
        for <linux-s390@vger.kernel.org>; Wed, 01 Mar 2023 06:26:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFfI+7W5JfA3qjbiFdEfsYsg+z7lgNEBSS9MtpBoNwc=;
        b=EEcOccBsvj1QAaaciZlkUk8KuCriZuysJhRY6QGRhYIvWpO8A4ZjjIz7gH65j2y9Uw
         xdr8dhCuvxntoqZrorBWPqU59zUOYuFJhfb9KEIJdf1eomwdlxlE8i5ZLyfGMe57eD3B
         7LuIrIqE3uVHtMg2uf3D2e64cRMFg0Q3ZuXqWiAUtNtI6+0iajBG2VKGVsJiWLt22Tyl
         KZz5w7KwSuHOnKMmUTWKk8I1X28DBsxtWQ9l0q8soZJx5eKZ/FibxtZdTUK6Y15k+4mU
         n1kW6fF8L4XzaEbuyQTi2enDAxCi5EnD5LGunVxr4q+e4GfM1yeZcAxUTnvRgiO4R13+
         K4gA==
X-Gm-Message-State: AO0yUKWDH4D9qohfVaduhAYvBq+1/728uaK0jKwQiAKiscYn6WUXDQI0
        ENGkw6sJ1MPvC/VAROc/0fYsdY0efw9gn2vdc/oAQtHJRIOAWvDPcGPGz9W0vZl5kAdnSozqJEY
        0nWBsegyvXLfCdzZ2a7Vuww==
X-Received: by 2002:a05:622a:181c:b0:3bf:cfe8:f8f6 with SMTP id t28-20020a05622a181c00b003bfcfe8f8f6mr10180744qtc.68.1677680801302;
        Wed, 01 Mar 2023 06:26:41 -0800 (PST)
X-Google-Smtp-Source: AK7set/5VAZOkUbaqOOwIEqEvngFddl9X3uCbgwdB202WlT7tWrpgWISNHEX56CELo/zqgPKbTMuHQ==
X-Received: by 2002:a05:622a:181c:b0:3bf:cfe8:f8f6 with SMTP id t28-20020a05622a181c00b003bfcfe8f8f6mr10180697qtc.68.1677680800970;
        Wed, 01 Mar 2023 06:26:40 -0800 (PST)
Received: from localhost.localdomain ([151.29.151.163])
        by smtp.gmail.com with ESMTPSA id n3-20020ac86743000000b003bfbf3afe51sm8259781qtp.93.2023.03.01.06.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 06:26:40 -0800 (PST)
Date:   Wed, 1 Mar 2023 15:26:32 +0100
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
Message-ID: <Y/9gmDRlGOChIwpf@localhost.localdomain>
References: <20230206221428.2125324-1-qyousef@layalina.io>
 <20230223153859.37tqoqk33oc6tv7o@airbuntu>
 <5f087dd8-3e39-ce83-fe24-afa5179c05d9@arm.com>
 <20230227205725.dipvh3i7dvyrv4tv@airbuntu>
 <5a1e58bf-7eb2-bd7a-7e19-7864428a2b83@arm.com>
 <20230228174627.vja5aejq27dsta2u@airbuntu>
 <Y/7/SLzvK8LfB29z@localhost.localdomain>
 <20230301122852.zgzreby42lh2zf6w@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301122852.zgzreby42lh2zf6w@airbuntu>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 01/03/23 12:28, Qais Yousef wrote:
> On 03/01/23 08:31, Juri Lelli wrote:

...

> > Not ignoring you guys here, but it turns out I'm quite bogged down with
> > other stuff at the moment. :/ So, apologies and I'll try to get to this
> > asap. Thanks a lot for all your efforts and time reviewing so far!
> 
> Np, I can feel you :-)

Eh. :/

BTW, do you have a repro script of some sort handy I might play with?

