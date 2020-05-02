Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:54377 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728286AbgEBPnQ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 2 May 2020 11:43:16 -0400
From: Markus Elfring <Markus.Elfring@web.de>
Subject: KVM: s390/mm: Clarification for two return value checks in
 gmap_shadow()
Message-ID: <7f0b7ac0-d061-9484-bc5e-bdd9e32aa42b@web.de>
Date: Sat, 2 May 2020 17:43:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org, =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>

Hello,

I have tried another small script out for the semantic patch language.
This source code analysis approach points out that the function =E2=80=9Cg=
map_find_shadow=E2=80=9D
is called two times by the function =E2=80=9Cgmap_shadow=E2=80=9D.
https://elixir.bootlin.com/linux/v5.7-rc3/source/arch/s390/mm/gmap.c#L1628
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/ar=
ch/s390/mm/gmap.c

Null pointer checks are performed at these places.
The function =E2=80=9Cgmap_find_shadow=E2=80=9D is documented in the same =
source file
that the pointer =E2=80=9CERR_PTR(-EAGAIN)=E2=80=9D can eventually be retu=
rned.
Are the referenced gmap data structures always initialised here?

Regards,
Markus
