Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2953BC4167B
	for <linux-s390@archiver.kernel.org>; Tue, 20 Dec 2022 14:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiLTOcY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Dec 2022 09:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiLTOb4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Dec 2022 09:31:56 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98B31A3BE
        for <linux-s390@vger.kernel.org>; Tue, 20 Dec 2022 06:31:51 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id s9so11022814qtx.6
        for <linux-s390@vger.kernel.org>; Tue, 20 Dec 2022 06:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T/NCsYKC04yFcK1fgm0juUVbSixz96HJYgI6+8cFKck=;
        b=aW5RhtAsBkNvIR682pacJYjMBchjsl6CBpgm1GNt+MoU0xR7oZIbXklJVEhSA5imlQ
         5u50ol+9QlNXecXRFfrW9BlWpiEgwr54V46RQJ7vPMFVZN8nUM7UL5cjfEyDNsEd6TlT
         I+s90R9sBzg5F4fXqzDg5UVxzzA1ZnYyjdfck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/NCsYKC04yFcK1fgm0juUVbSixz96HJYgI6+8cFKck=;
        b=OdPbD9g+nQpl0R0meoddGLSqaVOAvgpKtrcqBGYB2CfFqR9aIfDFgZ791zV6GbL+CU
         Ux3PaFEac37Bm/X5QE7O8nW+b1gzrQHt+41kxtZdHnXBE2GLkCIS8OwXEcn+xMV1DavO
         ghmcjAAn5GRiAmFtugK5WuwrLz6okjgd4j4RYDqFQXrY1cwxdo7GT1viBu+yMHwE+R79
         NA052QwJ7B1Arn43kr3u6JHZ4E9NT5r25PVwVNVymKlKcke0Tr6md4k92VNUjTIzFGSV
         qjPKCpx788D4a/12vmovSCJRQmOeQLpEqyXtRLn0DE3LeOPXt0lb9n+YmwQbfEs6M84Y
         K/mA==
X-Gm-Message-State: AFqh2kozJx5alM23rBuIRFqVdHOK6zCMtxe/B4ThEE3M8o0brRUnlTwo
        A4YeJBz+UjJLvO/EFaNjxNQSXkrqRuksfILD
X-Google-Smtp-Source: AMrXdXtV7j4m3M9eC8fV67hcXXpsPn7FTszk1nvp3gtbN0bln+bOYVa14I5VLUVDt45Qnxk/pYtGOA==
X-Received: by 2002:a05:622a:5987:b0:3a9:80b3:435f with SMTP id gb7-20020a05622a598700b003a980b3435fmr17831119qtb.12.1671546709067;
        Tue, 20 Dec 2022 06:31:49 -0800 (PST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id a19-20020ac85b93000000b003a611cb2a95sm7946896qta.9.2022.12.20.06.31.47
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 06:31:48 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id j16so11034950qtv.4
        for <linux-s390@vger.kernel.org>; Tue, 20 Dec 2022 06:31:47 -0800 (PST)
X-Received: by 2002:ac8:4988:0:b0:3a7:ef7b:6aa5 with SMTP id
 f8-20020ac84988000000b003a7ef7b6aa5mr8424356qtq.436.1671546695878; Tue, 20
 Dec 2022 06:31:35 -0800 (PST)
MIME-Version: 1.0
References: <20221219153525.632521981@infradead.org> <20221219154119.154045458@infradead.org>
 <Y6DEfQXymYVgL3oJ@boqun-archlinux> <Y6GXoO4qmH9OIZ5Q@hirez.programming.kicks-ass.net>
In-Reply-To: <Y6GXoO4qmH9OIZ5Q@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 20 Dec 2022 08:31:19 -0600
X-Gmail-Original-Message-ID: <CAHk-=wi493ukLwziiqofe=WCSfUU8Qa+LK0mp_GrGWKV3NnTpQ@mail.gmail.com>
Message-ID: <CAHk-=wi493ukLwziiqofe=WCSfUU8Qa+LK0mp_GrGWKV3NnTpQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 05/12] arch: Introduce arch_{,try_}_cmpxchg128{,_local}()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, corbet@lwn.net, will@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Dec 20, 2022 at 5:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Dec 19, 2022 at 12:07:25PM -0800, Boqun Feng wrote:
> >
> > I wonder whether we should use "(*(u128 *)ptr)" instead of "(*(unsigned
> > long *) ptr)"? Because compilers may think only 64bit value pointed by
> > "ptr" gets modified, and they are allowed to do "useful" optimization.
>
> In this I've copied the existing cmpxchg_double() code; I'll have to let
> the arch folks speak here, I've no clue.

It does sound like the right thing to do. I doubt it ends up making a
difference in practice, but yes, the asm doesn't have a memory
clobber, so the input/output types should be the right ones for the
compiler to not possibly do something odd and cache the part that it
doesn't see as being accessed.

              Linus
