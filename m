Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6063C433F5
	for <linux-s390@archiver.kernel.org>; Wed,  9 Mar 2022 19:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbiCITXx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbiCITXG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Mar 2022 14:23:06 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B56111DE6
        for <linux-s390@vger.kernel.org>; Wed,  9 Mar 2022 11:22:05 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id z9-20020a05683020c900b005b22bf41872so2446798otq.13
        for <linux-s390@vger.kernel.org>; Wed, 09 Mar 2022 11:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ajLEFScnY86/X/EB8VAWpPjqAUDRsUx1SOK3GF+S0iU=;
        b=Cuk6Sng0QFnBDMPD4pR668XwH3FXBI3EMDZfCqt6dtxF/NuSWNh3h1+I3HfiI2pGYQ
         c/SsCOHPaJEvqcjKMav3VmIw6hIsfBUZ4mCARDwrbjXf+7pyS5TGRdG2tVkLYWv5OqXN
         shhUSQZ5Gtzf+yFxJCIsagC3oPy0PNljar1IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajLEFScnY86/X/EB8VAWpPjqAUDRsUx1SOK3GF+S0iU=;
        b=jF1c1uxphm5gy0QWggXZjb13vQXpLdOx7XyQlAK7msnjdFcaHP5p1R6USVHa9C8Q/4
         MPeqnwp467CVtplzy7Q1hn3HLzpaUQFBDmEv+ZyFqdSCVvVgai5pGFhtM4al2I3Mq8Gt
         QjkjX11gmwLOsW9pXwLf+DvUGoB3lXqI0HwJdZO3lAEd1kwV2oO2gYncsgbKZ2HqY8c5
         yYJG+49ZfMun1LDHx2f21ABfWBBK0i0DX4hgg4sl15qFzYomeCCe3EsoqHXBkJUIJJUa
         NNnl7BfGF53jgLq91maDiFwPkNJM1bEHsraAg3sOmwjuIHIZ7nE629+TISNKL8Ir/wSl
         kvGQ==
X-Gm-Message-State: AOAM530MtdqHBl7ryCpXTB9Rk2WNOMRX8mGCxQXd/X+y9pEb4N4PXdIQ
        Gr1tg4U8FiCjy/RZNPouqyTNSCPsEPLC+jrEpX0=
X-Google-Smtp-Source: ABdhPJy31KYUK87dC9H333xDyTAQQjDYUz+w++8aD5L8VFhx4Q1bzqOjqr4Xvo3xxaYLEFsYqmbc/Q==
X-Received: by 2002:a9d:6285:0:b0:5b2:5993:a180 with SMTP id x5-20020a9d6285000000b005b25993a180mr704075otk.168.1646853724848;
        Wed, 09 Mar 2022 11:22:04 -0800 (PST)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id e17-20020a9d7311000000b005b23b11fed3sm1281178otk.70.2022.03.09.11.22.02
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 11:22:03 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id 12so3651160oix.12
        for <linux-s390@vger.kernel.org>; Wed, 09 Mar 2022 11:22:02 -0800 (PST)
X-Received: by 2002:a05:6808:2209:b0:2d5:1bb4:bb37 with SMTP id
 bd9-20020a056808220900b002d51bb4bb37mr702760oib.53.1646853722554; Wed, 09 Mar
 2022 11:22:02 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <CAHk-=wi1jrn=sds1doASepf55-wiBEiQ_z6OatOojXj6Gtntyg@mail.gmail.com>
 <CAHc6FU6L8c9UCJF_qcqY=USK_CqyKnpDSJvrAGput=62h0djDw@mail.gmail.com>
 <CAHk-=whaoxuCPg4foD_4VBVr+LVgmW7qScjYFRppvHqnni0EMA@mail.gmail.com> <20220309184238.1583093-1-agruenba@redhat.com>
In-Reply-To: <20220309184238.1583093-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Mar 2022 11:21:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wixOLK1Xp-LKhqEWEh3SxGak_ziwR0_fi8uMzY5ZYBzbg@mail.gmail.com>
Message-ID: <CAHk-=wixOLK1Xp-LKhqEWEh3SxGak_ziwR0_fi8uMzY5ZYBzbg@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Mar 9, 2022 at 10:42 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> +       while (start != end) {
> +               if (fixup_user_fault(mm, start, fault_flags, NULL))
> +                       goto out;
> +               start += PAGE_SIZE;
> +       }
> +       mmap_read_unlock(mm);
> +
> +out:
> +       if (size > (unsigned long)uaddr - start)
> +               return size - ((unsigned long)uaddr - start);
> +       return 0;
>  }

What?

That "goto out" is completely broken. It explicitly avoids the
"mmap_read_unlock()" for some reason I can't for the life of me
understand.

You must have done that on purpose, since a simple "break" would have
been the sane and simple thing to do, but it looks *entirely* wrong to
me.

I think the whole loop should just be

        mmap_read_lock(mm);
        do {
                if (fixup_user_fault(mm, start, fault_flags, NULL))
                        break;
                start = (start + PAGE_SIZE) & PAGE_MASK;
        } while (start != end);
        mmap_read_unlock(mm);

which also doesn't need that first unlooped iteration (not that I
think that passing in the non-masked starting address for the first
case actually helps, but that's a different thing).

                 Linus
