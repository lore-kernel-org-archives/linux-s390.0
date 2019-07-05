Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfGEMU3 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 5 Jul 2019 08:20:29 -0400
Date: Fri, 5 Jul 2019 14:20:24 +0200
From: Vasily Gorbik <gor@kernel.org>
Subject: Re: [PULL 0/1] vfio-ccw fix for 5.3
Message-ID: <your-ad-here.call-01562329224-ext-7594@work.hours>
References: <20190705062132.20755-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190705062132.20755-1-cohuck@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Fri, Jul 05, 2019 at 08:21:31AM +0200, Cornelia Huck wrote:
> The following changes since commit 05f31e3bf6b34fe6e4922868d132f6455f81d5bf:
> 
>   s390: ap: kvm: Enable PQAP/AQIC facility for the guest (2019-07-02 16:00:28 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20190705
> 
> for you to fetch changes up to c382cbc6dbf513d73cf896ad43a3789ad42c2e2f:
> 
>   vfio-ccw: Fix the conversion of Format-0 CCWs to Format-1 (2019-07-05 07:58:53 +0200)
> 
> ----------------------------------------------------------------
> Fix a bug introduced in the refactoring.
> 
> ----------------------------------------------------------------
> 
> Eric Farman (1):
>   vfio-ccw: Fix the conversion of Format-0 CCWs to Format-1
> 
>  drivers/s390/cio/vfio_ccw_cp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> -- 
> 2.20.1
> 
Applied, thanks.
