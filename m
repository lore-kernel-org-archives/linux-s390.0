From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 3/3] vfio-ccw: add handling for asnyc
 channel instructions
Date: Wed, 28 Nov 2018 09:41:07 +0100
Message-ID: <20181128094107.70996fde.cohuck@redhat.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-4-cohuck@redhat.com>
	<d7084481-b638-e128-eb91-49911882e39e@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <d7084481-b638-e128-eb91-49911882e39e@linux.ibm.com>
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
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 27 Nov 2018 14:57:31 -0500
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 11/22/2018 11:54 AM, Cornelia Huck wrote:
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 565669f95534..c01472ec77ea 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -304,6 +304,7 @@ struct vfio_region_info_cap_type {
> >   #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
> >   #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
> >   
> > +  
> 
> Whitespace error?

Probably crept in while I was looking for a home for the #define below.
Removed.

> 
> >   #define VFIO_REGION_TYPE_GFX                    (1)
> >   #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
> >   
> > @@ -354,6 +355,9 @@ struct vfio_region_gfx_edid {
> >   #define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
> >   };
> >   
> > +/* ccw sub-types */
> > +#define VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD	(1)
> > +  
> 
