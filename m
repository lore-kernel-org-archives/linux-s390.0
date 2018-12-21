From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 0/3] vfio-ccw: support hsch/csch (kernel
 part)
Date: Fri, 21 Dec 2018 13:42:22 +0100
Message-ID: <20181221134222.562a790e@oc2783563651>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181204133810.66e8cfe5@oc2783563651>
	<20181204141130.06496b9b.cohuck@redhat.com>
	<20181204160236.54de2784@oc2783563651>
	<20181205135402.33c2b22d.cohuck@redhat.com>
	<20181206194714.31e9f43a@oc2783563651>
	<20181207110529.3b293124.cohuck@redhat.com>
	<20181207175423.6c45621f@oc2783563651>
	<20181219125442.08eb053d.cohuck@redhat.com>
	<20181219151719.218dd2a2@oc2783563651>
	<20181221122332.61674eeb.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20181221122332.61674eeb.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 21 Dec 2018 12:23:32 +0100
Cornelia Huck <cohuck@redhat.com> wrote:
[..]
> 
> You've really lost me here :( I fear you're criticizing something I
> don't want to implement; I'll write some code, that should make things
> much easier to discuss.
> 

Nod.


> TBH, I have no idea how this will scale to many vfio-ccw devices.
> 
> > 
[..]
> > As long as you return -EAGAIN we are fine. But AFAIU you proposed to
> > do that until the I/O is submitted to the HW subchannel via ssch(). But
> > that is not the case I'm talking about here. We have already translated
> > the channel program for the first request, submitted it via ssch() and
> > are awaiting an interrupt that tells us the I/O is done. While waiting
> > for this interrupt we get a new ssch request. I understood, you don't
> > want to give -EAGAIN for this one, but make the ssch decide. The problem
> > is you still need the old translated channel program for the interrupt
> > handling, and at the same time you need the new channel program
> > translated as well, before doing the ssch for it in the host.
> 
> Why? You're not doing anything with that second ssch at all, it returns
> before translation is started.
> 

OK apparently I misunderstood something -- it was a long and twisty
discussion. Looking forward to the code ;).

[..]

> 
> I'll try to post something in January. Have a nice holiday break :)
> 

Don't feel pressured. :) Have nice holidays as well!

Regards,
Halil
