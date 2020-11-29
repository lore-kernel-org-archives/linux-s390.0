Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52232 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbgK2BSI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 28 Nov 2020 20:18:08 -0500
Date: Sun, 29 Nov 2020 02:17:17 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v12 11/17] s390/vfio-ap: allow assignment of unavailable
 AP queues to mdev device
Message-ID: <20201129021717.5683e779.pasic@linux.ibm.com>
In-Reply-To: <20201124214016.3013-12-akrowiak@linux.ibm.com>
References: <20201124214016.3013-1-akrowiak@linux.ibm.com>
        <20201124214016.3013-12-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Tue, 24 Nov 2020 16:40:10 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> The current implementation does not allow assignment of an AP adapter or
> domain to an mdev device if each APQN resulting from the assignment
> does not reference an AP queue device that is bound to the vfio_ap device
> driver. This patch allows assignment of AP resources to the matrix mdev as
> long as the APQNs resulting from the assignment:
>    1. Are not reserved by the AP BUS for use by the zcrypt device drivers.
>    2. Are not assigned to another matrix mdev.
> 
> The rationale behind this is twofold:
>    1. The AP architecture does not preclude assignment of APQNs to an AP
>       configuration that are not available to the system.
>    2. APQNs that do not reference a queue device bound to the vfio_ap
>       device driver will not be assigned to the guest's CRYCB, so the
>       guest will not get access to queues not bound to the vfio_ap driver.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>

Again code looks good. I'm still worried about all the incremental
changes (good for review) and their testability.
