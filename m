Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51FAC433EF
	for <linux-s390@archiver.kernel.org>; Thu, 10 Mar 2022 18:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245488AbiCJShN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 10 Mar 2022 13:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239592AbiCJShK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Mar 2022 13:37:10 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D49619D62E
        for <linux-s390@vger.kernel.org>; Thu, 10 Mar 2022 10:36:04 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id s25so10949970lfs.10
        for <linux-s390@vger.kernel.org>; Thu, 10 Mar 2022 10:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HpDrnPsAS8jhlqYsqpbk9Izj3698daXGmE+RS1//HxY=;
        b=UHy+dCOsa7FxiysvXGca8RRowRTsb+f9K8Y3q8uZRNidfKjZtYAUOhcwjei9ga9XcG
         +wtfxkazx1v2io2rfqD4ScGtNVv/JKMBAdplcBAzMMDJY/vbaSujZBBOR2CO/SDZU84T
         fnXVL4ZsOedT/Slbwc+d3/f0+tdUx2v0gDo5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HpDrnPsAS8jhlqYsqpbk9Izj3698daXGmE+RS1//HxY=;
        b=6JwAyfIuVJEys0qrzeP7U6jFBlUDdtd6B/T3KkvEIXLAGhxguKNiE4qqYVlCt05np2
         HQahI+DpNhCrbzGet0NQMOYVCIl2YfCFrGlCMlvoijSIILjbm1gBFGlUgHB0L2ZOPOSk
         xrLTlxoAe3lj1VaUFd2ZPVswvwJSPSH7nrkyKUb7DEQt3Z6vj7eXfY9cuuQVpua0HGOK
         HUH5847Ycrc31BIZvsAt3J6V0asx/6oDhn3pafgEvCoDwbS7VF2QH6HXsw4XwCLoOcaB
         vXw/vYE9Q4gExxIIGKrkkHTR8UA52r6uinM8ccnxigC0UM7xNXcQ/jtNLWbKLz/yPf8H
         m4Bg==
X-Gm-Message-State: AOAM530mRkfxMI6ZwYQRM8SEqtmBUXYHEgheZH9eNfz/Iv5gnhnpoGwn
        UHuupZVf2Y4RHvNurptOIic3n39ghnitbcbU/pk=
X-Google-Smtp-Source: ABdhPJya2DWXsMNK38FfalPpOdN6VW2jyf7TD4Uuq3WPWD5zHYX8qeloaeb4y+IZRNZSHT9fqX1ORA==
X-Received: by 2002:a05:6512:1698:b0:445:bc1d:3835 with SMTP id bu24-20020a056512169800b00445bc1d3835mr3647991lfb.122.1646937362578;
        Thu, 10 Mar 2022 10:36:02 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 194-20020a2e05cb000000b00247eb0e1b15sm1222575ljf.97.2022.03.10.10.36.01
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 10:36:01 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id r7so10998035lfc.4
        for <linux-s390@vger.kernel.org>; Thu, 10 Mar 2022 10:36:01 -0800 (PST)
X-Received: by 2002:a05:6512:e8a:b0:443:7b8c:579a with SMTP id
 bi10-20020a0565120e8a00b004437b8c579amr3725894lfb.687.1646937361137; Thu, 10
 Mar 2022 10:36:01 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com> <02b20949-82aa-665a-71ea-5a67c1766785@redhat.com>
In-Reply-To: <02b20949-82aa-665a-71ea-5a67c1766785@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Mar 2022 10:35:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiX1PspWAJ-4Jqk7GHig4B4pJFzPXU7eH2AYtN+iNVAeQ@mail.gmail.com>
Message-ID: <CAHk-=wiX1PspWAJ-4Jqk7GHig4B4pJFzPXU7eH2AYtN+iNVAeQ@mail.gmail.com>
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

On Thu, Mar 10, 2022 at 9:13 AM David Hildenbrand <david@redhat.com> wrote:
>
> For the time being, the idea LGTM.

I'll take that as an acked-by, and I think I'll just commit it to my
real tree rather than delay this fix for the next merge window (only
to have it then be marked as stable and applied that wat).

I do agree that we should look at future changes in this area, ranging
from limiting the number of pages to the (I think already pending)
work for arm64 to use an instruction to probe every 128 bytes instead
of on a page basis.

It might even be reasonable to have some hybrid approach that walks
the page tables and faults things in - not quite GUP, not quite
'handle_mm_fault()'.

That said, this is hopefully always going to be the rare case. Yes,
people do IO on "cold" virtual memory, but people doing any
performance work hopefully know that locality (temporal and spatial)
matters not just for the regular CPU data caches, but for pretty much
everything.

                    Linus
