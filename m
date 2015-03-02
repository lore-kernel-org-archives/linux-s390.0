From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/16] Introduce probe mode for machine
 type none
Date: Mon, 2 Mar 2015 17:43:52 +0100
Message-ID: <20150302174352.3715f1e4@bee>
References: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1425300248-40277-2-git-send-email-mimu@linux.vnet.ibm.com>
	<54F46C41.3000201@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54F46C41.3000201@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 02 Mar 2015 14:57:21 +0100
Andreas F=C3=A4rber <afaerber@suse.de> wrote:

> >  int configure_accelerator(MachineState *ms)
> >  {
> > -    const char *p;
> > +    const char *p, *name;
> >      char buf[10];
> >      int ret;
> >      bool accel_initialised =3D false;
> >      bool init_failed =3D false;
> >      AccelClass *acc =3D NULL;
> > +    ObjectClass *oc;
> > +    bool probe_mode =3D false;
> > =20
> >      p =3D qemu_opt_get(qemu_get_machine_opts(), "accel");
> >      if (p =3D=3D NULL) {
> > -        /* Use the default "accelerator", tcg */
> > -        p =3D "tcg";
> > +        oc =3D (ObjectClass *) MACHINE_GET_CLASS(current_machine);
> > +        name =3D object_class_get_name(oc);
> > +        probe_mode =3D !strcmp(name, "none" TYPE_MACHINE_SUFFIX);
> > +        if (probe_mode) {
> > +            /* Use these accelerators in probe mode, tcg should be=
 last */
> > +            p =3D probe_mode_accels;
> > +        } else {
> > +            /* Use the default "accelerator", tcg */
> > +            p =3D "tcg";
> > +        }
> >      } =20
>=20
> Can't we instead use an explicit ,accel=3Dprobe or ,accel=3Dauto?
> That would then obsolete the next patch.

How would you express the following with the accel=3D<pseudo-accel> app=
roach?

-probe -machine s390-ccw,accel=3Dkvm=20

Using machine "none" as default with tcg as last accelerator initialize=
d should not break
anything.

-M none

The return code of configure_accelerator() is ignored anyway.

Thanks,
Michael
