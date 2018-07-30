From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 30 Jul 2018 12:01:15 +0000
Subject: Re: [PATCH v7 05/22] s390/zcrypt: AP bus support for alternate driver(s)
Message-Id: <20180730140115.47306702.cohuck@redhat.com>
In-Reply-To: <20180727095344.5f2049ca.cohuck@redhat.com>
References: <20180727095344.5f2049ca.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 27 Jul 2018 09:53:44 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, 26 Jul 2018 21:54:12 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> > For the first shot the two masks located in sysfs at
> > /sys/bus/ap/apmask and /sys/bus/ap/aqmask are read-only and by default
> > all APQNs belong to the ap bus and the default drivers:
> > 
> >   cat /sys/bus/ap/apmask
> >   0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> >   cat /sys/bus/ap/aqmask
> >   0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> > 
> > The only way to change these masks is currently via kernel command
> > line, for example like:
> > 
> >   ... ap.apmask=0xffff ap.aqmask=0x40
> > 
> > would give these two pools:
> > 
> >   default drivers pool:    adapter 0 - 15, domain 1
> >   alternate drivers pool:  adapter 0 - 15, all but domain 1
> > 			   adapter 16-255, all domains  
> 
> This looks a bit non-intuitive to me. Is there an easy way to determine
> the masks if all I know is the list of apqns I want to have in the
> default respectively alternate drivers pool?

What about an interface based on ranges and exclusion (like e.g.
cio_ignore) instead?

ap.apmask=0x0-0xf ap.aqmask=0x1 for the example above

and you could do something like ap.apmask=all,!0xf to specify all
adapters but adapter 15.

For the output, we can rely on tooling to get something that is easily
readable, but requiring users to fiddle with bitmasks is error-prone,
even if it is a good representation internally.
