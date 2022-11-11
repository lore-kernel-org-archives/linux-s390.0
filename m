Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF84C4332F
	for <linux-s390@archiver.kernel.org>; Fri, 11 Nov 2022 10:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiKKKSJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 11 Nov 2022 05:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbiKKKRO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 11 Nov 2022 05:17:14 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C0171F24
        for <linux-s390@vger.kernel.org>; Fri, 11 Nov 2022 02:17:12 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w14so5836202wru.8
        for <linux-s390@vger.kernel.org>; Fri, 11 Nov 2022 02:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BH/APi1a0PoKAJZknP8AkAonpu9TnXBBnNUq+HUkcwM=;
        b=4oOscMH7jU6ury8coe6FqLy7zK1XZNinWBvFR7izLUhT8UO+Uf7A34vnnALOX+0uZw
         6u0BzpFG7Xf65rlpJuAvjMgTNhVx/gSKcxgRlSDN2zH7W+6LI6BnNcuT8FnlleBan74e
         U+nnWKJgynFDrs5h1v4LHjxM1v+N8pvPWTcuhFJiAYBmZcFqEaaRiyqBxAjt+VLKVj27
         ymKqo1xHrZ7qEJ3SsTyk8ixNapD9K4j74hbbeGy2nwxMGfxLNJInz1YB3DFYiKEqav4a
         oeGBzhxJPbF4jd3XpyzDJKvMeI1dC4S63nsd7WzmmwS7/SrtVuS1+i59tvEjxRd8GW0+
         CSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BH/APi1a0PoKAJZknP8AkAonpu9TnXBBnNUq+HUkcwM=;
        b=JNsxNpyK79jsdIIYaKygPnF9M0fdLgwFAieGjc3uocY4ztbM4dKqOBbziWpjcRvG0a
         ZMUmVK4GLRbpbS9ZU5O4BSTTAqfuBcIalzZqUvPBGxlZfhtcHzrtmsBNJnLfhzHtqNBb
         tjPakIlqOTr2kuZp2MwyI+4Owwi27VQL2QIJIKwyNTWYTN0nrd348e0FCAU8IVgYB+/H
         4ucrNDKJau/UqQ5Qbs+5uzuQHO10JDodu/gTX2U/h9DFyQGnhJumSwKfYiSIMp+HMdue
         BeQ1c8AubTkXEhU2m6mNNCDIhKxVIKGR8t7LGEXSroAP6TyNuyYHdKXmxA6aC2c4e6Lh
         EOgQ==
X-Gm-Message-State: ANoB5pkZibVUnVsjiPKTIZNEx3DKmCywUiBUSk9FpUV2Ho7TpeiP2qy1
        Vb0RIJUWmY5jU8Ve+ln8Lkqd8w==
X-Google-Smtp-Source: AA0mqf4pSdxpuNsvbAiQ/VPT4Uicb2yIOEyOj0DptBJEnqY46AvxjvE1jv4RoOcak7HL0HGEg3fM1Q==
X-Received: by 2002:a05:6000:18cc:b0:236:6d79:b312 with SMTP id w12-20020a05600018cc00b002366d79b312mr805921wrq.699.1668161831083;
        Fri, 11 Nov 2022 02:17:11 -0800 (PST)
Received: from localhost ([95.148.15.66])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c2ca800b003b4a699ce8esm8500043wmc.6.2022.11.11.02.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 02:17:10 -0800 (PST)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <anshuman.khandual@arm.com>, <linux-doc@vger.kernel.org>,
        <corbet@lwn.net>, <peterz@infradead.org>, <arnd@arndb.de>,
        <punit.agrawal@bytedance.com>, <linux-kernel@vger.kernel.org>,
        <darren@os.amperecomputing.com>, <yangyicong@hisilicon.com>,
        <huzhanyuan@oppo.com>, <lipeifeng@oppo.com>,
        <zhangshiming@oppo.com>, <guojian@oppo.com>, <realmz6@gmail.com>,
        <linux-mips@vger.kernel.org>, <openrisc@lists.librecores.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <linux-s390@vger.kernel.org>, Barry Song <21cnbao@gmail.com>,
        <wangkefeng.wang@huawei.com>, <xhao@linux.alibaba.com>,
        <prime.zeng@hisilicon.com>
Subject: Re: [External] [PATCH v5 0/2] arm64: support batched/deferred tlb
 shootdown during page reclamation
References: <20221028081255.19157-1-yangyicong@huawei.com>
Date:   Fri, 11 Nov 2022 10:17:09 +0000
In-Reply-To: <20221028081255.19157-1-yangyicong@huawei.com> (Yicong Yang's
        message of "Fri, 28 Oct 2022 16:12:53 +0800")
Message-ID: <87pmdtztga.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Yicong Yang <yangyicong@huawei.com> writes:

> From: Yicong Yang <yangyicong@hisilicon.com>
>
> Though ARM64 has the hardware to do tlb shootdown, the hardware
> broadcasting is not free.
> A simplest micro benchmark shows even on snapdragon 888 with only
> 8 cores, the overhead for ptep_clear_flush is huge even for paging
> out one page mapped by only one process:
> 5.36%  a.out    [kernel.kallsyms]  [k] ptep_clear_flush
>
> While pages are mapped by multiple processes or HW has more CPUs,
> the cost should become even higher due to the bad scalability of
> tlb shootdown.
>
> The same benchmark can result in 16.99% CPU consumption on ARM64
> server with around 100 cores according to Yicong's test on patch
> 4/4.
>
> This patchset leverages the existing BATCHED_UNMAP_TLB_FLUSH by
> 1. only send tlbi instructions in the first stage -
> 	arch_tlbbatch_add_mm()
> 2. wait for the completion of tlbi by dsb while doing tlbbatch
> 	sync in arch_tlbbatch_flush()
> Testing on snapdragon shows the overhead of ptep_clear_flush
> is removed by the patchset. The micro benchmark becomes 5% faster
> even for one page mapped by single process on snapdragon 888.
>
> With this support we're possible to do more optimization for memory
> reclamation and migration[*].

I applied the patches on v6.1-rc4 and was able to see the drop in
ptep_clear_flush() in the perf report when running the test program from
Patch 2. The tests were done on a rk3399 based system with benefits
visible when running the tests on either of the clusters. 

So, for the series,

Tested-by: Punit Agrawal <punit.agrawal@bytedance.com>

Thanks,
Punit

[...]

