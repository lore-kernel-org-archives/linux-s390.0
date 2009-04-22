From: Frans Pop <elendil@planet.nl>
Date: Wed, 22 Apr 2009 18:08:38 +0000
Subject: Re: [PATCH] s390: restore tape probe info message
Message-Id: <200904222008.39262.elendil@planet.nl>
In-Reply-To: <20090422191445.51154ad7@cotte.boeblingen.de.ibm.com>
References: <20090422191445.51154ad7@cotte.boeblingen.de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wednesday 22 April 2009, Carsten Otte wrote:
> Am Wed, 22 Apr 2009 14:44:17 +0200
>
> schrieb Frans Pop <elendil@planet.nl>:
> > Bring back a basic "new device detected" message.
>
> I fail to see why that is an important information.

I agree it's not essential, but IMO it is useful. It's also fairly 
standard in the kernel to have at least some indication in dmesg by 
default that a device driver was loaded, or rather, that a new device has 
been detected and is now available.

I also don't think there's any harm in having an informative message.
I would not mind if the level was changed from info to debug though.

> If one wants to figure out, it's easy to either
> use the usermode helper on device hotplug to log
> a message, or just have a process do inotify on
> /dev. Both ways are device driver independent.

That sounds too much like having to jump through hoops.

Cheers,
FJP
