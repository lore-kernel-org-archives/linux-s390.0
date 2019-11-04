Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56753 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727861AbfKDOX7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 09:23:59 -0500
Subject: Re: [RFC 14/37] KVM: s390: protvirt: Implement interruption injection
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-15-frankja@linux.ibm.com>
 <f51f2146-834c-ba48-1015-b83c4fe6cd54@redhat.com>
 <b48afe44-8195-e9ed-d005-bfecbcebb1ca@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b73c7a09-7901-3905-df6d-ce46a2f83aae@redhat.com>
Date: Mon, 4 Nov 2019 15:23:29 +0100
MIME-Version: 1.0
In-Reply-To: <b48afe44-8195-e9ed-d005-bfecbcebb1ca@de.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 04.11.19 15:05, Christian Borntraeger wrote:
>=20
>=20
> On 04.11.19 11:29, David Hildenbrand wrote:
>> On 24.10.19 13:40, Janosch Frank wrote:
>>> From: Michael Mueller <mimu@linux.ibm.com>
>>>
>>> The patch implements interruption injection for the following
>>> list of interruption types:
>>>
>>>  =C2=A0=C2=A0 - I/O
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 __deliver_io (III)
>>>
>>>  =C2=A0=C2=A0 - External
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 __deliver_cpu_timer (IEI)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 __deliver_ckc (IEI)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 __deliver_emergency_signal (IEI)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 __deliver_external_call (IEI)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 __deliver_service (IEI)
>>>
>>>  =C2=A0=C2=A0 - cpu restart
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 __deliver_restart (IRI)
>>
>> What exactly is IRQ_PEND_EXT_SERVICE_EV? Can you add some comments whet =
the new interrupt does and why it is needed in this context? Thanks
>=20
> I did that code. What about the following add-on description.
>=20
> The ultravisor does several checks on injected interrupts. For example it=
 will
> check that for an sclp interrupt with an sccb address we had an servc exi=
t
> and exit with a validity intercept.
> As the hypervisor must avoid valitity intercepts we now mask invalid inte=
rrupts.

s/valitity/validity/

>=20
> There are also sclp interrupts that only inject an event (e.g. an input e=
vent
> on the sclp consoles) those interrupts must not be masked.
> Let us split out these "event interupts" from the normal sccb interrupts =
into
> IRQ_PEND_EXT_SERVICE_EV.
>=20

Thanks for the clarification. From what I see, this is transparent from=20
user space - we only track these interrupts separately internally.

--=20

Thanks,

David / dhildenb
