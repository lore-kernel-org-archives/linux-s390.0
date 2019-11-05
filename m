Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23101 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729996AbfKEJ1N (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Nov 2019 04:27:13 -0500
Date: Tue, 5 Nov 2019 10:26:54 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 02/37] s390/protvirt: introduce host side setup
Message-ID: <20191105102654.223e7b42.cohuck@redhat.com>
In-Reply-To: <5a34febd-8abc-84f5-195e-43decbb366a5@de.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
        <20191024114059.102802-3-frankja@linux.ibm.com>
        <20191104165427.0e5e6da4.cohuck@redhat.com>
        <5a34febd-8abc-84f5-195e-43decbb366a5@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

On Mon, 4 Nov 2019 18:50:12 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 04.11.19 16:54, Cornelia Huck wrote:
> > On Thu, 24 Oct 2019 07:40:24 -0400
> > Janosch Frank <frankja@linux.ibm.com> wrote:

> >> diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
> >> index ed007f4a6444..88cf8825d169 100644
> >> --- a/arch/s390/boot/uv.c
> >> +++ b/arch/s390/boot/uv.c
> >> @@ -3,7 +3,12 @@
> >>  #include <asm/facility.h>
> >>  #include <asm/sections.h>
> >> =20
> >> +#ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
> >>  int __bootdata_preserved(prot_virt_guest);
> >> +#endif
> >> +#ifdef CONFIG_KVM_S390_PROTECTED_VIRTUALIZATION_HOST
> >> +struct uv_info __bootdata_preserved(uv_info);
> >> +#endif =20
> >=20
> > Two functions with the same name, but different signatures look really
> > ugly.
> >=20
> > Also, what happens if I want to build just a single kernel image for
> > both guest and host? =20
>=20
> This is not two functions with the same name. It is 2 variable declaratio=
ns with
> the __bootdata_preserved helper. We expect to have all distro kernels to =
enable
> both.=20

Ah ok, I misread that. (I'm blaming lack of sleep :/)

>=20
> >  =20
> >> =20
> >>  void uv_query_info(void)
> >>  {
> >> @@ -18,7 +23,20 @@ void uv_query_info(void)
> >>  =09if (uv_call(0, (uint64_t)&uvcb))
> >>  =09=09return;
> >> =20
> >> -=09if (test_bit_inv(BIT_UVC_CMD_SET_SHARED_ACCESS, (unsigned long *)u=
vcb.inst_calls_list) &&
> >> +=09if (IS_ENABLED(CONFIG_KVM_S390_PROTECTED_VIRTUALIZATION_HOST)) { =
=20
> >=20
> > Do we always have everything needed for a host if uv_call() is
> > successful? =20
>=20
> The uv_call is the query call. It will provide the list of features. We c=
heck that
> later on.

Hm yes. I'm just seeing the guest side check for features, while the
host code just seems to go ahead and copies things. (later on =3D=3D later
patches?)

>=20
> >  =20
> >> +=09=09memcpy(uv_info.inst_calls_list, uvcb.inst_calls_list, sizeof(uv=
_info.inst_calls_list));
> >> +=09=09uv_info.uv_base_stor_len =3D uvcb.uv_base_stor_len;
> >> +=09=09uv_info.guest_base_stor_len =3D uvcb.conf_base_phys_stor_len;
> >> +=09=09uv_info.guest_virt_base_stor_len =3D uvcb.conf_base_virt_stor_l=
en;
> >> +=09=09uv_info.guest_virt_var_stor_len =3D uvcb.conf_virt_var_stor_len=
;
> >> +=09=09uv_info.guest_cpu_stor_len =3D uvcb.cpu_stor_len;
> >> +=09=09uv_info.max_sec_stor_addr =3D ALIGN(uvcb.max_guest_stor_addr, P=
AGE_SIZE);
> >> +=09=09uv_info.max_num_sec_conf =3D uvcb.max_num_sec_conf;
> >> +=09=09uv_info.max_guest_cpus =3D uvcb.max_guest_cpus;
> >> +=09}
> >> +
> >> +=09if (IS_ENABLED(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) &&
> >> +=09    test_bit_inv(BIT_UVC_CMD_SET_SHARED_ACCESS, (unsigned long *)u=
vcb.inst_calls_list) &&
> >>  =09    test_bit_inv(BIT_UVC_CMD_REMOVE_SHARED_ACCESS, (unsigned long =
*)uvcb.inst_calls_list)) =20
> >=20
> > Especially as it looks like we need to test for those two commands to
> > determine whether we have support for a guest.
> >  =20
> >>  =09=09prot_virt_guest =3D 1;
> >>  }
> >> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> >> index ef3c00b049ab..6db1bc495e67 100644
> >> --- a/arch/s390/include/asm/uv.h
> >> +++ b/arch/s390/include/asm/uv.h
> >> @@ -44,7 +44,19 @@ struct uv_cb_qui {
> >>  =09struct uv_cb_header header;
> >>  =09u64 reserved08;
> >>  =09u64 inst_calls_list[4];
> >> -=09u64 reserved30[15];
> >> +=09u64 reserved30[2];
> >> +=09u64 uv_base_stor_len;
> >> +=09u64 reserved48;
> >> +=09u64 conf_base_phys_stor_len;
> >> +=09u64 conf_base_virt_stor_len;
> >> +=09u64 conf_virt_var_stor_len;
> >> +=09u64 cpu_stor_len;
> >> +=09u32 reserved68[3];
> >> +=09u32 max_num_sec_conf;
> >> +=09u64 max_guest_stor_addr;
> >> +=09u8  reserved80[150-128];
> >> +=09u16 max_guest_cpus;
> >> +=09u64 reserved98;
> >>  } __packed __aligned(8);
> >> =20
> >>  struct uv_cb_share {
> >> @@ -69,9 +81,21 @@ static inline int uv_call(unsigned long r1, unsigne=
d long r2)
> >>  =09return cc;
> >>  }
> >> =20
> >> -#ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
> >> +struct uv_info {
> >> +=09unsigned long inst_calls_list[4];
> >> +=09unsigned long uv_base_stor_len;
> >> +=09unsigned long guest_base_stor_len;
> >> +=09unsigned long guest_virt_base_stor_len;
> >> +=09unsigned long guest_virt_var_stor_len;
> >> +=09unsigned long guest_cpu_stor_len;
> >> +=09unsigned long max_sec_stor_addr;
> >> +=09unsigned int max_num_sec_conf;
> >> +=09unsigned short max_guest_cpus;
> >> +}; =20
> >=20
> > What is the main difference between uv_info and uv_cb_qui? The
> > alignment of max_sec_stor_addr? =20
>=20
> One is the hardware data structure for query, the other one is the Linux
> internal state.

That's clear; I'm mainly wondering about what is simply copied vs. what
needs to be calculated.
