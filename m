Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726131AbgHMMgc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Aug 2020 08:36:32 -0400
From: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [kvm-unit-tests RFC v2 2/4] scripts: add support for architecture dependent functions
In-Reply-To: <20200813120705.7bggleqpq56jqdxm@kamzik.brq.redhat.com>
References: <20200812092705.17774-1-mhartmay@linux.ibm.com> <20200812092705.17774-3-mhartmay@linux.ibm.com> <20200813074940.73xzr6nq4xktjhpu@kamzik.brq.redhat.com> <87lfiihiqd.fsf@linux.ibm.com> <20200813120705.7bggleqpq56jqdxm@kamzik.brq.redhat.com>
Date: Thu, 13 Aug 2020 14:36:23 +0200
Message-ID: <87h7t6hge0.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Jones <drjones@redhat.com>, Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Thu, Aug 13, 2020 at 02:07 PM +0200, Andrew Jones <drjones@redhat.com> w=
rote:
> On Thu, Aug 13, 2020 at 01:45:46PM +0200, Marc Hartmayer wrote:
>> On Thu, Aug 13, 2020 at 09:49 AM +0200, Andrew Jones <drjones@redhat.com=
> wrote:
>> > On Wed, Aug 12, 2020 at 11:27:03AM +0200, Marc Hartmayer wrote:
>> >> This is necessary to keep architecture dependent code separate from
>> >> common code.
>> >>=20
>> >> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>> >> ---
>> >>  README.md           | 3 ++-
>> >>  scripts/common.bash | 5 +++++
>> >>  2 files changed, 7 insertions(+), 1 deletion(-)
>> >>=20
>> >> diff --git a/README.md b/README.md
>> >> index 48be206c6db1..24d4bdaaee0d 100644
>> >> --- a/README.md
>> >> +++ b/README.md
>> >> @@ -134,7 +134,8 @@ all unit tests.
>> >>  ## Directory structure
>> >>=20=20
>> >>      .:                  configure script, top-level Makefile, and ru=
n_tests.sh
>> >> -    ./scripts:          helper scripts for building and running tests
>> >> +    ./scripts:          general architecture neutral helper scripts =
for building and running tests
>> >> +    ./scripts/<ARCH>:   architecture dependent helper scripts for bu=
ilding and running tests
>> >>      ./lib:              general architecture neutral services for th=
e tests
>> >>      ./lib/<ARCH>:       architecture dependent services for the tests
>> >>      ./<ARCH>:           the sources of the tests and the created obj=
ects/images
>> >> diff --git a/scripts/common.bash b/scripts/common.bash
>> >> index 96655c9ffd1f..f9c15fd304bd 100644
>> >> --- a/scripts/common.bash
>> >> +++ b/scripts/common.bash
>> >> @@ -52,3 +52,8 @@ function for_each_unittest()
>> >>  	fi
>> >>  	exec {fd}<&-
>> >>  }
>> >> +
>> >> +ARCH_FUNC=3Dscripts/${ARCH}/func.bash
>> >
>> > The use of ${ARCH} adds a dependency on config.mak. It works now becau=
se
>> > in the two places we source common.bash we source config.mak first
>>=20
>> Yep, I know.
>>=20
>> > , but
>> > I'd prefer we make that dependency explicit.
>>=20
>> Okay.
>>=20
>> > We could probably just
>> > source it again from this file.
>>=20
>> Another option is to pass ${ARCH} as an argument when we `source
>> scripts/runtime.bash`
>>=20
>> =3D> `source scripts/runtime.bash "${ARCH}"`
>>=20
>> Which one do you prefer?
>
> The first one. There's a chance that the arch helper functions will
> need more than $ARCH from config.mak. Of course that means we have
> a dependency on config.mak from the arch helper file too. We can
> just add a comment in common.bash about the order of sourcing
> though, as common.bash should be the only file sourcing the
> arch helper file.

Will add it. Thanks!

>
> Thanks,
> drew
>
>>=20
>> >
>> > Thanks,
>> > drew
>> >
>> >> +if [ -f "${ARCH_FUNC}" ]; then
>> >> +	source "${ARCH_FUNC}"
>> >> +fi
>> >> --=20
>> >> 2.25.4
>> >>=20
>> >
>> --=20
>> Kind regards / Beste Gr=C3=BC=C3=9Fe
>>    Marc Hartmayer
>>=20
>> IBM Deutschland Research & Development GmbH
>> Vorsitzender des Aufsichtsrats: Gregor Pillen=20
>> Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
>> Sitz der Gesellschaft: B=C3=B6blingen
>> Registergericht: Amtsgericht Stuttgart, HRB 243294
>>=20
>
--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen=20
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
