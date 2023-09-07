Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD54EC8726
	for <linux-s390@archiver.kernel.org>; Thu,  7 Sep 2023 18:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjIGSDG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 7 Sep 2023 14:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241371AbjIGSDE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Sep 2023 14:03:04 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A561FEA
        for <linux-s390@vger.kernel.org>; Thu,  7 Sep 2023 11:02:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bf1f632b8so158682766b.1
        for <linux-s390@vger.kernel.org>; Thu, 07 Sep 2023 11:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694109763; x=1694714563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hPr/PaYxGMdYMFVhUkN8avwnHv5koLDyq16882quvVs=;
        b=Rr2Zemtulye/lWWXa06FG3k1XRm+VmE+zVWUtEYXFjGAU0ZQXoPFanl7kHIsKDbMXk
         iadWQ2A9sZz9KtPeXbKvIDNj9Yg1xQQChiQYc85AqhIiU2qdd2bksWvwx/TM+by0KVEJ
         tmdFMbRDpkjeoJWQ3Yxr5wrP6BXL7lgz+Z2Ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694109763; x=1694714563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPr/PaYxGMdYMFVhUkN8avwnHv5koLDyq16882quvVs=;
        b=wEhLk62rKFkobfWvLwjaHTvsk/4PXQEfPujto+Sj/+sK7vJ+Ca6LZs5cUvIly90LyS
         +Y3t7wwmNUS9mgpDdulAinVapUuHZj5Myr4hBZodZGaLDER2LAAfJWhZszj4TBAl9Jmr
         9gZpXoiEtzHCoM5L+2tVuYs7JfNZDBRngaKTjqKEMbuIijprK61HlcwBG0yj144lLzE7
         ieX/ds89cNjrQDqtx04nqweNLFSjiWU6oQgsyI2ZOaAergUwQvzpR1f19b7CPRdhmfnd
         kQPjFIJCfNNZJu1Txo/M0292yMVKgFFAuRL7iOeP5tm1H/MyP+33XSR5VJCx1X+OPpxl
         y/Rg==
X-Gm-Message-State: AOJu0Yw8PHf3aJraOheAP2ynqZ13DF+M5WYV7urFLgY//Or4JAT2Qpcp
        rYWg+XS4z1pUe1QZvK453LOaPz5LQNp1QdSMD23CqooU
X-Google-Smtp-Source: AGHT+IH1NzMdWcFlyJvgCxUrl58uKCXrCElYaqMRMPYSx99KnWLnrj0YnqGgxjG/vnUb2RDTBiafkQ==
X-Received: by 2002:a17:907:7795:b0:9a1:db97:62a1 with SMTP id ky21-20020a170907779500b009a1db9762a1mr76291ejc.46.1694109762595;
        Thu, 07 Sep 2023 11:02:42 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id fx4-20020a170906b74400b009887f4e0291sm10676064ejb.27.2023.09.07.11.02.41
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 11:02:41 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-52a4737a08fso1640822a12.3
        for <linux-s390@vger.kernel.org>; Thu, 07 Sep 2023 11:02:41 -0700 (PDT)
X-Received: by 2002:a05:6402:1644:b0:522:29d3:4185 with SMTP id
 s4-20020a056402164400b0052229d34185mr44289edx.32.1694109760777; Thu, 07 Sep
 2023 11:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230907112743.6134-E-hca@linux.ibm.com>
In-Reply-To: <20230907112743.6134-E-hca@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Sep 2023 11:02:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZP5uKXLmunUNotMo0cXhz=un5BzB_fB4zaefVR2Ex2Q@mail.gmail.com>
Message-ID: <CAHk-=wgZP5uKXLmunUNotMo0cXhz=un5BzB_fB4zaefVR2Ex2Q@mail.gmail.com>
Subject: Re: [GIT PULL] more s390 updates for 6.6 merge window
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 7 Sept 2023 at 04:27, Heiko Carstens <hca@linux.ibm.com> wrote:
>
>   Note that the set_memory_xx() family comes with an int num_pages
>   parameter which overflows with 8TB. This could be addressed by
>   changing the num_pages parameter to unsigned long, however requires
>   to change all architectures, since the module code expects an int
>   parameter (see module_set_memory()).

Bah. We should just do this. Change the 'start' to a pointer, and
change the page count to 'unsigned long'.

Changing module_set_memory() to take the right kind of function
pointer looks trivial too.

I'm not even sure why we did that "unsigned long addr" thing, but I
assume it is because of our (very very _very_ old) historical
get_free_pages() model.

We should probably change get_free_pages() too, but that literally
goes back to linux-0.01. It's horrendously bad, but it's _very_
traditional, and it comes from the VM code historically using bitops
on the page pointers.

           Linus
