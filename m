Return-Path: <SRS0=lgIa=TQ=vger.kernel.org=kvm-owner@kernel.org>
Date: Thu, 16 May 2019 12:54:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/4] vfio: vfio_iommu_type1: Define
 VFIO_IOMMU_INFO_CAPABILITIES
Message-ID: <20190516125434.7dbc4b3c@x1.home>
In-Reply-To: <f396492c-5815-7fd2-0e78-7681e6380591@de.ibm.com>
References: <1557476555-20256-1-git-send-email-pmorel@linux.ibm.com>
        <1557476555-20256-3-git-send-email-pmorel@linux.ibm.com>
        <f396492c-5815-7fd2-0e78-7681e6380591@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, sebott@linux.vnet.ibm.com, gerald.schaefer@de.ibm.com, pasic@linux.vnet.ibm.com, walling@linux.ibm.com, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 16 May 2019 16:57:42 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Alex, 
> 
> patch 1 and 3 are s390 specific, 2 and 4 are vfio common code.
> Are you ok with the common code changes? If yes, would you prefer to have this
> via the s390 tree (Martin) or your tree?

Hi Christian,

The vfio code still needs work imo, and I'm not sure it isn't somewhat
abusive of the iommu attribute interface as well.  I don't necessarily
have a problem with it ultimately going through the s390 tree, but
let's see what comes in the next revision.  Thanks,

Alex

> On 10.05.19 10:22, Pierre Morel wrote:
> > To use the VFIO_IOMMU_GET_INFO to retrieve IOMMU specific information,
> > we define a new flag VFIO_IOMMU_INFO_CAPABILITIES in the
> > vfio_iommu_type1_info structure and the associated capability
> > information block.
> > 
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > ---
> >  include/uapi/linux/vfio.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 8f10748..8f68e0f 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -715,6 +715,16 @@ struct vfio_iommu_type1_info {
> >  	__u32	flags;
> >  #define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
> >  	__u64	iova_pgsizes;		/* Bitmap of supported page sizes */
> > +#define VFIO_IOMMU_INFO_CAPABILITIES (1 << 1)  /* support capabilities info */
> > +	__u64   cap_offset;     /* Offset within info struct of first cap */
> > +};
> > +
> > +#define VFIO_IOMMU_INFO_CAP_QFN		1
> > +#define VFIO_IOMMU_INFO_CAP_QGRP	2
> > +
> > +struct vfio_iommu_type1_info_block {
> > +	struct vfio_info_cap_header header;
> > +	__u32 data[];
> >  };
> >  
> >  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
> >   
> 
