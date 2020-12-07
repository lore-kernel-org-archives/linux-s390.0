Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51982 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725804AbgLGPpY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Dec 2020 10:45:24 -0500
Subject: Re: [PATCH] s390/vfio-ap: Clean up vfio_ap resources when KVM pointer
 invalidated
References: <20201202234101.32169-1-akrowiak@linux.ibm.com>
 <20201203185514.54060568.pasic@linux.ibm.com>
 <a5a613ef-4c74-ad68-46bd-7159fbafef47@linux.ibm.com>
 <20201207162411.050c6cea.pasic@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <d0c2aaee-3367-a15d-514d-88211251ca06@de.ibm.com>
Date: Mon, 7 Dec 2020 16:42:05 +0100
MIME-Version: 1.0
In-Reply-To: <20201207162411.050c6cea.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com, alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com



On 07.12.20 16:24, Halil Pasic wrote:
> On Fri, 4 Dec 2020 11:48:24 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> On 12/3/20 12:55 PM, Halil Pasic wrote:
>>> On Wed,  2 Dec 2020 18:41:01 -0500
>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>  
>>>> The vfio_ap device driver registers a group notifier with VFIO when the
>>>> file descriptor for a VFIO mediated device for a KVM guest is opened to
>>>> receive notification that the KVM pointer is set (VFIO_GROUP_NOTIFY_SET_KVM
>>>> event). When the KVM pointer is set, the vfio_ap driver stashes the pointer
>>>> and calls the kvm_get_kvm() function to increment its reference counter.
>>>> When the notifier is called to make notification that the KVM pointer has
>>>> been set to NULL, the driver should clean up any resources associated with
>>>> the KVM pointer and decrement its reference counter. The current
>>>> implementation does not take care of this clean up.
>>>>
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>  
>>> Do we need a Fixes tag? Do we need this backported? In my opinion
>>> this is necessary since the interrupt patches.  
>>
>> I'll put in a fixes tag:
>> Fixes: 258287c994de (s390: vfio-ap: implement mediated device open callback)
>>
>> Yes, this should probably be backported.
> 
> I changed my mind regarding the severity of this issue. I was paranoid
> about post-mortem interrupts, and resulting notifier byte updates by the
> machine. What I overlooked is that the pin is going to prevent the memory
> form getting repurposed. I.e. if we have something like vmalloc(),
> vfio_pin(notifier_page), vfree(), I believe the notifier_page is not free
> (available for allocation). So the worst case scenario is IMHO a resource
> leak and not corruption. So I'm not sure this must be backported.
> Opinions?

Resource leaks qualify for backport and cc stable, but it is not a security
issue so this has no urgency and CVE and these kind of things.

So lets finish this without hurry, add cc stable and then look for necessary
distro backports.
