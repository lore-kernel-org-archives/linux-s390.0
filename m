Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F29DC433F5
	for <linux-s390@archiver.kernel.org>; Thu, 10 Mar 2022 19:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbiCJTXY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 10 Mar 2022 14:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiCJTXX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Mar 2022 14:23:23 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2B2F32AE
        for <linux-s390@vger.kernel.org>; Thu, 10 Mar 2022 11:22:21 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id v28so9141901ljv.9
        for <linux-s390@vger.kernel.org>; Thu, 10 Mar 2022 11:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HHGuzVLaCZTJR5Z/FIfYDsWY8nrsVyf9XB/r18bCkXI=;
        b=ep7XFBy0Q99M5ouVxkQy/Xu+D2RZ7bpJRAdEIb9jXanfP8Lx6Lp5YBbGfSecYfO6B+
         2GOiehczcxMm6X1BX+TQuCcgQF28n9vabec+jv5ZwC9I+//4EvcchXvD9GydAvFCw2ua
         Uw2lQ/BCnimAOmwaI85VX66awfuh3v1U2bb5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHGuzVLaCZTJR5Z/FIfYDsWY8nrsVyf9XB/r18bCkXI=;
        b=ue7xwSzKPsODoco48go6zWUQ0dROqHolik24yQmKLwLdqQvunrj8B6ikkU+OMvhqsb
         6U6Q72beSQydF1tmCG7VYdR+j9narva4ebWp1C/r5p1UiCEIRzSdmtn8gsrxrlh7zmQS
         YsxUcCB9WEucoYdGicVP0LrRvw82GLEaDC6Gm5Ow/XV3/I93qdE+0TlY2dRy0gMVgxsf
         hmmNKjzUNRkvxvWdu0+qiWP35B6Ek/LFTcbuIh+62fkLblPCLfzQ0MeHaI9plKTcJJI2
         oU/nKGdCq7ETfreUoA5lXvesdHJtjbsLBaHy+DXX4B16eFneTPqYGnCxTilPfspDrijR
         vk9A==
X-Gm-Message-State: AOAM531w1zDc7GhW2ebZM0+s9pwFAkV3uzDdxl6IB31gwECjKByYxDYF
        2zn3hKMd55AvpVIlUl+WKNKJhBfBknici1mzQYQ=
X-Google-Smtp-Source: ABdhPJxtb1JL7dKRq/UPb+w/GkLwiKd4qgqOBBkD/you/0LTop8SGNmCTNB7adphnkCX6spmtfcc6Q==
X-Received: by 2002:a05:651c:1542:b0:244:e12b:8b83 with SMTP id y2-20020a05651c154200b00244e12b8b83mr3978852ljp.436.1646940139914;
        Thu, 10 Mar 2022 11:22:19 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id r25-20020ac25a59000000b0044394f8a312sm1136638lfn.75.2022.03.10.11.22.17
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 11:22:18 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id v28so9141716ljv.9
        for <linux-s390@vger.kernel.org>; Thu, 10 Mar 2022 11:22:17 -0800 (PST)
X-Received: by 2002:a2e:804b:0:b0:247:e81f:87e9 with SMTP id
 p11-20020a2e804b000000b00247e81f87e9mr4029456ljg.176.1646940137523; Thu, 10
 Mar 2022 11:22:17 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <02b20949-82aa-665a-71ea-5a67c1766785@redhat.com> <CAHk-=wiX1PspWAJ-4Jqk7GHig4B4pJFzPXU7eH2AYtN+iNVAeQ@mail.gmail.com>
 <CAHc6FU6+y2ZGg3QnW9NLsj43vvDpAFu-pVBK-xTPfsDcKa39Mg@mail.gmail.com>
In-Reply-To: <CAHc6FU6+y2ZGg3QnW9NLsj43vvDpAFu-pVBK-xTPfsDcKa39Mg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Mar 2022 11:22:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiXEQ9+NedP6LRbAXGTHrT4MZSPRvbJAFmgrDh75GpE2Q@mail.gmail.com>
Message-ID: <CAHk-=wiXEQ9+NedP6LRbAXGTHrT4MZSPRvbJAFmgrDh75GpE2Q@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Andreas Gruenbacher <agruenba@redhat.com>
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

On Thu, Mar 10, 2022 at 10:48 AM Andreas Gruenbacher
<agruenba@redhat.com> wrote:
>
> Works for me. This should probably still be tagged as:
>
> Fixes: cdd591fc86e3 ("iov_iter: Introduce fault_in_iov_iter_writeable")
> Cc: stable@vger.kernel.org # v5.16+

Yeah, I had already added the "Fixes" line there (and it makes the
stable one unnecessary).

            Linus
