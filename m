Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB44CC433EF
	for <linux-s390@archiver.kernel.org>; Tue,  8 Mar 2022 17:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345761AbiCHRlh (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 8 Mar 2022 12:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238659AbiCHRlg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Mar 2022 12:41:36 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C4F4A925
        for <linux-s390@vger.kernel.org>; Tue,  8 Mar 2022 09:40:39 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id r7so17838851lfc.4
        for <linux-s390@vger.kernel.org>; Tue, 08 Mar 2022 09:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j4HcIA5ZURFOUl98GOVrefN75djtXjyZm8o/dMFbKz8=;
        b=XUxN+P64bilcPljqWgWX3wqVnw3FZMXB5ZH4wIfuAfuPKU8hucKGsVwl/+klugjHvC
         xd1iG9Sq95/OIhQAcijP56EOmxpcFGCDgrpONQjnZ4xtLxScBr0K/bZ22n0j5UyeCIsH
         RdkV3T99Y854qU87ErGuLfUzTChN5wVlQfXLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j4HcIA5ZURFOUl98GOVrefN75djtXjyZm8o/dMFbKz8=;
        b=br3g6yVODn7mxpovhbkbxsNjtI6MRhl4ATAvNa4+Wh4+44KjFe7qafErA7TYcHJTVR
         cLDAp0tr4AjpGCssx/aiLLCiEkppYB360Wm5ztv6IsC3YZgi7+6hYTakxHkMU60vzgOx
         k8HTz9tKfi2csE7BDkIB6Zms4bp9srZ6zmkmjVcULBN09PFwJ+ASF8NX7jKoCr28o8Ge
         RlBDHT9HEC6xsTwd2q7UkPjOcNwpfUVqB33rDL7i6JddQHXOPTPuPbWdROYL/X93fwfJ
         +xO79PXv+QfLUUUFFE+Hup41TZmGeTc2NGnt0g3vES0MuSSZ5mmqDHuOX+QKPCA1od2S
         WuLA==
X-Gm-Message-State: AOAM533Z7mSOXIuHBJbZwVDFPoCVDNpSBPHWPchcudjqSfxJduwwDk2k
        h80sMmedoA5rPM2PfQin0T/gXZ1//4JD+S/HEP0=
X-Google-Smtp-Source: ABdhPJzM8DPhfjffNJjfsTtb5Afe8YiUXADVRfV/Mx7S+K2EjkDRBV1dWQ2xhPPc0mF+hngL25kMeA==
X-Received: by 2002:a05:6512:a81:b0:445:c06b:a531 with SMTP id m1-20020a0565120a8100b00445c06ba531mr11711885lfu.364.1646761234350;
        Tue, 08 Mar 2022 09:40:34 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id h7-20020ac25d67000000b0044836d7c475sm947936lft.147.2022.03.08.09.40.32
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 09:40:33 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id g39so33540586lfv.10
        for <linux-s390@vger.kernel.org>; Tue, 08 Mar 2022 09:40:32 -0800 (PST)
X-Received: by 2002:a19:e048:0:b0:448:2caa:7ed2 with SMTP id
 g8-20020a19e048000000b004482caa7ed2mr8519640lfj.449.1646761232492; Tue, 08
 Mar 2022 09:40:32 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Mar 2022 09:40:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
Message-ID: <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     David Hildenbrand <david@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Mar 8, 2022 at 9:26 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Your actual patch looks pretty nasty, though. We avoid marking it
> accessed on purpose (to avoid atomicity issues wrt hw-dirty bits etc),
> but still, that patch makes me go "there has to be a better way".

That better way might be to make q() not use GUP at all.

It doesn't want the page - it just wants to make sure the fault is
handled. For the fault_in_readable() case we already just do the user
access.

The only reason we don't do that for fault_in_safe_writeable() is that
we don't have a good non-destructive user write.

Hmm. The futex code actually uses "fixup_user_fault()" for this case.
Maybe fault_in_safe_writeable() should do that?

                            Linus
