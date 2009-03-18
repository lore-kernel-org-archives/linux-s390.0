Return-Path: <linux-kernel-owner+w=401wt.eu-S1755630AbZCRPtn@vger.kernel.org>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator -
 hang traced
From: John Stultz <johnstul@us.ibm.com>
In-Reply-To: <200903181307.44867.elendil@planet.nl>
References: <200903080230.10099.elendil@planet.nl>
	 <1237344897.6160.136.camel@localhost> <20090318102825.32c821f3@skybase>
	 <200903181307.44867.elendil@planet.nl>
Content-Type: text/plain
Date: Wed, 18 Mar 2009 08:48:58 -0700
Message-Id: <1237391338.32698.9.camel@jstultz-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Frans Pop <elendil@planet.nl>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2009-03-18 at 13:07 +0100, Frans Pop wrote:
> > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Reported-by: Frans Pop <elendil@planet.nl>
> Tested-by: Frans Pop <elendil@planet.nl>
> 
> I've tried this patch with 2.6.28.8 and it fixes the hang! Maybe that
> aspect should be mentioned in the commit log?
> 
> I've also tested the patch with 2.6.29-rc8 and it also fixes the hang
> during login I reported with that [1]. Which means that not only jiffies is
> affected, but also tod! And that does not really surprise me because after
> the system switches to tod, I also see a continuously increasing error
> with clock->xtime_nsec always equal to -4096 (see below).
> 
> Am I correct that any kernel starting from 2.6.19 is affected by this, and
> that it's the most likely cause of Debian bug report
> http://bugs.debian.org/511334? If so, I'll get it pushed into Debian's
> stable kernels.

Cool!

> Ever increasing error with tod on 2.6.28.8 (with Martin's patch applied):
>      0.672655! timekeeping: clock source changed from jiffies to tod (shift: 12)
>      0.676889! tod/12 (150): xtime.tv: 1237377507/55524946 -> 1237377507/55524947
>      0.677020!    clock->xtime: 0 -> -4096, error: 0 -> -4294967296
>      0.680788! tod/12 (151): xtime.tv: 1237377507/55524947 -> 1237377507/55524948
>      0.680919!    clock->xtime: -4096 -> -4096, error: -4294967296 -> -8589934592
>      0.685280! tod/12 (152): xtime.tv: 1237377507/55524948 -> 1237377507/55524949
>      0.685411!    clock->xtime: -4096 -> -4096, error: -8589934592 -> -12884901888
>      4.685237! tod/12 (1152): xtime.tv: 1237377511/55525948 -> 1237377511/55525949
>      4.685356!    clock->xtime: -4096 -> -4096, error: -4303557230592 -> -4307852197888
>     20.700920! tod/12 (5155): xtime.tv: 1237377527/55529951 -> 1237377527/55529952
>     20.701057!    clock->xtime: -4096 -> -4096, error: -21496311316480 -> -21500606283776
>     32.864888! tod/12 (8160): xtime.tv: 1237377539/55532956 -> 1237377539/55532957
>     32.865008!    clock->xtime: -4096 -> -4096, error: -34402688040960 -> -34406983008256
>     86.760987! tod/12 (21172): xtime.tv: 1237377593/55545968 -> 1237377593/55545969
>     86.761120!    clock->xtime: -4096 -> -4096, error: -90288802496512 -> -90293097463808
>    127.100183! tod/12 (29180): xtime.tv: 1237377633/55553976 -> 1237377633/55553977
>    127.100304!    clock->xtime: -4096 -> -4096, error: -124682900602880 -> -124687195570176
>    491.860765! tod/12 (37189): xtime.tv: 1237377998/55561985 -> 1237377998/55561986
>    491.860886!    clock->xtime: -4096 -> -4096, error: -159081293676544 -> -159085588643840

Hrm. Is the box otherwise working ok? The TOD clock should not be
affected by the second issue (one shot mode) discussed.

thanks
-john
