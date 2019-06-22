Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbfFVIii (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 22 Jun 2019 04:38:38 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5M8afvh090896
        for <linux-s390@vger.kernel.org>; Sat, 22 Jun 2019 04:38:37 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t9gvh84cs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 22 Jun 2019 04:38:37 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Sat, 22 Jun 2019 09:38:35 +0100
Date: Sat, 22 Jun 2019 10:38:29 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PULL 13/14] vfio-ccw: Factor out the ccw0-to-ccw1 transition
References: <20190621143355.29175-1-cohuck@redhat.com>
 <20190621143355.29175-14-cohuck@redhat.com>
 <2129b739-6722-123f-ec7d-f751557de7a0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2129b739-6722-123f-ec7d-f751557de7a0@linux.ibm.com>
Message-Id: <20190622083829.GA3456@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Fri, Jun 21, 2019 at 03:13:20PM -0400, Eric Farman wrote:
> Conny,
> 
> I'm bad at things, because I thought for sure I had checked for and
> fixed this before I sent the patches.  This one gets a sparse warning,
> fixed below.
> 
> Eric
> 
> On 6/21/19 10:33 AM, Cornelia Huck wrote:
> > From: Eric Farman <farman@linux.ibm.com>
> > 
> > This is a really useful function, but it's buried in the
> > copy_ccw_from_iova() routine so that ccwchain_calc_length()
> > can just work with Format-1 CCWs while doing its counting.
> > But it means we're translating a full 2K of "CCWs" to Format-1,
> > when in reality there's probably far fewer in that space.
> > 
> > Let's factor it out, so maybe we can do something with it later.
> > 
> > Signed-off-by: Eric Farman <farman@linux.ibm.com>
> > Message-Id: <20190618202352.39702-5-farman@linux.ibm.com>
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  drivers/s390/cio/vfio_ccw_cp.c | 48 ++++++++++++++++++----------------
> >  1 file changed, 25 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> > index a55f8d110920..9a8bf06281e0 100644
> > --- a/drivers/s390/cio/vfio_ccw_cp.c
> > +++ b/drivers/s390/cio/vfio_ccw_cp.c
> > @@ -161,6 +161,27 @@ static inline void pfn_array_idal_create_words(
> >  	idaws[0] += pa->pa_iova & (PAGE_SIZE - 1);
> >  }
> >  
> > +void convert_ccw0_to_ccw1(struct ccw1 *source, unsigned long len)
> 
> static void convert_...

Please send an add-on patch. Code is already in our internal tree for
testing purposes and will be push out next week.
