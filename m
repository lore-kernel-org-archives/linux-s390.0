From: Petr Machata <pmachata@gmail.com>
Date: Wed, 11 Nov 2015 18:21:04 +0000
Subject: Re: [PATCH] ltrace: update s390 system call tables
Message-Id: <CAKfwACUm_fLFkOf7ymGhs=xc_XBXUe-jmBGZikpTfZgg7QKMow@mail.gmail.com>
In-Reply-To: <1446812905-56448-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1446812905-56448-1-git-send-email-heiko.carstens@de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

2015-11-06 13:28 GMT+01:00 Heiko Carstens <heiko.carstens@de.ibm.com>:
> just a simple patch for ltrace to add update and fix the system call tables
> on s390. In addition this also slightly improves the script to generate
> the tables.

Thanks, applied.

There was some trickery with the repository.  It seems Alioth now
hosts GITs on scm.alioth.debian.org//git/ltrace/ltrace.git, whereas it
was scm.alioth.debian.org/git/collab-maint/ltrace.git before.  The old
repo refused my commits, I noticed the change, and pushed to the new
repo.  But that didn't have updates since early last year, which I
didn't notice.  So currently your patch is commited all the way back
among commits from like February 2014.  The newer commits are rebased
on top of that.  I don't think it makes much difference, we didn't
have a release in that time period.

Thanks,
Petr
