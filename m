Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729198AbgKDNYH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Nov 2020 08:24:07 -0500
Date: Wed, 4 Nov 2020 14:23:10 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v11 08/14] s390/vfio-ap: hot plug/unplug queues on
 bind/unbind of queue device
Message-ID: <20201104142310.15f9d73b.pasic@linux.ibm.com>
In-Reply-To: <055284df-87d8-507a-d7d7-05a73459322d@linux.ibm.com>
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
        <20201022171209.19494-9-akrowiak@linux.ibm.com>
        <20201028145725.1a81c5cf.pasic@linux.ibm.com>
        <055284df-87d8-507a-d7d7-05a73459322d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Tue, 3 Nov 2020 17:49:21 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> > We do this to show the no queues but bits set output in show? We could
> > get rid of some code if we were to not z  

Managed to delete "eroize" fro "zeroize"

> 
> I'm not sure what you are saying/asking here. The reason for this
> is because there is no point in setting bits in the APCB if no queues
> will be made available to the guest which is the case if the APM or
> AQM are cleared.

Exactly my train of thought! There is no point doing work (here
zeroizing) that has no effect.

Also I'm leaning towards incremental updates to the shadow_apcb (instead
of basically recomputing it from the scratch each time). One thing I'm
particularly worried abut is that because of the third argument of
vfio_ap_mdev_filter_guest_matrix() called filter_apid, we could end up
with different filtering decision than previously. E.g. we decided to
filter the card on e.g. removal of a single queueu, but then somebody
does an assign domain, and suddenly we unplug the domain and plug the
card. With incremental changes the shadow_apcb, we could do less work
(revise only what needs to be), and it would be more straight forward
to reason about the absence of inconsistent filtering.

Regards,
Halil
