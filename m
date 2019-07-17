Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726494AbfGQQLP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jul 2019 12:11:15 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6HG7Mk5022209
        for <linux-s390@vger.kernel.org>; Wed, 17 Jul 2019 12:11:13 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tt5qqkwh2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 17 Jul 2019 12:11:13 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 17 Jul 2019 17:11:11 +0100
Date: Wed, 17 Jul 2019 18:11:05 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PULL v2 0/6] vfio-ccw fixes for 5.3
References: <20190717094350.13620-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717094350.13620-1-cohuck@redhat.com>
Message-Id: <20190717161105.GC5427@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Wed, Jul 17, 2019 at 11:43:44AM +0200, Cornelia Huck wrote:
> are available in the Git repository at:
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20190717-2
> Cornelia Huck (1):
>   Documentation: fix vfio-ccw doc
> 
> Farhan Ali (5):
>   vfio-ccw: Fix misleading comment when setting orb.cmd.c64
>   vfio-ccw: Fix memory leak and don't call cp_free in cp_init
>   vfio-ccw: Set pa_nr to 0 if memory allocation fails for pa_iova_pfn
>   vfio-ccw: Don't call cp_free if we are processing a channel program
>   vfio-ccw: Update documentation for csch/hsch
> 
>  Documentation/s390/vfio-ccw.rst | 31 ++++++++++++++++++++++++++++---
>  drivers/s390/cio/vfio_ccw_cp.c  | 28 +++++++++++++++++-----------
>  drivers/s390/cio/vfio_ccw_drv.c |  2 +-
>  3 files changed, 46 insertions(+), 15 deletions(-)

I added these to our internal repository for the time being for
testing. Will pull into our external fixes branch as soon as rc1 is
available. So please don't delete the tag ;)
