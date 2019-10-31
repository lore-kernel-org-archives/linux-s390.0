Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48550 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728561AbfJaRal (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 31 Oct 2019 13:30:41 -0400
Subject: Re: [RFC 09/37] KVM: s390: protvirt: Implement on-demand pinning
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-10-frankja@linux.ibm.com>
 <b76ae1ca-d211-d1c7-63d9-9b45c789f261@redhat.com>
 <7465141c-27b7-a89e-f02d-ab05cdd8505d@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4abdc1dc-884e-a819-2e9d-2b8b15030394@redhat.com>
Date: Thu, 31 Oct 2019 18:30:30 +0100
MIME-Version: 1.0
In-Reply-To: <7465141c-27b7-a89e-f02d-ab05cdd8505d@de.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 31.10.19 16:41, Christian Borntraeger wrote:
>=20
>=20
> On 25.10.19 10:49, David Hildenbrand wrote:
>> On 24.10.19 13:40, Janosch Frank wrote:
>>> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>>
>>> Pin the guest pages when they are first accessed, instead of all at
>>> the same time when starting the guest.
>>
>> Please explain why you do stuff. Why do we have to pin the hole guest me=
mory? Why can't we mlock() the hole memory to avoid swapping in user space?
>=20
> Basically we pin the guest for the same reason as AMD did it for their SE=
V. It is hard

Pinning all guest memory is very ugly. What you want is "don't page",=20
what you get is unmovable pages all over the place. I was hoping that=20
you could get around this by having an automatic back-and-forth=20
conversion in place (due to the special new exceptions).

> to synchronize page import/export with the I/O for paging. For example yo=
u can actually
> fault in a page that is currently under paging I/O. What do you do? impor=
t (so that the
> guest can run) or export (so that the I/O will work). As this turned out =
to be harder then
> we though we decided to defer paging to a later point in time.

I don't quite see the issue yet. If you page out, the page will=20
automatically (on access) be converted to !secure/encrypted memory. If=20
the UV/guest wants to access it, it will be automatically converted to=20
secure/unencrypted memory. If you have concurrent access, it will be=20
converted back and forth until one party is done.

A proper automatic conversion should make this work. What am I missing?

>=20
> As we do not want to rely on the userspace to do the mlock this is now do=
ne in the kernel.

I wonder if we could come up with an alternative (similar to how we=20
override VM_MERGEABLE in the kernel) that can be called and ensured in=20
the kernel. E.g., marking whole VMAs as "don't page" (I remember=20
something like "special VMAs" like used for VDSOs that achieve exactly=20
that, but I am absolutely no expert on that). That would be much nicer=20
than pinning all pages and remembering what you pinned in huge page=20
arrays ...

--=20

Thanks,

David / dhildenb
