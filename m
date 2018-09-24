From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 24 Sep 2018 09:21:51 +0000
Subject: Re: [PATCH] s390/cio: Refactor alloc of vfio_ccw_private
Message-Id: <20180924112151.4cabf94d.cohuck@redhat.com>
In-Reply-To: <62cd81fe-47e7-cf4e-67d4-39d1d2ebf1d1@linux.ibm.com>
References: <62cd81fe-47e7-cf4e-67d4-39d1d2ebf1d1@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 21 Sep 2018 09:40:09 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 09/21/2018 07:56 AM, Cornelia Huck wrote:
> > On Thu, 20 Sep 2018 17:19:34 +0200
> > Eric Farman <farman@linux.ibm.com> wrote:

> >> +	vfio_private_cache = kmem_cache_create_usercopy("vfio_ccw_private",
> >> +					sizeof(struct vfio_ccw_private),
> >> +					0, SLAB_ACCOUNT, IOREGION_OFFSET,
> >> +					IOREGION_SIZE, NULL);  
> > 
> > That should work fine, but I'm currently (...) trying to add more
> > regions (for example, for halt/clear handling) and I'm wondering
> > whether we should change how we allocate our I/O regions, for example
> > using a dedicated region that is pointed to by the private structure.
> > Thoughts?  
> 
> That would definitely make this a bit more future proof.  What would be 
> in the new regions, that's not in the ccw_io_region already?  (Which is 
> an orb and an irb, and for some reason another scsw).

The idea is not to include more data (at least for my current use
case), but rather to switch to a structure that allows user space to
specify a command (and sidestep the whole question about whether the
scsw is a real scsw etc.). We'll keep the existing region for ssch, but
I have something that is nearly ready that introduces a new structure
guarded by a capability chain that is used for handling hsch/csch (and
that I'll post if I ever find a spare minute.) Other possible uses are
path handling and other things.
