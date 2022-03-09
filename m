Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01851C4332F
	for <linux-s390@archiver.kernel.org>; Wed,  9 Mar 2022 19:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbiCITgv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237900AbiCITgu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Mar 2022 14:36:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92937113E
        for <linux-s390@vger.kernel.org>; Wed,  9 Mar 2022 11:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646854550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZS3I81Galj1GdO7UYd+sKCoSNlGOUGVoOsBzPkL9oAw=;
        b=iEtj32OTn9ctO+ZnWygUykmMJhArPwTChZV24XfHfAbUFwiCtnSjjfWSx2WiC/Csh0oFD2
        q790l0/OxiWgsdab1rD9eebia8d5dTB2zdDBL/65egivI3C4oU3RObTB385IZM81/yeCkJ
        FQFxOGhsXifcAUWAEsxmTQcSdrg9keA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-DQLlDeipOjiMv88HGIYCwg-1; Wed, 09 Mar 2022 14:35:49 -0500
X-MC-Unique: DQLlDeipOjiMv88HGIYCwg-1
Received: by mail-wm1-f71.google.com with SMTP id 14-20020a05600c104e00b003897a167353so1323829wmx.8
        for <linux-s390@vger.kernel.org>; Wed, 09 Mar 2022 11:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZS3I81Galj1GdO7UYd+sKCoSNlGOUGVoOsBzPkL9oAw=;
        b=6VyJV77jJ7gOunvJi1L6CdfTsgOGKPCw14AEqkDtBjBMDCoesVMp9x80xijrAr2wSm
         cY8NGSRh6JDWe5jN/DGJdJZMq0McpE0B5R5IDB5Yv5mtkABcWcEq8BikgQa9CEYhpM13
         6QaAftnt3IoDiluC1LsMRlhuxZu0ITWOUxIBnIk45XAAqr5XHY+gFJSnWVBUtxPsNep3
         +UiHV7frmULiBbKxCImq7xAK2Ge+iKWjgumXWHt/yIEeq3sTGiYLvif5cEo8sF8lIopY
         T+YjofjZTU9ii1xUx4oBwpdAl9ouxCVt60fGhPp4MfPdqWFgkvPw1hvNEYbQo8i3S24V
         TIVQ==
X-Gm-Message-State: AOAM530KnzdsPbKqpbEHIvLvo/STE0VvMxY+wVPdB2/7WEhjlmWwdqPC
        Fov6LrvxHUsPqQDItCkYgPUSmOEYM1eahO3bmnRaI2hUgsJvIppuadqxVWRVvwP90fVnror0A89
        P6XJ0Q+3x3XgXajHSXjDoNciT7FsCUtmARlSEYQ==
X-Received: by 2002:a05:6000:10c6:b0:1f1:e562:bee2 with SMTP id b6-20020a05600010c600b001f1e562bee2mr892438wrx.654.1646854547804;
        Wed, 09 Mar 2022 11:35:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0la76JJIHCiuuXGNz+2k1My92hBu1ArSVMN8GhFQj6QO8YhMJVj5DYkOvqpLnFDQ4NiVOIlnzHU+c6/gk5RQ=
X-Received: by 2002:a05:6000:10c6:b0:1f1:e562:bee2 with SMTP id
 b6-20020a05600010c600b001f1e562bee2mr892423wrx.654.1646854547635; Wed, 09 Mar
 2022 11:35:47 -0800 (PST)
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
In-Reply-To: <CAHk-=wixOLK1Xp-LKhqEWEh3SxGak_ziwR0_fi8uMzY5ZYBzbg@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 9 Mar 2022 20:35:36 +0100
Message-ID: <CAHc6FU6aqqYO4d5x3=73bxr+9yfL6CLJeGGzFwCZCy9wzApgwQ@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
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

On Wed, Mar 9, 2022 at 8:22 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Mar 9, 2022 at 10:42 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > +       while (start != end) {
> > +               if (fixup_user_fault(mm, start, fault_flags, NULL))
> > +                       goto out;
> > +               start += PAGE_SIZE;
> > +       }
> > +       mmap_read_unlock(mm);
> > +
> > +out:
> > +       if (size > (unsigned long)uaddr - start)
> > +               return size - ((unsigned long)uaddr - start);
> > +       return 0;
> >  }
>
> What?
>
> That "goto out" is completely broken. It explicitly avoids the
> "mmap_read_unlock()" for some reason I can't for the life of me
> understand.
>
> You must have done that on purpose, since a simple "break" would have
> been the sane and simple thing to do, but it looks *entirely* wrong to
> me.

Ouch, that was stupid. Same for the "return size".

> I think the whole loop should just be
>
>         mmap_read_lock(mm);
>         do {
>                 if (fixup_user_fault(mm, start, fault_flags, NULL))
>                         break;
>                 start = (start + PAGE_SIZE) & PAGE_MASK;
>
>         } while (start != end);
>         mmap_read_unlock(mm);
>
> which also doesn't need that first unlooped iteration (not that I
> think that passing in the non-masked starting address for the first
> case actually helps, but that's a different thing).

That's better, thanks.

Andreas

