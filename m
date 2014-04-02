From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Date: Wed, 02 Apr 2014 17:32:39 +0000
Subject: Re: linux-3.10+: unable to boot 31bit builds
Message-Id: <alpine.LFD.2.11.1404021920510.1495@denkbrett>
In-Reply-To: <alpine.LFD.2.11.1404021657140.10939@denkbrett>
References: <alpine.LFD.2.11.1404021657140.10939@denkbrett>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

On Wed, 2 Apr 2014, Sebastian Ott wrote:
> On Wed, 2 Apr 2014, Mike Frysinger wrote:
> > On Wed 22 Jan 2014 08:55:36 Heiko Carstens wrote:
> > > On Tue, Jan 21, 2014 at 12:58:36PM +0100, Heiko Carstens wrote:
> > > > On Tue, Jan 21, 2014 at 12:22:52PM +0100, Heiko Carstens wrote:
> > > > > On Tue, Jan 21, 2014 at 04:57:39AM -0500, Mike Frysinger wrote:
> > > > > > hmm, doesn't seem to work for me.  don't get a crash, just a "virtual
> > > > > > machine is placed in CP mode due to a SIGP initial C".  whatever that
> > > > > > means :).> > 
> > > > > Ah, that probably happened because the kernel failed to mount the
> > > > > root file system and killed all CPUs before printing a nice error
> > > > > message.
> > > > 
> > > > Ok, that's not correct. Just bisected it down to:
> > > > 
> > > > commit 14556b33f2a5d6a3bc75cd33b709452a31555b25
> > > > Author: Sebastian Ott <sebott@linux.vnet.ibm.com>
> > > > Date:   Sat Apr 13 13:03:54 2013 +0200
> > > > 
> > > >     s390/css: introduce cio_register_early_subchannels
> > > >     
> > > >     Use cio_register_early_subchannels to register early subchannels
> > > >     which are already in use. Call this function before we do the
> > > >     actual subchannel scanning loop. This helps us to get rid of some
> > > >     more special cases regarding the console subchannel.
> > > >     
> > > >     Reviewed-by: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
> > > >     Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
> > > >     Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > > 
> > > > For some non-obvious reason this kills 31 bit with your config under z/VM.
> > > 
> > > The patch below fixes this for me...
> > > The difference for 64 vs 32 bit was probably that even if cdev->drv was a
> > > NULL pointer, dereferencing cdev->drv->path_event was also NULL by
> > > coincidence. While on 32 bit it is not NULL and the kernel jumped to
> > > somehere...
> > > 
> > > With all three patches within this thread s390 with CONFIG_64BIT=n ipl's
> > > again, and the 32 bit native statfs64 syscall works as well.
> > > 
> > > However I would strongly suggest to use CONFIG_64BIT=y with CONFIG_COMPAT=y
> > > instead for (now) obvious reasons ;)
> > > 
> > > diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
> > > index c7638c543250..b19ab38a5e9a 100644
> > > --- a/drivers/s390/cio/device_fsm.c
> > > +++ b/drivers/s390/cio/device_fsm.c
> > > @@ -484,7 +484,7 @@ static void ccw_device_report_path_events(struct
> > > ccw_device *cdev) if (mask & cdev->private->pgid_reset_mask & sch->vpm)
> > >  			path_event[chp] |= PE_PATHGROUP_ESTABLISHED;
> > >  	}
> > > -	if (cdev->online && cdev->drv->path_event)
> > > +	if (cdev->online && cdev->drv && cdev->drv->path_event)
> > >  		cdev->drv->path_event(cdev, path_event);
> > >  }
> > 
> > looks like this patch was dropped somewhere ?  i had to re-apply it to my 3.14 
> > build to get it to boot ...
> > -mike
> 
> The commit to fix this is 2253e8d79 (which is included in 3.14). I'll
> try an 31bit build with 3.14.

Indeed...3.14 failed. 2253e8d79 is _not_ included in 3.14 - my git-fu let
me down. I used
$ git describe 2253e8d
v3.14-rc3-169-g2253e8d

and assumed it was in 3.14. I usually use
$ git describe --contains 2253e8d
fatal: cannot describe '2253e8d79237c69086ded391e6767afe16972527'

which should have told me that there is no tag after this commit (since
there is no v3.15-rc1 yet). Sorry for the confusion. You can cherry-pick
2253e8d on top of 3.14 and it'll work.

Regards,
Sebastian
