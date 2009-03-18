Return-Path: <linux-kernel-owner+w=401wt.eu-S1757667AbZCRMIA@vger.kernel.org>
From: Frans Pop <elendil@planet.nl>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator - hang traced
Date: Wed, 18 Mar 2009 13:07:42 +0100
References: <200903080230.10099.elendil@planet.nl> <1237344897.6160.136.camel@localhost> <20090318102825.32c821f3@skybase>
In-Reply-To: <20090318102825.32c821f3@skybase>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903181307.44867.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: john stultz <johnstul@us.ibm.com>, linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wednesday 18 March 2009, john stultz wrote:
> In my testing, this isn't really specific to the recent rounding
> change, however the rounding change made the issue crop up fast enough
> that it could be seen, whereas before the issue wouldn't crop up before
> the tod clock was installed. If you boot w/ clocksource=jiffies, you'll
> probably see the hang with your working kernels as well, only at a
> later point (it would be helpful if you would verify that and let me
> know).

Confirmed. It then hangs while checking/loading the initramfs.

On Wednesday 18 March 2009, Martin Schwidefsky wrote:
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
>
> The implementation of __div64_31 for G5 machines is broken. The
> comments in __div64_31 are correct, only the code does not do what the
> comments say. The part "If the remainder has overflown subtract base
> and increase the quotient" is only partially realized, the base is
> subtracted correctly but the quotient is only increased if the dividend
> had the last bit set. Using the correct instruction fixes the problem.
>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reported-by: Frans Pop <elendil@planet.nl>
Tested-by: Frans Pop <elendil@planet.nl>

I've tried this patch with 2.6.28.8 and it fixes the hang! Maybe that
aspect should be mentioned in the commit log?

I've also tested the patch with 2.6.29-rc8 and it also fixes the hang
during login I reported with that [1]. Which means that not only jiffies is
affected, but also tod! And that does not really surprise me because after
the system switches to tod, I also see a continuously increasing error
with clock->xtime_nsec always equal to -4096 (see below).

Am I correct that any kernel starting from 2.6.19 is affected by this, and
that it's the most likely cause of Debian bug report
http://bugs.debian.org/511334? If so, I'll get it pushed into Debian's
stable kernels.

Cheers,
FJP

[1] http://marc.info/?t=123656370500001&r=1&w=2

Ever increasing error with tod on 2.6.28.8 (with Martin's patch applied):
     0.672655! timekeeping: clock source changed from jiffies to tod (shift: 12)
     0.676889! tod/12 (150): xtime.tv: 1237377507/55524946 -> 1237377507/55524947
     0.677020!    clock->xtime: 0 -> -4096, error: 0 -> -4294967296
     0.680788! tod/12 (151): xtime.tv: 1237377507/55524947 -> 1237377507/55524948
     0.680919!    clock->xtime: -4096 -> -4096, error: -4294967296 -> -8589934592
     0.685280! tod/12 (152): xtime.tv: 1237377507/55524948 -> 1237377507/55524949
     0.685411!    clock->xtime: -4096 -> -4096, error: -8589934592 -> -12884901888
     4.685237! tod/12 (1152): xtime.tv: 1237377511/55525948 -> 1237377511/55525949
     4.685356!    clock->xtime: -4096 -> -4096, error: -4303557230592 -> -4307852197888
    20.700920! tod/12 (5155): xtime.tv: 1237377527/55529951 -> 1237377527/55529952
    20.701057!    clock->xtime: -4096 -> -4096, error: -21496311316480 -> -21500606283776
    32.864888! tod/12 (8160): xtime.tv: 1237377539/55532956 -> 1237377539/55532957
    32.865008!    clock->xtime: -4096 -> -4096, error: -34402688040960 -> -34406983008256
    86.760987! tod/12 (21172): xtime.tv: 1237377593/55545968 -> 1237377593/55545969
    86.761120!    clock->xtime: -4096 -> -4096, error: -90288802496512 -> -90293097463808
   127.100183! tod/12 (29180): xtime.tv: 1237377633/55553976 -> 1237377633/55553977
   127.100304!    clock->xtime: -4096 -> -4096, error: -124682900602880 -> -124687195570176
   491.860765! tod/12 (37189): xtime.tv: 1237377998/55561985 -> 1237377998/55561986
   491.860886!    clock->xtime: -4096 -> -4096, error: -159081293676544 -> -159085588643840
