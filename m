Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171026083842.5ca46b2f@mschwideX1>
References: <20171025102737.GA145851@beast> <20171026083842.5ca46b2f@mschwideX1>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 2 Nov 2017 16:36:53 -0700
Message-ID: <CAGXu5jLJY_zYf=v_xYUEG6tgLzwvW8P+-d9GNNp8XN5bhnWvzQ@mail.gmail.com>
Subject: Re: [PATCH] s390/ap_bus: Convert timers to use timer_setup()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Harald Freudenberger <freude@de.ibm.com>, linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Oct 25, 2017 at 11:38 PM, Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
> On Wed, 25 Oct 2017 03:27:37 -0700
> Kees Cook <keescook@chromium.org> wrote:
>
>> In preparation for unconditionally passing the struct timer_list pointer to
>> all timer callbacks, switch to using the new timer_setup() and from_timer()
>> to pass the timer pointer explicitly.
>>
>> Cc: Harald Freudenberger <freude@de.ibm.com>
>> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Cc: linux-s390@vger.kernel.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  drivers/s390/crypto/ap_bus.c   | 10 +++++-----
>>  drivers/s390/crypto/ap_bus.h   |  2 +-
>>  drivers/s390/crypto/ap_queue.c |  2 +-
>>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> Parked for the second part of the s390 updates for the next merge window.
> Thanks.

Thanks for getting these staged. I just wanted to check with you,
since I don't see these in -next anywhere yet:

s390: qdio: Convert timers to use timer_setup()
s390/sclp: Convert timers to use timer_setup()
s390/cio: Convert timers to use timer_setup()
s390/scsi: Convert timers to use timer_setup()
s390/ap_bus: Convert timers to use timer_setup()

Are all of these expected to land for -rc1? (Would it help to carry
them in the timer tree?) I've got tree-wide changes ready to go once
all these conversions have landed.

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
