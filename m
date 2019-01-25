From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
Date: Fri, 25 Jan 2019 13:58:07 +0100
Message-ID: <20190125135807.17c59cdd@oc2783563651>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 24 Jan 2019 21:25:10 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> >   	private = dev_get_drvdata(mdev_parent_dev(mdev));
> > -	if (private->state != VFIO_CCW_STATE_IDLE)
> > +	if (private->state == VFIO_CCW_STATE_NOT_OPER ||
> > +	    private->state == VFIO_CCW_STATE_STANDBY)
> >   		return -EACCES;
> > +	if (!mutex_trylock(&private->io_mutex))
> > +		return -EAGAIN;  
> 
> Ah, I see Halil's difficulty here.
> 
> It is true there is a race condition today, and that this doesn't 
> address it.  That's fine, add it to the todo list.  But even with that, 
> I don't see what the mutex is enforcing?  

It is protecting the io regions. AFAIU the idea was that only one
thread is accessing the io region(s) at a time to prevent corruption and
reading half-morphed data.

> Two simultaneous SSCHs will be 
> serialized (one will get kicked out with a failed trylock() call), while 
> still leaving the window open between cc=0 on the SSCH and the 
> subsequent interrupt.  In the latter case, a second SSCH will come 
> through here, do the copy_from_user below, and then jump to fsm_io_busy 
> to return EAGAIN.  Do we really want to stomp on io_region in that case?

I'm not sure I understood you correctly. The interrupt handler does not
take the lock before writing to the io_region. That is one race but it is
easy to fix.

The bigger problem is that between the interrupt handler has written IRB
area and userspace has read it we may end up destroying it by stomping on
it (to use your words). The userspace reading a wrong (given todays qemu
zeroed out) IRB could lead to follow on problems.
 
>   Why can't we simply return EAGAIN if state==BUSY?
> 

Sure we can. That would essentially go back to the old way of things:
if not idle return with error. Just the error code returned would change
form EACCESS to EAGAIN. Which Isn't necessarily a win, because
conceptually here should be never two interleaved io_requests/start
commands hitting the module.


> >   
> >   	region = private->io_region;
> > -	if (copy_from_user((void *)region + *ppos, buf, count))
> > -		return -EFAULT;
> > +	if (copy_from_user((void *)region + *ppos, buf, count)) {
> > +		ret = -EFAULT;
> > +		goto out_unlock;
> > +	}
