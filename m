Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727953AbfFDPYv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Jun 2019 11:24:51 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x54FF4VD095295
        for <linux-s390@vger.kernel.org>; Tue, 4 Jun 2019 11:24:50 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2swu4bredf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 04 Jun 2019 11:24:49 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 4 Jun 2019 16:24:47 +0100
Date: Tue, 4 Jun 2019 17:24:42 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PULL 0/7] vfio-ccw: fixes
References: <20190603105038.11788-1-cohuck@redhat.com>
 <20190603111124.GB20699@osiris>
 <20190603131641.4ad411f0.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603131641.4ad411f0.cohuck@redhat.com>
Message-Id: <20190604152442.GG5774@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Mon, Jun 03, 2019 at 01:16:41PM +0200, Cornelia Huck wrote:
> On Mon, 3 Jun 2019 13:11:24 +0200
> Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> 
> > On Mon, Jun 03, 2019 at 12:50:31PM +0200, Cornelia Huck wrote:
> > > The following changes since commit 674459be116955e025d6a5e6142e2d500103de8e:
> > > 
> > >   MAINTAINERS: add Vasily Gorbik and Christian Borntraeger for s390 (2019-05-31 10:14:15 +0200)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20190603
> > > 
> > > for you to fetch changes up to 9b6e57e5a51696171de990b3c41bd53d4b8ab8ac:
> > > 
> > >   s390/cio: Remove vfio-ccw checks of command codes (2019-06-03 12:02:55 +0200)
> > > 
> > > ----------------------------------------------------------------
> > > various vfio-ccw fixes (ccw translation, state machine)
> > > 
> > > ----------------------------------------------------------------
> > > 
> > > Eric Farman (7):
> > >   s390/cio: Update SCSW if it points to the end of the chain
> > >   s390/cio: Set vfio-ccw FSM state before ioeventfd
> > >   s390/cio: Split pfn_array_alloc_pin into pieces
> > >   s390/cio: Initialize the host addresses in pfn_array
> > >   s390/cio: Don't pin vfio pages for empty transfers
> > >   s390/cio: Allow zero-length CCWs in vfio-ccw
> > >   s390/cio: Remove vfio-ccw checks of command codes  
> > 
> > Given that none of the commits contains a stable tag, I assume it's ok
> > to schedule these for the next merge window (aka 'feature branch')?
> 
> All are bug fixes, but for what I think are edge cases. Would be nice
> if they could still make it into 5.2, but I have no real problem with
> deferring them to the next release, either.
> 
> Eric, Farhan: Do you agree?

As discussed on IRC: pulled and pushed to features branch. Urgent
fixes really should either have a stable and/or fixes tag, if
possible.

Thank you!
