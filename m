Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34438 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726410AbfKMOTc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 13 Nov 2019 09:19:32 -0500
Subject: Re: [PATCH] Fix unpack
References: <07705597-8e8f-28d4-f9a1-d3d5dc9a4555@redhat.com>
 <20191113140306.2952-1-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <02bf4a93-5635-bf90-0a5d-05dc575413d4@redhat.com>
Date: Wed, 13 Nov 2019 15:19:23 +0100
MIME-Version: 1.0
In-Reply-To: <20191113140306.2952-1-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 13/11/2019 15.03, Janosch Frank wrote:
> That should be easier to read :)
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kvm/pv.c | 60 +++++++++++++++++++++++++++-------------------
>  1 file changed, 35 insertions(+), 25 deletions(-)
>=20
> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> index 94cf16f40f25..fd73afb33b20 100644
> --- a/arch/s390/kvm/pv.c
> +++ b/arch/s390/kvm/pv.c
> @@ -195,43 +195,53 @@ int kvm_s390_pv_set_sec_parms(struct kvm *kvm,
>  =09return 0;
>  }
> =20
> -int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned lon=
g size,
> -=09=09       unsigned long tweak)
> +static int unpack_one(struct kvm *kvm, unsigned long addr, u64 tweak[2])
>  {
> -=09int i, rc =3D 0;
> +=09int rc;
>  =09struct uv_cb_unp uvcb =3D {
>  =09=09.header.cmd =3D UVC_CMD_UNPACK_IMG,
>  =09=09.header.len =3D sizeof(uvcb),
>  =09=09.guest_handle =3D kvm_s390_pv_handle(kvm),
> -=09=09.tweak[0] =3D tweak
> +=09=09.gaddr =3D addr,
> +=09=09.tweak[0] =3D tweak[0],
> +=09=09.tweak[1] =3D tweak[1],
>  =09};
> =20
> -=09if (addr & ~PAGE_MASK || size & ~PAGE_MASK)
> -=09=09return -EINVAL;
> +=09rc =3D uv_call(0, (u64)&uvcb);
> +=09if (!rc)
> +=09=09return rc;
> +=09if (uvcb.header.rc =3D=3D 0x10a) {
> +=09=09/* If not yet mapped fault and retry */
> +=09=09rc =3D gmap_fault(kvm->arch.gmap, uvcb.gaddr,
> +=09=09=09=09FAULT_FLAG_WRITE);
> +=09=09if (!rc)
> +=09=09=09return -EAGAIN;
> +=09}
> +=09VM_EVENT(kvm, 3, "PROTVIRT VM UNPACK: failed addr %llx rc %x rrc %x",
> +=09=09 uvcb.gaddr, uvcb.header.rc, uvcb.header.rrc);
> +=09return rc;
> +}
> =20
> +int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned lon=
g size,
> +=09=09       unsigned long tweak)
> +{
> +=09int rc =3D 0;
> +=09u64 tw[2] =3D {tweak, 0};
> +
> +=09if (addr & ~PAGE_MASK || !size || size & ~PAGE_MASK)
> +=09=09return -EINVAL;
> =20
>  =09VM_EVENT(kvm, 3, "PROTVIRT VM UNPACK: start addr %lx size %lx",
>  =09=09 addr, size);
> -=09for (i =3D 0; i < size / PAGE_SIZE; i++) {
> -=09=09uvcb.gaddr =3D addr + i * PAGE_SIZE;
> -=09=09uvcb.tweak[1] =3D i * PAGE_SIZE;
> -retry:
> -=09=09rc =3D uv_call(0, (u64)&uvcb);
> -=09=09if (!rc)
> +=09while (tw[1] < size) {
> +=09=09rc =3D unpack_one(kvm, addr, tw);
> +=09=09if (rc =3D=3D -EAGAIN)
>  =09=09=09continue;
> -=09=09/* If not yet mapped fault and retry */
> -=09=09if (uvcb.header.rc =3D=3D 0x10a) {
> -=09=09=09rc =3D gmap_fault(kvm->arch.gmap, uvcb.gaddr,
> -=09=09=09=09=09FAULT_FLAG_WRITE);
> -=09=09=09if (rc)
> -=09=09=09=09return rc;
> -=09=09=09goto retry;
> -=09=09}
> -=09=09VM_EVENT(kvm, 3, "PROTVIRT VM UNPACK: failed addr %llx rc %x rrc %=
x",
> -=09=09=09 uvcb.gaddr, uvcb.header.rc, uvcb.header.rrc);
> -=09=09break;
> +=09=09if (rc)
> +=09=09=09break;
> +=09=09addr +=3D PAGE_SIZE;
> +=09=09tw[1] +=3D PAGE_SIZE;
>  =09}
> -=09VM_EVENT(kvm, 3, "PROTVIRT VM UNPACK: finished with rc %x rrc %x",
> -=09=09 uvcb.header.rc, uvcb.header.rrc);
> +=09VM_EVENT(kvm, 3, "PROTVIRT VM UNPACK: finished rc %x", rc);
>  =09return rc;
>  }
>=20

Yes, I think that will be better, thanks!

 Thomas
