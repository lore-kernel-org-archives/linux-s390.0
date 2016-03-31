Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 31 Mar 2016 15:26:51 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [GIT PULL] s390 patches for 4.6-rc2
Message-ID: <20160331152651.650e334a@mschwide>
In-Reply-To: <CA+55aFyEDjfDd_Ni3ZUcf4jkwBYvuLZOdmWP-FnRgchW1hj5OQ@mail.gmail.com>
References: <20160331145724.13258ddb@mschwide>
	<CA+55aFyEDjfDd_Ni3ZUcf4jkwBYvuLZOdmWP-FnRgchW1hj5OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 31 Mar 2016 07:59:56 -0500
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Mar 31, 2016 at 7:57 AM, Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> >
> > to receive the following updates:
> >
> > * An interface for dasd driver to query if a volume is online to
> >   another operating system
> > * A proper fix for the lcu locking issue in the dasd driver
> > * Add the new preadv2 and pwritev2 system calls
> > * Define the mark_rodata_ro function and set DEBUG_RODATA=y
> > * A few more bug fixes.
> 
> I'm not seeing that the dasd changes are bugfixes.
> 
> Not pulled. You can try to explain more, but on the whole this looks
> more like a new feature than anything else.

The commit "s390/dasd: add query host access to volume support" introduces
is an attribute 'host_access_count' to find out how many systems are using
a particular device. This is indeed a new feature.

The other large dasd patch "s390/dasd: reorder lcu and device lock" is a
far better solution for the LCU locking that the git commit 9bfefde718c1352d
"s390/dasd: fix incorrect locking order for LCU device add/remove" tries
to solve. That commit has been added with the merge window patches for 4.6.

I really would like to see the "s390/dasd: reorder lcu and device lock" go
into 4.6 as the current solution is really ugly. But I'll remove the patch
with the new attribute. Would that be acceptable?

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
