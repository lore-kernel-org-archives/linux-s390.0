Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbgHMMHV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Aug 2020 08:07:21 -0400
Date: Thu, 13 Aug 2020 14:07:05 +0200
From: Andrew Jones <drjones@redhat.com>
Subject: Re: [kvm-unit-tests RFC v2 2/4] scripts: add support for
 architecture dependent functions
Message-ID: <20200813120705.7bggleqpq56jqdxm@kamzik.brq.redhat.com>
References: <20200812092705.17774-1-mhartmay@linux.ibm.com>
 <20200812092705.17774-3-mhartmay@linux.ibm.com>
 <20200813074940.73xzr6nq4xktjhpu@kamzik.brq.redhat.com>
 <87lfiihiqd.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87lfiihiqd.fsf@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Thu, Aug 13, 2020 at 01:45:46PM +0200, Marc Hartmayer wrote:
> On Thu, Aug 13, 2020 at 09:49 AM +0200, Andrew Jones <drjones@redhat.com>=
 wrote:
> > On Wed, Aug 12, 2020 at 11:27:03AM +0200, Marc Hartmayer wrote:
> >> This is necessary to keep architecture dependent code separate from
> >> common code.
> >>=20
> >> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> >> ---
> >>  README.md           | 3 ++-
> >>  scripts/common.bash | 5 +++++
> >>  2 files changed, 7 insertions(+), 1 deletion(-)
> >>=20
> >> diff --git a/README.md b/README.md
> >> index 48be206c6db1..24d4bdaaee0d 100644
> >> --- a/README.md
> >> +++ b/README.md
> >> @@ -134,7 +134,8 @@ all unit tests.
> >>  ## Directory structure
> >> =20
> >>      .:                  configure script, top-level Makefile, and run=
_tests.sh
> >> -    ./scripts:          helper scripts for building and running tests
> >> +    ./scripts:          general architecture neutral helper scripts f=
or building and running tests
> >> +    ./scripts/<ARCH>:   architecture dependent helper scripts for bui=
lding and running tests
> >>      ./lib:              general architecture neutral services for the=
 tests
> >>      ./lib/<ARCH>:       architecture dependent services for the tests
> >>      ./<ARCH>:           the sources of the tests and the created obje=
cts/images
> >> diff --git a/scripts/common.bash b/scripts/common.bash
> >> index 96655c9ffd1f..f9c15fd304bd 100644
> >> --- a/scripts/common.bash
> >> +++ b/scripts/common.bash
> >> @@ -52,3 +52,8 @@ function for_each_unittest()
> >>  	fi
> >>  	exec {fd}<&-
> >>  }
> >> +
> >> +ARCH_FUNC=3Dscripts/${ARCH}/func.bash
> >
> > The use of ${ARCH} adds a dependency on config.mak. It works now because
> > in the two places we source common.bash we source config.mak first
>=20
> Yep, I know.
>=20
> > , but
> > I'd prefer we make that dependency explicit.
>=20
> Okay.
>=20
> > We could probably just
> > source it again from this file.
>=20
> Another option is to pass ${ARCH} as an argument when we `source
> scripts/runtime.bash`
>=20
> =3D> `source scripts/runtime.bash "${ARCH}"`
>=20
> Which one do you prefer?

The first one. There's a chance that the arch helper functions will
need more than $ARCH from config.mak. Of course that means we have
a dependency on config.mak from the arch helper file too. We can
just add a comment in common.bash about the order of sourcing
though, as common.bash should be the only file sourcing the
arch helper file.

Thanks,
drew

>=20
> >
> > Thanks,
> > drew
> >
> >> +if [ -f "${ARCH_FUNC}" ]; then
> >> +	source "${ARCH_FUNC}"
> >> +fi
> >> --=20
> >> 2.25.4
> >>=20
> >
> --=20
> Kind regards / Beste Gr=EF=BF=BD=EF=BF=BDe
>    Marc Hartmayer
>=20
> IBM Deutschland Research & Development GmbH
> Vorsitzender des Aufsichtsrats: Gregor Pillen=20
> Gesch=EF=BF=BDftsf=EF=BF=BDhrung: Dirk Wittkopp
> Sitz der Gesellschaft: B=EF=BF=BDblingen
> Registergericht: Amtsgericht Stuttgart, HRB 243294
>=20
