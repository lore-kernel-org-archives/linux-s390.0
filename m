Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171017110658.0f05a0ab@mschwideX1>
References: <20171016234325.GA102019@beast> <20171017105847.2dbd7be7@mschwideX1>
 <20171017110658.0f05a0ab@mschwideX1>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 17 Oct 2017 08:17:24 -0700
Message-ID: <CAGXu5jK-HGkAhnmLMUwnyNXpDjcV-zB1XieNWrndh8w+ZnL7cA@mail.gmail.com>
Subject: Re: [PATCH] s390/cio: Convert timers to use timer_setup()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Oct 17, 2017 at 2:06 AM, Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
> On Tue, 17 Oct 2017 10:58:47 +0200
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
>> On Mon, 16 Oct 2017 16:43:25 -0700
>> Kees Cook <keescook@chromium.org> wrote:
>>
>> > In preparation for unconditionally passing the struct timer_list
>> > pointer to all timer callbacks, switch to using the new timer_setup()
>> > and from_timer() to pass the timer pointer explicitly.
>> >
>> > Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
>> > Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
>> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> > Cc: linux-s390@vger.kernel.org
>> > Signed-off-by: Kees Cook <keescook@chromium.org>
>> > ---
>> >  drivers/s390/cio/device.c     |  8 ++++----
>> >  drivers/s390/cio/device.h     |  2 ++
>> >  drivers/s390/cio/device_fsm.c | 10 ++++------
>> >  drivers/s390/cio/eadm_sch.c   |  9 ++++-----
>> >  4 files changed, 14 insertions(+), 15 deletions(-)
>>
>> Applied to s390/linux:feature branch. Thanks.
>
> On second though, this will be postponed until the first merge of
> the s390/linux tree in 4.15 merge window has been done. I do not
> want to rebase the features branch and without the base timer code
> the branch will not compile. But be assured the patch is accepted
> and queued, just not visible yet.

Okay, thanks!

-Kees

-- 
Kees Cook
Pixel Security
