From: =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
Subject: Re: [Qemu-devel] [RFC PATCH v2 13/15] cpu-model/s390: Add processor
 property routines
Date: Fri, 20 Feb 2015 17:28:14 +0100
Message-ID: <54E7609E.6020302@suse.de>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>	<1424183053-4310-14-git-send-email-mimu@linux.vnet.ibm.com>	<54E73EB2.6050700@suse.de>	<20150220163209.4e082e0b@bee>	<54E755BD.5000705@suse.de> <20150220170408.49db6da5@bee>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20150220170408.49db6da5@bee>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

Am 20.02.2015 um 17:04 schrieb Michael Mueller:
> On Fri, 20 Feb 2015 16:41:49 +0100
> Andreas F=C3=A4rber <afaerber@suse.de> wrote:
>=20
>> Can't you just implement the class-level name-to-ObjectClass callbac=
k
>> that other CPUs have grown for the above use case?
>=20
> If it fulfills the requirements sure. Please point me to an example,

Take a look at include/qom/cpu.h CPUClass::class_by_name and git-grep
the existing targets - most implement it already. It's a generic hook t=
o
be used from everywhere rather than a local function specific to the
legacy init function. Apart from the error handling it should be
straight-forward.

> sounds that
> s390_select_cpu_model() is doing something similar to that, just that=
 it hooks in
> the s390_set_processor_props() call.
>=20
> const char *s390_select_cpu_model(const char *model)
> {
>     S390ProcessorProps proc;
>     const char *typename;
>     S390CPUClass *cc;
>=20
>     /* return already selected cpu typename */
>     typename =3D s390_cpu_typename();
>     if (typename) {
>         goto out;
>     }
>=20
>     /* return standard cpu typename when cpu models are unavailable *=
/
>     typename =3D TYPE_S390_CPU;
>     if (!s390_cpu_classes_initialized() || !model) {
>         goto out;
>     }
>     cc =3D S390_CPU_CLASS(s390_cpu_class_by_name(model));
>     if (!cc) {
>         goto out;
>     }
>     proc.cpuid =3D cpuid(cc->proc);
>     proc.ibc =3D cc->proc->ibc;
>     memcpy(proc.fac_list, cc->fac_list, S390_ARCH_FAC_LIST_SIZE_BYTE)=
;
>     if (s390_set_processor_props(&proc)) {
>         goto out;
>     }

Sorry for my ignorance, but what is proc actually needed for? For
initializing the class, there's .class_init (and cc->fac_list apparentl=
y
is initialized here). If you need to pass info to KVM, you can do so in
DeviceClass::realize when the vCPU actually goes "live". A
string-to-string (or string-to-ObjectClass) translation function seems
like a weird point in time to take action with global effect.

Anyway, please implement the generic callback, then you can still call
it from your own helper functions if needed.

Regards,
Andreas

>=20
>     /* return requested cpu typename in success case */
>     typename =3D object_class_get_name((ObjectClass *) cc);
> out:
>     selected_cpu_typename =3D typename;
>     trace_select_cpu_model(model, typename);
>     return typename;
> }

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Jane Smithard, Jennifer Guild, Dilip Upmany=
u,
Graham Norton; HRB 21284 (AG N=C3=BCrnberg)
