Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727904AbfH2Oit (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Aug 2019 10:38:49 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7TEcCMo032013
        for <linux-s390@vger.kernel.org>; Thu, 29 Aug 2019 10:38:48 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2upgk9r68r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 29 Aug 2019 10:38:48 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Thu, 29 Aug 2019 15:38:45 +0100
Date: Thu, 29 Aug 2019 16:38:39 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PULL 0/1] vfio-ccw patch for next release
References: <20190828155716.22809-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190828155716.22809-1-cohuck@redhat.com>
Message-Id: <your-ad-here.call-01567089519-ext-5685@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Wed, Aug 28, 2019 at 05:57:15PM +0200, Cornelia Huck wrote:
> The following changes since commit 416f79c23dbe47e0e223efc06d3487e1d90a92ee:
> 
>   s390/paes: Prepare paes functions for large key blobs (2019-08-21 12:58:54 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20190828
> 
> for you to fetch changes up to 60e05d1cf0875f0cf73472f7dff71d9933c5b697:
> 
>   vfio-ccw: add some logging (2019-08-23 12:53:32 +0200)
> 
> ----------------------------------------------------------------
> Add some logging into the s390dbf.
> 
> ----------------------------------------------------------------
> 
> Cornelia Huck (1):
>   vfio-ccw: add some logging
> 
>  drivers/s390/cio/vfio_ccw_drv.c     | 50 ++++++++++++++++++++++++++--
>  drivers/s390/cio/vfio_ccw_fsm.c     | 51 ++++++++++++++++++++++++++++-
>  drivers/s390/cio/vfio_ccw_ops.c     | 10 ++++++
>  drivers/s390/cio/vfio_ccw_private.h | 17 ++++++++++
>  4 files changed, 124 insertions(+), 4 deletions(-)
> 
> -- 
> 2.20.1
> 

Applied, thanks!
-- 
⣿⣿⣿⣿⢋⡀⣀⠹⣿⣿⣿⣿
⣿⣿⣿⣿⠠⣶⡦⠀⣿⣿⣿⣿
⣿⣿⣿⠏⣴⣮⣴⣧⠈⢿⣿⣿
⣿⣿⡏⢰⣿⠖⣠⣿⡆⠈⣿⣿
⣿⢛⣵⣄⠙⣶⣶⡟⣅⣠⠹⣿
⣿⣜⣛⠻⢎⣉⣉⣀⠿⣫⣵⣿
