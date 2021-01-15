Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726125AbhAOBJH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Jan 2021 20:09:07 -0500
Date: Fri, 15 Jan 2021 02:08:16 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v13 06/15] s390/vfio-ap: allow assignment of unavailable
 AP queues to mdev device
Message-ID: <20210115020816.3e0226bd.pasic@linux.ibm.com>
In-Reply-To: <270e192b-b88d-b072-428c-6cbfc0f9a280@linux.ibm.com>
References: <20201223011606.5265-1-akrowiak@linux.ibm.com>
        <20201223011606.5265-7-akrowiak@linux.ibm.com>
        <20210111214037.477f0f03.pasic@linux.ibm.com>
        <270e192b-b88d-b072-428c-6cbfc0f9a280@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Thu, 14 Jan 2021 12:54:39 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 1/11/21 3:40 PM, Halil Pasic wrote:
> > On Tue, 22 Dec 2020 20:15:57 -0500
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >  
> >> The current implementation does not allow assignment of an AP adapter or
> >> domain to an mdev device if each APQN resulting from the assignment
> >> does not reference an AP queue device that is bound to the vfio_ap device
> >> driver. This patch allows assignment of AP resources to the matrix mdev as
> >> long as the APQNs resulting from the assignment:
> >>     1. Are not reserved by the AP BUS for use by the zcrypt device drivers.
> >>     2. Are not assigned to another matrix mdev.
> >>
> >> The rationale behind this is twofold:
> >>     1. The AP architecture does not preclude assignment of APQNs to an AP
> >>        configuration that are not available to the system.
> >>     2. APQNs that do not reference a queue device bound to the vfio_ap
> >>        device driver will not be assigned to the guest's CRYCB, so the
> >>        guest will not get access to queues not bound to the vfio_ap driver.  
> > You didn't tell us about the changed error code.  
> 
> I am assuming you are talking about returning -EBUSY from
> the vfio_ap_mdev_verify_no_sharing() function instead of
> -EADDRINUSE. I'm going to change this back per your comments
> below.
> 
> >
> > Also notice that this point we don't have neither filtering nor in-use.
> > This used to be patch 11, and most of that stuff used to be in place. But
> > I'm going to trust you, if you say its fine to enable it this early.  
> 
> The patch order was changed due to your review comments in
> in Message ID <20201126165431.6ef1457a.pasic@linux.ibm.com>,
> patch 07/17 in the v12 series. In order to ensure that only queues
> bound to the vfio_ap driver are given to the guest, I'm going to
> create a patch that will preceded this one which introduces the
> filtering code currently introduced in the patch 12/17, the hot
> plug patch.
> 

I don't want to delay this any further, so it's up to you. I don't think
we will get the in-between steps perfect anyway.

I've re-readthe Message ID
 <20201126165431.6ef1457a.pasic@linux.ibm.com> and I didn't
ask for this change. I pointed out a problem, and said, maybe it can be
solved by reordering, I didn't think it through.

[..]
