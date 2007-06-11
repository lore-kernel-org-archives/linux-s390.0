From: Frans Pop <elendil@planet.nl>
Date: Mon, 11 Jun 2007 04:58:12 +0000
Subject: Re: 2.6.21.3 - exceptions & kernel panic when booting Debian Installer
Message-Id: <200706110658.12846.elendil@planet.nl>
In-Reply-To: <20070606114132.GA14756@osiris.boeblingen.de.ibm.com>
References: <20070606114132.GA14756@osiris.boeblingen.de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wednesday 06 June 2007 13:41, Heiko Carstens wrote:
> The new exceptions you are seeing are from directed yield (diag 9c),
> hypfs (diag 224), new ipl/reipl code (diag 308) and new etr code
> (opcode b216). All of them have proper exception handling. That is not
> what is causing problems.

Thanks for the explanation. Not very pretty, but at least I now know they 
can be safely ignored :-)

> Looks like your init process is doing something wrong, so it terminates
> too early (or gets terminated). Can't tell from the output you posted.

Yes, you are right. The issue is caused by the library reduction we do to 
to keep the size of installer initrds as small as possible. If I build 
the initrd without library reduction, the installer boots fine.

With the recent libc updates and some changes in the way library reduction 
is being done we're seeing issues on several architectures, but I failed 
to consider that as the most likely option because of the earlier kernel 
problems on hercules.

Now to narrow this down further...

Thanks again,
FJP
