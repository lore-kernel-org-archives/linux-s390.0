From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: s390: fix build failure
Date: Wed, 8 Jun 2016 06:25:20 -0400 (EDT)
Message-ID: <1162621005.20783715.1465381520818.JavaMail.zimbra@redhat.com>
References: <1465336170-23064-1-git-send-email-sudipm.mukherjee@gmail.com> <5757AA6F.705@de.ibm.com> <20160608053129.GA3311@osiris> <20160608180917.4d6d3434@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160608180917.4d6d3434@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



----- Original Message -----
> From: "Stephen Rothwell" <sfr@canb.auug.org.au>
> To: "Heiko Carstens" <heiko.carstens@de.ibm.com>
> Cc: "Christian Borntraeger" <borntraeger@de.ibm.com>, "Sudip Mukherje=
e" <sudipm.mukherjee@gmail.com>, "Cornelia Huck"
> <cornelia.huck@de.ibm.com>, "Paolo Bonzini" <pbonzini@redhat.com>, "R=
adim Kr=C4=8Dm=C3=A1=C5=99" <rkrcmar@redhat.com>, "Martin
> Schwidefsky" <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, =
linux-s390@vger.kernel.org, kvm@vger.kernel.org
> Sent: Wednesday, June 8, 2016 10:09:17 AM
> Subject: Re: [PATCH] KVM: s390: fix build failure
>=20
> Hi Heiko,
>=20
> On Wed, 8 Jun 2016 07:31:29 +0200 Heiko Carstens <heiko.carstens@de.i=
bm.com>
> wrote:
> >
> > On Wed, Jun 08, 2016 at 07:17:35AM +0200, Christian Borntraeger wro=
te:
> > > On 06/07/2016 11:49 PM, Sudip Mukherjee wrote:
> > > > etr_ptff definitions are moved and renamed but we missed updati=
ng them
> > > > here and as a result s390 defconfig and allmodconfig was failin=
g with
> > > > the error:
> > > > arch/s390/kvm/kvm-s390.c:230:45: error: 'ETR_PTFF_QAF' undeclar=
ed
> > > >=20
> > > > Fixes: cc8f94656487 ("s390/time: move PTFF definitions")
> > > > Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk=
>
> > >=20
> > > Thank you for the report and patch.
> > >=20
> > > This is linux-next only. Its a conflict between my kvms390 queue =
and
> > > Martins s390 queue. We cannot apply this directly as it would bre=
ak
> > > the build of my tree when not merged in next. (and it does not ap=
ply
> > > on Martins tree).
> > >=20
> > > I will have a look how to fix that up.
> >=20
> > We could ask Stephen Rothwell to apply the patch only to linux-next=
? ;)
>=20
> Martin sent me the same patch earlier and I applied it to the merge o=
f
> the kvms390 tree today.  Someone needs to remember to tell Linus when
> the time comes.

I can take care of that.  On your side, the resolution will have to mig=
rate
to the KVM tree as soon as Christian sends me a pull request for 4.8.

Thanks,

Paolo
