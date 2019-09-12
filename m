Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730661AbfILJ2O (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Sep 2019 05:28:14 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8C9I40q047666
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2019 05:28:13 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uyjnwss1q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2019 05:28:12 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 12 Sep 2019 10:28:10 +0100
Subject: Re: [PATCH] KVM: s390: Do not leak kernel stack data in the
 KVM_S390_INTERRUPT ioctl
References: <20190912090050.20295-1-thuth@redhat.com>
 <6905df78-95f0-3d6d-aaae-910cd2d7a232@redhat.com>
 <253e67f6-0a41-13e8-4ca2-c651d5fcdb69@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 12 Sep 2019 11:28:05 +0200
MIME-Version: 1.0
In-Reply-To: <253e67f6-0a41-13e8-4ca2-c651d5fcdb69@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RPvOYPwnVuIf8SY9NmEhIEE0AZLwMgBpN"
Message-Id: <1c8e5098-06fa-02b2-6af7-a356927ac5c4@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RPvOYPwnVuIf8SY9NmEhIEE0AZLwMgBpN
Content-Type: multipart/mixed; boundary="cjG9B14QKHqLUU5MFwg4X6fAHDdTuBMQk";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <1c8e5098-06fa-02b2-6af7-a356927ac5c4@linux.ibm.com>
Subject: Re: [PATCH] KVM: s390: Do not leak kernel stack data in the
 KVM_S390_INTERRUPT ioctl
References: <20190912090050.20295-1-thuth@redhat.com>
 <6905df78-95f0-3d6d-aaae-910cd2d7a232@redhat.com>
 <253e67f6-0a41-13e8-4ca2-c651d5fcdb69@redhat.com>
In-Reply-To: <253e67f6-0a41-13e8-4ca2-c651d5fcdb69@redhat.com>

--cjG9B14QKHqLUU5MFwg4X6fAHDdTuBMQk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/12/19 11:20 AM, Thomas Huth wrote:
> On 12/09/2019 11.14, David Hildenbrand wrote:
>> On 12.09.19 11:00, Thomas Huth wrote:
>>> When the userspace program runs the KVM_S390_INTERRUPT ioctl to injec=
t
>>> an interrupt, we convert them from the legacy struct kvm_s390_interru=
pt
>>> to the new struct kvm_s390_irq via the s390int_to_s390irq() function.=

>>> However, this function does not take care of all types of interrupts
>>> that we can inject into the guest later (see do_inject_vcpu()). Since=
 we
>>> do not clear out the s390irq values before calling s390int_to_s390irq=
(),
>>> there is a chance that we copy unwanted data from the kernel stack
>>> into the guest memory later if the interrupt data has not been proper=
ly
>>> initialized by s390int_to_s390irq().
>>>
>>> Specifically, the problem exists with the KVM_S390_INT_PFAULT_INIT
>>> interrupt: s390int_to_s390irq() does not handle it, but the function
>>> __deliver_pfault_init() will later copy the uninitialized stack data
>>> from the ext.ext_params2 into the guest memory.
>>>
>>> Fix it by handling that interrupt type in s390int_to_s390irq(), too.
>>> And while we're at it, make sure that s390int_to_s390irq() now
>>> directly returns -EINVAL for unknown interrupt types, so that we
>>> do not run into this problem again in case we add more interrupt
>>> types to do_inject_vcpu() sometime in the future.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  arch/s390/kvm/interrupt.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>>> index 3e7efdd9228a..165dea4c7f19 100644
>>> --- a/arch/s390/kvm/interrupt.c
>>> +++ b/arch/s390/kvm/interrupt.c
>>> @@ -1960,6 +1960,16 @@ int s390int_to_s390irq(struct kvm_s390_interru=
pt *s390int,
>>>  	case KVM_S390_MCHK:
>>>  		irq->u.mchk.mcic =3D s390int->parm64;
>>>  		break;
>>> +	case KVM_S390_INT_PFAULT_INIT:
>>> +		irq->u.ext.ext_params =3D s390int->parm;
>>> +		irq->u.ext.ext_params2 =3D s390int->parm64;
>>> +		break;
>>> +	case KVM_S390_RESTART:
>>> +	case KVM_S390_INT_CLOCK_COMP:
>>> +	case KVM_S390_INT_CPU_TIMER:
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>>  	}
>>>  	return 0;
>>>  }
>>>
>>
>> Wouldn't a safe fix be to initialize the struct to zero in the caller?=

>=20
> That's of course possible, too. But that means that we always have to
> zero out the whole structure, so that's a little bit more of overhead
> (well, it likely doesn't matter for such a legacy ioctl).

Or memset it in s390int_to_s390irq so the caller doesn't need to know.
That should be fast enough for such a small struct.

>=20
> But the more important question: Do we then still care of fixing the
> PFAULT_INIT interrupt here? Since it requires a parameter, the "case
> KVM_S390_INT_PFAULT_INIT:" part would be required here anyway.

Let's wait for Christian's opinion on that.


--cjG9B14QKHqLUU5MFwg4X6fAHDdTuBMQk--

--RPvOYPwnVuIf8SY9NmEhIEE0AZLwMgBpN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl16D6UACgkQ41TmuOI4
ufgeoBAApRNlMJkqvyukjvF8OKQUGVO8jXQeceq+WZwGKV6LX5cmJUlmBroHkHi8
Yjak7EbSLBK1PhZng0SHQXoFCBEteqLc3UjY+siwKk5DSPZMcdACFEZPbqDgI8NH
JFXJ9lnGa5bRDASY4vu//ujYWj5hppTrHSpDJoCbJJVDZAVIan1N/BF7/yR5qJdn
+pNM5PyQo4o3nl7MxarKhDy2l0jcvCnNDUWRbqaBu3CoWID1eh9xvqbmQBrYuFZ+
9Ds2wOhbN4yX06yPEw4JbNK8WfWuhSW3gPL09l4CAYU24rI0UWzNMPYfgps0Y1Sk
5VbAjOyUV39I8X8K2b0s2vcSV6TP1rDRg8d3wb9f4AjCJZ4wDRMFMpr44Lr5hBT+
sY9+3UdbBqmx1Ou4QMJJe1NvqpJomGVjR597Nohn2m6r3UcOqqApRAI+AHZnZzCu
5yEvw9fosFvnKgYD344OJ3CUYvxVZ/kMs+/0VnLxYWxdf+GpDNwjLZX9RhKwmFOx
rM/rt66dF0wJbmX2HQjRbdN8rwImo0oHxOwotGw1NKkCjE9Fn3hnJ0WhjK34VXJ0
nbBT3ojZbv2PH1nO0VrVVQkE3kRziq4JiiD0nDycTKPZGDTT8drgcoYbijVMNQoR
oCJ2bxwQu6lUjWg2Qt8QMsy1hZ07cIKjQBt1pm6igZxQXkFzYYg=
=JmeN
-----END PGP SIGNATURE-----

--RPvOYPwnVuIf8SY9NmEhIEE0AZLwMgBpN--
