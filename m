From: Leonardo Bras <leobras.c@gmail.com>
Subject: Re: [PATCH v3 0/7] Remove errors building drivers/DRIVERNAME
Date: Wed, 3 Oct 2018 12:46:15 -0300
Message-ID: <CADvQ+rETmm2Ag4sijXG-0Aya7B0oww7LkLgijAC+nznyWskkvg@mail.gmail.com>
References: <20180928020816.11251-1-leobras.c@gmail.com> <20181001075607.GA3776@rric.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001075607.GA3776@rric.localdomain>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: Robert Richter <rric@kernel.org>
Cc: lkcamp@lists.libreplanetbr.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Finn Thain <fthain@telegraphics.com.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Oct 1, 2018 at 4:56 AM Robert Richter <rric@kernel.org> wrote:
>
> On 27.09.18 23:08:09, Leonardo Br=C3=A1s wrote:
> > This Patchset changes some driver's Makefile to allow them building
> > using the command 'make drivers/DRIVERNAME', if compatible.
> >
> > The changed drivers would return error if the above command was run
> > on them, after an x86 allyesconfig.
>
> I don't see what you are trying to achieve here. Why shouldn't the
> command fail if it is not the intended way to call it? There are a
> couple of use cases where drivers/ is used to share common code over
> different archs and it is not always the intention to build them in
> drivers/ directly.


Sorry, I was not very clear at my reasons why this change is important,
I will try to briefly explain the whole story.

Some weeks ago I was trying to solve a task that needed to change some
compiling options, build the whole kernel (allyesconfig) and look for error=
s.
The problem was: It would take a long time to build everything in my comput=
er.
And many friends with slimmer laptops would take much longer.

So, I was looking for a service that could do that for me, in the cloud.
I found out Gitlab.com offers free 50k minutes of CI for open source projec=
ts,
and allows anyone get this CI time by only forking my project, adding their
changes and pushing to Gitlab.

But Gitlab don't allow 'jobs' to take longer than 3 hours, after that the '=
job'
is killed.

The kernel could not be built in 3h, not with allyesconfig. So, I created a
'job' for each directory in Linux kernel, and tried to build them separatel=
y.
All went fine, except for drivers/, which took over 3 hours.

Most logical thing was to continue the division and create five 'jobs' that
could divide the building time of drivers. To do that, each job took care o=
f a
range of starting letters, as you can see in this link:
https://gitlab.com/LeoBras/linux-next/blob/build-ci/.gitlab-ci.yml

But then I found out some drivers were failing to build. Even if they were =
not
enabled in my .config. After some work I found out some drivers selection i=
s
done in drivers/Makefile, and incompatible drivers would break my build if
tried to call them directly on drivers/DRIVERNAME.

This patchset intents to let the .config selection happen also in
drivers/DRIVERNAME/Makefile, avoiding accidentally building drivers
that are not in .config.

This would allow the kernel to be build on Gitlab CI, and would benefit man=
y
people who wants to help in the kernel development, but have not much
processing power in their machines.

I understand my changes may have mistakes, and I am trying to fix them all.
I thank you any suggestion to make the code better.

Also, I would be happy to know of any other solution to remote build my cha=
nges
and look for warnkings / errors.


Thank you for reading,
Leonardo Bras
