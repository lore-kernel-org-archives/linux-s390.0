Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1507151226210.18576@nanos>
References: <cover.1436511577.git.baolin.wang@linaro.org>
	<a1bd8d71caeb4051d0be87aad1baae7ababa4df7.1436511577.git.baolin.wang@linaro.org>
	<alpine.DEB.2.11.1507151226210.18576@nanos>
Date: Wed, 15 Jul 2015 19:42:26 +0800
Message-ID: <CAMz4kuLxBj+82trNVXs9qkuecrKvgdbXuJ3dfvDOCfyJwrDX9Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] cputime: Introduce cputime_to_timespec64()/timespec64_to_cputime()
From: Baolin Wang <baolin.wang@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20150715114226.MnL_LuvHCWYx_YeINAo4sqXqmmya53-Dd-CEtcT9Ro0@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: benh@kernel.crashing.org, Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>, peterz@infradead.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, rth@twiddle.net, riel@redhat.com, cl@linux.com, tj@kernel.org, =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>
List-ID: <linux-s390.vger.kernel.org>

On 15 July 2015 at 18:31, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 15 Jul 2015, Baolin Wang wrote:
>
>> The cputime_to_timespec() and timespec_to_cputime() functions are
>> not year 2038 safe on 32bit systems due to that the struct timepsec
>> will overflow in 2038 year.
>
> And how is this relevant? cputime is not based on wall clock time at
> all. So what has 2038 to do with cputime?
>
> We want proper explanations WHY we need such a change.

When converting the posix-cpu-timers, it call the
cputime_to_timespec() function. Thus it need a conversion for this
function.
You can see that conversion in patch "posix-cpu-timers: Convert to
y2038 safe callbacks" from
https://git.linaro.org/people/baolin.wang/upstream_0627.git.
And I also will explain this in the changelog. Thanks for your comments.

>
> Thanks,
>
>         tglx
>
>


-- 
Baolin.wang
Best Regards
