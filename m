Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4F7C433FE
	for <linux-s390@archiver.kernel.org>; Thu,  3 Nov 2022 15:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiKCPeN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 3 Nov 2022 11:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKCPeM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Nov 2022 11:34:12 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED6011C38
        for <linux-s390@vger.kernel.org>; Thu,  3 Nov 2022 08:34:11 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id t25so6255579ejb.8
        for <linux-s390@vger.kernel.org>; Thu, 03 Nov 2022 08:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2nyiqtS+4bjeBqC2j1CWjrUOou5+X6yWUKBJ7APuUG8=;
        b=IMzxLKhzewPSr953ozKcvA7MJkFz5aBGxh8wYt4YDDFNkFIw3w1GbuIjjEYSijrvZN
         vrsCGUFhvMNDOgPyJH44HqqAB1ZCby8RagmeEdamwIzh7rWeGkXUJabTgCCG9GgR49p8
         eM1itnPR9VBPRPpXfufcFcUxykqWRbKSPPJgqNhWqyIczmyjaQ6yxBg5KqRewZ7TYZcy
         yquj8IvH/AQtJnsWm9yePrvX+uUI5XSresCTCa3CObXmVX+CRvt3amiWYtwztltaW2u/
         K2vNjxe8ke2YRetylyiUkj+eMGGsypPmIL4gqhk0ENvCLYBb5PdSkY7ojDfwYsl+jzEo
         D12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nyiqtS+4bjeBqC2j1CWjrUOou5+X6yWUKBJ7APuUG8=;
        b=Oi1oqhHSk6D9bSERwYv57hnRxQIfzq4IXW+Ei4iHdZHJ0jcY8mftClP5ey6h9Kh2k0
         TmyFV1XkMOeFufglgpwNaEl7pTIESVc4yck+Jmbo1F0AJXX3uThGN7vBVK9hdLRVsfCZ
         3B40VP8qXrwng/y9IzGIFSC3HUyodcX2XfdKtsJmgEFvMJ2be/SPfUQAHfSDsmnKM+k9
         FoNcfZMSejkvqYg2ji65Xa++VWJwfPecidcBhy7QMxeC9z6UpytYi3V2cMHPS8A3a/X8
         sy4lrqFua6maQQO6FIAbyNKbscXv3QU8sr/RHt9SyCN6+Hy1hK89RutvhhmNdSXgAznF
         90ow==
X-Gm-Message-State: ACrzQf2F0sVDX5xxbd/X9TtaXn1TUtdzViGaw4R0Ub+s6Gh+LvQSwE9H
        5H1/V2Opx4kJ1srABGF1IzjgBw==
X-Google-Smtp-Source: AMsMyM7fW4+lX3GNb3JnmyhpDtENiHSDLEpmcsIq/zZQ8gPf3Wg1SImlQR44FmCt0HiSs2WLUbDJOQ==
X-Received: by 2002:a17:907:6e1a:b0:7ad:ba0b:538c with SMTP id sd26-20020a1709076e1a00b007adba0b538cmr26868184ejc.111.1667489645948;
        Thu, 03 Nov 2022 08:34:05 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-748-2a9a-a2a6-1362.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:748:2a9a:a2a6:1362])
        by smtp.gmail.com with ESMTPSA id r5-20020a170906a20500b00787f91a6b16sm627228ejy.26.2022.11.03.08.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 08:34:05 -0700 (PDT)
Date:   Thu, 3 Nov 2022 16:34:04 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yury Norov <yury.norov@gmail.com>, x86@kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <20221103153404.uh77nrdkowrxj6cr@kamzik>
References: <Y1vrMMtRwb0Lekl0@yury-laptop>
 <Y1vvMlwf/4EA/8WW@zn.tnic>
 <CAAH8bW_DkvPCH0-q2Bfe0OJ72r63mRM3GP7NKOFrhe3zMO2gbQ@mail.gmail.com>
 <Y1v+Ed6mRN9gisJS@zn.tnic>
 <20221031080604.6xei6c4e3ckhsvmy@kamzik>
 <Y1+OUawGJDjh4DOJ@zn.tnic>
 <20221031100327.r7tswmpszvs5ot5n@kamzik>
 <Y2K6clNJBn0SbWU+@zn.tnic>
 <20221103125945.lrr5oxxmylwpam53@kamzik>
 <Y2PX9GfxWYh6+XGT@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2PX9GfxWYh6+XGT@zn.tnic>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Nov 03, 2022 at 04:02:12PM +0100, Borislav Petkov wrote:
> On Thu, Nov 03, 2022 at 01:59:45PM +0100, Andrew Jones wrote:
> > The patch I'm proposing ensures cpumask_next()'s range, which is actually
> > [-1, nr_cpus_ids - 1),
> 
> Lemme make sure I understand it correctly: on the upper boundary, if you
> supply for n the value nr_cpu_ids - 2, then it will return potentially
> the last bit if the mask is set, i.e., the one at position (nr_cpu_ids - 1).
> 
> If you supply nr_cpus_ids - 1, then it'll return nr_cpu_ids to signal no
> further bits set.
> 
> Yes, no?

Yes

> 
> > I'll send a v4 with another stab at the commit message.
> 
> Yes, and it is still an unreadable mess: "A kernel compiled with commit
> ... but not its revert... " Nope.
> 
> First make sure cpumask_next()'s valid accepted range has been settled
> upon, has been explicitly documented in a comment above it and then I'll
> take a patch that fixes whatever is there to fix.

That's fair, but I'll leave that to Yury.

> 
> Callers should not have to filter values before passing them in - the
> function either returns an error or returns the next bit in the mask.

That's reasonable, but cpumask folk probably need to discuss it because
not all cpumask functions have a return value where an error may be
placed.

> 
> This thing:
> 
> 	if (*pos == nr_cpu_ids)
> 
> but then to pass in pos - 1:
> 
> 	*pos = cpumask_next(*pos - 1
> 
> looks to me like the interface needs more cooking.

Indeed, but that's less of an issue with cpumask_next() than with
the way cpuinfo implements its start and next seq ops (next
unconditionally increments *pos and then calls start and start
must use *pos - 1 since the first time its called it needs to use
-1).

Thanks,
drew
