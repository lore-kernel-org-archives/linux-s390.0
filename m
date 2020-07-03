Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1214 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbgGCQVl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 12:21:41 -0400
Date: Fri, 3 Jul 2020 18:21:32 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PULL 0/1] vfio-ccw fix
Message-ID: <20200703162132.GB5294@osiris>
References: <20200703095253.620719-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703095253.620719-1-cohuck@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Fri, Jul 03, 2020 at 11:52:52AM +0200, Cornelia Huck wrote:
> The following changes since commit 9e9f85e029a2ee4167aacf3ff04e4288a5e5c74e:
> Sean Christopherson (1):
>   vfio-ccw: Fix a build error due to missing include of linux/slab.h
> 
>  drivers/s390/cio/vfio_ccw_chp.c | 1 +
>  1 file changed, 1 insertion(+)

Pulled, however it would have been nice if the commit log would have
contained some words how to trigger the build error.

Thanks!
