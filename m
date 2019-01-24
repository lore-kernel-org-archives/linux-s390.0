From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 5/5] vfio-ccw: add handling for async
 channel instructions
Date: Thu, 24 Jan 2019 11:37:08 +0100
Message-ID: <20190124113708.2b024784@oc2783563651>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-6-cohuck@redhat.com>
	<20190123165148.55aba88b@oc2783563651>
	<20190124110637.2e2e3c4c.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20190124110637.2e2e3c4c.cohuck@redhat.com>
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
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 24 Jan 2019 11:06:37 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 23 Jan 2019 16:51:48 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Mon, 21 Jan 2019 12:03:54 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> > 
> > > Add a region to the vfio-ccw device that can be used to submit
> > > asynchronous I/O instructions. ssch continues to be handled by the
> > > existing I/O region; the new region handles hsch and csch.
> > > 
> > > Interrupt status continues to be reported through the same channels
> > > as for ssch.
> > > 
> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> > 
> > I had a look, and I don't have any new concerns.(New like not raised
> > before.)
> 
> So, what was raised before that I did not address?
> 

I had the cp->initialized in mind here. My understanding is that this is
the point at which safe accessors are necessary. But I consider that
addressed.

I'm still not a fan of this try_lock() and -EAGAIN in write (and just
lock() in read approach), for the reasons I stated before. But it ain't
a deal-breaker for me. It is just that I don't get the benefit of the
busy looping userspace.

Regards,
Halil
