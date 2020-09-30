Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730398AbgI3W3k (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 30 Sep 2020 18:29:40 -0400
Date: Thu, 1 Oct 2020 00:29:30 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v10 09/16] s390/vfio-ap: allow assignment of unavailable
 AP queues to mdev device
Message-ID: <20201001002930.26185810.pasic@linux.ibm.com>
In-Reply-To: <76600ed5-60cc-c530-56db-43f7026d8c8e@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
        <20200821195616.13554-10-akrowiak@linux.ibm.com>
        <20200927014902.1a1a0d8c.pasic@linux.ibm.com>
        <76600ed5-60cc-c530-56db-43f7026d8c8e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Wed, 30 Sep 2020 08:59:36 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> >> @@ -572,6 +455,11 @@ static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev,
> >>   	DECLARE_BITMAP(aqm, AP_DOMAINS);
> >>   
> >>   	list_for_each_entry(lstdev, &matrix_dev->mdev_list, node) {
> >> +		/*
> >> +		 * If either of the input masks belongs to the mdev to which an
> >> +		 * AP resource is being assigned, then we don't need to verify
> >> +		 * that mdev's masks.
> >> +		 */
> >>   		if (matrix_mdev == lstdev)
> >>   			continue;
> >>     
> > Seems unrelated.  
> 
> What seems unrelated? The matrix_mdev passed in is the mdev to which 
> assignment is
> being made. This function is verifying that no APQN assigned to the 
> matrix_mdev is
> assigned to any other mdev. Since we are looping through all mdevs here, 
> we are
> skipping the verification if the current mdev being examined is the same 
> as the matrix_mdev
> to which the assignment is being made. Maybe I'm not understanding your 
> point here.

Sorry I did not explain myself clear enough. By seems unrelated, I mean
that while valid possibly it does not contribute towards achieving the
objective of the patch (as stated by the commit message and the short
description).

AFAICT this is about documenting some pre-existing logic that is not
changed, nor it needs to be changed to achieve the objective.

This patch does not change the function at all (except for the
comment). If the comment is about the new arguments, then is
belongs to "implement in-use callback for vfio_ap driver" where those
were added.

BTW I find the comment hard to understand because I don't see "If either
of the input masks belongs to the mdev to which an  AP resource is being
assigned expressed in the code.

I would rather have the docstring of the function updated so the
relationship of the three arguments is clear.

Regards,
Halil
