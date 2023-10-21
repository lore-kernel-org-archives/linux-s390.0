Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F792C07545
	for <linux-s390@archiver.kernel.org>; Sat, 21 Oct 2023 17:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjJUR46 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 21 Oct 2023 13:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUR45 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 21 Oct 2023 13:56:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EE0121
        for <linux-s390@vger.kernel.org>; Sat, 21 Oct 2023 10:56:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b9faf05f51so275341066b.2
        for <linux-s390@vger.kernel.org>; Sat, 21 Oct 2023 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697911008; x=1698515808; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ILprG4exMXJZBE2W/AdcWEmO8g6abjcQF7Y2TjAbtlE=;
        b=T0oCKoRQtuH5grcYxKY+vMgU58ZaLoL5RWKB+2eXYCYBaOUkHxCtKh9SVUGQzwZUiM
         dLu+ZsOLJXUHHtsmppJOW6UkloD3uFLZS7+SPn0lndQDTT6L38kcAklgZdbOhyvKYjxT
         faohfxTW6QfiN2if5lJtv6l4lcvNTBVCVLf08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697911008; x=1698515808;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILprG4exMXJZBE2W/AdcWEmO8g6abjcQF7Y2TjAbtlE=;
        b=LzagkxyG4xMBHiH/VTF6BJjrkbWYAKbAPXL5c+uzMynVWs6Qd3h6yjUQczch8T/FGS
         lhQePdVY2fIaeB1fPdi38ibaKP4paoO70swZw3AI4JK8MhK2ZnOOUtTv2UNPwtj4bJPH
         KI4kn/syZ6g0vbRPlW2q/LxhyZJpaPDfQV/e+2mR3BZ/ITR4DRv+A9rIDy4vyEkostmE
         EgI0n9J/LikJkqs7PZKwhmBLBkK2D7YGzbq3LT6Ysx3dX9YykMMvxoHFB7Sn+FwxG9uB
         OMDt5k+7UFGfSZOucydwSyth/o9SBMNRtiT7PWDKBhTSWQzOo8VWmL4xw1JYSdD9EL4Q
         SEuA==
X-Gm-Message-State: AOJu0YyyZpe/9C7FLLG2KXt0t8sh1/EnaplKj04lVNzJX5fpNYFHhKK/
        M+7Ms8zPvc4q5xjIbOny72CZSXmlbo5McTCIckjG9t0z
X-Google-Smtp-Source: AGHT+IGe1jXaofwRYPOGe5INdBopol9CJKGAGu+c5EDIXcVOxIc1Ju9AfFdL9+XG5NOcmchhns0bGA==
X-Received: by 2002:a17:907:1ca4:b0:9bf:5696:9155 with SMTP id nb36-20020a1709071ca400b009bf56969155mr3669052ejc.8.1697911008098;
        Sat, 21 Oct 2023 10:56:48 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id pj19-20020a170906d79300b009ad829ed144sm3892948ejb.130.2023.10.21.10.56.47
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 10:56:47 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-53f6ccea1eeso2782748a12.3
        for <linux-s390@vger.kernel.org>; Sat, 21 Oct 2023 10:56:47 -0700 (PDT)
X-Received: by 2002:a05:6402:2553:b0:53d:b52a:5f4b with SMTP id
 l19-20020a056402255300b0053db52a5f4bmr3519347edb.41.1697911006627; Sat, 21
 Oct 2023 10:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <your-ad-here.call-01697881440-ext-2458@work.hours>
In-Reply-To: <your-ad-here.call-01697881440-ext-2458@work.hours>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 21 Oct 2023 10:56:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTUz1bdY6zvsN4ED0arCLE8Sb==1GH8d0sjm5bu7zesQ@mail.gmail.com>
Message-ID: <CAHk-=wgTUz1bdY6zvsN4ED0arCLE8Sb==1GH8d0sjm5bu7zesQ@mail.gmail.com>
Subject: Re: [GIT PULL] s390 fixes for 6.6-rc7
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, 21 Oct 2023 at 02:44, Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> please pull s390 fixes for 6.6-rc7.

Pulled. HOWEVER.

> - Fix IOMMU bitmap allocation in s390 PCI to avoid out of bounds access
>   when IOMMU pages aren't a multiple of 64.

Please don't do this kind of thing.

And I quote:

    static unsigned long *bitmap_vzalloc(size_t bits, gfp_t flags)
    {
        size_t n = BITS_TO_LONGS(bits);
        size_t bytes;

        if (unlikely(check_mul_overflow(n, sizeof(unsigned long), &bytes)))
                return NULL;

        return vzalloc(bytes);
    }

the above overflow handling is *not* "defensive and good programming".

The above is just "unreadable mindless boiler plate".

Seriously, you're taking a 'size_t' of number of bits, turning it into
number of longs, and you're then turning *that* into number of bytes,
AND YOU ADD OVERFLOW CHECKING?!??!!!

Now, to make matters worse, the above calculation can actually
overflow in theory - but not in the place where you added the
protection!

Because the "longs to bytes" sure as hell can't overflow. We know
that, because the number of longs is guaranteed to have a much smaller
range, since it came from a calculation of bits.

But what can actually overflow? BITS_TO_LONGS(bits) will overflow, and
turn ~0ul to 0, because it does the __KERNEL_DIV_ROUND_UP thing, which
is the simplistic

    #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))

so that code added overflow protection that doesn't make sense, in all
the wrong places.

You need to verify the sanity of the number of bits first anyway.

Of course, in your use-case, the number of bits is also not unlimited,
because the source is

        zdev->iommu_pages = zdev->iommu_size >> PAGE_SHIFT;

so it turns out that no, the BITS_TO_LONGS() won't overflow either,
but at least in some other situations - and only looking at that
bitmap_vzalloc() in a vacuum - it *could* have.

Now, I will argue that you always need range checking on the number of
bits *anyway* for other reasons - trying to just blindly allocate some
random amount of memory isn't acceptable, so there should to be some
range checking before anyway.

But that code is wrong, because the overflow is simply not an issue.
Adding overflow handling code is literally only actively misleading,
making the code harder to read, for no reason, and making people
*think* it's being careful when it is anything *but* careful.

I suspect that the compiler actually sees "that is stupid" and turns
the overflow into just a single left-shift again because it has seen
the (bigger) right-shift and knows it cannot overflow, but the problem
I'm ranting against is mindlessly adding boiler plate code that makes
the code harder to read for *humans*.

If you *do* want to add proper overflow handling, you'd need to either
fix BITS_TO_LONGS() some way (which is actually non-trivial since it
needs to be able to stay a constant and only use the argument once),
or you do something like

        if (!bits)
                return ZERO_SIZE_PTR;
        longs = BITS_TO_LONG(bits);
        if (!longs)
                return NULL;
        return vzalloc(longs * sizeof(long));

and I'd suggest maybe we should

 (a) do the above checking in our bitmap_alloc() routines

 (b) also change our bitmap_alloc() routines to take 'size_t' instead
of 'unsigned int' bit counts

 (c) and finally, add that vzalloc() case, but simply using

        kvmalloc_array(n, size, flags | __GFP_ZERO);

instead.

(And yes, kvmalloc_array() will actually then also do that
check_mul_overflow() thing, but now it's not pointless boiler plate
any more, now it's actually meaningful for *other* cases than the
bitmap allocation one that cannot overflow).

Hmm?

           Linus
