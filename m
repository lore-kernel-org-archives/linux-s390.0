From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 6/6] vfio-ccw: add handling for async
 channel instructions
Date: Thu, 31 Jan 2019 12:53:56 +0100
Message-ID: <20190131125356.3c227899.cohuck@redhat.com>
References: <20190130132212.7376-1-cohuck@redhat.com>
	<20190130132212.7376-7-cohuck@redhat.com>
	<20190130180931.4fd4b6a9@oc2783563651>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20190130180931.4fd4b6a9@oc2783563651>
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
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 30 Jan 2019 18:09:31 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 30 Jan 2019 14:22:12 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > +static void fsm_async_retry(struct vfio_ccw_private *private,
> > +			    enum vfio_ccw_event event)
> > +{
> > +	private->cmd_region->ret_code = -EAGAIN;
> > +}
> > +  
> 
> This is essentially dead code at the moment, isn't it? I mean we hold the
> io_mutex whenever we are in state VFIO_CCW_STATE_CP_PROCESSING, and we
> call vfio_ccw_fsm_event() with the very same mutex held.

Well, I did have to put something in the state machine...
