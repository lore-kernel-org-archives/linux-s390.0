Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D87C433F5
	for <linux-s390@archiver.kernel.org>; Mon,  7 Mar 2022 23:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240865AbiCGXTU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 7 Mar 2022 18:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbiCGXTT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Mar 2022 18:19:19 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E4831DC9
        for <linux-s390@vger.kernel.org>; Mon,  7 Mar 2022 15:18:22 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id n19so7938510lfh.8
        for <linux-s390@vger.kernel.org>; Mon, 07 Mar 2022 15:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvag9d2yKnVQ2WA/+ZCk8meLFVTu4t3Z/Y+Vhn7jLqs=;
        b=iE1Mpo/4WNvmX4KVx+vCPrRdmpw6OvR5A+gP5peGjMWmvtI9qqXJ7QVWhM5mmjDAr9
         OxRVuE27WlAcAJxgb2qcdgwfIEVoyYkX+FP20GgX2hzl8hfi+DISfSMg4WgSb2Dw6/4C
         iRVzuKCVR8of2ZBhjlZfemAtmupGO2kDD76nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvag9d2yKnVQ2WA/+ZCk8meLFVTu4t3Z/Y+Vhn7jLqs=;
        b=Am0s6DIGvRJYz+pt3Y/LPRhNSTtz1qz2ErTOKe+pFNh6UsXqx1QG0R6W2XJ0JCcyBu
         PqejH8R2A5rAaJ09y8KL6I/hmdM6dkaQPlOC3c/zS8rpyBFT6612AUbDzlxPGXeE6r1D
         oj+wc5I84OAmrXiLwHvipv6ogeYCsovzdBwGHQBucKxX5A4Pw0G5h4FVLSbImGLw7Woc
         L9JON7oZcDp75O89mM7kJKoC80+oJl/zmNALnD/1P+BBtf4fMoNGMb1i7ZdSPM+1JXeJ
         KBL/xGPKIDV0/bquv/Ez1Ail05T73pRQdF167EKL52//Qk2m+BEy59Vl57tdP0Sak4aG
         g3PQ==
X-Gm-Message-State: AOAM531RUbwYJSp1qdMsqCbKnW35dghd54j7CCYAR3kJqk9KCiMAmSkC
        ++hqZhFZfKROg9x/5gz0JwhyIcsHIwq9O0+Twsg=
X-Google-Smtp-Source: ABdhPJw+Zl3Dn99ed1p3SeCswIgI1yujGyBDKCS1U9t9dxFhi+6L//cQZ/S3NZ6XjKp8o0FfCM/vfQ==
X-Received: by 2002:ac2:5d2c:0:b0:448:31b8:e00b with SMTP id i12-20020ac25d2c000000b0044831b8e00bmr3527926lfb.19.1646695101028;
        Mon, 07 Mar 2022 15:18:21 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id r28-20020a2eb61c000000b00247e43e83e0sm1178119ljn.58.2022.03.07.15.18.18
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 15:18:19 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id w27so29066471lfa.5
        for <linux-s390@vger.kernel.org>; Mon, 07 Mar 2022 15:18:18 -0800 (PST)
X-Received: by 2002:a05:6512:3049:b0:447:d55d:4798 with SMTP id
 b9-20020a056512304900b00447d55d4798mr8957028lfb.531.1646695098272; Mon, 07
 Mar 2022 15:18:18 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
In-Reply-To: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Mar 2022 15:18:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
Message-ID: <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Mar 7, 2022 at 2:52 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> After generic_file_read_iter() returns a short or empty read, we fault
> in some pages with fault_in_iov_iter_writeable(). This succeeds, but
> the next call to generic_file_read_iter() returns -EFAULT and we're
> not making any progress.

Since this is s390-specific, I get the very strong feeling that the

  fault_in_iov_iter_writeable ->
    fault_in_safe_writeable ->
      __get_user_pages_locked ->
        __get_user_pages

path somehow successfully finds the page, despite it not being
properly accessible in the page tables.

And it's presumably something specific in the s390x page table
functionality that makes that happen.

The places I'd look at in particular is to make sure that
follow_page_mask() actually has the same rules as a real page table
lookup on s390x.

IOW, if follow_page_mask() finds the page and thinks it's writable,
then it will return a 'page' successfully, and the __get_user_pages()
code will be happy and say "it's there".

But if then accessing the page by trying to write to it using the
virtual address fails despite that, then you'll get the behavior you
describe.

I'd take a look at that can_follow_write_pte() case in particular,
since this is a FOLL_WRITE thing, but it could be any of the pte
checking details.

Have you tried tracing through that path?

                      Linus
