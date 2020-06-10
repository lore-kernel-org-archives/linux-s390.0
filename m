Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbgFJLCT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 Jun 2020 07:02:19 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80631C03E96F
        for <linux-s390@vger.kernel.org>; Wed, 10 Jun 2020 04:02:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f185so1410896wmf.3
        for <linux-s390@vger.kernel.org>; Wed, 10 Jun 2020 04:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200610052154.5180-1-cai@lca.pw> <CACT4Y+Ze=cddKcU_bYf4L=GaHuJRUjY=AdFFpM7aKy2+aZrmyQ@mail.gmail.com>
In-Reply-To: <CACT4Y+Ze=cddKcU_bYf4L=GaHuJRUjY=AdFFpM7aKy2+aZrmyQ@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 10 Jun 2020 13:02:04 +0200
Message-ID: <CAG_fn=X-da3V0OC-Bzd2rmkNuZ_bVpH_n7Sp5P_hSGXD4ryyBA@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: silence a KASAN false positive
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Kees Cook <keescook@chromium.org>, kasan-dev <kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>, linux-s390 <linux-s390@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Jun 10, 2020 at 7:55 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Jun 10, 2020 at 7:22 AM Qian Cai <cai@lca.pw> wrote:
> >
> > kernel_init_free_pages() will use memset() on s390 to clear all pages
> > from kmalloc_order() which will override KASAN redzones because a
> > redzone was setup from the end of the allocation size to the end of the
> > last page. Silence it by not reporting it there. An example of the
> > report is,
>
> Interesting. The reason why we did not hit it on x86_64 is because
> clear_page is implemented in asm (arch/x86/lib/clear_page_64.S) and
> thus is not instrumented. Arm64 probably does the same. However, on
> s390 clear_page is defined to memset.

Can we define it to __memset() instead?
__memset() is supposed to be ignored by KASAN, e.g. KASAN runtime uses
it in the places where we don't care about bugs.
