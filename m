Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbgGGLTm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Jul 2020 07:19:42 -0400
Subject: Re: [PATCH v4 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
References: <1594111477-15401-1-git-send-email-pmorel@linux.ibm.com>
 <1594111477-15401-3-git-send-email-pmorel@linux.ibm.com>
 <20200707114633.68122a00.cohuck@redhat.com>
 <20200707060838-mutt-send-email-mst@kernel.org>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <64057bea-2239-1374-b371-abd7256a32bf@linux.ibm.com>
Date: Tue, 7 Jul 2020 13:19:31 +0200
MIME-Version: 1.0
In-Reply-To: <20200707060838-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com



On 2020-07-07 13:14, Michael S. Tsirkin wrote:
> On Tue, Jul 07, 2020 at 11:46:33AM +0200, Cornelia Huck wrote:
>> On Tue,  7 Jul 2020 10:44:37 +0200
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>
>>> S390, protecting the guest memory against unauthorized host access
>>> needs to enforce VIRTIO I/O device protection through the use of
>>> VIRTIO_F_VERSION_1 and VIRTIO_F_IOMMU_PLATFORM.
>>
>> Hm... what about:
>>
>> "If protected virtualization is active on s390, the virtio queues are
>> not accessible to the host, unless VIRTIO_F_IOMMU_PLATFORM has been
>> negotiated. Use the new arch_validate_virtio_features() interface to
>> enforce this."
> 
> s/enforce this/fail probe if that's not the case, preventing a host error on access attempt/
> 

yes, more complete, thanks.

regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
