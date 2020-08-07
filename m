Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbgHGO0I (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Aug 2020 10:26:08 -0400
Subject: Re: [PATCH v1 0/1] s390: virtio-ccw: PV needs VIRTIO I/O device
 protection
References: <1596723782-12798-1-git-send-email-pmorel@linux.ibm.com>
 <20200806174744.595b9c8c.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <7a79725f-14d9-5b1a-f0e0-77c3ce596420@linux.ibm.com>
Date: Fri, 7 Aug 2020 16:25:59 +0200
MIME-Version: 1.0
In-Reply-To: <20200806174744.595b9c8c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org



On 2020-08-06 17:47, Cornelia Huck wrote:
> On Thu,  6 Aug 2020 16:23:01 +0200
...
> This does work, and I'm tempted to queue this patch, but I'm wondering
> whether we need to give up on a cross-architecture solution already
> (especially keeping in mind that ccw is the only transport that is
> really architecture-specific).
> 
> I know that we've gone through a few rounds already, and I'm not sure
> whether we've been there already, but:
> 
> Could virtio_finalize_features() call an optional
> arch_has_restricted_memory_access() function and do the enforcing of
> IOMMU_PLATFORM? That would catch all transports, and things should work
> once an architecture opts in. That direction also shouldn't be a
> problem if virtio is a module.

Yes thanks, I rework it in this direction.


-- 
Pierre Morel
IBM Lab Boeblingen
