Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726015AbgKRJoJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Nov 2020 04:44:09 -0500
Received: by mail-ej1-f71.google.com with SMTP id l2so636296ejx.6
        for <linux-s390@vger.kernel.org>; Wed, 18 Nov 2020 01:44:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/2] Fix and MAINTAINER update for 5.10
Date: Wed, 18 Nov 2020 10:43:58 +0100
Message-Id: <B53D943E-050D-45BD-9847-B8D712577442@redhat.com>
References: <20201118093942.457191-1-borntraeger@de.ibm.com>
In-Reply-To: <20201118093942.457191-1-borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>


> Am 18.11.2020 um 10:39 schrieb Christian Borntraeger <borntraeger@de.ibm.c=
om>:
>=20
> =EF=BB=BFConny, David,
>=20
> your chance for quick feedback. I plan to send a pull request for kvm
> master soon.
>=20

LGTM

> I have agreed with Heiko to carry this via the KVM tree as
> this is KVM s390 specific.
>=20
> Christian Borntraeger (2):
>  s390/uv: handle destroy page legacy interface
>  MAINTAINERS: add uv.c also to KVM/s390
>=20
> MAINTAINERS           | 1 +
> arch/s390/kernel/uv.c | 9 ++++++++-
> 2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.28.0
>=20
