Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39120 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727627AbgDCTzH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Apr 2020 15:55:07 -0400
Received: by mail-wm1-f69.google.com with SMTP id u6so2519149wmm.6
        for <linux-s390@vger.kernel.org>; Fri, 03 Apr 2020 12:55:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/5] KVM: s390: vsie: Fix region 1 ASCE sanity shadow address checks
Date: Fri, 3 Apr 2020 21:55:02 +0200
Message-Id: <67F45F4F-33CB-455A-8CB8-7D20D9A2BF2F@redhat.com>
References: <59b411eb-dabe-8cac-9270-7a9f0faa63d5@de.ibm.com>
In-Reply-To: <59b411eb-dabe-8cac-9270-7a9f0faa63d5@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, stable@vger.kernel.org



> Am 03.04.2020 um 19:56 schrieb Christian Borntraeger <borntraeger@de.ibm.c=
om>:
>=20
> =EF=BB=BF
>=20
>> On 03.04.20 17:30, David Hildenbrand wrote:
>> In case we have a region 1 ASCE, our shadow/g3 address can have any value=
.
>> Unfortunately, (-1UL << 64) is undefined and triggers sometimes,
>> rejecting valid shadow addresses when trying to walk our shadow table
>> hierarchy.
>=20
> I thin the range of the addresses do not matter.
> Took me a while to understand maybe rephrase that:
>=20
> In case we have a region 1 the following calculation=20
> (31 + ((gmap->asce & _ASCE_TYPE_MASK) >> 2)*11)
> results in 64. As shifts beyond the size are undefined the compiler is fre=
e to use
> instructions like sllg. sllg will only use 6 bits of the shift value (here=
 64)
> resulting in no shift at all. That means that ALL addresses will be reject=
ed.

Interestingly, it would not fail when shadowing the r2t, but only when tryin=
g to shadow the r3t.

>=20
> With that this makes sense.=20
>=20
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>=20

In case there are no other comments, can you fixup when applying, or do you w=
ant me to resend?

Cheers=
