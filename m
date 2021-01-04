Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 4 Jan 2021 16:23:57 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v1 0/4] s390/kvm: fix MVPG when in VSIE
Message-ID: <20210104162357.6b85baf0@ibm-vm>
In-Reply-To: <5947ede7-7f9f-cdaa-b827-75a5715e4f12@redhat.com>
References: <20201218141811.310267-1-imbrenda@linux.ibm.com>
 <5947ede7-7f9f-cdaa-b827-75a5715e4f12@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org

On Sun, 20 Dec 2020 10:40:27 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 18.12.20 15:18, Claudio Imbrenda wrote:
> > The current handling of the MVPG instruction when executed in a
> > nested guest is wrong, and can lead to the nested guest hanging. =20
>=20
> Hi,
>=20
> thanks for spotting and debugging! Is this related to nested guests
> hanging while migrating (mentioned by Janosch at some point)?

no, it was found by running legacy tests in VSIE (I have written
kvm-unit-tests for this now, I'll post them Soon=E2=84=A2)

> Or can this not be reproduced with actual Linux guests?

Linux doesn't use MVPG, and gcc in general seems to avoid it, so we
never really see this in the wild. Moreover Linux does not normally run
with DAT disabled.
=20
> Thanks!
>=20
> >=20
> > This patchset fixes the behaviour to be more architecturally
> > correct, and fixes the hangs observed.
> >=20
> > Claudio Imbrenda (4):
> >   s390/kvm: VSIE: stop leaking host addresses
> >   s390/kvm: extend guest_translate for MVPG interpretation
> >   s390/kvm: add kvm_s390_vsie_mvpg_check needed for VSIE MVPG
> >   s390/kvm: VSIE: correctly handle MVPG when in VSIE
> >=20
> >  arch/s390/kvm/gaccess.c | 88
> > ++++++++++++++++++++++++++++++++++++++--- arch/s390/kvm/gaccess.h |
> >  3 ++ arch/s390/kvm/vsie.c    | 78
> > +++++++++++++++++++++++++++++++++--- 3 files changed, 159
> > insertions(+), 10 deletions(-)=20
>=20
>=20
