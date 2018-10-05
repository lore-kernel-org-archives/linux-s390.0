From: Leonardo Bras <leobras.c@gmail.com>
Subject: Re: [PATCH v3 3/7] drivers: parisc: Avoids building driver if
 CONFIG_PARISC is disabled
Date: Thu, 4 Oct 2018 23:16:24 -0300
Message-ID: <CADvQ+rG0WQjFTU=A4tAACvqFevw51DX_-yq2-9j78T8pSrjcXQ@mail.gmail.com>
References: <20180928020816.11251-1-leobras.c@gmail.com> <20180928020816.11251-4-leobras.c@gmail.com>
 <1538118915.3593.4.camel@HansenPartnership.com> <CADvQ+rGQenkoE0xCRTwjA5BuKZbZ2Upkyx=+qWFUGnUcit-aCQ@mail.gmail.com>
 <1538628062.18776.5.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538628062.18776.5.camel@HansenPartnership.com>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: lkcamp@lists.libreplanetbr.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Finn Thain <fthain@telegraphics.com.au>, Robert Richter <rric@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> Well it's not really that persuasive.  Most people simply let the build
> run to completion, but if you have a problem with a job control 3h
> timelimit, then create a job that kills itself at 2:59 and then
> resubmits itself.  That will produce a complete build in 3h chunks
> without any need to call sub Makefiles.
>

Humm, I probably should have explained better how GitlabCI works.
It works creating a docker container that have a limited lifespan of 3h max.
After that the time is over, this container ceases to exist, leaving no build
objects, only the console log. So there is no way of 'resuming' the building
from where it stopped. I used the 'job' term because it's how they call it,
and I understand it's easily confused with bash jobs.

> All of our Makefiles are coded assuming the upper level can prevent
> descent into the lower ones.  You're proposing to change that
> assumption, requiring a fairly large patch set, which doesn't really
> seem to provide a huge benefit.
>
> James

I understand your viewpoint.
But what I propose is not to change that assumption, but instead give some
Makefiles the aditional ability to be called directly and still not build stuff
if they were not enabled in .config.

But, why these chosen Makefiles, and not all of them?
Granularity.
What I am trying to achieve with this patchset is the ability of building
smaller sets of drivers without accidentally building what is not enabled
on .config.
And, in my viewpoint, building a single drivers/DRIVERNAME is small enough to
be fast in most situations.

This change is not supposed to bother the usual way of building the kernel, and
it is not even supposed to add overhead to kernel compilation. And it would,
at least, solve my problem with the 3h limit, and enable the tool
I am building on GiltabCI to help other developers.

Thanks for reading,

Leonardo Bras
