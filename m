From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/16] Introduce probe mode for machine
 type none
Date: Tue, 3 Mar 2015 11:55:24 +0100
Message-ID: <20150303115524.40bd40b0@bee>
References: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1425300248-40277-2-git-send-email-mimu@linux.vnet.ibm.com>
	<54F46C41.3000201@suse.de>
	<20150302174352.3715f1e4@bee>
	<54F4965D.7000701@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54F4965D.7000701@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 02 Mar 2015 17:57:01 +0100
Andreas F=C3=A4rber <afaerber@suse.de> wrote:

> Am 02.03.2015 um 17:43 schrieb Michael Mueller:
> > On Mon, 02 Mar 2015 14:57:21 +0100
> > Andreas F=C3=A4rber <afaerber@suse.de> wrote:
> >=20
> >>>  int configure_accelerator(MachineState *ms)
> >>>  {
> >>> -    const char *p;
> >>> +    const char *p, *name;
> >>>      char buf[10];
> >>>      int ret;
> >>>      bool accel_initialised =3D false;
> >>>      bool init_failed =3D false;
> >>>      AccelClass *acc =3D NULL;
> >>> +    ObjectClass *oc;
> >>> +    bool probe_mode =3D false;
> >>> =20
> >>>      p =3D qemu_opt_get(qemu_get_machine_opts(), "accel");
> >>>      if (p =3D=3D NULL) {
> >>> -        /* Use the default "accelerator", tcg */
> >>> -        p =3D "tcg";
> >>> +        oc =3D (ObjectClass *) MACHINE_GET_CLASS(current_machine=
);
> >>> +        name =3D object_class_get_name(oc);
> >>> +        probe_mode =3D !strcmp(name, "none" TYPE_MACHINE_SUFFIX)=
;
> >>> +        if (probe_mode) {
> >>> +            /* Use these accelerators in probe mode, tcg should =
be last */
> >>> +            p =3D probe_mode_accels;
> >>> +        } else {
> >>> +            /* Use the default "accelerator", tcg */
> >>> +            p =3D "tcg";
> >>> +        }
> >>>      } =20
> >>
> >> Can't we instead use an explicit ,accel=3Dprobe or ,accel=3Dauto?
> >> That would then obsolete the next patch.
> >=20
> > How would you express the following with the accel=3D<pseudo-accel>=
 approach?
> >=20
> > -probe -machine s390-ccw,accel=3Dkvm=20
> >=20
> > Using machine "none" as default with tcg as last accelerator initia=
lized should not break
> > anything.
> >=20
> > -M none
>=20
> Let me ask differently: What does -machine none or -M none have to do
> with probing? It reads as if you are introducing two probe modes. Why=
 do

The machine none? nothing directly, I guess. What are real world use ca=
ses for that
machine type?

> you need both? If we have -probe, isn't that independent of which

It is just two different means to switch on the same mode.

> machine we specify? Who is going to call either, with which respectiv=
e goal?

-probe itself would be sufficient but I currently do not want to enforc=
e the use of
a new parameter. Best would be not to have that mode at all if possible=
=2E=20

The intended use case is driven by management interfaces that need to d=
raw decisions
on, in this particular case runnable cpu models, with information origi=
nated by qemu.

Let me walk through Eduardo's suggestion first and crosscheck it with m=
y requirements
before we enter in a maybe afterwards obsolete discussion.

Thanks,
Michael

>=20
> I think that changing the semantics of an absent ,accel=3Dfoo paramet=
er to
> mean something else than its longtime default of tcg is a bad idea.
>
> Have you testing qtest with it? Doesn't -qtest imply accel=3Dqtest or=
 is
> that always passed explicitly?
>=20
> Regards,
> Andreas
>=20
