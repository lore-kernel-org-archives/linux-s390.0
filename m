Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727966AbgFPNgu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Jun 2020 09:36:50 -0400
Subject: Re: [PATCH v2 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
References: <1592224764-1258-1-git-send-email-pmorel@linux.ibm.com>
 <1592224764-1258-2-git-send-email-pmorel@linux.ibm.com>
 <20200616115202.0285aa08.pasic@linux.ibm.com>
 <ef235cc9-9d4b-1247-c01a-9dd1c63f437c@linux.ibm.com>
 <20200616142010.04b7ba19.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <8ba494d2-ad91-bc5c-2df8-b9d81c435211@linux.ibm.com>
Date: Tue, 16 Jun 2020 15:36:35 +0200
MIME-Version: 1.0
In-Reply-To: <20200616142010.04b7ba19.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, David Gibson <david@gibson.dropbear.id.au>, Ram Pai <linuxram@us.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>



On 2020-06-16 14:20, Cornelia Huck wrote:
> On Tue, 16 Jun 2020 12:52:50 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 2020-06-16 11:52, Halil Pasic wrote:
>>> On Mon, 15 Jun 2020 14:39:24 +0200
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>>>> @@ -162,6 +163,11 @@ bool force_dma_unencrypted(struct device *dev)
>>>>    	return is_prot_virt_guest();
>>>>    }
>>>>    
>>>> +int arch_needs_iommu_platform(struct virtio_device *dev)
>>>
>>> Maybe prefixing the name with virtio_ would help provide the
>>> proper context.
>>
>> The virtio_dev makes it obvious and from the virtio side it should be
>> obvious that the arch is responsible for this.
>>
>> However if nobody has something against I change it.
> 
> arch_needs_virtio_iommu_platform()?

fine with me

-- 
Pierre Morel
IBM Lab Boeblingen
