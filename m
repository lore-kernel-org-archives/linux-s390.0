Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D220C761A6
	for <linux-s390@archiver.kernel.org>; Tue,  4 Apr 2023 13:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbjDDNtT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 Apr 2023 09:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbjDDNs5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Apr 2023 09:48:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECBF4224
        for <linux-s390@vger.kernel.org>; Tue,  4 Apr 2023 06:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680616084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zsTIZUaOt4/p51daq2PZX1n16o1nkazviHKpSzXwqxo=;
        b=ArHeF70/hRk2CF/NkNwJhUWtTFgN/xrNP1xI9/O4iDpUFTs66FPCYWfd3DrEmMh+I6tAbd
        WvBiPjaCPXghfR+HXSg6eZRnmJkhBjLSmeqGBmnIOkCq2AQaJ6Ss4v4hBN2LZs1Zz4UP69
        4ohj/3+nx0RAfMynf/M/iLXNhr7rbmg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-cenYHHJAOgiGsZD8jznEwg-1; Tue, 04 Apr 2023 09:48:00 -0400
X-MC-Unique: cenYHHJAOgiGsZD8jznEwg-1
Received: by mail-wr1-f70.google.com with SMTP id b9-20020a05600018a900b002cfe70737d2so3681974wri.1
        for <linux-s390@vger.kernel.org>; Tue, 04 Apr 2023 06:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680616079;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsTIZUaOt4/p51daq2PZX1n16o1nkazviHKpSzXwqxo=;
        b=prOQZt3MfR8auSwu+GO6ulMgnaXORsyAlsQgkHbHnXT64ay5Hf7Jd2C+GhEdX5O+HT
         o2c/9O9LImXqCcbDKEq5ZALA5PtjmtwNhx6YFxv994hvKeP/T1Oq6Hf6mXJUJhkmxovJ
         QiVnGkJVds3k8d60r3bZvgALrarB1eEHYZYPGlVqYJ8FyVBxz/O+I6fCKQuHLjjoURfM
         1eDs2SgttQEHIOMEDFmcvpmQ6FpcMXZ0x86WY7L98HS578M11pz4n3oRA3gaeRRKT1z9
         eNY1htN59S0N8xunUcFLLf7yHHrF0tvebI/6ykMe3AHFk6RsyiYS7/YQbLur2OEgg/dW
         248A==
X-Gm-Message-State: AAQBX9dC/Xq/yPlToijSBGVy8QOSnGL2kPwYJefaDJr24mDiUhDsK3sE
        fIdREK45EeIr5mtZRZeHm1633nKCqr45pwy5Y5S+DU4LkbPNg85cAcQtr4N+z6O2cP9LJMuITAU
        lg2evCmQf0eUCRReUSclLWw==
X-Received: by 2002:a5d:4d11:0:b0:2ce:9819:1c1e with SMTP id z17-20020a5d4d11000000b002ce98191c1emr1783349wrt.30.1680616079625;
        Tue, 04 Apr 2023 06:47:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350bmtLhdkOTL49G5hyyIR/dGwEI3AOPEAjf+veEKXRQyea3PV+FawQK0/io3jdVH76JN5ImpWw==
X-Received: by 2002:a5d:4d11:0:b0:2ce:9819:1c1e with SMTP id z17-20020a5d4d11000000b002ce98191c1emr1783320wrt.30.1680616079268;
        Tue, 04 Apr 2023 06:47:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:b600:e63:6c3b:7b5d:f439? (p200300cbc709b6000e636c3b7b5df439.dip0.t-ipconnect.de. [2003:cb:c709:b600:e63:6c3b:7b5d:f439])
        by smtp.gmail.com with ESMTPSA id d7-20020adfe2c7000000b002d419f661d6sm12391832wrj.82.2023.04.04.06.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 06:47:58 -0700 (PDT)
Message-ID: <78a31392-8f9b-9705-918a-24edb650f395@redhat.com>
Date:   Tue, 4 Apr 2023 15:47:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/3] arch: Introduce ARCH_HAS_CPUMASK_BITS
Content-Language: en-US
To:     Yair Podemsky <ypodemsk@redhat.com>, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, peterz@infradead.org, arnd@arndb.de,
        keescook@chromium.org, paulmck@kernel.org, jpoimboe@kernel.org,
        samitolvanen@google.com, frederic@kernel.org, ardb@kernel.org,
        juerg.haefliger@canonical.com, rmk+kernel@armlinux.org.uk,
        geert+renesas@glider.be, tony@atomide.com,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        nick.hawkins@hpe.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, mtosatti@redhat.com, vschneid@redhat.com,
        dhildenb@redhat.com
Cc:     alougovs@redhat.com
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-2-ypodemsk@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230404134224.137038-2-ypodemsk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 04.04.23 15:42, Yair Podemsky wrote:
> Some architectures set and maintain the mm_cpumask bits when loading
> or removing process from cpu.
> This Kconfig will mark those to allow different behavior between
> kernels that maintain the mm_cpumask and those that do not.
> 

I was wondering if we should do something along the lines of:

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0722859c3647..1f5c15d8e8ed 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -767,11 +767,13 @@ struct mm_struct {
  #endif /* CONFIG_LRU_GEN */
         } __randomize_layout;

+#ifdef CONFIG_MM_CPUMASK
         /*
          * The mm_cpumask needs to be at the end of mm_struct, because it
          * is dynamically sized based on nr_cpu_ids.
          */
         unsigned long cpu_bitmap[];
+#endif
  };

But that would, of course, require additional changes to make it 
compile. What concerns me a bit is that we have in mm/rmap.c a 
mm_cpumask() usage. But it's glued to 
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH ... shaky.

At least if we would properly fence it, there would be no
accidental abuse anymore.


> Signed-off-by: Yair Podemsky <ypodemsk@redhat.com>
> ---
>   arch/Kconfig         | 8 ++++++++
>   arch/arm/Kconfig     | 1 +
>   arch/powerpc/Kconfig | 1 +
>   arch/s390/Kconfig    | 1 +
>   arch/sparc/Kconfig   | 1 +
>   arch/x86/Kconfig     | 1 +

As Valentin says, there are other architectures that do the same.

-- 
Thanks,

David / dhildenb

