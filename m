Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78630FA3740
	for <linux-s390@archiver.kernel.org>; Mon, 31 Oct 2022 10:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJaKDc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 31 Oct 2022 06:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiJaKDc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 31 Oct 2022 06:03:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE92665EB
        for <linux-s390@vger.kernel.org>; Mon, 31 Oct 2022 03:03:30 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id f27so28069814eje.1
        for <linux-s390@vger.kernel.org>; Mon, 31 Oct 2022 03:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ij0opVplOZ4JlIp6K8xwI+xLgpGAyEZHWtU1AyZKEUo=;
        b=NVMInip05i3j2Mewd8/9DA5VH9moDODkHGKksq2V35DG4ZziDSBIvUuAT9vkgpRf0d
         21cfnb+Ic7yb0fKpaQko2/3X06kq6xe/XCHQEYDl6OhLI2/0FrdGqDZUQd1J7/senkcv
         DOl89eFWBJftp3vto1gh5cWgUBeCTuph9SIKiz0krDlDYUjX/89nzBZ1SkCF6yXeBQ5L
         oy/FLx+eyQ0Wt0BTeHJp3vkdt0LtCHU4KDi4RBqwOyUiIBl9/k/dAugnydtOxw9EUUT/
         ArMtYe3iEM2RkUy0/xdIxnvFPevgupjBBbMoUxHQvvlem6IUyPz4BSgqjGCJMagdWnvZ
         oKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ij0opVplOZ4JlIp6K8xwI+xLgpGAyEZHWtU1AyZKEUo=;
        b=J0c4c9UmgNHWq9tk6J/GhGlbfMGkZvQJogouvO6K6nIqErAuyYRok82EYuVT2QRt3a
         8UzezJ8Wlt82KzgElajGOXzA1azsz6ERCtBEAeI5ZPwAhOPfeqYpMHLJ0qIIj95IQG6Y
         VWNvKcyvt3MyG3ctoK/mIq36yvwfyDOKl5bkNQRw6x92rPJyPPeseULblUFdqgHnkCO2
         o1TksReDDpi0nN+9tdltWdVXYWfI8bXpsPBpvCs7Z/rYDDnr5xTqd85f61ZOAXCc1wfx
         eMADqNEIZPFkrh2Z6/3GaUzdivJ9ydmjb3x6hikt9aATy/jSTIVqEQDDaIXhsBNLUsH6
         2+bg==
X-Gm-Message-State: ACrzQf38LwybixVWqTW+uhiYTiN7r6u7uSGRt7g0QqL0b3X+KZL5QjaS
        0J1IYdmGcgqsIVxIkLoPhZXBgg==
X-Google-Smtp-Source: AMsMyM6ycpS4chQBPAohNrxS8VumeP7MjXmU/tZoBGLw1w6j4emq8bR2PAjr2PZhdKbiabGv9P0mtA==
X-Received: by 2002:a17:906:9745:b0:78d:480f:cee7 with SMTP id o5-20020a170906974500b0078d480fcee7mr11952970ejy.192.1667210609260;
        Mon, 31 Oct 2022 03:03:29 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id eh22-20020a0564020f9600b00461bacee867sm3048302edb.25.2022.10.31.03.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 03:03:28 -0700 (PDT)
Date:   Mon, 31 Oct 2022 11:03:27 +0100
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
Message-ID: <20221031100327.r7tswmpszvs5ot5n@kamzik>
References: <20221014155845.1986223-1-ajones@ventanamicro.com>
 <20221014155845.1986223-3-ajones@ventanamicro.com>
 <20221028074828.b66uuqqfbrnjdtab@kamzik>
 <Y1vrMMtRwb0Lekl0@yury-laptop>
 <Y1vvMlwf/4EA/8WW@zn.tnic>
 <CAAH8bW_DkvPCH0-q2Bfe0OJ72r63mRM3GP7NKOFrhe3zMO2gbQ@mail.gmail.com>
 <Y1v+Ed6mRN9gisJS@zn.tnic>
 <20221031080604.6xei6c4e3ckhsvmy@kamzik>
 <Y1+OUawGJDjh4DOJ@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1+OUawGJDjh4DOJ@zn.tnic>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 31, 2022 at 09:58:57AM +0100, Borislav Petkov wrote:
> On Mon, Oct 31, 2022 at 09:06:04AM +0100, Andrew Jones wrote:
> >  The valid cpumask range is [0, nr_cpu_ids) and cpumask_next() always
> >  returns a CPU ID greater than its input, which results in its input
> >  range being [-1, nr_cpu_ids - 1). Ensure showing CPU info avoids
> >  triggering error conditions in cpumask_next() by stopping its loop
> 
> What error conditions?
> 
> What would happen if @n is outside of the valid range?

Currently (after the revert of 78e5a3399421) with DEBUG_PER_CPU_MAPS we'll
get a warning splat when the cpu is outside the range [-1, nr_cpu_ids) and
cpumask_next() will call find_next_bit() with the input plus one anyway.
find_next_bit() doesn't explicity document what happens when an input is
outside the range, but it currently returns the bitmap size without any
side effects, which means cpumask_next() will return nr_cpu_ids.
show_cpuinfo() doesn't try to show anything in that case and stops its
loop, or, IOW, things work fine now with an input of nr_cpu_ids - 1. But,
show_cpuinfo() is just getting away with a violated cpumask_next()
contract, which 78e5a3399421 exposed. How about a new commit message like
this

  seq_read_iter() and cpuinfo's start and next seq operations implement a
  pattern like

    n = cpumask_next(n - 1, mask);
    show(n);
    while (1) {
        ++n;
        n = cpumask_next(n - 1, mask);
        if (n >= nr_cpu_ids)
           break;
        show(n);
    }

  which loops until cpumask_next() identifies its CPU ID input is out of
  its valid range, [-1, nr_cpu_ids - 1). seq_read_iter() assumes the
  result of an invalid input is to return nr_cpu_ids or larger without any
  side effects, however the cpumask API does not document that and it
  reserves the right to change how it responds to invalid inputs. Ensure
  inputs from seq_read_iter() are valid.

Thanks,
drew
