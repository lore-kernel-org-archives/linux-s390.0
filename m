From: Leonardo Bras <leobras.c@gmail.com>
Subject: Re: [PATCH v3 3/7] drivers: parisc: Avoids building driver if
 CONFIG_PARISC is disabled
Date: Tue, 9 Oct 2018 22:01:50 -0300
Message-ID: <CADvQ+rG0wn5_msc5Z_QgqV0+Qvr4kueF32T69qS0UjvHRz+Y+g@mail.gmail.com>
References: <20180928020816.11251-1-leobras.c@gmail.com> <20180928020816.11251-4-leobras.c@gmail.com>
 <1538118915.3593.4.camel@HansenPartnership.com> <CADvQ+rGQenkoE0xCRTwjA5BuKZbZ2Upkyx=+qWFUGnUcit-aCQ@mail.gmail.com>
 <1538628062.18776.5.camel@HansenPartnership.com> <CADvQ+rG0WQjFTU=A4tAACvqFevw51DX_-yq2-9j78T8pSrjcXQ@mail.gmail.com>
 <765df6c3-0339-ebf3-6446-cef4fc1eb1cc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <765df6c3-0339-ebf3-6446-cef4fc1eb1cc@gmail.com>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: schmitzmic@gmail.com
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, lkcamp@lists.libreplanetbr.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Finn Thain <fthain@telegraphics.com.au>, Robert Richter <rric@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Michael,

> That already works, doesn't it? So all that you'd need is an offline
> tool to precompute what drivers to actually build with a given config.
>
> 'make -n' with some suitable output mangling might do the job.
>
> There may well be other ways to achieve your stated goal, without any
> need to make changes to the kernel build process (which is the result of
> many years of evolution and tuning, BTW).

Thanks for the info, I will try to use it.

> > This change is not supposed to bother the usual way of building the kernel, and
>
> Enough people have voiced their concern to warrant that you should back
> up that claim, IMO. Have you verified that your patchset does not change
> current behaviour when building the entire set of default configurations
> for each supported architecture? Does it reduce or increase overall
> complexity of the build process?
>
I have tried in some ARCHs and it worked fine. Out of curiosity, I
will try on all
of them.

> > it is not even supposed to add overhead to kernel compilation. And it would,
> > at least, solve my problem with the 3h limit, and enable the tool
> > I am building on GiltabCI to help other developers.
>
> (Apropos of nothing: Am I the only one who thinks gitlab might take a
> rather dim view of your creativity in dealing with their limit?)
>

They make available 50k minutes a month for OSS projects. I don't believe they
care how it's spent if its used to build/deploy the project. They even
allow using
several 'jobs' in parallel in order to speed up the process.

Thanks for your help,

Leonardo Bras
