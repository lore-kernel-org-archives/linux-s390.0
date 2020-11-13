Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37702 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbgKMXrc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 13 Nov 2020 18:47:32 -0500
Date: Sat, 14 Nov 2020 00:47:22 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v11 05/14] s390/vfio-ap: implement in-use callback for
 vfio_ap driver
Message-ID: <20201114004722.76c999e0.pasic@linux.ibm.com>
In-Reply-To: <6a5feb16-46b5-9dca-7e85-7d344b0ffa24@linux.ibm.com>
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
        <20201022171209.19494-6-akrowiak@linux.ibm.com>
        <20201027142711.1b57825e.pasic@linux.ibm.com>
        <6a5feb16-46b5-9dca-7e85-7d344b0ffa24@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Fri, 13 Nov 2020 12:14:22 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:
[..]
> >>   }
> >>   
> >> +#define MDEV_SHARING_ERR "Userspace may not re-assign queue %02lx.%04lx " \
> >> +			 "already assigned to %s"
> >> +
> >> +static void vfio_ap_mdev_log_sharing_err(const char *mdev_name,
> >> +					 unsigned long *apm,
> >> +					 unsigned long *aqm)
> >> +{
> >> +	unsigned long apid, apqi;
> >> +
> >> +	for_each_set_bit_inv(apid, apm, AP_DEVICES)
> >> +		for_each_set_bit_inv(apqi, aqm, AP_DOMAINS)
> >> +			pr_err(MDEV_SHARING_ERR, apid, apqi, mdev_name);
> > Isn't error rather severe for this? For my taste even warning would be
> > severe for this.
> 
> The user only sees a EADDRINUSE returned from the sysfs interface,
> so Conny asked if I could log a message to indicate which APQNs are
> in use by which mdev. I can change this to an info message, but it
> will be missed if the log level is set higher. Maybe Conny can put in
> her two cents here since she asked for this.
> 

I'm looking forward to Conny's opinion. :)

[..]
> >>   
> >> @@ -708,18 +732,18 @@ static ssize_t assign_adapter_store(struct device *dev,
> >>   	if (ret)
> >>   		goto done;
> >>   
> >> -	set_bit_inv(apid, matrix_mdev->matrix.apm);
> >> +	memset(apm, 0, sizeof(apm));
> >> +	set_bit_inv(apid, apm);
> >>   
> >> -	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
> >> +	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev, apm,
> >> +					     matrix_mdev->matrix.aqm);
> > What is the benefit of using a copy here? I mean we have the vfio_ap lock
> > so nobody can see the bit we speculatively flipped.
> 
> The vfio_ap_mdev_verify_no_sharing() function definition was changed
> so that it can also be re-used by the vfio_ap_mdev_resource_in_use()
> function rather than duplicating that code for the in_use callback. The
> in-use callback is invoked by the AP bus which has no concept of
> a mediated device, so I made this change to accommodate that fact.

Seems I was not clear enough with my question. Here you pass a local
apm which has the every bit 0 except the one corresponding to the
adapter we are trying to assign. The matrix.apm actually may have
more apm bits set. What we used to do, is set the matrix.apm bit,
verify, and clear it if verification fails. I think that
would still work.

The computational complexity is currently the same. For
some reason unknown to me ap_apqn_in_matrix_owned_by_def_drv() uses loops
instead of using bitmap operations. But it won't do any less work
if the apm argument is sparse. Same is true bitmap ops are used.

What you do here is not wrong, because if the invariants, which should
be maintained, are maintained, performing the check with the other
bits set in the apm is superfluous. But as I said before, actually
it ain't extra work, and if there was a bug, it could help us detect
it (because the assignment, that should have worked would fail).

Preparing the local apm isn't much extra work either, but I still
don't understand the change. Why can't you pass in matrix.apm
after set_bit_inv(apid, ...) like we use to do before?

Again, no big deal, but I just prefer to understand the whys.

> 
> >
> > I've also pointed out in the previous patch that in_use() isn't
> > perfectly reliable (at least in theory) because of a race.
> 
> We discussed that privately and determined that the sysfs assignment
> interfaces will use mutex_trylock() to avoid races.

I don't think, what we discussed is going to fix the race I'm referring
to here. But I do look forward to v12.

Regards,
Halil
