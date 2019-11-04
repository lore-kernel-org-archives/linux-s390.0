Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35033 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726526AbfKDLbk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 06:31:40 -0500
Subject: Re: [kvm-unit-tests PATCH v2 5/5] s390x: SCLP unit test
References: <1572023194-14370-1-git-send-email-imbrenda@linux.ibm.com>
 <1572023194-14370-6-git-send-email-imbrenda@linux.ibm.com>
 <1df14176-20a7-a9af-5622-2853425d973e@redhat.com>
 <20191104122931.0774ff7a@p-imbrenda.boeblingen.de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <56ce2fe9-1a6a-ffd6-3776-0be1b622032b@redhat.com>
Date: Mon, 4 Nov 2019 12:31:32 +0100
MIME-Version: 1.0
In-Reply-To: <20191104122931.0774ff7a@p-imbrenda.boeblingen.de.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 04.11.19 12:29, Claudio Imbrenda wrote:
> On Mon, 4 Nov 2019 11:58:20 +0100
> David Hildenbrand <david@redhat.com> wrote:
>=20
> [...]
>=20
>> Can we just please rename all "cx" into something like "len"? Or is
>> there a real need to have "cx" in there?
>=20
> if cx is such a nuisance to you, sure, I can rename it to i

better than random characters :)

>=20
>> Also, I still dislike "test_one_sccb". Can't we just just do
>> something like
>>
>> expect_pgm_int();
>> rc =3D test_one_sccb(...)
>> report("whatever pgm", rc =3D=3D WHATEVER);
>> report("whatever rc", lc->pgm_int_code =3D=3D WHATEVER);
>>
>> In the callers to make these tests readable and cleanup
>> test_one_sccb(). I don't care if that produces more LOC as long as I
>> can actually read and understand the test cases.
>=20
> if you think that makes it more readable, ok I guess...
>=20
> consider that the output will be unreadable, though
>=20

I think his will turn out more readable.

--=20

Thanks,

David / dhildenb
