Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: KVM: s390/mm: Clarification for two return value checks in
 gmap_shadow()
References: <7f0b7ac0-d061-9484-bc5e-bdd9e32aa42b@web.de>
From: David Hildenbrand <david@redhat.com>
Message-ID: <993d6b88-1f8f-745e-90b6-6ab0917a57a6@redhat.com>
Date: Sat, 2 May 2020 19:27:31 +0200
MIME-Version: 1.0
In-Reply-To: <7f0b7ac0-d061-9484-bc5e-bdd9e32aa42b@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>

On 02.05.20 17:43, Markus Elfring wrote:
> Hello,
>=20
> I have tried another small script out for the semantic patch language.
> This source code analysis approach points out that the function =E2=80=9C=
gmap_find_shadow=E2=80=9D
> is called two times by the function =E2=80=9Cgmap_shadow=E2=80=9D.
> https://elixir.bootlin.com/linux/v5.7-rc3/source/arch/s390/mm/gmap.c#L1=
628
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log=
/arch/s390/mm/gmap.c
>=20
> Null pointer checks are performed at these places.

Right, in case we have already a shadow, we return it. In case we are
just concurrently creating/initializing another one, we return -EINVAL
so the caller will retry (and find the fully initialized one). In case
we get NULL, we have to create a new one.

> The function =E2=80=9Cgmap_find_shadow=E2=80=9D is documented in the sa=
me source file
> that the pointer =E2=80=9CERR_PTR(-EAGAIN)=E2=80=9D can eventually be r=
eturned.
> Are the referenced gmap data structures always initialised here?

-EAGAIN makes sure that we are not touching partially initialized one.
In case we find a valid gmap shadow, it is fully initialized. That's
what we have the ->initialized field for.

Hope that answers your question.

--=20
Thanks,

David / dhildenb
