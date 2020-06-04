Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725995AbgFDLOJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Jun 2020 07:14:09 -0400
Date: Thu, 4 Jun 2020 13:14:01 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PULL v2 00/10] vfio-ccw patches for 5.8
Message-ID: <your-ad-here.call-01591269241-ext-6441@work.hours>
References: <20200603112716.332801-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200603112716.332801-1-cohuck@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Wed, Jun 03, 2020 at 01:27:06PM +0200, Cornelia Huck wrote:
> The following changes since commit e1750a3d9abbea2ece29cac8dc5a6f5bc19c1492:
> 
>   s390/pci: Log new handle in clp_disable_fh() (2020-05-28 12:26:03 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw tags/vfio-ccw-20200603-v2
> 
> for you to fetch changes up to b2dd9a44a1098c96935c495570b663bd223a087e:
> 
>   vfio-ccw: Add trace for CRW event (2020-06-03 11:28:19 +0200)
> 
> ----------------------------------------------------------------
> vfio-ccw updates:
> - accept requests without the prefetch bit set
> - enable path handling via two new regions

Merged into features, thank you.
https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=features
