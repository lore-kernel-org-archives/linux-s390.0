Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 5 Oct 2017 19:06:30 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH] s390: qdio: Convert timers to use timer_setup()
In-Reply-To: <CAGXu5jL+za1du_1kOZj1i50kXDGzY91EvLhnO5EJSQ1q1WN6NQ@mail.gmail.com>
References: <20171005005435.GA23979@beast> <alpine.LFD.2.21.1710051107190.1796@schleppi>  <CAGXu5jL+za1du_1kOZj1i50kXDGzY91EvLhnO5EJSQ1q1WN6NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1710051905350.1796@schleppi>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 5 Oct 2017, Kees Cook wrote:
> On Thu, Oct 5, 2017 at 2:13 AM, Sebastian Ott <sebott@linux.vnet.ibm.com> wrote:
> > On Wed, 4 Oct 2017, Kees Cook wrote:
> >> In preparation for unconditionally passing the struct timer_list pointer to
> >> all timer callbacks, switch to using the new timer_setup() and from_timer()
> >> to pass the timer pointer explicitly.
> >
> >> -void qdio_outbound_timer(unsigned long data)
> >> +void qdio_outbound_timer(struct timer_list *t)
> >>  {
> >> -     struct qdio_q *q = (struct qdio_q *)data;
> >> +     struct qdio_q *q = from_timer(q, t, o.out.timer);
> >                                             ^
> >                              this should be u.out.timer
> 
> Oh thank you, good catch!
> 
> > Will be applied to s390/linux.git
> 
> Did you fix this up already or should I send a v2?

Already fixed, so no V2 needed.

Sebastian
