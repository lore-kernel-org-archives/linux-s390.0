From: Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH v3 3/7] drivers: parisc: Avoids building driver if
 CONFIG_PARISC is disabled
Date: Sat, 6 Oct 2018 17:28:41 +1300
Message-ID: <765df6c3-0339-ebf3-6446-cef4fc1eb1cc@gmail.com>
References: <20180928020816.11251-1-leobras.c@gmail.com>
 <20180928020816.11251-4-leobras.c@gmail.com>
 <1538118915.3593.4.camel@HansenPartnership.com>
 <CADvQ+rGQenkoE0xCRTwjA5BuKZbZ2Upkyx=+qWFUGnUcit-aCQ@mail.gmail.com>
 <1538628062.18776.5.camel@HansenPartnership.com>
 <CADvQ+rG0WQjFTU=A4tAACvqFevw51DX_-yq2-9j78T8pSrjcXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADvQ+rG0WQjFTU=A4tAACvqFevw51DX_-yq2-9j78T8pSrjcXQ@mail.gmail.com>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: Leonardo Bras <leobras.c@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: lkcamp@lists.libreplanetbr.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Finn Thain <fthain@telegraphics.com.au>, Robert Richter <rric@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



Am 05.10.2018 um 15:16 schrieb Leonardo Bras:
>> Well it's not really that persuasive.  Most people simply let the build
>> run to completion, but if you have a problem with a job control 3h
>> timelimit, then create a job that kills itself at 2:59 and then
>> resubmits itself.  That will produce a complete build in 3h chunks
>> without any need to call sub Makefiles.
>>
>
> Humm, I probably should have explained better how GitlabCI works.
> It works creating a docker container that have a limited lifespan of 3h max.
> After that the time is over, this container ceases to exist, leaving no build
> objects, only the console log. So there is no way of 'resuming' the building
> from where it stopped. I used the 'job' term because it's how they call it,
> and I understand it's easily confused with bash jobs.
>
>> All of our Makefiles are coded assuming the upper level can prevent
>> descent into the lower ones.  You're proposing to change that
>> assumption, requiring a fairly large patch set, which doesn't really
>> seem to provide a huge benefit.
>>
>> James
>
> I understand your viewpoint.
> But what I propose is not to change that assumption, but instead give some
> Makefiles the aditional ability to be called directly and still not build stuff
> if they were not enabled in .config.
>
> But, why these chosen Makefiles, and not all of them?
> Granularity.
> What I am trying to achieve with this patchset is the ability of building
> smaller sets of drivers without accidentally building what is not enabled
> on .config.
> And, in my viewpoint, building a single drivers/DRIVERNAME is small enough to
> be fast in most situations.

That already works, doesn't it? So all that you'd need is an offline 
tool to precompute what drivers to actually build with a given config.

'make -n' with some suitable output mangling might do the job.

There may well be other ways to achieve your stated goal, without any 
need to make changes to the kernel build process (which is the result of 
many years of evolution and tuning, BTW).

> This change is not supposed to bother the usual way of building the kernel, and

Enough people have voiced their concern to warrant that you should back 
up that claim, IMO. Have you verified that your patchset does not change 
current behaviour when building the entire set of default configurations 
for each supported architecture? Does it reduce or increase overall 
complexity of the build process?

> it is not even supposed to add overhead to kernel compilation. And it would,
> at least, solve my problem with the 3h limit, and enable the tool
> I am building on GiltabCI to help other developers.

(Apropos of nothing: Am I the only one who thinks gitlab might take a 
rather dim view of your creativity in dealing with their limit?)

> Thanks for reading,
>
> Leonardo Bras

Thanks for listening!

Cheers,

	Michael
