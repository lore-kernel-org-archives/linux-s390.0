Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387981AbgLNTtd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Dec 2020 14:49:33 -0500
Subject: Re: [PATCH v3] s390/vfio-ap: clean up vfio_ap resources when KVM
 pointer invalidated
References: <20201214165617.28685-1-akrowiak@linux.ibm.com>
 <X9ebwKJSSyVP/M9H@kroah.com>
 <237fe6d3-ebcc-1046-b295-a0154ce1158e@linux.ibm.com>
 <X9fAWD/k9Wbp7Rac@kroah.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <9ac4e4f3-3b59-8bdd-50d6-439fc4c35b9c@linux.ibm.com>
Date: Mon, 14 Dec 2020 14:48:44 -0500
MIME-Version: 1.0
In-Reply-To: <X9fAWD/k9Wbp7Rac@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org, sashal@kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, pbonzini@redhat.com, alex.williamson@redhat.com, pasic@linux.vnet.ibm.com



On 12/14/20 2:43 PM, Greg KH wrote:
> On Mon, Dec 14, 2020 at 02:39:17PM -0500, Tony Krowiak wrote:
>>
>> On 12/14/20 12:07 PM, Greg KH wrote:
>>> On Mon, Dec 14, 2020 at 11:56:17AM -0500, Tony Krowiak wrote:
>>>> The vfio_ap device driver registers a group notifier with VFIO when the
>>>> file descriptor for a VFIO mediated device for a KVM guest is opened to
>>>> receive notification that the KVM pointer is set (VFIO_GROUP_NOTIFY_SET_KVM
>>>> event). When the KVM pointer is set, the vfio_ap driver takes the
>>>> following actions:
>>>> 1. Stashes the KVM pointer in the vfio_ap_mdev struct that holds the state
>>>>      of the mediated device.
>>>> 2. Calls the kvm_get_kvm() function to increment its reference counter.
>>>> 3. Sets the function pointer to the function that handles interception of
>>>>      the instruction that enables/disables interrupt processing.
>>>> 4. Sets the masks in the KVM guest's CRYCB to pass AP resources through to
>>>>      the guest.
>>>>
>>>> In order to avoid memory leaks, when the notifier is called to receive
>>>> notification that the KVM pointer has been set to NULL, the vfio_ap device
>>>> driver should reverse the actions taken when the KVM pointer was set.
>>>>
>>>> Fixes: 258287c994de ("s390: vfio-ap: implement mediated device open callback")
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>> ---
>>>>    drivers/s390/crypto/vfio_ap_ops.c | 29 ++++++++++++++++++++---------
>>>>    1 file changed, 20 insertions(+), 9 deletions(-)
>>> <formletter>
>>>
>>> This is not the correct way to submit patches for inclusion in the
>>> stable kernel tree.  Please read:
>>>       https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>>> for how to do this properly.
>>>
>>> </formletter>
>> I read the document on the correct way to submit patches for inclusion in
>> the stable kernel. I apologize for my ignorance, but I don't see the
>> problem. Can you help me out here? Does a patch that fixes a memory leak
>> not qualify or is it something else?
> You forgot to put "Cc: stable..." in the signed-off-by area.
>
> thanks,

Option 1, I must be blind. thanks

>
> greg k-h
