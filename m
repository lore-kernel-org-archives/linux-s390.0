Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEEEC433F5
	for <linux-s390@archiver.kernel.org>; Thu, 10 Mar 2022 18:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238970AbiCJStG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 10 Mar 2022 13:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238331AbiCJStF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Mar 2022 13:49:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD7B03E0E4
        for <linux-s390@vger.kernel.org>; Thu, 10 Mar 2022 10:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646938082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IAMDDR/OlT3VUgZyoMb3yfhymErEdiK+nlypftXgzIc=;
        b=EC77DK2kCivl92+punPKvbL2aqH5ZUEKkBJ+0sxrqfGbzDEAGHScS2d/qPdrbTNZ6nJWms
        fuVccIgNv3U43wx96rlwu1RgDmQXEsqJJRz9Nv4exhFY/Pqr88l7wuGKeClR11MNTpxUtZ
        qsRn1dQjdnddRfg/VT5D63OJTfcWCCU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-JpS9ZvktPBG446uesPngvw-1; Thu, 10 Mar 2022 13:48:01 -0500
X-MC-Unique: JpS9ZvktPBG446uesPngvw-1
Received: by mail-wr1-f69.google.com with SMTP id p9-20020adf9589000000b001e333885ac1so1999436wrp.10
        for <linux-s390@vger.kernel.org>; Thu, 10 Mar 2022 10:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IAMDDR/OlT3VUgZyoMb3yfhymErEdiK+nlypftXgzIc=;
        b=gGOS1vD362VaP+cFk6TusEIHeSVDXOJU34yMeyb9QIE9lQZWhhaNF1TZK2JqIOErUS
         k6IrfFJr91ZMUkkePywXlfnwghm3TtX/V2HymaNy04FhNt94tJwN0nASQCntDefACwVd
         Aaffz7yDz4T/C+0yK4dlw1f5ic1xoz65m+DTuhAHr42LOCQm2Sajc0lufKu1IEWVYOoR
         xps84O1brOPPCj6C98sTCuhkMIqi2opvhyUQIonrnl1jBI7qcLSe22kxR7ijwdPCs4+c
         YwNbnuzkU46D9GyNL4PntAeMFjRnoVG/DuEXI+2YiOkKjk5cVyJmf0lySasS/ytAwPr6
         depw==
X-Gm-Message-State: AOAM531OgQ77CsJqYvQOT+YFXhUC32BI/vLeT/Xy0036m5J88EF9EW+P
        gZtruKMC5PnnWuXmLA6+Mff09swo1t17W0xYTzLn75j8cW2oIcNUHBIJfIPFqm2yvOKvc0uif+F
        XTWbTUYbflJaCZpZJfYir23NPSNeFiJkFyWBKZw==
X-Received: by 2002:a05:6000:154b:b0:203:7564:930 with SMTP id 11-20020a056000154b00b0020375640930mr4625772wry.349.1646938080537;
        Thu, 10 Mar 2022 10:48:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1y1c4l/wYGkW+ggwZo6uKhbBm9y9Jr+TggF7K0Kz6yMLtKELmt+rxnEHc+KJK41kda9Lif0f87yrE0QOxUj8=
X-Received: by 2002:a05:6000:154b:b0:203:7564:930 with SMTP id
 11-20020a056000154b00b0020375640930mr4625762wry.349.1646938080321; Thu, 10
 Mar 2022 10:48:00 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <02b20949-82aa-665a-71ea-5a67c1766785@redhat.com> <CAHk-=wiX1PspWAJ-4Jqk7GHig4B4pJFzPXU7eH2AYtN+iNVAeQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiX1PspWAJ-4Jqk7GHig4B4pJFzPXU7eH2AYtN+iNVAeQ@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 10 Mar 2022 19:47:48 +0100
Message-ID: <CAHc6FU6+y2ZGg3QnW9NLsj43vvDpAFu-pVBK-xTPfsDcKa39Mg@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Mar 10, 2022 at 7:36 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Mar 10, 2022 at 9:13 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > For the time being, the idea LGTM.
>
> I'll take that as an acked-by, and I think I'll just commit it to my
> real tree rather than delay this fix for the next merge window (only
> to have it then be marked as stable and applied that wat).

Works for me. This should probably still be tagged as:

Fixes: cdd591fc86e3 ("iov_iter: Introduce fault_in_iov_iter_writeable")
Cc: stable@vger.kernel.org # v5.16+

Thanks,
Andreas

