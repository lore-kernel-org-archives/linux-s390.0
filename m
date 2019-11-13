Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41297 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726491AbfKMK2t (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Nov 2019 05:28:49 -0500
Subject: Re: [RFC 04/37] KVM: s390: protvirt: Add initial lifecycle handling
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-5-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <07705597-8e8f-28d4-f9a1-d3d5dc9a4555@redhat.com>
Date: Wed, 13 Nov 2019 11:28:34 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-5-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24/10/2019 13.40, Janosch Frank wrote:
> Let's add a KVM interface to create and destroy protected VMs.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
[...]
> +int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned lon=
g size,
> +=09=09       unsigned long tweak)
> +{
> +=09int i, rc =3D 0;
> +=09struct uv_cb_unp uvcb =3D {
> +=09=09.header.cmd =3D UVC_CMD_UNPACK_IMG,
> +=09=09.header.len =3D sizeof(uvcb),
> +=09=09.guest_handle =3D kvm_s390_pv_handle(kvm),
> +=09=09.tweak[0] =3D tweak
> +=09};
> +
> +=09if (addr & ~PAGE_MASK || size & ~PAGE_MASK)
> +=09=09return -EINVAL;

Also check for size =3D=3D 0 ?

> +
> +

Remove one of the two empty lines, please.

> +=09VM_EVENT(kvm, 3, "PROTVIRT VM UNPACK: start addr %lx size %lx",
> +=09=09 addr, size);
> +=09for (i =3D 0; i < size / PAGE_SIZE; i++) {
> +=09=09uvcb.gaddr =3D addr + i * PAGE_SIZE;
> +=09=09uvcb.tweak[1] =3D i * PAGE_SIZE;
> +retry:
> +=09=09rc =3D uv_call(0, (u64)&uvcb);
> +=09=09if (!rc)
> +=09=09=09continue;
> +=09=09/* If not yet mapped fault and retry */
> +=09=09if (uvcb.header.rc =3D=3D 0x10a) {
> +=09=09=09rc =3D gmap_fault(kvm->arch.gmap, uvcb.gaddr,
> +=09=09=09=09=09FAULT_FLAG_WRITE);
> +=09=09=09if (rc)
> +=09=09=09=09return rc;
> +=09=09=09goto retry;
> +=09=09}
> +=09=09VM_EVENT(kvm, 3, "PROTVIRT VM UNPACK: failed addr %llx rc %x rrc %=
x",
> +=09=09=09 uvcb.gaddr, uvcb.header.rc, uvcb.header.rrc);
> +=09=09break;

A break at the end of the for-loop ... that's really not what I'd expect.

Could you please invert the logic here, i.e.:

    if (uvcb.header.rc !=3D 0x10a) {
        VM_EVENT(...)
        break;
    }
    rc =3D gmap_fault(...)
    ...

I think you might even get rid of that ugly "goto", too, that way?

> +=09}
> +=09VM_EVENT(kvm, 3, "PROTVIRT VM UNPACK: finished with rc %x rrc %x",
> +=09=09 uvcb.header.rc, uvcb.header.rrc);
> +=09return rc;
> +}

 Thomas
