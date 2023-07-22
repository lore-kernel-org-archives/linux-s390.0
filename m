Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FC7C001DC
	for <linux-s390@archiver.kernel.org>; Sat, 22 Jul 2023 18:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjGVSwn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 22 Jul 2023 14:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGVSwm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 22 Jul 2023 14:52:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC70F211E
        for <linux-s390@vger.kernel.org>; Sat, 22 Jul 2023 11:52:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e28b299adso4552543a12.2
        for <linux-s390@vger.kernel.org>; Sat, 22 Jul 2023 11:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690051960; x=1690656760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G4EHsYbDrBuVMb0gheWkPS7eVFc1IDuaQkcZFjpTTTs=;
        b=EjD8e/kE4zgLvTf0Y8U30s3ksjYhtPvE3bs7ydQwZREUSkWaV84qRlYN7Wjc1AUZJG
         XNK+uaf3H0bYNy5ERd89OVoc/AufSaZUAJABJ5K/c+F0aKqrixcTR24BuBJ0DwEP1PI/
         ddbtldqLZ2csSXXbKoNTklYHms9h3MiHIyU3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690051960; x=1690656760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4EHsYbDrBuVMb0gheWkPS7eVFc1IDuaQkcZFjpTTTs=;
        b=c+eESlFkzrSa16tiiasuRckTrjQ7F4zHEiw6le+WDZjnZ7Zi25nCLiTJVuw4KKd9w7
         gveq3hlzrwngiNl1bK88TxCqIWLodQwNF5+6DZFTgrmQKz7KfNwnCEejOLn3hUgrUUon
         +fWPuxARMsfpH9NzJdS+WORlvZ9ZHtzC4vYZuJ1ZoaDToLUqOVpwQ3KjQvHxRzEaNTIN
         KKLlt/3dnsBulKLxXC5XvHIWCUE2n44RlWQjDPA0ZwEPo2ZtsNsbJjI5Mrf8jLPPCkWe
         wMG78KDNepflSvb51kTrXf/+CdbUIbqs+toNYPhNU7twKfNeTtGHYBI0FfzZw3co3FGQ
         /zEg==
X-Gm-Message-State: ABy/qLZBBGj5YLP8vdNfvrO37K7d4TYhYh46bsiT6Pz6w04AcaQFkKrv
        58RheqNGsKV1EZX5o8wNsYLJEFaJSFjdyrV6v9Fu7A==
X-Google-Smtp-Source: APBJJlHS62QyUgGRC/dZiB8iJn0Gv6CKrfFZoRJQlFFuuzpOGWFROfo/H3aomhBngdAho/+ip155+A==
X-Received: by 2002:aa7:ca48:0:b0:522:1686:20d5 with SMTP id j8-20020aa7ca48000000b00522168620d5mr1998764edt.40.1690051959977;
        Sat, 22 Jul 2023 11:52:39 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id w10-20020aa7d28a000000b00521f4ee396fsm1619865edq.12.2023.07.22.11.52.39
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 11:52:39 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-52222562f1eso69694a12.3
        for <linux-s390@vger.kernel.org>; Sat, 22 Jul 2023 11:52:39 -0700 (PDT)
X-Received: by 2002:aa7:d48d:0:b0:521:63c5:77d7 with SMTP id
 b13-20020aa7d48d000000b0052163c577d7mr5117199edr.8.1690051959163; Sat, 22 Jul
 2023 11:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230722160215.7417-A-hca@linux.ibm.com>
In-Reply-To: <20230722160215.7417-A-hca@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Jul 2023 11:52:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2g7kDTKPawbhOKXFsAF+Zayygmp1f64oerQktc_LCYw@mail.gmail.com>
Message-ID: <CAHk-=wj2g7kDTKPawbhOKXFsAF+Zayygmp1f64oerQktc_LCYw@mail.gmail.com>
Subject: Re: [GIT PULL] s390 fixes for 6.5-rc3
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, 22 Jul 2023 at 09:02, Heiko Carstens <hca@linux.ibm.com> wrote:
>
> - Fix per vma lock fault handling: add missing !(fault & VM_FAULT_ERROR)
>   check to fault handler to prevent error handling for return values that
>   don't indicate an error

Hmm. The s390 code / people seems to still be a bit confused about the
VM_FAULT flags.

The commit comment says "With per-vma locks, handle_mm_fault() may
return non-fatal error flags".

That's actively misleading.

Why? Because handle_mm_fault() may - and will - return non-fatal error
flags *regardless* of the per-vma locks.

There's VM_FAULT_COMPLETED, there's VM_FAULT_MAJOR, there are all
those kinds of "informational" bits.

So honestly, when that patch then does

+       if (likely(!(fault & VM_FAULT_ERROR)))
+               fault = 0;

I feel like the code is very confused about what is going on, and is
papering over the real bug.

The *real* bug seems to be that do_protection_exception() and
do_dat_exception() do this:

        fault = do_exception(regs, access);
        if (unlikely(fault))
                do_fault_error(regs, fault);

which is basically nonsensical. And the reason that s390 does that
seems to be that s390 (and arm, for that matter) seem, to have added a
few extra VM_FAULT_xyz bits that aren't part of VM_FAULT_ERROR, so
then in do_fault_error() you have that nonsensical "test some of the
fields as values, and other fields as bits".

Anyway, I have pulled this, since it clearly fixes a problem. But I do
think that the *deeper* problem is that s390 treats those bits as
errors in the first place, when they really aren't. Yes, the error
bits are *common*, but that field really shouldn't be seen as just
errors, and I really think that the deeper problem is that

        if (unlikely(fault))
                do_fault_error(regs, fault);

logic. It's simply wrong.

Of course, it looks like the reason you found this is that the s390
do_fault_error() then does a BUG() on any bits it doesn't understand.
You have that nonsensical "clear flags" in other places too. So it's
not like this work-around is new. But it's a workaround, and a sign of
confusion, I feel.

Maybe the extra s390 fault conditions should be added to the generic
list and added to the VM_FAULT_ERROR mask. I dunno.

              Linus
