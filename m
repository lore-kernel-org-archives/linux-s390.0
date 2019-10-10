Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730815AbfJJAEU (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 9 Oct 2019 20:04:20 -0400
Date: Wed, 9 Oct 2019 17:04:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: "reuse mergeable anon_vma as parent when fork" causes a crash
 on s390
Message-Id: <20191009170418.b7954140de86e422f3818381@linux-foundation.org>
In-Reply-To: <CALvZod4psOEyYwPOF1UcJoK96LbYBccYhsG0DrKD+CCf8Sc-Yg@mail.gmail.com>
References: <1570656570.5937.24.camel@lca.pw>
        <CALvZod4psOEyYwPOF1UcJoK96LbYBccYhsG0DrKD+CCf8Sc-Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Shakeel Butt <shakeelb@google.com>
Cc: Qian Cai <cai@lca.pw>, Wei Yang <richardw.yang@linux.intel.com>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Rik van Riel <riel@surriel.com>, Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>

On Wed, 9 Oct 2019 15:21:11 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Wed, Oct 9, 2019 at 2:30 PM Qian Cai <cai@lca.pw> wrote:
> >
> > The linux-next commit "mm/rmap.c: reuse mergeable anon_vma as parent when fork"
> > [1] causes a crash on s390 while compiling some C code. Reverted it fixes the
> > issue.
> >
> > [1] https://lore.kernel.org/lkml/20191004160632.30251-1-richardw.yang@linux.intel.com/
> >
>
> ...
>
> Our internal syzbot instance also hit this bug and bisected to the same patch.

Thanks, I'll drop
mm-rmapc-reuse-mergeable-anon_vma-as-parent-when-fork.patch.
