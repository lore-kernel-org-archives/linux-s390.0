Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 0/4] S390: Fine-tuning for six function implementations
References: <fac68081-f0bb-2574-ba52-11ad78d792c3@users.sourceforge.net>
From: Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <51ba03f7-d1d8-8064-7dee-b5a910ad47de@oracle.com>
Date: Tue, 9 May 2017 10:04:57 +0200
MIME-Version: 1.0
In-Reply-To: <fac68081-f0bb-2574-ba52-11ad78d792c3@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-s390@vger.kernel.org, =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Sascha Silbe <silbe@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 05/07/17 19:12, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 7 May 2017 19:00:09 +0200
>
> A few update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (4):
>   Combine two function calls into one in show_cacheinfo()
>   Use seq_putc() in show_cpu_summary()
>   Replace six seq_printf() calls by seq_puts()
>   Combine two function calls into one at four places
>
>  arch/s390/kernel/cache.c     |  4 ++--
>  arch/s390/kernel/processor.c |  2 +-
>  arch/s390/kernel/sysinfo.c   | 25 +++++++++++--------------
>  3 files changed, 14 insertions(+), 17 deletions(-)
>

I'm sorry, I wouldn't normally respond to this, but I was put on the Cc
after all so I'll give my feedback.

I think these patches are a waste of time and a resources.

It would be different if your patches fixed actual bugs. This is just
mindless code transformations that MAY in the best case save a few bytes
of code here and there (I don't know; you didn't say).

But the potential gains from these incredibly numerous and tiny patches
that don't fix anything are so small, it's a waste of time, bandwidth,
and mental capacity for you and for everybody involved.

I just searched my inbox for patches from you and you sent literally
_hundreds_ over the past few days, all doing this crazy printf/puts/putc
transformation.

Another bit of searching and I see that I'm not the first one giving you
this response:

https://lkml.org/lkml/2017/1/23/383 - Jens Axboe
https://lkml.org/lkml/2017/1/23/262 - Johannes Thumshirn
https://lkml.org/lkml/2017/1/12/513 - Cyrille Pitchen
https://lkml.org/lkml/2016/10/24/491 - Theodore Ts'o
https://lkml.org/lkml/2016/10/7/148 - Dan Carpenter
https://lkml.org/lkml/2016/9/14/58 - Christian Borntraeger

...and I'm sure there are many more.


Vegard
