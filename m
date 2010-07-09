From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [-next July 9 - s390 ] Badness at fs/sysfs/symlink.c:82 during
 qeth initalization
Date: Fri, 9 Jul 2010 17:33:26 +0200
Message-ID: <20100709173326.72674aea@mschwide.boeblingen.de.ibm.com>
References: <20100709150117.51612026.sfr@canb.auug.org.au>
	<4C36EF9C.7010804@in.ibm.com>
	<m1d3ux55od.fsf@fess.ebiederm.org>
	<4C36F974.4030608@in.ibm.com>
	<20100709142818.GB9041@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20100709142818.GB9041@kroah.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Sachin Sant <sachinp@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-s390@vger.kernel.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 9 Jul 2010 07:28:18 -0700
Greg KH <greg@kroah.com> wrote:

> On Fri, Jul 09, 2010 at 03:57:00PM +0530, Sachin Sant wrote:
> > Eric W. Biederman wrote:
> >>> With today's next(20100709) qeth interface fails to initialize
> >>> with following Badness message:
> >>>     sysfs: symlink across ns_types 0.0.6000/net:eth0 -> net/eth0
> >>>     
> >>
> >> Is this with CONFIG_SYSFS_DEPRECATED set?
> >>
> >> I think I may have made my warning check a little extra strict.
> >>   
> > Yes.
> >
> > CONFIG_SYSFS_DEPRECATED=y
> > CONFIG_SYSFS_DEPRECATED_V2=y
> 
> Why do you have those options enabled?  Does your userspace really
> require them?  I want to remove those options soon, and it would be good
> to find out what is still relying on them.
> 
> If you disable those options, does it then work?

The default configuration for s390 does not have the options enabled and
with a recent userspace everything works just fine. From my point of view
the two options can be removed.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
