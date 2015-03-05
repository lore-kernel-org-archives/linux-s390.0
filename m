From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/16] Introduce probe mode for machine
 type none
Date: Thu, 5 Mar 2015 15:56:03 +0100
Message-ID: <20150305155603.356b5ae7@bee>
References: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1425300248-40277-2-git-send-email-mimu@linux.vnet.ibm.com>
	<54F46C41.3000201@suse.de>
	<20150302174352.3715f1e4@bee>
	<54F4965D.7000701@suse.de>
	<20150303115524.40bd40b0@bee>
	<20150304191925.GD13041@thinpad.lan.raisama.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150304191925.GD13041@thinpad.lan.raisama.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>, linux-s390@vger.kernel.org, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 4 Mar 2015 16:19:25 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, Mar 03, 2015 at 11:55:24AM +0100, Michael Mueller wrote:
> > On Mon, 02 Mar 2015 17:57:01 +0100
> > Andreas F=C3=A4rber <afaerber@suse.de> wrote:
> >=20
> > > Am 02.03.2015 um 17:43 schrieb Michael Mueller:
> > > > On Mon, 02 Mar 2015 14:57:21 +0100
> > > > Andreas F=C3=A4rber <afaerber@suse.de> wrote:
> > > >=20
> > > >>>  int configure_accelerator(MachineState *ms)
> > > >>>  {
> > > >>> -    const char *p;
> > > >>> +    const char *p, *name;
> > > >>>      char buf[10];
> > > >>>      int ret;
> > > >>>      bool accel_initialised =3D false;
> > > >>>      bool init_failed =3D false;
> > > >>>      AccelClass *acc =3D NULL;
> > > >>> +    ObjectClass *oc;
> > > >>> +    bool probe_mode =3D false;
> > > >>> =20
> > > >>>      p =3D qemu_opt_get(qemu_get_machine_opts(), "accel");
> > > >>>      if (p =3D=3D NULL) {
> > > >>> -        /* Use the default "accelerator", tcg */
> > > >>> -        p =3D "tcg";
> > > >>> +        oc =3D (ObjectClass *) MACHINE_GET_CLASS(current_mac=
hine);
> > > >>> +        name =3D object_class_get_name(oc);
> > > >>> +        probe_mode =3D !strcmp(name, "none" TYPE_MACHINE_SUF=
=46IX);
> > > >>> +        if (probe_mode) {
> > > >>> +            /* Use these accelerators in probe mode, tcg sho=
uld be last */
> > > >>> +            p =3D probe_mode_accels;
> > > >>> +        } else {
> > > >>> +            /* Use the default "accelerator", tcg */
> > > >>> +            p =3D "tcg";
> > > >>> +        }
> > > >>>      } =20
> > > >>
> > > >> Can't we instead use an explicit ,accel=3Dprobe or ,accel=3Dau=
to?
> > > >> That would then obsolete the next patch.
> > > >=20
> > > > How would you express the following with the accel=3D<pseudo-ac=
cel> approach?
> > > >=20
> > > > -probe -machine s390-ccw,accel=3Dkvm=20
> > > >=20
> > > > Using machine "none" as default with tcg as last accelerator in=
itialized should not break
> > > > anything.
> > > >=20
> > > > -M none
> > >=20
> > > Let me ask differently: What does -machine none or -M none have t=
o do
> > > with probing? It reads as if you are introducing two probe modes.=
 Why do
> >=20
> > The machine none? nothing directly, I guess. What are real world us=
e cases for that
> > machine type?
> >=20
> > > you need both? If we have -probe, isn't that independent of which
> >=20
> > It is just two different means to switch on the same mode.
> >=20
> > > machine we specify? Who is going to call either, with which respe=
ctive goal?
> >=20
> > -probe itself would be sufficient but I currently do not want to en=
force the use of
> > a new parameter. Best would be not to have that mode at all if poss=
ible.=20
> >=20
> > The intended use case is driven by management interfaces that need =
to draw decisions
> > on, in this particular case runnable cpu models, with information o=
riginated by qemu.
> >=20
> > Let me walk through Eduardo's suggestion first and crosscheck it wi=
th my requirements
> > before we enter in a maybe afterwards obsolete discussion.
>=20
> I have been working on some changes to implement x86 CPU probing code
> that creates accel objects on the fly, that may be useful. See:
>   https://github.com/ehabkost/qemu-hacks/tree/work/user-accel-init
>=20
> Especially the commit:
>   kvm: Move /dev/kvm opening/closing to open/close methods
>=20

So the idea is to use kvm_open/close() in the query-cpu-definitions cal=
lback on the fly without
to disturb the KVM-side data structures for the machine probe instead o=
f going through kvm_init()
during accelerator configuration?


> The next steps I plan are:
>  * Create AccelState object on TCG too, and somehow pass it as argume=
nt
>    to cpu_x86_init()
>  * Change all kvm_enabled() occurrences on target-i386/cpu.c to use
>    the provided accel object (including
>    x86_cpu_get_supported_feature_word() and x86_cpu_filter_features()=
)
>  * Use the new
>    x86_cpu_get_supported_feature_word()/x86_cpu_filter_features() cod=
e
>    to implement a is_runnable(X86CPUClass*, AccelState*) check
>  * Use the new is_runnable() check to extend query-cpu-definitions fo=
r x86 too
>  * Add -cpu string and machine-type arguments to the is_runnable() ch=
eck
>=20
