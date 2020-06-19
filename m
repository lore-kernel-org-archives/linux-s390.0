Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732671AbgFSMCa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Jun 2020 08:02:30 -0400
Date: Fri, 19 Jun 2020 14:02:13 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
Message-ID: <20200619140213.69f4992d.pasic@linux.ibm.com>
In-Reply-To: <20200619112051.74babdb1.cohuck@redhat.com>
References: <1592390637-17441-1-git-send-email-pmorel@linux.ibm.com>
        <1592390637-17441-2-git-send-email-pmorel@linux.ibm.com>
        <20200618002956.5f179de4.pasic@linux.ibm.com>
        <20200619112051.74babdb1.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com

On Fri, 19 Jun 2020 11:20:51 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> > > +	if (arch_needs_virtio_iommu_platform(dev) &&
> > > +		!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
> > > +		dev_warn(&dev->dev,
> > > +			 "virtio: device must provide VIRTIO_F_IOMMU_PLATFORM\n");    
> > 
> > I'm not sure, divulging the current Linux name of this feature bit is a
> > good idea, but if everybody else is fine with this, I don't care that  
> 
> Not sure if that feature name will ever change, as it is exported in
> headers. At most, we might want to add the new ACCESS_PLATFORM define
> and keep the old one, but that would still mean some churn.
> 
> > much. An alternative would be:
> > "virtio: device falsely claims to have full access to the memory,
> > aborting the device"  
> 
> "virtio: device does not work with limited memory access" ?
> 
> But no issue with keeping the current message.

I think I prefer Conny's version, but no strong feelings here.

Halil
