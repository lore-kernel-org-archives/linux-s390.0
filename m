Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726507AbgFEKwm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 Jun 2020 06:52:42 -0400
Date: Fri, 5 Jun 2020 12:52:30 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390/virtio: remove unused pm callbacks
Message-ID: <20200605105230.GA4189@osiris>
References: <20200526093629.257649-1-cohuck@redhat.com>
 <20200604234421.4ada966b.pasic@linux.ibm.com>
 <20200605093907.4d4b3c2a.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605093907.4d4b3c2a.cohuck@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org

On Fri, Jun 05, 2020 at 09:39:07AM +0200, Cornelia Huck wrote:
> On Thu, 4 Jun 2020 23:44:21 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Tue, 26 May 2020 11:36:29 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> > 
> > > Support for hibernation on s390 has been recently been removed with
> 
> s/been recently been removed/recently been removed/
> 
> > > commit 394216275c7d ("s390: remove broken hibernate / power management
> > > support"), no need to keep unused code around.
> > > 
> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> > 
> > Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> 
> Thanks!
> 
> As this is only a single patch, I think a pull request is a bit
> overkill, so it would probably be best for someone to pick this
> directly.
> 
> s390 arch maintainers? Michael?

Applied, thanks!
