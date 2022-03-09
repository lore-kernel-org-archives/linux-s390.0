Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89D6C433FE
	for <linux-s390@archiver.kernel.org>; Wed,  9 Mar 2022 20:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbiCIU6s (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Mar 2022 15:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbiCIU6s (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Mar 2022 15:58:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8664B220EF
        for <linux-s390@vger.kernel.org>; Wed,  9 Mar 2022 12:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646859467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xw6hw1HS79I7piNNK9ZnlZMSG43eCGoaiA/W2f4I5E0=;
        b=If8jyOiU+JaDOLnvzRlKG4f4EfktQNNqqSNYqgkzRsQcMWkp3L2J7vMGL6zlEfB7Kz3iSH
        hMPuFDMoG3yDWP7gDUzxsDX5iydpTUIksC2EGYMC/od+4H9vTfoeX3c2GFIQB7rE+wPtL4
        DR64kbssyToIDTstVlRKwwHreiG0n/k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-6Y4IQ0PjNXWIblifNhzu3Q-1; Wed, 09 Mar 2022 15:57:46 -0500
X-MC-Unique: 6Y4IQ0PjNXWIblifNhzu3Q-1
Received: by mail-wm1-f71.google.com with SMTP id v125-20020a1cac83000000b0037e3d70e7e1so3109143wme.1
        for <linux-s390@vger.kernel.org>; Wed, 09 Mar 2022 12:57:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xw6hw1HS79I7piNNK9ZnlZMSG43eCGoaiA/W2f4I5E0=;
        b=betaI7WGSfZ+BRhARj/O3oPw/Xg0/MH6oFYKO3b7Pw3KH3MYn3gngYl3iakIdfxKtl
         5hWJwXM4s5AH2fRHiLTVdDumeMrNVkUI/vEJK98HJTz8DsX5SG/TSBCX2xLWOtBQLusj
         wXARtiJwJs9Pn6p37SkcxV0ngV54ZvU28+XezybT4csJ9HLIRRIR9TKQ+QCHlTgl32mC
         sF7A+ZKqh9EiWW2Nn64JSJAYg0SLDwpWIkIj6IbvQDg8PFcWkvRvL4a7HdoGbK2velUX
         mztqKirjRhPwhoe8Ee/4d/sCyoTYzl15snXLf+TdjSBjdmNrz5NDZIm6Fj5Yt5i5THtE
         bGqg==
X-Gm-Message-State: AOAM532D35xYFZ9xndQcCmS0QnRqirMsAP/02+D9N3yUmzKX5k7Ehi9T
        YtqvDjNB2JbSt2TtN99C/+7kuxZSWcf/NhN3IAMUHFmdj+NvNDljc/fPN065EZKMP78NaHw2LY0
        QEAs6o+wCALn2Lqyo16mVDU5L2W0BWi9suzeyXw==
X-Received: by 2002:a05:600c:4a12:b0:389:9c7d:5917 with SMTP id c18-20020a05600c4a1200b003899c7d5917mr997966wmp.0.1646859464895;
        Wed, 09 Mar 2022 12:57:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkBn5sHebB/8AskukJ70ApHkZsY22IFF92X45WXzmERVLwWMLiZIb0VspQbtQmg8kWGP6WnrmcmRq5iZFnoK0=
X-Received: by 2002:a05:600c:4a12:b0:389:9c7d:5917 with SMTP id
 c18-20020a05600c4a1200b003899c7d5917mr997951wmp.0.1646859464684; Wed, 09 Mar
 2022 12:57:44 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <CAHk-=wi1jrn=sds1doASepf55-wiBEiQ_z6OatOojXj6Gtntyg@mail.gmail.com>
 <CAHc6FU6L8c9UCJF_qcqY=USK_CqyKnpDSJvrAGput=62h0djDw@mail.gmail.com>
 <CAHk-=whaoxuCPg4foD_4VBVr+LVgmW7qScjYFRppvHqnni0EMA@mail.gmail.com>
 <20220309184238.1583093-1-agruenba@redhat.com> <CAHk-=wgBOFg3brJbo-gcaPM+fxjzHwC4efhcM8tCKK3YUhYUug@mail.gmail.com>
In-Reply-To: <CAHk-=wgBOFg3brJbo-gcaPM+fxjzHwC4efhcM8tCKK3YUhYUug@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 9 Mar 2022 21:57:32 +0100
Message-ID: <CAHc6FU4ix3bv20XeBEPaTsLZhKMn25DkcXBQNaVE-hqV7s677Q@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Filipe Manana <fdmanana@suse.com>
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

On Wed, Mar 9, 2022 at 8:08 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Mar 9, 2022 at 10:42 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > From what I took from the previous discussion, probing at a sub-page
> > granularity won't be necessary for bytewise copying: when the address
> > we're trying to access is poisoned, fault_in_*() will fail; when we get
> > a short result, that will take us to the poisoned address in the next
> > iteration.
>
> Sadly, that isn't actually the case.
>
> It's not the case for GUP (that page aligns things), and it's not the
> case for fault_in_writeable() itself (that also page aligns things).

As long as the fault_in_*() functions probe the exact start address,
they will detect when that address is poisoned. They can advance
page-wise after that and it doesn't matter if they skip poisoned
addresses. When the memory range is then accessed, that may fail at a
poisoned address. The next call to fault_in_*() will be with that
poisoned address as the start address.

So it's the unaligned probing at the start in the fault_in_*()
functions that's essential, and fault_in_readable(),
fault_in_writeable(), and fault_in_safe_writeable() now all do that
probing.

> But more importantly, it's not actually the case for the *users*
> either. Not all of the users are byte-stream oriented, and I think it
> was btrfs that had a case of "copy a struct at the beginning of the
> stream". And if that copy failed, it wouldn't advance by as many bytes
> as it got - it would require that struct to be all fetched, and start
> from the beginning.
>
> So we do need to probe at least a minimum set of bytes. Probably a
> fairly small minimum, but still...

There are only a few users like that, and they can be changed to pass
back the actual address that fails so that that address can be probed
instead of probing every 128 bytes of the entire buffer on arm64.

Thanks,
Andreas

