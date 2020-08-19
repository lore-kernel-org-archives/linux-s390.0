Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27892 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727030AbgHSIvs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Aug 2020 04:51:48 -0400
Subject: Re: [PATCH v8 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
References: <1597762711-3550-1-git-send-email-pmorel@linux.ibm.com>
 <1597762711-3550-3-git-send-email-pmorel@linux.ibm.com>
 <20200818192233.6c80798e.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <2a0e6ac5-1238-fd7b-f39f-6fad767b1493@linux.ibm.com>
Date: Wed, 19 Aug 2020 10:51:32 +0200
MIME-Version: 1.0
In-Reply-To: <20200818192233.6c80798e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com



On 2020-08-18 19:22, Cornelia Huck wrote:

>> + */
>> +int arch_has_restricted_memory_access(struct virtio_device *dev)
>> +{
>> +	if (!is_prot_virt_guest())
>> +		return 0;
> 
> If you just did a
> 
> return is_prot_virt_guest();
> 
> and did the virtio feature stuff in the virtio core, this function
> would be short and sweet :)


yes, the smaller the better, thanks

Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
