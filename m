Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 16 Nov 2017 09:03:14 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390/ap_bus: Convert timers to use timer_setup()
In-Reply-To: <CAGXu5jJ3f=fHyCHnW72GS9NL9xWvJkXjocsodddgQOqcgbjjTA@mail.gmail.com>
References: <20171025102737.GA145851@beast>
        <20171026083842.5ca46b2f@mschwideX1>
        <CAGXu5jLJY_zYf=v_xYUEG6tgLzwvW8P+-d9GNNp8XN5bhnWvzQ@mail.gmail.com>
        <20171103072926.12ef827c@mschwideX1>
        <CAGXu5jJ3f=fHyCHnW72GS9NL9xWvJkXjocsodddgQOqcgbjjTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20171116090314.36ded7c5@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Harald Freudenberger <freude@de.ibm.com>, linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 15 Nov 2017 23:58:44 -0800
Kees Cook <keescook@chromium.org> wrote:

> On Thu, Nov 2, 2017 at 11:29 PM, Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> > On Thu, 2 Nov 2017 16:36:53 -0700
> > Kees Cook <keescook@chromium.org> wrote:
> >  
> >> On Wed, Oct 25, 2017 at 11:38 PM, Martin Schwidefsky
> >> <schwidefsky@de.ibm.com> wrote:  
> >> > On Wed, 25 Oct 2017 03:27:37 -0700
> >> > Kees Cook <keescook@chromium.org> wrote:
> >> >  
> >> >> In preparation for unconditionally passing the struct timer_list pointer to
> >> >> all timer callbacks, switch to using the new timer_setup() and from_timer()
> >> >> to pass the timer pointer explicitly.
> >> >>
> >> >> Cc: Harald Freudenberger <freude@de.ibm.com>
> >> >> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> >> >> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> >> >> Cc: linux-s390@vger.kernel.org
> >> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >> >> ---
> >> >>  drivers/s390/crypto/ap_bus.c   | 10 +++++-----
> >> >>  drivers/s390/crypto/ap_bus.h   |  2 +-
> >> >>  drivers/s390/crypto/ap_queue.c |  2 +-
> >> >>  3 files changed, 7 insertions(+), 7 deletions(-)  
> >> >
> >> > Parked for the second part of the s390 updates for the next merge window.
> >> > Thanks.  
> >>
> >> Thanks for getting these staged. I just wanted to check with you,
> >> since I don't see these in -next anywhere yet:
> >>
> >> s390: qdio: Convert timers to use timer_setup()
> >> s390/sclp: Convert timers to use timer_setup()
> >> s390/cio: Convert timers to use timer_setup()
> >> s390/scsi: Convert timers to use timer_setup()
> >> s390/ap_bus: Convert timers to use timer_setup()
> >>
> >> Are all of these expected to land for -rc1? (Would it help to carry
> >> them in the timer tree?) I've got tree-wide changes ready to go once
> >> all these conversions have landed.  
> >
> > These patches are parked on a private branches. The features branch
> > on s390/linux is the one that is used for -next AND for the upstream
> > merge. And since I do not want to rebase that branch the timer_setup
> > patches are not in -next as well.
> >
> > Four of you patches are safe with me, the s390/scsi patch is in
> > Steffens patch queue. All good I would say.  
> 
> Hi,
> 
> I saw s390 get merged for -rc1, but none of these timer_setup()
> conversions were included. Given the possible short merge window,
> what's the state of these? I can't do the bulk API changes at the end
> of -rc1 without the s390 timer patches. Anything I can help with?

The remaining timer_setup changes are on the features branch of s390/linux,
I plan to send a please-pull request be the end of the week.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
