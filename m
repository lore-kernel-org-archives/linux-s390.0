Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbgK2BKQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 28 Nov 2020 20:10:16 -0500
Date: Sun, 29 Nov 2020 02:09:23 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v12 10/17] s390/vfio-ap: initialize the guest apcb
Message-ID: <20201129020923.6c470310.pasic@linux.ibm.com>
In-Reply-To: <20201124214016.3013-11-akrowiak@linux.ibm.com>
References: <20201124214016.3013-1-akrowiak@linux.ibm.com>
        <20201124214016.3013-11-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Tue, 24 Nov 2020 16:40:09 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> The APCB is a control block containing the masks that specify the adapters,
> domains and control domains to which a KVM guest is granted access. When
> the vfio_ap device driver is notified that the KVM pointer has been set,
> the guest's APCB is initialized from the AP configuration of adapters,
> domains and control domains assigned to the matrix mdev. The linux device
> model, however, precludes passing through to a guest any devices that
> are not bound to the device driver facilitating the pass-through.
> Consequently, APQNs assigned to the matrix mdev that do not reference
> AP queue devices must be filtered before assigning them to the KVM guest's
> APCB; however, the AP architecture precludes filtering individual APQNs, so
> the APQNs will be filtered by APID. That is, if a given APQN does not
> reference a queue device bound to the vfio_ap driver, its APID will not
> get assigned to the guest's APCB. For example:
> 
> Queues bound to vfio_ap:
> 04.0004
> 04.0022
> 04.0035
> 05.0004
> 05.0022
> 
> Adapters/domains assigned to the matrix mdev:
> 04 0004
>    0022
>    0035
> 05 0004
>    0022
>    0035
> 
> APQNs assigned to APCB:
> 04.0004
> 04.0022
> 04.0035
> 
> The APID 05 was filtered from the matrix mdev's matrix because
> queue device 05.0035 is not bound to the vfio_ap device driver.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>

This adds filtering. So from here guest_matrix may be different
than matrix also for an mdev that is associated with a guest. I'm still
grappling with the big picture. Have you thought about testability?
How is a testcase supposed to figure out which behavior is
to be deemed correct?

I don't like the title line. It implies that guest apcb was
uninitialized before. Which is not the case.
