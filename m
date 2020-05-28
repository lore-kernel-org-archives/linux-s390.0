Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389746AbgE1Mmk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 May 2020 08:42:40 -0400
Date: Thu, 28 May 2020 14:42:31 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PULL 00/10] vfio-ccw patches for 5.8
Message-ID: <your-ad-here.call-01590669751-ext-3257@work.hours>
References: <20200525094115.222299-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200525094115.222299-1-cohuck@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Mon, May 25, 2020 at 11:41:05AM +0200, Cornelia Huck wrote:
> The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:
> 
>   Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw tags/vfio-ccw-20200525

Hello Conny,

s390/features is based on v5.7-rc2 rather than on v5.7-rc3 as your
tags/vfio-ccw-20200525. Are there any pre-requisites in between for
vfio-ccw changes? It does cleanly rebase onto v5.7-rc2.

Could you please rebase onto v5.7-rc2 or s390/features if that's possible?

Thank you.
