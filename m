From: =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
Subject: Re: [Qemu-devel] [PATCH v3 01/16] Introduce probe mode for machine
 type none
Date: Mon, 02 Mar 2015 17:57:01 +0100
Message-ID: <54F4965D.7000701@suse.de>
References: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>	<1425300248-40277-2-git-send-email-mimu@linux.vnet.ibm.com>	<54F46C41.3000201@suse.de> <20150302174352.3715f1e4@bee>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150302174352.3715f1e4@bee>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

Am 02.03.2015 um 17:43 schrieb Michael Mueller:
> On Mon, 02 Mar 2015 14:57:21 +0100
> Andreas F=C3=A4rber <afaerber@suse.de> wrote:
>=20
>>>  int configure_accelerator(MachineState *ms)
>>>  {
>>> -    const char *p;
>>> +    const char *p, *name;
>>>      char buf[10];
>>>      int ret;
>>>      bool accel_initialised =3D false;
>>>      bool init_failed =3D false;
>>>      AccelClass *acc =3D NULL;
>>> +    ObjectClass *oc;
>>> +    bool probe_mode =3D false;
>>> =20
>>>      p =3D qemu_opt_get(qemu_get_machine_opts(), "accel");
>>>      if (p =3D=3D NULL) {
>>> -        /* Use the default "accelerator", tcg */
>>> -        p =3D "tcg";
>>> +        oc =3D (ObjectClass *) MACHINE_GET_CLASS(current_machine);
>>> +        name =3D object_class_get_name(oc);
>>> +        probe_mode =3D !strcmp(name, "none" TYPE_MACHINE_SUFFIX);
>>> +        if (probe_mode) {
>>> +            /* Use these accelerators in probe mode, tcg should be=
 last */
>>> +            p =3D probe_mode_accels;
>>> +        } else {
>>> +            /* Use the default "accelerator", tcg */
>>> +            p =3D "tcg";
>>> +        }
>>>      } =20
>>
>> Can't we instead use an explicit ,accel=3Dprobe or ,accel=3Dauto?
>> That would then obsolete the next patch.
>=20
> How would you express the following with the accel=3D<pseudo-accel> a=
pproach?
>=20
> -probe -machine s390-ccw,accel=3Dkvm=20
>=20
> Using machine "none" as default with tcg as last accelerator initiali=
zed should not break
> anything.
>=20
> -M none

Let me ask differently: What does -machine none or -M none have to do
with probing? It reads as if you are introducing two probe modes. Why d=
o
you need both? If we have -probe, isn't that independent of which
machine we specify? Who is going to call either, with which respective =
goal?

I think that changing the semantics of an absent ,accel=3Dfoo parameter=
 to
mean something else than its longtime default of tcg is a bad idea.

Have you testing qtest with it? Doesn't -qtest imply accel=3Dqtest or i=
s
that always passed explicitly?

Regards,
Andreas

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Jane Smithard, Jennifer Guild, Dilip Upmany=
u,
Graham Norton; HRB 21284 (AG N=C3=BCrnberg)
