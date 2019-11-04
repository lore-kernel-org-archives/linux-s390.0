Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40673 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728012AbfKDKWZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 05:22:25 -0500
Subject: Re: [RFC 09/37] KVM: s390: protvirt: Implement on-demand pinning
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-10-frankja@linux.ibm.com>
 <b76ae1ca-d211-d1c7-63d9-9b45c789f261@redhat.com>
 <7465141c-27b7-a89e-f02d-ab05cdd8505d@de.ibm.com>
 <4abdc1dc-884e-a819-2e9d-2b8b15030394@redhat.com>
 <20191101095016.0562fa76@p-imbrenda.boeblingen.de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fe0f9eaa-6dde-1d53-67e3-000f9eb64bbc@redhat.com>
Date: Mon, 4 Nov 2019 11:22:17 +0100
MIME-Version: 1.0
In-Reply-To: <20191101095016.0562fa76@p-imbrenda.boeblingen.de.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 01.11.19 09:50, Claudio Imbrenda wrote:
> On Thu, 31 Oct 2019 18:30:30 +0100
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 31.10.19 16:41, Christian Borntraeger wrote:
>>>
>>>
>>> On 25.10.19 10:49, David Hildenbrand wrote:
>>>> On 24.10.19 13:40, Janosch Frank wrote:
>>>>> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>>>>
>>>>> Pin the guest pages when they are first accessed, instead of all
>>>>> at the same time when starting the guest.
>>>>
>>>> Please explain why you do stuff. Why do we have to pin the hole
>>>> guest memory? Why can't we mlock() the hole memory to avoid
>>>> swapping in user space?
>>>
>>> Basically we pin the guest for the same reason as AMD did it for
>>> their SEV. It is hard
>>
>> Pinning all guest memory is very ugly. What you want is "don't page",
>> what you get is unmovable pages all over the place. I was hoping that
>> you could get around this by having an automatic back-and-forth
>> conversion in place (due to the special new exceptions).
>=20
> we're not pinning all of guest memory, btw, but only the pages that are
> actually used.

Any longer-running guest will eventually touch all guest physical memory=20
(e.g., page cache, page shuffling), so this is only an optimization for=20
short running guests.

--=20

Thanks,

David / dhildenb
