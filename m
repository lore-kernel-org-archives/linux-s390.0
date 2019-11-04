Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34999 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727838AbfKDOiT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 09:38:19 -0500
Subject: Re: [RFC v2] KVM: s390: protvirt: Secure memory is not mergeable
References: <20191024114059.102802-8-frankja@linux.ibm.com>
 <20191025082446.754-1-frankja@linux.ibm.com>
 <7918ea28-8f10-dc1c-e35b-c1b66631877e@redhat.com>
 <12ddbeda-5abb-fffa-ad1b-c2f0397c8391@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c2562008-7306-1e7b-3bd0-c54d952b9cbc@redhat.com>
Date: Mon, 4 Nov 2019 15:38:10 +0100
MIME-Version: 1.0
In-Reply-To: <12ddbeda-5abb-fffa-ad1b-c2f0397c8391@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 04.11.19 15:36, Janosch Frank wrote:
> On 11/4/19 3:32 PM, David Hildenbrand wrote:
>> On 25.10.19 10:24, Janosch Frank wrote:
>>> KSM will not work on secure pages, because when the kernel reads a
>>> secure page, it will be encrypted and hence no two pages will look the
>>> same.
>>>
>>> Let's mark the guest pages as unmergeable when we transition to secure
>>> mode.
>>
>> Patch itself looks good to me, but I do wonder: Is this really needed
>> when pinning all encrypted pages currently?
>>
>> Not sure about races between KSM and the pinning/encrypting thread,
>> similar to paging, though ...
>>
>=20
> The pinning was added several months after I wrote the patch.
> Now that we have it, we really need to have another proper look at the
> whole topic.
>=20
> Thanks for your review :-)

I'd certainly prefer this patch (+some way to mlock) over pinning ;)

You can have

Reviewed-by: David Hildenbrand <david@redhat.com>

For this patch, if you end up needing it :)

--=20

Thanks,

David / dhildenb
