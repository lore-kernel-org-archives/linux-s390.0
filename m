Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22961 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729995AbgC3NPS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Mar 2020 09:15:18 -0400
Subject: Re: [kvm-unit-tests PATCH] s390x: Add stsi 3.2.2 tests
References: <20200330122035.19607-1-frankja@linux.ibm.com>
 <df745d0c-5d24-ee03-8600-ec495f1a5af6@redhat.com>
 <d42ac187-9f8f-81eb-c9b4-4d585fdef236@linux.ibm.com>
 <727e1ed5-99ea-e559-ca9c-0f067cbcc153@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ab811a78-fe3c-1c6b-bb6d-85466e040ac6@redhat.com>
Date: Mon, 30 Mar 2020 15:15:09 +0200
MIME-Version: 1.0
In-Reply-To: <727e1ed5-99ea-e559-ca9c-0f067cbcc153@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, cohuck@redhat.com, borntraeger@de.ibm.com

On 30.03.20 15:09, Janosch Frank wrote:
> On 3/30/20 3:03 PM, Janosch Frank wrote:
>> On 3/30/20 2:50 PM, David Hildenbrand wrote:
>>> On 30.03.20 14:20, Janosch Frank wrote:
>>>> +	report(data->vm[0].total_cpus =3D=3D smp_query_num_cpus(), "cpu # =
total");
>>>> +	report(data->vm[0].conf_cpus =3D=3D smp_query_num_cpus(), "cpu # c=
onfigured");
>>>> +	report(data->vm[0].standby_cpus =3D=3D 0, "cpu # standby");
>>>> +	report(data->vm[0].reserved_cpus =3D=3D 0, "cpu # reserved");
>>>
>>> IIRC, using -smp 1,maxcpus=3DX, you could also test the reported rese=
rved
>>> CPUs.
>>
>> Will try that
>=20
> Just like I thought, QEMU does not manipulate cpu counts and KVM
> pre-sets standby and reserved to 0. So we have absolutely no change whe=
n
> adding the smp parameter.

Well, for TCG it is properly implemented. Is this a BUG in KVM's STSI cod=
e?


--=20
Thanks,

David / dhildenb
