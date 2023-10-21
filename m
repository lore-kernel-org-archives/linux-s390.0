Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A43C07545
	for <linux-s390@archiver.kernel.org>; Sat, 21 Oct 2023 18:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjJUSJA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 21 Oct 2023 14:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJUSI7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 21 Oct 2023 14:08:59 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CE0DC
        for <linux-s390@vger.kernel.org>; Sat, 21 Oct 2023 11:08:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9becde9ea7bso638483366b.0
        for <linux-s390@vger.kernel.org>; Sat, 21 Oct 2023 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697911731; x=1698516531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=riI2Gx31LBdznSH8wFDQvGpcc769IU1d5o0vtYVXSEA=;
        b=KMvsy6EU4n0p2WpDeLp+SohgzoPvSJzwXI4dewmNrdG0xxvGTFvfn9iTJ1rNVEyyTB
         Ji6MJDM9inBOyaXBXWFYHz7+wT0wolihUIOmFHp7ZnoNDoCVtksbObhiDD6cQZGiuPVG
         Iy/zr5uOoVV7cFY8CBFx1LJOvOw8aU7D0W9dU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697911731; x=1698516531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riI2Gx31LBdznSH8wFDQvGpcc769IU1d5o0vtYVXSEA=;
        b=Ns4xJFXskWX8WNahI7Q89tBH8pThQGu7nNMftqOwS3AK2XjOk2CiYjVkGsB1Dp0Jyk
         dT6oFuLEBuPhegj8/RxZrBaFCLzthyWeUDUc/mMg/Yjk0bpJNYxGznSxqKO1I1j6Krjw
         9+j5tgVW+HxIcfZhkBBh5CnlkR1J7/CEaLA+3xDcmgISha4sOzlNORm8/wZbEfvNAI0F
         d3z3psPV2hhknHzcu0NxM2Wv5YGyEsqlQyfqT4S0KsfPYbeTksxZrVlXcAr3dihJCLGl
         WTB9kHNof5C/DhMTqux32XBoyN2WKdmUqefzX+reil7XEXifomqZrhWFuKWrzhpR3qi2
         k/aA==
X-Gm-Message-State: AOJu0YxlTlRJZ2r0nlEsD30sfuoklWSq4HmV7/7R2SolcpAnTG/uqX4b
        JGnZNGexEmwbE40+9yVLh6nlFBx9UiZdWDmY4NeCRBjF
X-Google-Smtp-Source: AGHT+IHCFOxp1Kivq1heuyIBmx4koXglkvPYNTLtf91tXmjZxV5FVWoEM6lWEbOpSZMiXvtLr70MyQ==
X-Received: by 2002:a17:907:97cc:b0:9a5:9f3c:961e with SMTP id js12-20020a17090797cc00b009a59f3c961emr4921007ejc.18.1697911731401;
        Sat, 21 Oct 2023 11:08:51 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id v21-20020a170906489500b009b928eb8dd3sm3909906ejq.163.2023.10.21.11.08.48
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 11:08:48 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-53db3811d8fso4033270a12.1
        for <linux-s390@vger.kernel.org>; Sat, 21 Oct 2023 11:08:48 -0700 (PDT)
X-Received: by 2002:a50:d49e:0:b0:533:ccec:552 with SMTP id
 s30-20020a50d49e000000b00533ccec0552mr4827141edi.9.1697911728338; Sat, 21 Oct
 2023 11:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <your-ad-here.call-01697881440-ext-2458@work.hours> <CAHk-=wgTUz1bdY6zvsN4ED0arCLE8Sb==1GH8d0sjm5bu7zesQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgTUz1bdY6zvsN4ED0arCLE8Sb==1GH8d0sjm5bu7zesQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 21 Oct 2023 11:08:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxAk=PQBX4OvscNfGKfc+M8iKmNd6D39wOZzXV0k729w@mail.gmail.com>
Message-ID: <CAHk-=wjxAk=PQBX4OvscNfGKfc+M8iKmNd6D39wOZzXV0k729w@mail.gmail.com>
Subject: Re: [GIT PULL] s390 fixes for 6.6-rc7
To:     Vasily Gorbik <gor@linux.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Just re-quoting my suggestion here and adding Andy and Dmitry, who did
the original bitmap_alloc() helper interfaces a few years ago.

Also adding Kees in case he has any hardening suggestions, since this
is about (incorrect) overflow handling.

Kees: see my rant about mindlessly doing overflow handling in the wrong place in

   https://lore.kernel.org/all/CAHk-=wgTUz1bdY6zvsN4ED0arCLE8Sb==1GH8d0sjm5bu7zesQ@mail.gmail.com/

in case you or somebody has a better idea for BITS_TO_LONG handling
than just "you need to check for zero before and after".

             Linus

On Sat, 21 Oct 2023 at 10:56, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If you *do* want to add proper overflow handling, you'd need to either
> fix BITS_TO_LONGS() some way (which is actually non-trivial since it
> needs to be able to stay a constant and only use the argument once),
> or you do something like
>
>         if (!bits)
>                 return ZERO_SIZE_PTR;
>         longs = BITS_TO_LONG(bits);
>         if (!longs)
>                 return NULL;
>         return vzalloc(longs * sizeof(long));
>
> and I'd suggest maybe we should
>
>  (a) do the above checking in our bitmap_alloc() routines
>
>  (b) also change our bitmap_alloc() routines to take 'size_t' instead
> of 'unsigned int' bit counts
>
>  (c) and finally, add that vzalloc() case, but simply using
>
>         kvmalloc_array(n, size, flags | __GFP_ZERO);
>
> instead.
