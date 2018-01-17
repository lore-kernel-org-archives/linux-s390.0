From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 4/6] s390: add system call to run tasks with modified
 branch prediction
Date: Wed, 17 Jan 2018 14:25:49 +0100
Message-ID: <20180117132549.GC5708@osiris>
References: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
 <1516182519-10623-5-git-send-email-schwidefsky@de.ibm.com>
 <5bda76be-0fec-8165-20bf-5cd8e51e955a@redhat.com>
 <c80554d9-a7e0-00cf-9f03-b16ce34205c5@de.ibm.com>
 <20180117125506.26f3813c@mschwideX1>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180117125506.26f3813c@mschwideX1>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 17, 2018 at 12:55:06PM +0100, Martin Schwidefsky wrote:
> On Wed, 17 Jan 2018 12:14:52 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>=20
> > On 01/17/2018 11:03 AM, Florian Weimer wrote:
> > > On 01/17/2018 10:48 AM, Martin Schwidefsky wrote: =20
> > >> =A0=A0=A0=A0=A0=A0=A0=A0 rc =3D syscall(__NR_s390_modify_bp);
> > >> =A0=A0=A0=A0=A0=A0=A0=A0 if (rc) {
> > >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 perror("s390_modify=
_bp");
> > >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 exit(EXIT_FAILURE);
> > >> =A0=A0=A0=A0=A0=A0=A0=A0 } =20
> > >=20
> > > Isn't this traditionally done through personality or prctl? =20
> >=20
> > I think we want this per thread (and not per process). So I assume pers=
onality
> > will not work out. Can a prctl be done per thread?
>=20
> The prctl interface seems to be usable to set a per-thread control
> as well. But there is no architecture specific prctl as far as I
> can see. Maybe a common PR_SET_NOBP with an arch function like
> arch_set_nobp.

There is for example PR_MPX_ENABLE_MANAGEMENT, which is x86 specific. On
the other hand x86 even has an arch_prctl() system call... ;)
