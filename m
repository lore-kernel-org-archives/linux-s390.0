Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91ED5C2BB41
	for <linux-s390@archiver.kernel.org>; Tue, 16 Aug 2022 15:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiHPP7F (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 16 Aug 2022 11:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbiHPP6h (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 16 Aug 2022 11:58:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFB7B7C6
        for <linux-s390@vger.kernel.org>; Tue, 16 Aug 2022 08:55:54 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ha11so10114722pjb.2
        for <linux-s390@vger.kernel.org>; Tue, 16 Aug 2022 08:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=S0TjqgZ/cpwhvqIRclTaRgLLFqhzUsXjGRreU5l1Dao=;
        b=qTx7jEv4/nwmvCExtD6R89Dm1SBJ4SkhasuOIfOrwWZ6K1t2Zr0EaCkQWcJCS/uim+
         8X9WP8VRmTcp17JN0SF1dTFzd9Oh4JZoisOJYrLLcIy4MM3xb74oG5Mscfg6rwcrXhJI
         hQdCdNpKMiGt/+1SGkofKjc4IhOG8u/ztqpv2yctdU8Nuk2IMbHx6qI6TzuQQ0klWjGq
         aFceiAkHInK+h5iWx+IC90K1AiFSPR3Plz+cYfA1om82VYY1xFn9WCIj5pzWRvWr0cZB
         /NocanLC50/KXHrrK96ND8mMKm9IrEstRN/hRIk2ALjS9Xwx1q7bVX56kmoPPF2s2jMo
         tW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=S0TjqgZ/cpwhvqIRclTaRgLLFqhzUsXjGRreU5l1Dao=;
        b=PzlHoDFStokoZ2cI8KaVkKOPq2i0YkFD4Ix9nDm8HiCfGTbVXHexTMRkKt1QKDB/Wm
         TAG+7tQhqvm+nzJAz1fyQjeBxtDPU2tAHeXrSt5/jXnIp5Hh2TWS7HdMJeYBlbQebvgI
         7hNDRRhTieoqmSkpHJCys3oCHfOQ1M/hQ6PV7iYhjG2tdspUvUXetoCGuSl1/ml4e79m
         6+iSGjzwWGE2almgoXbQl+V/ziuKdKBdyiVDyWE/etMH2tmdXjjwPy/FBJfBOclqnS4i
         hfwA8WFIg+ZPib928IRUuPXXy81dTaeoa44fefEIUw8fTu5F7a4qiwINl7FoqNzQMhlw
         5Keg==
X-Gm-Message-State: ACgBeo0oHIgRvVDOM1maQAc3bES1ys4CXrZuyOiBZBgCuTV20XkG9jPl
        DDJCq2FdQfRvQJ1fKYz+cLSWRJSCf2fUVh9QjnlftQ==
X-Google-Smtp-Source: AA6agR7rNOEKD6nRN5Avv+ABuxkIhBYlnMLShbilL+t09HuhZ24Kqp5AE/3faQMwTl37shqIo4Nw0wBbJ21Udr/teco=
X-Received: by 2002:a17:902:8683:b0:171:3114:7678 with SMTP id
 g3-20020a170902868300b0017131147678mr22420060plo.172.1660665354218; Tue, 16
 Aug 2022 08:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89i+6NPujMyiQxriZRt6vhv6hNrAntXxi1uOhJ0SSqnJ47w@mail.gmail.com>
 <20220627123415.GA32052@shbuild999.sh.intel.com> <CANn89iJAoYCebNbXpNMXRoDUkFMhg9QagetVU9NZUq+GnLMgqQ@mail.gmail.com>
 <20220627144822.GA20878@shbuild999.sh.intel.com> <CANn89iLSWm-c4XE79rUsxzOp3VwXVDhOEPTQnWgeQ48UwM=u7Q@mail.gmail.com>
 <20220628034926.GA69004@shbuild999.sh.intel.com> <CALvZod71Fti8yLC08mdpDk-TLYJVyfVVauWSj1zk=BhN1-GPdA@mail.gmail.com>
 <20220703104353.GB62281@shbuild999.sh.intel.com> <YsIeYzEuj95PWMWO@castle>
 <20220705050326.GF62281@shbuild999.sh.intel.com> <YvswusNaC5yr+HwT@xsang-OptiPlex-9020>
In-Reply-To: <YvswusNaC5yr+HwT@xsang-OptiPlex-9020>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 16 Aug 2022 08:55:43 -0700
Message-ID: <CALvZod66HFiBX2N07gmCYDk_iH0bf4U+O=0DqUDmcebpOSyvwA@mail.gmail.com>
Subject: Re: [net] 4890b686f4: netperf.Throughput_Mbps -69.4% regression
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Eric Dumazet <edumazet@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Xin Long <lucien.xin@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        linux-s390@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>, Ying Xu <yinxu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Aug 15, 2022 at 10:53 PM Oliver Sang <oliver.sang@intel.com> wrote:
>
> Hi all,
>
> now we noticed this commit has already merged into mainline, and in our tests
> there is still similar regression. [1]
>
> not sure if there is a plan to merge some of the solutions that have been
> discussed in this thread? we'll very glad to test patches if there is a request
>
> Thanks a lot!

Hi Oliver, sorry for the delay. I will send out the patches in a day or two.

thanks,
Shakeel
