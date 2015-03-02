From: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v3 01/16] Introduce probe mode for machine type none
Date: Mon, 02 Mar 2015 14:57:21 +0100
Message-ID: <54F46C41.3000201@suse.de>
References: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com> <1425300248-40277-2-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425300248-40277-2-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>
Cc: Michael Mueller <mimu@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>
List-ID: <linux-s390.vger.kernel.org>

Am 02.03.2015 um 13:43 schrieb Michael Mueller:
> QEMU now switches into "probe mode" when the selected machine is "non=
e" and no
> specific accelerator(s) has been requested (i.e.: "-machine none").
>=20
> In probe mode a by "<ARCH>_CONFIG" defines predefined list of acceler=
ators run
> their init() methods.
>=20
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> ---
>  accel.c              | 31 +++++++++++++++++++++++++------
>  include/hw/boards.h  |  1 +
>  include/sysemu/kvm.h | 10 ++++++++++
>  kvm-all.c            |  3 +++
>  4 files changed, 39 insertions(+), 6 deletions(-)

Edgar/Peter, isn't Xilinx using -machine none in TCG mode?

> @@ -78,20 +83,30 @@ static int accel_init_machine(AccelClass *acc, Ma=
chineState *ms)
> =20
>  int configure_accelerator(MachineState *ms)
>  {
> -    const char *p;
> +    const char *p, *name;
>      char buf[10];
>      int ret;
>      bool accel_initialised =3D false;
>      bool init_failed =3D false;
>      AccelClass *acc =3D NULL;
> +    ObjectClass *oc;
> +    bool probe_mode =3D false;
> =20
>      p =3D qemu_opt_get(qemu_get_machine_opts(), "accel");
>      if (p =3D=3D NULL) {
> -        /* Use the default "accelerator", tcg */
> -        p =3D "tcg";
> +        oc =3D (ObjectClass *) MACHINE_GET_CLASS(current_machine);
> +        name =3D object_class_get_name(oc);
> +        probe_mode =3D !strcmp(name, "none" TYPE_MACHINE_SUFFIX);
> +        if (probe_mode) {
> +            /* Use these accelerators in probe mode, tcg should be l=
ast */
> +            p =3D probe_mode_accels;
> +        } else {
> +            /* Use the default "accelerator", tcg */
> +            p =3D "tcg";
> +        }
>      }

Can't we instead use an explicit ,accel=3Dprobe or ,accel=3Dauto?
That would then obsolete the next patch.

Regards,
Andreas

> =20
> -    while (!accel_initialised && *p !=3D '\0') {
> +    while ((probe_mode || !accel_initialised) && *p !=3D '\0') {
>          if (*p =3D=3D ':') {
>              p++;
>          }

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Felix Imend=F6rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N=FCrnberg)
