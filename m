Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AB8C433F5
	for <linux-s390@archiver.kernel.org>; Wed,  9 Mar 2022 20:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbiCIUiC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Mar 2022 15:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiCIUiB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Mar 2022 15:38:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF09912604
        for <linux-s390@vger.kernel.org>; Wed,  9 Mar 2022 12:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646858220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tfvPp8T6sBDgCD/bU6cj7d0QWkoleA0xgC26OnRlcVg=;
        b=KFfzsgCbNlLH0ViE0M+FW3IU+TSp7nXLrTKNW1SfzoZUPC9hLj4Yudo3FZLzqb2pPmpmYA
        bnw8IVghWI73LXc9Lq292wr7xIEJWayBhoulgPfJg9yZpcxuDPjNSSMgmBdLCzN1ObBAgI
        krKSFUjNtXY8d2x8Fwr3nuEfyUY6VvM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-vRcIjY02MKK92VNBQUqv-Q-1; Wed, 09 Mar 2022 15:36:59 -0500
X-MC-Unique: vRcIjY02MKK92VNBQUqv-Q-1
Received: by mail-wr1-f72.google.com with SMTP id y13-20020adfee0d000000b001f1fa450a3dso1111983wrn.11
        for <linux-s390@vger.kernel.org>; Wed, 09 Mar 2022 12:36:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tfvPp8T6sBDgCD/bU6cj7d0QWkoleA0xgC26OnRlcVg=;
        b=XNjCa5jLDRc98CUjil5BKQflXxLIZfvfp2Wd9lHM4AnYOk1yMZo0Lx3wdp/npYLtLb
         TbyWLBD7z3KMuEPJMxmCZibCrItv4Br+e4zqh36k/xxnlbYQL5idhZz37SA++FBURfjq
         izSEEp2orF7jaLjnhljbMrzaCy/Ct1CzbLF8X2YNm4ffwkYU7od8bZlOOVS5iY/yNuMz
         KZ1jEWxvZ4pKJrur7MP3tLEuovSGfcTvH0NdAlUcYGmKvzTY4hgPgG0SfATnN50nw42e
         nIYmZVu9kqAXaM+A890gYhVWotjq85nTjsv05LgBK14SmA4rmA6u3pU4UpM3HOkf9cSa
         HLOg==
X-Gm-Message-State: AOAM5305r7MS/3ilx/IPSFPplnfANswfXyN9q7PG5Ax/EwG6Vlx6Lael
        2p2p0pmSBd08jWi4yz8j8ykl6G8EvZQghu5EfZTuKW0izobDre7xse/smOmq8AXughRzmeXQd+k
        9WEb4rDJExPwqEo6K8Qy7t0WVrDbyUnzx1uDmLA==
X-Received: by 2002:a1c:e90a:0:b0:381:504e:b57d with SMTP id q10-20020a1ce90a000000b00381504eb57dmr8983122wmc.177.1646858215117;
        Wed, 09 Mar 2022 12:36:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxslNgqul7CsdHPFzrY6nugLgNmi6JeFFMtWCGzEmkIP6sbUIPjlerK4tjyTPW31RtVNkdst4BOmhD7u76G54o=
X-Received: by 2002:a1c:e90a:0:b0:381:504e:b57d with SMTP id
 q10-20020a1ce90a000000b00381504eb57dmr8983106wmc.177.1646858214930; Wed, 09
 Mar 2022 12:36:54 -0800 (PST)
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
 <CAHc6FU6aqqYO4d5x3=73bxr+9yfL6CLJeGGzFwCZCy9wzApgwQ@mail.gmail.com> <CAHk-=wj4Av2gecvTfExCq-d2cXx0m7fdO0sG6JC1DxdCCDT7ig@mail.gmail.com>
In-Reply-To: <CAHk-=wj4Av2gecvTfExCq-d2cXx0m7fdO0sG6JC1DxdCCDT7ig@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 9 Mar 2022 21:36:43 +0100
Message-ID: <CAHc6FU4uzG+HR1doK5p+6kVW9GS0JGbCrbZnAvBhWuLZe8DGUw@mail.gmail.com>
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

On Wed, Mar 9, 2022 at 9:19 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Mar 9, 2022 at 11:35 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > That's better, thanks.
>
> Ok, can you give this one more test?
>
> It has that simplified loop, but it also replaced the
> FAULT_FLAG_KILLABLE with just passing in 'unlocked'.
>
> I thought I didn't need to do that, but the "retry" loop inside
> fixup_user_fault() will actually set that 'unlocked' thing even if the
> caller doesn't care whether the mmap_sem was unlocked during the call,
> so we have to pass in that pointer just to get that to work.
>
> And we don't care if mmap_sem was dropped, because this loop doesn't
> cache any vma information or anything like that, but we don't want to
> get a NULL pointer oops just because fixup_user_fault() tries to
> inform us about something we don't care about ;)

It's a moot point now, but I don't think handle_mm_fault would have
returned VM_FAULT_RETRY without FAULT_FLAG_ALLOW_RETRY, so there
wouldn't have been any NULL pointer accesses.

> That incidentally gets us FAULT_FLAG_ALLOW_RETRY too, which is
> probably a good thing anyway - it means that the mmap_sem will be
> dropped if we wait for IO. Not likely a huge deal, but it's the
> RightThing(tm) to do.

Looking good.

> So this has some other changes there too, but on the whole the
> function is now really quite simple. But it would be good to have one
> final round of testing considering how many small details changed..

Sure, we'll put it through all our tests.

Thanks,
Andreas

