Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82367C433F5
	for <linux-s390@archiver.kernel.org>; Wed,  9 Mar 2022 20:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbiCIUt0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Mar 2022 15:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbiCIUtX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Mar 2022 15:49:23 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D867436301
        for <linux-s390@vger.kernel.org>; Wed,  9 Mar 2022 12:48:23 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bu29so6009165lfb.0
        for <linux-s390@vger.kernel.org>; Wed, 09 Mar 2022 12:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGqeo2LtdIlvNqnd6R2s5eetiuT+hRt9mmDkO0Tckbg=;
        b=PWCsZlVycSx5+VU2FvKPokNaZvFARLZhdR+NloChOOsE5FG1pZlOARqcts3qtbEfiV
         Jac1mG8KWnbOw9MoSqlVRYlGu7wFIW/+vbmcBNGZj0T73vPlbfb4IVtymATFS/oyXcfM
         wPhJl5v4zoMSVNsy37CGUm/kJgR6HBdYc0ick=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGqeo2LtdIlvNqnd6R2s5eetiuT+hRt9mmDkO0Tckbg=;
        b=v3Ih3N0v44WYdAH/+9NN0I2VxO2ZRjrpsHdcEhH7o6+OcjSjBZEo8XisYALyAPd+WJ
         UbyvoPdr60R7KcZ7qHPC5BXAsw6D/HCndUrDzBEs4nGVwKvMtMoS3v2Vb9PUOAw+8RTl
         max8YFt0M+//+kQXoYG6XR62zODQDirtho779Xe80q5qZfSNv5OE5sMAMmdM44HUbdf3
         FREIBcY2c1kjOKijsJ2WGzYd+AnjMTcKh6WBKB+wIMuxxnVKEQ+kwHAaSurip33Q3IOl
         G2OTw2NnzBR8DiAtSr1ih+VZtropi1HzgDiLWlN+n7woWq34zi/nsHMoQCH8/K6MfwuZ
         MVvA==
X-Gm-Message-State: AOAM531LnrbJQKG7Z6TkYvAnGApa49XWmc0MndkptHRbmbYUR0b9cc5X
        lB64JbuBZBz5Akd8edNdhNM2yt7WCL4vWWbGAeE=
X-Google-Smtp-Source: ABdhPJzWgzQkhua/snJWZ7FY2M8x7NgVL7ONFuKzswnF2OAVdkIrQlceKgSIHmAui7QNQrzpMgJSJg==
X-Received: by 2002:a19:4941:0:b0:445:8fd5:5cea with SMTP id l1-20020a194941000000b004458fd55ceamr884791lfj.179.1646858901600;
        Wed, 09 Mar 2022 12:48:21 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id bt23-20020a056512261700b0044400161095sm578065lfb.168.2022.03.09.12.48.19
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 12:48:19 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id r7so5917954lfc.4
        for <linux-s390@vger.kernel.org>; Wed, 09 Mar 2022 12:48:19 -0800 (PST)
X-Received: by 2002:ac2:41cf:0:b0:448:1eaa:296c with SMTP id
 d15-20020ac241cf000000b004481eaa296cmr917150lfi.52.1646858899041; Wed, 09 Mar
 2022 12:48:19 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <CAHk-=wi1jrn=sds1doASepf55-wiBEiQ_z6OatOojXj6Gtntyg@mail.gmail.com>
 <CAHc6FU6L8c9UCJF_qcqY=USK_CqyKnpDSJvrAGput=62h0djDw@mail.gmail.com>
 <CAHk-=whaoxuCPg4foD_4VBVr+LVgmW7qScjYFRppvHqnni0EMA@mail.gmail.com>
 <20220309184238.1583093-1-agruenba@redhat.com> <CAHk-=wixOLK1Xp-LKhqEWEh3SxGak_ziwR0_fi8uMzY5ZYBzbg@mail.gmail.com>
 <CAHc6FU6aqqYO4d5x3=73bxr+9yfL6CLJeGGzFwCZCy9wzApgwQ@mail.gmail.com>
 <CAHk-=wj4Av2gecvTfExCq-d2cXx0m7fdO0sG6JC1DxdCCDT7ig@mail.gmail.com> <CAHc6FU4uzG+HR1doK5p+6kVW9GS0JGbCrbZnAvBhWuLZe8DGUw@mail.gmail.com>
In-Reply-To: <CAHc6FU4uzG+HR1doK5p+6kVW9GS0JGbCrbZnAvBhWuLZe8DGUw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Mar 2022 12:48:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=whycC7kUa=_CiDr9pPpPp8g+9u7kKe1ssSsgGGkhBTvVg@mail.gmail.com>
Message-ID: <CAHk-=whycC7kUa=_CiDr9pPpPp8g+9u7kKe1ssSsgGGkhBTvVg@mail.gmail.com>
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

On Wed, Mar 9, 2022 at 12:37 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> It's a moot point now, but I don't think handle_mm_fault would have
> returned VM_FAULT_RETRY without FAULT_FLAG_ALLOW_RETRY, so there
> wouldn't have been any NULL pointer accesses.

No, it really does - FAULT_FLAG_KILLABLE will trigger the code in
page_lock_or_retry() (->__folio_lock_or_retry) even without
FAULT_FLAG_ALLOW_RETRY.

So lock_page_or_retry() will drop the mmap_sem and return false, and
then you have

        locked = lock_page_or_retry(page, vma->vm_mm, vmf->flags);

        if (!locked) {
                ret |= VM_FAULT_RETRY;
                goto out_release;
        }

for the swapin case.

And mm/filemap.c has essentially the same logic in
lock_folio_maybe_drop_mmap(), although the syntax is quite different.

Basically FAULT_FLAG_KILLABLE implies a kind of "half-way ALLOW_RETRY"
- allow aborting, but only for the fatal signal case.

                  Linus
