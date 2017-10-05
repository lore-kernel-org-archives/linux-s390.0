Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1710051107190.1796@schleppi>
References: <20171005005435.GA23979@beast> <alpine.LFD.2.21.1710051107190.1796@schleppi>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 5 Oct 2017 09:58:55 -0700
Message-ID: <CAGXu5jL+za1du_1kOZj1i50kXDGzY91EvLhnO5EJSQ1q1WN6NQ@mail.gmail.com>
Subject: Re: [PATCH] s390: qdio: Convert timers to use timer_setup()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Oct 5, 2017 at 2:13 AM, Sebastian Ott <sebott@linux.vnet.ibm.com> wrote:
> On Wed, 4 Oct 2017, Kees Cook wrote:
>> In preparation for unconditionally passing the struct timer_list pointer to
>> all timer callbacks, switch to using the new timer_setup() and from_timer()
>> to pass the timer pointer explicitly.
>
>> -void qdio_outbound_timer(unsigned long data)
>> +void qdio_outbound_timer(struct timer_list *t)
>>  {
>> -     struct qdio_q *q = (struct qdio_q *)data;
>> +     struct qdio_q *q = from_timer(q, t, o.out.timer);
>                                             ^
>                              this should be u.out.timer

Oh thank you, good catch!

> Will be applied to s390/linux.git

Did you fix this up already or should I send a v2?

-Kees

-- 
Kees Cook
Pixel Security
