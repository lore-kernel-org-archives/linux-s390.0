Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20140331092400.17071766@mschwide>
References: <20140331092400.17071766@mschwide>
Date: Mon, 31 Mar 2014 14:45:32 -0700
Message-ID: <CA+55aFzPP6kBzWrcvps6NVu=f-FUtrfs1U6DyRpdwX6hH6PM-Q@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for the 3.15 merge window
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Mar 31, 2014 at 12:24 AM, Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> There are two memory management related changes, the CMMA support for
> KVM to avoid swap-in of freed pages and the split page table lock for
> the PMD level. These two come with common code changes in mm/.

Ugh. I pulled it, but things like this makes me want to dig my eyes
out with a spoon:

  +#ifdef finish_arch_post_lock_switch
  +        finish_arch_post_lock_switch();
  +#endif

when I think the proper thing to do would have been to move the
#ifndef that creates an empty finish_arch_post_lock_switch() from
kernel/sched/sched.h to some common file, or possibly even just
duplicate it.

I detest #ifdef's in the middle of code. Yes, we do have them, but we
should try to avoid adding more of them.

Maybe we could have a <linux/mmu_context.h> that includes the
<asm/mmu_context.h> and then does that "let's add the dummy function
for architectures that don't need it"?

Added Ingo to the cc, since this ends up intersecting with the
scheduler code that now does the wrapper on its own.

              Linus
