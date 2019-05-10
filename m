Return-Path: <linux-arch-owner@vger.kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
In-Reply-To: <20190510050709.GA1831@jagdpanzerIV>
References: <20190509121923.8339-1-pmladek@suse.com> <20190510043200.GC15652@jagdpanzerIV> <CAHk-=wiP+hwSqEW0dM6AYNWUR7jXDkeueq69et6ahfUgV7hC3w@mail.gmail.com> <20190510050709.GA1831@jagdpanzerIV>
Date: Fri, 10 May 2019 16:41:24 +1000
Message-ID: <87h8a2vmjv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190510064124.q7J_CwuPPeHjW5ZMFj9t16uRiB6ATm6nxxi7Biu_ngY@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>, Christophe Leroy <christophe.leroy@c-s.fr>, Stephen Rothwell <sfr@ozlabs.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> writes:
> On (05/09/19 21:47), Linus Torvalds wrote:
>>    [ Sorry about html and mobile crud, I'm not at the computer right now ]
>>    How about we just undo the whole misguided probe_kernel_address() thing?
>
> But the problem will remain - %pS/%pF on PPC (and some other arch-s)
> do dereference_function_descriptor(), which calls probe_kernel_address().

(Only on 64-bit big endian, and we may even change that one day)

> So if probe_kernel_address() starts to dump_stack(), then we are heading
> towards stack overflow. Unless I'm totally missing something.

We only ended up calling dump_stack() from probe_kernel_address() due to
a combination of things:
  1. probe_kernel_address() actually uses __copy_from_user_inatomic()
     which is silly because it's not doing a user access.
  2. our user access code uses mmu_has_feature() which uses jump labels,
     and so isn't safe to call until we've initialised those jump labels.
     This is unnecessarily fragile, we can easily make the user access
     code safe to call before the jump labels are initialised.
  3. we had extra debug code enabled in mmu_has_feature() which calls
     dump_stack().

I've fixed 2, and plan to fix 1 as well at some point. And 3 is behind a
CONFIG option that no one except me is going to have enabled in
practice.

So in future we shouldn't be calling dump_stack() in that path.

cheers
