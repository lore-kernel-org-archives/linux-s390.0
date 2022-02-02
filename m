Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B25C4332F
	for <linux-s390@archiver.kernel.org>; Wed,  2 Feb 2022 13:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344413AbiBBNp4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 2 Feb 2022 08:45:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21034 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344406AbiBBNpz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Feb 2022 08:45:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643809555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YxruncnGKSYEtQADjLUNkNWhCcGBbzpK2sbDwkeQUpo=;
        b=IvlHLOIoAfjxqUryG5VtmgReaCtzLoMtgEAAKndnl8Lqi914pDdVatgXRntOsQovBp53GE
        EyeC3I9hFv8V8pRcIotB0VS/+D0GazCr7QtuFhOA16z9du7/fUdOXcleb1D3uDxp0yBjcv
        uKzYQh460kzzs7wa0ybeaECp/Y3LALQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-elpcUH6RPyWuyJtvA0iyeQ-1; Wed, 02 Feb 2022 08:45:54 -0500
X-MC-Unique: elpcUH6RPyWuyJtvA0iyeQ-1
Received: by mail-ed1-f69.google.com with SMTP id o25-20020a056402039900b0040631c2a67dso10325505edv.19
        for <linux-s390@vger.kernel.org>; Wed, 02 Feb 2022 05:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=YxruncnGKSYEtQADjLUNkNWhCcGBbzpK2sbDwkeQUpo=;
        b=B5nt4V9RROa1jEyZdhWChheXH/Ag9pR/hS9tDt34n1tqn/WO7hxcA3zlPbTJzQ6SZ2
         f9x5cQRcRwFVn/BfnaMU2rlCn4nc9ESqI5/6A8orB5bxWo91yqEbj+gzqW4EWVx6hrFK
         mhKRaZsX0Z6sdZaCMAsCiKC21qHfrqUtSWF7B/9IH58hpvQKUQN0MtV2yqwe5ODYzURk
         XpBjQ/Gd9bFilziznMEy2aXM7oVRjNTshYJvAdo+hUIix+TYGUcCCoJwFWNGdxkgTaUX
         g8yg/faBzHHBPCBlyc9e4FJ6ms1McZ19/VpuRDAFshoEWNzwCweg+jKQxGsZo5WtO7FU
         VOvA==
X-Gm-Message-State: AOAM533M9GQRKTslHvZ7ZuNgYgrVOTPk43Rpsh/DFxvj5F4PLEOm94Jl
        yJ9VXQZDSgLOOHwAPFnvWvVzJbZe2cN3qgcsZRvWAiW1+7qkXQDHmKl3KEOw5uz0hTmurxC8xgQ
        68bb8z6tZvswuHgfzgB0lRg==
X-Received: by 2002:a05:6402:5248:: with SMTP id t8mr30084289edd.14.1643809552858;
        Wed, 02 Feb 2022 05:45:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqE4L2UK0676VaeKIuCkwGMt3tw/zzsCSLR83dbtSZbWUp25WGEt3s5690JhdDTieh82ha0w==
X-Received: by 2002:a05:6402:5248:: with SMTP id t8mr30084241edd.14.1643809552570;
        Wed, 02 Feb 2022 05:45:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:f800:a55c:e484:3cd9:3632? (p200300cbc709f800a55ce4843cd93632.dip0.t-ipconnect.de. [2003:cb:c709:f800:a55c:e484:3cd9:3632])
        by smtp.gmail.com with ESMTPSA id z8sm15746580ejc.151.2022.02.02.05.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 05:45:52 -0800 (PST)
Message-ID: <c25ad11e-6700-3a11-1a44-f69b4a7fc9e2@redhat.com>
Date:   Wed, 2 Feb 2022 14:45:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH RFC v1] drivers/base/node: consolidate node device
 subsystem initialization in node_dev_init()
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
References: <20220128151540.164759-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220128151540.164759-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 28.01.22 16:15, David Hildenbrand wrote:
> ... and call node_dev_init() after memory_dev_init() from driver_init(),
> so before any of the existing arch/subsys calls. All online nodes should
> be known at that point.
> 
> This is in line with memory_dev_init(), which initializes the memory
> device subsystem and creates all memory block devices.
> 
> Similar to memory_dev_init(), panic() if anything goes wrong, we don't
> want to continue with such basic initialization errors.
> 
> The important part is that node_dev_init() gets called after
> memory_dev_init() and after cpu_dev_init(), but before any of the
> relevant archs call register_cpu() to register the new cpu device under
> the node device. The latter should be the case for the current users
> of topology_init().
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: x86@kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: David Hildenbrand <david@redhat.com>

If there are no further comments, then I'll resend as !RFC with a
slightly extended patch description, testing at least under arm64 and
ppc64 as they are relatively easy to test for me.

-- 
Thanks,

David / dhildenb

