Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32608 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733267AbfKHMO6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 Nov 2019 07:14:58 -0500
Subject: Re: [RFC 02/37] s390/protvirt: introduce host side setup
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-3-frankja@linux.ibm.com>
 <20191104165427.0e5e6da4.cohuck@redhat.com>
 <5a34febd-8abc-84f5-195e-43decbb366a5@de.ibm.com>
 <20191105102654.223e7b42.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9bbd0930-c55c-084b-6ae1-6a5df6a33778@redhat.com>
Date: Fri, 8 Nov 2019 13:14:46 +0100
MIME-Version: 1.0
In-Reply-To: <20191105102654.223e7b42.cohuck@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

On 05/11/2019 10.26, Cornelia Huck wrote:
> On Mon, 4 Nov 2019 18:50:12 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>=20
>> On 04.11.19 16:54, Cornelia Huck wrote:
>>> On Thu, 24 Oct 2019 07:40:24 -0400
>>> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>>>> diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
>>>> index ed007f4a6444..88cf8825d169 100644
>>>> --- a/arch/s390/boot/uv.c
>>>> +++ b/arch/s390/boot/uv.c
>>>> @@ -3,7 +3,12 @@
>>>>   #include <asm/facility.h>
>>>>   #include <asm/sections.h>
>>>>  =20
>>>> +#ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
>>>>   int __bootdata_preserved(prot_virt_guest);
>>>> +#endif
>>>> +#ifdef CONFIG_KVM_S390_PROTECTED_VIRTUALIZATION_HOST
>>>> +struct uv_info __bootdata_preserved(uv_info);
>>>> +#endif
>>>
>>> Two functions with the same name, but different signatures look really
>>> ugly.
>>>
>>> Also, what happens if I want to build just a single kernel image for
>>> both guest and host?
>>
>> This is not two functions with the same name. It is 2 variable declarati=
ons with
>> the __bootdata_preserved helper. We expect to have all distro kernels to=
 enable
>> both.
>=20
> Ah ok, I misread that. (I'm blaming lack of sleep :/)

Honestly, I have to admit that I mis-read this in the same way as=20
Cornelia at the first glance. Why is that macro not using capital=20
letters? ... then it would be way more obvious that it's not about a=20
function prototype...

  Thomas
