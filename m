Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9762C761A6
	for <linux-s390@archiver.kernel.org>; Thu,  6 Apr 2023 15:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239278AbjDFPww (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 6 Apr 2023 11:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239269AbjDFPws (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Apr 2023 11:52:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C729EEB
        for <linux-s390@vger.kernel.org>; Thu,  6 Apr 2023 08:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680796322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rXGtO/ZmgcxJ+0cLf6d2t80Dy16O6Eu74rSJdt26LEE=;
        b=cG/hStLMUZpHAA7CwfN22qTpW54CqsVflHpyJ+05KcEFgdej++Z5EqDYyirOzmZSLfJzlH
        ufBnSih66ypmJouKAKgyeKyIGXLBb2xBNlQJ7krMA6OEWHIir1EeQy/f9OKlQpgfYUqcxi
        +eQPe7UYGCS/KPhoKAYXZ40vEUhGkBk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-cv9jL0-yNVWirlvfE99xyA-1; Thu, 06 Apr 2023 11:51:57 -0400
X-MC-Unique: cv9jL0-yNVWirlvfE99xyA-1
Received: by mail-wm1-f71.google.com with SMTP id m7-20020a05600c4f4700b003ee7e120bdfso18454635wmq.6
        for <linux-s390@vger.kernel.org>; Thu, 06 Apr 2023 08:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680796316; x=1683388316;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXGtO/ZmgcxJ+0cLf6d2t80Dy16O6Eu74rSJdt26LEE=;
        b=Oge2Hrr8mtc1+ZcNYRuZHvuFyGtmDJNFL/OL14bd9nlKI9XsGFwng2CGayZXJlAvif
         h8LGRpH2hxI+ek7ra0OSAz18sEu3rKBwlPJNpndOcQYnbmTLrbe2w35GtE522AeybVDA
         orWelLDbnd3eN6DFtDOGb+ZVrk6meJrpiKjZPmYCXranYXZkX/HgrY2j9wjnGWpoYT/q
         ZLONK8oRn//dH+WuU9gwGGnLew8VFz/qAV06HWaSO0UMpMAkhcRctiNFjw9JS7AtSW0M
         f4EPs+zhzB+OLygrjUOahYdwS+hBzZK8HjdvUjbIUBb9jToaRMXIGmsBJaeaaOFr/qlZ
         GmIw==
X-Gm-Message-State: AAQBX9fbTeTDwfpG2KICaz3yB4Io+5nOCVVFbzmOWavBWRt/3XtwfgDu
        XS5tDZsaLgyTl5tS2rJ98lIdkvECZSsGnFzbzS0gSkCAo5SXCNNDjqL7szKiR2b6kXoMtbG56gO
        SN6nanO/NupqNouiFwin65w==
X-Received: by 2002:a5d:4b48:0:b0:2c5:5349:22c1 with SMTP id w8-20020a5d4b48000000b002c5534922c1mr4313684wrs.5.1680796315814;
        Thu, 06 Apr 2023 08:51:55 -0700 (PDT)
X-Google-Smtp-Source: AKy350ay4SJLqt5fA44R22zdeLYwjok7IPAqD9HIjt6I2uRSHvro/TvSjV0I+pG8tJTj7AgJtBYNWg==
X-Received: by 2002:a5d:4b48:0:b0:2c5:5349:22c1 with SMTP id w8-20020a5d4b48000000b002c5534922c1mr4313662wrs.5.1680796315457;
        Thu, 06 Apr 2023 08:51:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:6300:a8be:c1ad:41a1:2bf7? (p200300cbc7056300a8bec1ad41a12bf7.dip0.t-ipconnect.de. [2003:cb:c705:6300:a8be:c1ad:41a1:2bf7])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d668d000000b002e61e002943sm2031659wru.116.2023.04.06.08.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 08:51:54 -0700 (PDT)
Message-ID: <248392c0-52d1-d09d-75ec-9e930435c053@redhat.com>
Date:   Thu, 6 Apr 2023 17:51:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To:     Peter Zijlstra <peterz@infradead.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Yair Podemsky <ypodemsk@redhat.com>, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org,
        paulmck@kernel.org, jpoimboe@kernel.org, samitolvanen@google.com,
        ardb@kernel.org, juerg.haefliger@canonical.com,
        rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        tony@atomide.com, linus.walleij@linaro.org,
        sebastian.reichel@collabora.com, nick.hawkins@hpe.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, vschneid@redhat.com, dhildenb@redhat.com,
        alougovs@redhat.com, jannh@google.com,
        Yang Shi <shy828301@gmail.com>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com> <ZC1Q7uX4rNLg3vEg@lothringen>
 <ZC1XD/sEJY+zRujE@lothringen> <ZC3P3Ds/BIcpRNGr@tpad>
 <20230405195226.GB365912@hirez.programming.kicks-ass.net>
 <ZC69Wmqjdwk+I8kn@tpad>
 <20230406132928.GM386572@hirez.programming.kicks-ass.net>
 <20230406140423.GA386634@hirez.programming.kicks-ass.net>
 <20230406150213.GQ386572@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
In-Reply-To: <20230406150213.GQ386572@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 06.04.23 17:02, Peter Zijlstra wrote:
> On Thu, Apr 06, 2023 at 04:04:23PM +0200, Peter Zijlstra wrote:
>> On Thu, Apr 06, 2023 at 03:29:28PM +0200, Peter Zijlstra wrote:
>>> On Thu, Apr 06, 2023 at 09:38:50AM -0300, Marcelo Tosatti wrote:
>>>
>>>>> To actually hit this path you're doing something really dodgy.
>>>>
>>>> Apparently khugepaged is using the same infrastructure:
>>>>
>>>> $ grep tlb_remove_table khugepaged.c
>>>> 	tlb_remove_table_sync_one();
>>>> 	tlb_remove_table_sync_one();
>>>>
>>>> So just enabling khugepaged will hit that path.
>>>
>>> Urgh, WTF..
>>>
>>> Let me go read that stuff :/
>>
>> At the very least the one on collapse_and_free_pmd() could easily become
>> a call_rcu() based free.
>>
>> I'm not sure I'm following what collapse_huge_page() does just yet.
> 
> DavidH, what do you thikn about reviving Jann's patches here:
> 
>    https://bugs.chromium.org/p/project-zero/issues/detail?id=2365#c1
> 
> Those are far more invasive, but afaict they seem to do the right thing.
> 

I recall seeing those while discussed on security@kernel.org. What we 
currently have was (IMHO for good reasons) deemed better to fix the 
issue, especially when caring about backports and getting it right.

The alternative that was discussed in that context IIRC was to simply 
allocate a fresh page table, place the fresh page table into the list 
instead, and simply free the old page table (then using common machinery).

TBH, I'd wish (and recently raised) that we could just stop wasting 
memory on page tables for THPs that are maybe never going to get 
PTE-mapped ... and eventually just allocate on demand (with some 
caching?) and handle the places where we're OOM and cannot PTE-map a THP 
in some descend way.

... instead of trying to figure out how to deal with these page tables 
we cannot free but have to special-case simply because of GUP-fast.

-- 
Thanks,

David / dhildenb

