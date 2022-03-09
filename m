Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04811C433F5
	for <linux-s390@archiver.kernel.org>; Wed,  9 Mar 2022 21:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238357AbiCIVJt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Mar 2022 16:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiCIVJs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Mar 2022 16:09:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EFFCD86
        for <linux-s390@vger.kernel.org>; Wed,  9 Mar 2022 13:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646860128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MglxRBPyUbTeRJGcxsoUAZ8JhFWGp4eKx23qba031D0=;
        b=Jjgrouu57L8tzrxilLKFu2AWE5gZHciGWEr4eUwLPJcBRG4ipPzMDmmeer/bXUuLheEE5R
        dfCkcAF7Zs1+y5MKjpAzRlWx7gUvXYdq7inQekG2nErFk4RH4oug07GsCKycn9pWdLZJCz
        pfUMPFV9EJ8QuwPuyNA3mix97RE8Yk8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-psW6SV9WN1OuBU8Knk7O8Q-1; Wed, 09 Mar 2022 16:08:45 -0500
X-MC-Unique: psW6SV9WN1OuBU8Knk7O8Q-1
Received: by mail-wr1-f72.google.com with SMTP id a16-20020adff7d0000000b001f0473a6b25so1117933wrq.1
        for <linux-s390@vger.kernel.org>; Wed, 09 Mar 2022 13:08:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MglxRBPyUbTeRJGcxsoUAZ8JhFWGp4eKx23qba031D0=;
        b=RGacwWkC1buJo5Ml+t2o1kMpeR0fcK0uTT0o5Q2iRNhaMyf7oTx2k98ueNAkbsdk7G
         +dyZyrae8A7cw/gP43tPP8wJgVJS6WfJVhAA7Y4idf/ZbmZI2XmEy4VGXQdcHvS5OGU4
         qlfWAX9P4iYQdo/uD9Pjz+ndV8Picvy2nLTYbQNSfGS5r7Amj0TEXqw1N1nEwtS+THPK
         Mwn567eInch2sD4CDhuYziuhblau7woYFILmaD685d939orpJkOKBVejz3Qx31V6hXXJ
         sfmn9QZQq6DOcCKQcgaG8Db9vz0HJZTgCqbCcGyAnkLHjqOiPPxGWDveGGSOiXdWWroH
         UnXA==
X-Gm-Message-State: AOAM531WEhRKawoLNNORlSA7I4hg++5u86uusgfaqIpF5K/uNNu8f08O
        vI9a+k1MLJWiGMxzZzmtjhgA+3iO2vb0vx1tpI3MLakjmJhQ1oRb4oF2iZFNT6kI+yKBNmWP6YK
        rYR9cmpOoluP5QsfTss8G8k9u+cV1cFpVfDJkjg==
X-Received: by 2002:a05:600c:22cd:b0:389:c99a:45a4 with SMTP id 13-20020a05600c22cd00b00389c99a45a4mr1031349wmg.38.1646860124120;
        Wed, 09 Mar 2022 13:08:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7hkfjg0Oh5K+Q1w3HaqTFk5Ml3O3uxREayIyKT3hnlocfDzkhydhZe8v9YaMY9wEWxhSnFZjIW2JyrmqXnrw=
X-Received: by 2002:a05:600c:22cd:b0:389:c99a:45a4 with SMTP id
 13-20020a05600c22cd00b00389c99a45a4mr1031343wmg.38.1646860123956; Wed, 09 Mar
 2022 13:08:43 -0800 (PST)
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
Date:   Wed, 9 Mar 2022 22:08:32 +0100
Message-ID: <CAHc6FU5+AgDcoXE4Qfh_9hpn9d_it4aFyhoS=TKpqrBPe4GP+w@mail.gmail.com>
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
> > With a large enough buffer, a simple malloc() will return unmapped
> > pages, and reading into such a buffer will result in fault-in.  So page
> > faults during read() are actually pretty normal, and it's not the user's
> > fault.
>
> Agreed. But that wasn't the case here:
>
> > In my test case, the buffer was pre-initialized with memset() to avoid
> > those kinds of page faults, which meant that the page faults in
> > gfs2_file_read_iter() only started to happen when we were out of memory.
> > But that's not the common case.
>
> Exactly. I do not think this is a case that we should - or need to -
> optimize for.
>
> And doing too much pre-faulting is actually counter-productive.
>
> > * Get rid of max_size: it really makes no sense to second-guess what the
> >   caller needs.
>
> It's not about "what caller needs". It's literally about latency
> issues. If you can force a busy loop in kernel space by having one
> unmapped page and then do a 2GB read(), that's a *PROBLEM*.
>
> Now, we can try this thing, because I think we end up having other
> size limitations in the IO subsystem that means that the filesystem
> won't actually do that, but the moment I hear somebody talk about
> latencies, that max_size goes back.

Thanks, this puts fault_in_safe_writeable() in line with
fault_in_readable() and fault_in_writeable().

There currently are two users of
fault_in_safe_writeable()/fault_in_iov_iter_writeable(): gfs2 and
btrfs.
In gfs2, we cap the size at BIO_MAX_VECS pages (256). I don't see an
explicit cap in btrfs; adding Filipe.

Andreas

