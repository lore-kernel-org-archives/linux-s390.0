Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 23 Jun 2020 10:48:24 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] mm/page_alloc: silence a KASAN false positive
Message-ID: <20200623084824.GB5665@osiris>
References: <20200610052154.5180-1-cai@lca.pw>
 <CACT4Y+Ze=cddKcU_bYf4L=GaHuJRUjY=AdFFpM7aKy2+aZrmyQ@mail.gmail.com>
 <20200610122600.GB954@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610122600.GB954@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@lca.pw>
Cc: Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Potapenko <glider@google.com>, Kees Cook <keescook@chromium.org>, kasan-dev <kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>, linux-s390 <linux-s390@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>

On Wed, Jun 10, 2020 at 08:26:00AM -0400, Qian Cai wrote:
> On Wed, Jun 10, 2020 at 07:54:50AM +0200, Dmitry Vyukov wrote:
> > On Wed, Jun 10, 2020 at 7:22 AM Qian Cai <cai@lca.pw> wrote:
> > >
> > > kernel_init_free_pages() will use memset() on s390 to clear all pages
> > > from kmalloc_order() which will override KASAN redzones because a
> > > redzone was setup from the end of the allocation size to the end of the
> > > last page. Silence it by not reporting it there. An example of the
> > > report is,
> > 
> > Interesting. The reason why we did not hit it on x86_64 is because
> > clear_page is implemented in asm (arch/x86/lib/clear_page_64.S) and
> > thus is not instrumented. Arm64 probably does the same. However, on
> > s390 clear_page is defined to memset.
> > clear_[high]page are pretty extensively used in the kernel.
> > We can either do this, or make clear_page non instrumented on s390 as
> > well to match the existing implicit assumption. The benefit of the
> > current approach is that we can find some real use-after-free's and
> > maybe out-of-bounds on clear_page. The downside is that we may need
> > more of these annotations. Thoughts?
> 
> Since we had already done the same thing in poison_page(), I suppose we
> could do the same here. Also, clear_page() has been used in many places
> on s390, and it is not clear to me if those are all safe like this.
> 
> There might be more annotations required, so it probably up to s390
> maintainers (CC'ed) if they prefer not instrumenting clear_page() like
> other arches.

Vasily will look into this and come up with a proper solution for s390.
