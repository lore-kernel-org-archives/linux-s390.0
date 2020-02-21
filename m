Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21571 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726694AbgBUL3C (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 21 Feb 2020 06:29:02 -0500
Subject: Re: [PATCH v3 00/37] KVM: s390: Add support for protected VMs
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
 <5556ee4a-09c6-117a-be99-4a5e136b78ea@redhat.com>
 <0665a90a-19f2-39a8-8a48-d180a622e9f2@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1c54d830-79de-e3ee-4c11-d87f95f90c57@redhat.com>
Date: Fri, 21 Feb 2020 12:28:51 +0100
MIME-Version: 1.0
In-Reply-To: <0665a90a-19f2-39a8-8a48-d180a622e9f2@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org

> In fact you can do that. The hardware checks the integrity on guest phy=
sical
> address. So it is perfectly possible to remap a kvm slot as long as the
> e=C5=84crypted content matches what counter, guest content hash and gue=
st address
> tell. (It is like swapping, you move the encrypted content from one hos=
t=20
> page to another).=20
> For new pages (not unpacked and never touched by the guest) the ultravi=
sor
> will bring a zeroed out page on first import.
>=20
> What does not work is when the user space address changes for a guest
> virtio indicator. But this was already broken before (we never did an
> adapter unmap/remap).
>=20

Thanks for the info!

>>
>> Can we get a new version once the other reviewers are done, so at leas=
t
>> I can have a final look?
>=20
> Just the updated patches as reply (e.g. a 3.2 for patch 9) or the full =
monty?

Whatever you others prefer. I can see that Conny has some feedback.
maybe wait for that and then (selectively) resend.


--=20
Thanks,

David / dhildenb
