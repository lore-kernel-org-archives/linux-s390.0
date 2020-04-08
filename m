Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35762 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728872AbgDHQq0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 12:46:26 -0400
Date: Wed, 8 Apr 2020 18:46:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v7 06/15] s390/vfio-ap: sysfs attribute to display the
 guest CRYCB
Message-ID: <20200408184606.309d9cd9.cohuck@redhat.com>
In-Reply-To: <60c6bfb6-dd0a-75dc-1043-8dffe983220a@linux.ibm.com>
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
        <20200407192015.19887-7-akrowiak@linux.ibm.com>
        <20200408123344.1a9032e1.cohuck@redhat.com>
        <60c6bfb6-dd0a-75dc-1043-8dffe983220a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com

On Wed, 8 Apr 2020 12:38:49 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 4/8/20 6:33 AM, Cornelia Huck wrote:
> > On Tue,  7 Apr 2020 15:20:06 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >  
> >> The matrix of adapters and domains configured in a guest's CRYCB may
> >> differ from the matrix of adapters and domains assigned to the matrix mdev,
> >> so this patch introduces a sysfs attribute to display the CRYCB of a guest
> >> using the matrix mdev. For a matrix mdev denoted by $uuid, the crycb for a
> >> guest using the matrix mdev can be displayed as follows:
> >>
> >>     cat /sys/devices/vfio_ap/matrix/$uuid/guest_matrix
> >>
> >> If a guest is not using the matrix mdev at the time the crycb is displayed,
> >> an error (ENODEV) will be returned.
> >>
> >> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> >> ---
> >>   drivers/s390/crypto/vfio_ap_ops.c | 58 +++++++++++++++++++++++++++++++
> >>   1 file changed, 58 insertions(+)
> >> +static DEVICE_ATTR_RO(guest_matrix);  
> > Hm... should information like the guest configuration be readable by
> > everyone? Or should it be restricted a bit more?  
> 
> Why? The matrix attribute already displays the APQNs of the queues
> assigned to the matrix mdev. The guest_matrix attribute merely displays
> a subset of the matrix (i.e., the APQNs assigned to the mdev that reference
> queue devices bound to the vfio_ap device driver).
> 
> How can this be restricted?

I was thinking of using e.g. 400 instead of 444 for the permissions.

I'm not sure if the info about what subset of the queues the guest
actually uses is all that interesting (except for managing guests); but
if I see guest information being exposed, I get a little wary, so I
just stumbled over this.

Maybe I'll come back to that once I have looked at the series in more
detail, but this might not be a problem at all.

> 
> >  
> >> +
> >>   static struct attribute *vfio_ap_mdev_attrs[] = {
> >>   	&dev_attr_assign_adapter.attr,
> >>   	&dev_attr_unassign_adapter.attr,
> >> @@ -1050,6 +1107,7 @@ static struct attribute *vfio_ap_mdev_attrs[] = {
> >>   	&dev_attr_unassign_control_domain.attr,
> >>   	&dev_attr_control_domains.attr,
> >>   	&dev_attr_matrix.attr,
> >> +	&dev_attr_guest_matrix.attr,
> >>   	NULL,
> >>   };
> >>     
> 
