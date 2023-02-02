Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4CFC63797
	for <linux-s390@archiver.kernel.org>; Thu,  2 Feb 2023 19:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBBTjj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 2 Feb 2023 14:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjBBTjh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Feb 2023 14:39:37 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA807A480
        for <linux-s390@vger.kernel.org>; Thu,  2 Feb 2023 11:39:33 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v10so3137512edi.8
        for <linux-s390@vger.kernel.org>; Thu, 02 Feb 2023 11:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JmnIaySd7zoAM6xF2ibXT8yo+UTOpvQnMVr9b5O/7+w=;
        b=ca1h9KkMFNsKgO7Ao0NeYlaifxp7NzGcaaakgNFyQLMxBSXDHTcSanf/uonLuKRR18
         lO7gVsm341hb9Nhg1BLsB8gPuvWRYHLOlq9HV87cUF6Vj8wjTPtsHShRpe/Vd30GyM78
         DjJAMh6ZqNcvDd+rLB79O+fNMlUiqjmmCA6so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmnIaySd7zoAM6xF2ibXT8yo+UTOpvQnMVr9b5O/7+w=;
        b=a6EKwhbFwIwpOEHjhBROJ62PZMir3Rw65wtL2eJmDDj34iG8gmla44vtlRYpc6q75F
         JlTYmrvG3LDb53zW2f/KimGAhOWkRUk0xng2cPY26Jb1FSPtDiNIzZlNaF6vWRUJmY2K
         5ETVOjH4ySHOqhSXSnWGBenQYS6s1z5edo/I4sMoLiivz04iWJL0Caujer3IUFbhvom2
         0LVJFYgWHm1c2ZMgzrXafHqP45J1tMzTGxQw3K2H1E3UPN1yvArRoBNK/ExvgISe8dXM
         2D9uz133hyIlEyG7ktoptDuZCpotj5pKISbYd0I5enUx/KjTMkMlqD8sM9kinrlMRPkc
         kpLw==
X-Gm-Message-State: AO0yUKUD0OGXwGgFoYC7QcikALZc2cESj4dNlJDPjLIDA86WqxMSaCr0
        EvhY2LqcTQEGMwWqw0M7p6/GPGuDVQxYHIJaP6fQzw==
X-Google-Smtp-Source: AK7set8+xHadxCy5qXWT6jHusT8YxxQBwSq0lJGCKawTJbhKLoo775Ny5e7YDygWaIKJaqvAG6jj5A==
X-Received: by 2002:a05:6402:64a:b0:488:6003:24b6 with SMTP id u10-20020a056402064a00b00488600324b6mr7484523edx.40.1675366771711;
        Thu, 02 Feb 2023 11:39:31 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id eo13-20020a056402530d00b0049dd7eec977sm132541edb.41.2023.02.02.11.39.30
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 11:39:30 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id bk15so9047948ejb.9
        for <linux-s390@vger.kernel.org>; Thu, 02 Feb 2023 11:39:30 -0800 (PST)
X-Received: by 2002:a17:906:f109:b0:882:e1b7:a90b with SMTP id
 gv9-20020a170906f10900b00882e1b7a90bmr2112186ejb.187.1675366759217; Thu, 02
 Feb 2023 11:39:19 -0800 (PST)
MIME-Version: 1.0
References: <20230202145030.223740842@infradead.org>
In-Reply-To: <20230202145030.223740842@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Feb 2023 11:39:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiF6y7CwR1P5_73aK2f=x=RZjwgh3sgeO3Mczv4XcDc8g@mail.gmail.com>
Message-ID: <CAHk-=wiF6y7CwR1P5_73aK2f=x=RZjwgh3sgeO3Mczv4XcDc8g@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Introduce cmpxchg128() -- aka. the demise of cmpxchg_double()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     corbet@lwn.net, will@kernel.org, boqun.feng@gmail.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Feb 2, 2023 at 7:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
>  - fixed up the inline asm to use 'u128 *' mem argument so the compiler knows
>    how wide the modification is.
>  - reworked the percpu thing to use union based type-punning instead of
>    _Generic() based casts.

Looks lovely to me. This removed all my concerns (except for the
testing one, but all the patches looked nice and clean to me, so
clearly it must be perfect).

                Linus
