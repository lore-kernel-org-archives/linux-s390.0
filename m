Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1276C433EF
	for <linux-s390@archiver.kernel.org>; Tue,  8 Mar 2022 17:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346496AbiCHR2Y (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 8 Mar 2022 12:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349305AbiCHR2N (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Mar 2022 12:28:13 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06C05576A
        for <linux-s390@vger.kernel.org>; Tue,  8 Mar 2022 09:27:15 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 25so12401719ljv.10
        for <linux-s390@vger.kernel.org>; Tue, 08 Mar 2022 09:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pBQK4ptu5eu2CzXY/y3b95Ceol5gDBseg1AS4dXHJSU=;
        b=QU6dkM5L6DYfyvH3o0dpNFOmDFylySug8m5L3qgKK6V5c8lg8QrTruPxg85qI+5sPk
         LkI5S5XEiNwiuN1kP91fSxyfy5flySXCqOk3vBfhsp6fjOxF8K8sHKh8L3to/d668dCH
         7E+gqw0RScaNfcrTSTDNHD/elU9jbJacJnGLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pBQK4ptu5eu2CzXY/y3b95Ceol5gDBseg1AS4dXHJSU=;
        b=iJ+lB6+/zTGUpgNv81YVt1Xq2vQm465/g356u6VsxuiSd/++LVBcvGsX/s46xRml1+
         pubGMLwiAsfzNGjfZsdsevgCt3mRToDRMLY5z2oa9rdilQh7NInAvAjUvtNBKNjo4MhS
         FLCWSocGb7WakxtXQb4PE92behBw5gaNse2TfI3FVnHOVOG/Cyx8XXDcTOMtmqju8FJA
         9O1cMVryE9BBMvPtwkF/xBPSOoE2360jK/lqPOCAKScbMHKKWn4gmjzAQnVlnzIbR26s
         mlHTfjZmU/UW7GRkWeTcM2FSjDoUrPfwmeBA1CgoaW9hGsR3Zoo8eCJumGtYdLkeSi8p
         PBZw==
X-Gm-Message-State: AOAM532uv909nQnKbWwXROH7DKRvLQCixjbPzdmzeFTg2L7SS8m3kEDl
        TfXUcbsErO6jfQYWEvjawVjNguV4pYd50D7l6qE=
X-Google-Smtp-Source: ABdhPJxFMWcbfq4WJujGn535IfRMn943iKc+60k0iCR7jisCysvaBoJ1RFV1J6U7cDukxgsF15Ntrw==
X-Received: by 2002:a2e:900a:0:b0:247:df2c:7607 with SMTP id h10-20020a2e900a000000b00247df2c7607mr9643181ljg.262.1646760431279;
        Tue, 08 Mar 2022 09:27:11 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id bq1-20020a056512150100b004481de98e5bsm2674847lfb.305.2022.03.08.09.27.09
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 09:27:09 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 3so14858345lfr.7
        for <linux-s390@vger.kernel.org>; Tue, 08 Mar 2022 09:27:09 -0800 (PST)
X-Received: by 2002:a05:6512:e8a:b0:443:7b8c:579a with SMTP id
 bi10-20020a0565120e8a00b004437b8c579amr11552290lfb.687.1646760428865; Tue, 08
 Mar 2022 09:27:08 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com> <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com>
In-Reply-To: <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Mar 2022 09:26:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
Message-ID: <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
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

On Tue, Mar 8, 2022 at 12:21 AM David Hildenbrand <david@redhat.com> wrote:
>
> As raised offline already, I suspect
>
> shrink_active_list()
> ->page_referenced()
>  ->page_referenced_one()
>   ->ptep_clear_flush_young_notify()
>    ->ptep_clear_flush_young()
>
> which results on s390x in:
>
> static inline pte_t pte_mkold(pte_t pte)
> {
>         pte_val(pte) &= ~_PAGE_YOUNG;
>         pte_val(pte) |= _PAGE_INVALID;
>         return pte;
> }

Yeah, that looks likely.

It looks to me like GUP just doesn't care about _PAGE_INVALID on s390,
and happily looks up that page despite it not being "present" as far
as hardware is concerned.

Your actual patch looks pretty nasty, though. We avoid marking it
accessed on purpose (to avoid atomicity issues wrt hw-dirty bits etc),
but still, that patch makes me go "there has to be a better way".

                              Linus
