Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23461 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726697AbgAHOpF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jan 2020 09:45:05 -0500
Subject: Re: [PATCH v3] KVM: s390: Add new reset vcpu API
References: <20191205120956.50930-1-frankja@linux.ibm.com>
 <dd724da0-9bba-079e-6b6f-756762dbc942@de.ibm.com>
 <d0db08ef-ade9-93d4-105f-ace6fef50c81@linux.ibm.com>
 <3ddb7aa6-96d4-246f-a8ba-fdf2408a4ff0@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d3370e31-ca33-567d-ce0e-1168f603a686@redhat.com>
Date: Wed, 8 Jan 2020 15:44:57 +0100
MIME-Version: 1.0
In-Reply-To: <3ddb7aa6-96d4-246f-a8ba-fdf2408a4ff0@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: cohuck@redhat.com, linux-s390@vger.kernel.org

On 08/01/2020 15.38, Christian Borntraeger wrote:
> 
> 
> On 08.01.20 15:35, Janosch Frank wrote:
>> On 1/8/20 3:28 PM, Christian Borntraeger wrote:
>>>
>>>
>>> On 05.12.19 13:09, Janosch Frank wrote:
>>> [...]
>>>> +4.123 KVM_S390_CLEAR_RESET
>>>> +
>>>> +Capability: KVM_CAP_S390_VCPU_RESETS
>>>> +Architectures: s390
>>>> +Type: vcpu ioctl
>>>> +Parameters: none
>>>> +Returns: 0
>>>> +
>>>> +This ioctl resets VCPU registers and control structures that QEMU
>>>> +can't access via the kvm_run structure. The clear reset is a superset
>>>> +of the initial reset and additionally clears general, access, floating
>>>> +and vector registers.
>>>
>>> As Thomas outlined, make it more obvious that userspace does the remaining
>>> parts. I do not think that we want the kernel to do the things (unless it
>>> helps you in some way for the ultravisor guests)
>>
>> Ok, will do
> 
> I changed my mind (see my other mail) but I would like Thomas, Conny or David
> to ack/nack.

I don't mind too much as long as it is properly documented, but I also
slightly prefer to be consistent here, i.e. let the kernel clear the
rest here, too, just like we do it already with the initial reset.

 Thomas
