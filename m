Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A4BC433EF
	for <linux-s390@archiver.kernel.org>; Wed, 16 Mar 2022 18:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348602AbiCPSux (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 16 Mar 2022 14:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiCPSuw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Mar 2022 14:50:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285556B08B
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 11:49:38 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so3322139pjp.3
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 11:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y7ERAKcifRzxT6vcVSjDSozSgypW/KEW+vG0ASHCMHY=;
        b=EzwZe3ti/2sTFi0gzWAE+otHNwPAgMXQlTrdW5phcUmxKkHY/mhUFb2IyXF9KVVy/D
         ZZScNEQ30YzZhGoDBcDZwia4z6A8qPXdZYDXWIe1+P7k6dicin06qMrNjt3UBPEGg0xg
         hXRUdafsQ4hecOzsNY8upgcQF/oTX1S+MFQdBAm5vGiFsmlgOef5nXj5Lih8CZJjNAC1
         8z2v38eH+liqupz+geO+Jhdb8o970vpMhLS4UkfDjB26oOyfng2nrCBZgaQQoVM80Uak
         B+d+V2FIZiDq0KBGNEgpnXziZu8VfjqhxX/NJyQgCCDiqwRrqIkL9BtI8MgIhQfcEk6b
         CmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y7ERAKcifRzxT6vcVSjDSozSgypW/KEW+vG0ASHCMHY=;
        b=xoyDKadrM4jNEE7Ywp4TngiH8aja5rfcs8NWGKlSAVYfyufUaH83OA/VIky4OnZJGO
         J4dZvKii7OmPTX+KKOL95nLqDVUD5/ytluDFt5cX7UN6zmtAyvBvwbCcUEmGoPt1XjmG
         DUKM/ZqJdsSj3z2F27g23afEFC0m9cdNX6wVCC62kI/a8xSCeWkqyzJyVx3HMA7Sq2Xh
         YyUwfTbSJ2c27B017rnpmMlVGKX01yzqIQmdAwtDJRlYRc2zm7ieaZBL4Z3YQNYP9Oi4
         VGtbfnB5+hWObcCaaabc3CYbQ8b7gjE1EEuy6VyE4QeBiEJ58v0AF3f9BXONqUBpIBjV
         vR/w==
X-Gm-Message-State: AOAM5329r67EOFSEiHMvGebdG2ZH7tx81yq/iFcWswphyHBSFFPyQrDy
        7iyFjKCwKiGxNLh7m/2FdAmtG5rGk6qA3rNCmECW
X-Google-Smtp-Source: ABdhPJxwp/pkpCQtHo7tVh5Dg1xcTc9fNxHdNL+EZXfY9wfYvIVklmRmDUPiJum14n0p7tN0MasdTRHMWSpkdNRp57Q=
X-Received: by 2002:a17:903:32c8:b0:150:1189:c862 with SMTP id
 i8-20020a17090332c800b001501189c862mr878311plr.134.1647456577401; Wed, 16 Mar
 2022 11:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220316060214.2200695-1-morbo@google.com> <20220316074356.n7e5lzrmnal2dcgu@gator>
 <334cc93e-9843-daa9-5846-394c199e294f@redhat.com>
In-Reply-To: <334cc93e-9843-daa9-5846-394c199e294f@redhat.com>
From:   Bill Wendling <morbo@google.com>
Date:   Wed, 16 Mar 2022 11:49:26 -0700
Message-ID: <CAGG=3QWOZVtXfyR4Lu8qBS-ASBFeMaLGo1ANXTxi7gPoLbA2Ag@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH] libfdt: use logical "or" instead of
 bitwise "or" with boolean operands
To:     Thomas Huth <thuth@redhat.com>
Cc:     Andrew Jones <drjones@redhat.com>, kvm list <kvm@vger.kernel.org>,
        Nikos Nikoleris <nikos.nikoleris@arm.com>,
        Laurent Vivier <lvivier@redhat.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Mar 16, 2022 at 12:53 AM Thomas Huth <thuth@redhat.com> wrote:
>
> On 16/03/2022 08.43, Andrew Jones wrote:
> > On Tue, Mar 15, 2022 at 11:02:14PM -0700, Bill Wendling wrote:
> >> Clang warns about using a bitwise '|' with boolean operands. This seems
> >> to be due to a small typo.
> >>
> >>    lib/libfdt/fdt_rw.c:438:6: warning: use of bitwise '|' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
> >>            if (can_assume(LIBFDT_ORDER) |
> >>
> >> Using '||' removes this warnings.
> >>
> >> Signed-off-by: Bill Wendling <morbo@google.com>
> >> ---
> >>   lib/libfdt/fdt_rw.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/lib/libfdt/fdt_rw.c b/lib/libfdt/fdt_rw.c
> >> index 13854253ff86..3320e5559cac 100644
> >> --- a/lib/libfdt/fdt_rw.c
> >> +++ b/lib/libfdt/fdt_rw.c
> >> @@ -435,7 +435,7 @@ int fdt_open_into(const void *fdt, void *buf, int bufsize)
> >>                      return struct_size;
> >>      }
> >>
> >> -    if (can_assume(LIBFDT_ORDER) |
> >> +    if (can_assume(LIBFDT_ORDER) ||
> >>          !fdt_blocks_misordered_(fdt, mem_rsv_size, struct_size)) {
> >>              /* no further work necessary */
> >>              err = fdt_move(fdt, buf, bufsize);
> >> --
> >> 2.35.1.723.g4982287a31-goog
> >>
> >
> > This is fixed in libfdt upstream with commit 7be250b4 ("libfdt:
> > Correct condition for reordering blocks"), which is in v1.6.1.
> > We can either take this patch as a backport of 7be250b4 or we
> > can rebase all of our libfdt to v1.6.1. Based on the number of
> > fixes in v1.6.1, which appear to be mostly for compiling with
> > later compilers, I'm in favor of rebasing.
>
> +1 for updating to v1.6.1 completely.
>
Also +1. :-) Thank you!

-bw

> > Actually, we can also use this opportunity to [re]visit the
> > idea of changing libfdt to a git submodule. I'd like to hear
> > opinions on that.
>
> I'm always a little bit torn when it comes to this question. Sure, git
> submodules maybe make the update easier ... but they are a real pita when
> you're working with remote machines that might not have direct connection to
> the internet. For example, I'm used to rsync my sources to the non-x86
> machines, and if you forget to update the submodule to the right state
> before the sync, you've just lost. So from my side, it's a preference for
> continuing without submodules (but I won't insist if everybody else wants to
> have them instead).
>
>   Thomas
>
