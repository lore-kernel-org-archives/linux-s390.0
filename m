Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10352 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727402AbfGYKWU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 25 Jul 2019 06:22:20 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6PAHvxQ092813
        for <linux-s390@vger.kernel.org>; Thu, 25 Jul 2019 06:22:18 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ty77cgayy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 25 Jul 2019 06:22:17 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 25 Jul 2019 11:22:03 +0100
Date: Thu, 25 Jul 2019 12:21:57 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: vfio-ccw: Remove myself as the
 maintainer
References: <cover.1564003585.git.alifm@linux.ibm.com>
 <19aee1ab0e5bcc01053b515117a66426a9332086.1564003585.git.alifm@linux.ibm.com>
 <20190725093335.09c96c0d.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725093335.09c96c0d.cohuck@redhat.com>
Message-Id: <20190725102157.GA25333@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, farman@linux.ibm.com, pasic@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu, Jul 25, 2019 at 09:33:35AM +0200, Cornelia Huck wrote:
> On Wed, 24 Jul 2019 17:32:03 -0400
> Farhan Ali <alifm@linux.ibm.com> wrote:
> 
> > I will not be able to continue with my maintainership responsibilities
> > going forward, so remove myself as the maintainer.
> 
> ::sadface::
> 
> Thank you for all of your good work!
> 
> > 
> > Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> > ---
> >  MAINTAINERS | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0e90487..dd07a23 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13696,7 +13696,6 @@ F:	drivers/pci/hotplug/s390_pci_hpc.c
> >  
> >  S390 VFIO-CCW DRIVER
> >  M:	Cornelia Huck <cohuck@redhat.com>
> > -M:	Farhan Ali <alifm@linux.ibm.com>
> >  M:	Eric Farman <farman@linux.ibm.com>
> >  R:	Halil Pasic <pasic@linux.ibm.com>
> >  L:	linux-s390@vger.kernel.org
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> 
> Heiko/Vasily/Christian: can you take this one directly through the s390
> tree?

Sure.
