Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 18 Feb 2014 10:45:33 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH RFC/RFT v2 3/8] s390: move cacheinfo sysfs to generic
 cacheinfo infrastructure
Message-ID: <20140218094533.GA4085@osiris>
References: <1391791763-28518-1-git-send-email-sudeep.holla@arm.com>
 <1391791763-28518-4-git-send-email-sudeep.holla@arm.com>
 <20140210113019.GC19013@osiris>
 <530256CB.6000603@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <530256CB.6000603@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sudeep Holla <Sudeep.Holla@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Sudeep,

> > Please have a look at these two commits which should describe why things
> > are as they are on s390:
> > 
> > 881730ad365130f64b5c70c40904b04eb3b79de3
> >  "s390/cache: expose cpu cache topology via sysfs"
> > 6668022c7bde3fdc96d3d257294a7216c7a46829
> >  "s390/cache: add cpu cache information to /proc/cpuinfo"
> > 
>
> I need your help to get few things clarified.
> 
> IIUC, I see that shared caches are not exposed via sysfs but there are exposed
> through /proc/cpuinfo, right ?

Yes.

> If yes, based on your above statement, shared
> cpus are may not be system-wide, then how can /proc/cpuinfo show shared
> cache info.

/proc/cpuinfo shows the information of the underlying hardware but we
cannot tell which second level (virtual) cpus share which caches.
There simply is no such interface available.

Also, if there would be such an interface, it would be only valid until
the hypervisor decides to schedule a virtual cpu on a different physical
cpu; which in turn would mean that we would have to update the cpu maps
all the time.

In order to avoid all those games, we decided to only expose cpu private
caches via sysfs, so we obviously have static cpu maps.

However since the physical cache information may be of interest for a
guest operating system there is the second interface /proc/cpuinfo
which provides this.
