Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39864 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726339AbfKNPhF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Nov 2019 10:37:05 -0500
Subject: Re: [RFC 20/37] KVM: S390: protvirt: Introduce instruction data area
 bounce buffer
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-21-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ad0f9b90-3ce4-c2d2-b661-635fe439f7e2@redhat.com>
Date: Thu, 14 Nov 2019 16:36:51 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-21-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24/10/2019 13.40, Janosch Frank wrote:
> Now that we can't access guest memory anymore, we have a dedicated
> sattelite block that's a bounce buffer for instruction data.

"satellite block that is ..."

> We re-use the memop interface to copy the instruction data to / from
> userspace. This lets us re-use a lot of QEMU code which used that
> interface to make logical guest memory accesses which are not possible
> anymore in protected mode anyway.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  5 ++++-
>  arch/s390/kvm/kvm-s390.c         | 31 +++++++++++++++++++++++++++++++
>  arch/s390/kvm/pv.c               |  9 +++++++++
>  3 files changed, 44 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm=
_host.h
> index 5deabf9734d9..2a8a1e21e1c3 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -308,7 +308,10 @@ struct kvm_s390_sie_block {
>  #define CRYCB_FORMAT2 0x00000003
>  =09__u32=09crycbd;=09=09=09/* 0x00fc */
>  =09__u64=09gcr[16];=09=09/* 0x0100 */
> -=09__u64=09gbea;=09=09=09/* 0x0180 */
> +=09union {
> +=09=09__u64=09gbea;=09=09=09/* 0x0180 */
> +=09=09__u64=09sidad;
> +=09};
>  =09__u8    reserved188[8];=09=09/* 0x0188 */
>  =09__u64   sdnxo;=09=09=09/* 0x0190 */
>  =09__u8    reserved198[8];=09=09/* 0x0198 */
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 97d3a81e5074..6747cb6cf062 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4416,6 +4416,13 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu =
*vcpu,
>  =09if (mop->size > MEM_OP_MAX_SIZE)
>  =09=09return -E2BIG;
> =20
> +=09/* Protected guests move instruction data over the satellite
> +=09 * block which has its own size limit
> +=09 */
> +=09if (kvm_s390_pv_is_protected(vcpu->kvm) &&
> +=09    mop->size > ((vcpu->arch.sie_block->sidad & 0x0f) + 1) * PAGE_SIZ=
E)
> +=09=09return -E2BIG;
> +
>  =09if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
>  =09=09tmpbuf =3D vmalloc(mop->size);
>  =09=09if (!tmpbuf)
> @@ -4427,10 +4434,22 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu=
 *vcpu,
>  =09switch (mop->op) {
>  =09case KVM_S390_MEMOP_LOGICAL_READ:
>  =09=09if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
> +=09=09=09if (kvm_s390_pv_is_protected(vcpu->kvm)) {
> +=09=09=09=09r =3D 0;
> +=09=09=09=09break;

Please add a short comment to the code why this is required / ok.

> +=09=09=09}
>  =09=09=09r =3D check_gva_range(vcpu, mop->gaddr, mop->ar,
>  =09=09=09=09=09    mop->size, GACC_FETCH);
>  =09=09=09break;
>  =09=09}
> +=09=09if (kvm_s390_pv_is_protected(vcpu->kvm)) {
> +=09=09=09r =3D 0;
> +=09=09=09if (copy_to_user(uaddr, (void *)vcpu->arch.sie_block->sidad +
> +=09=09=09=09=09 (mop->gaddr & ~PAGE_MASK),

That looks bogus. Couldn't userspace use mop->gaddr =3D 4095 and mop->size
=3D 4095 to read most of the page beyond the sidad page (assuming that it
is mapped, too)?
I think you have to take mop->gaddr into account in your new check at
the beginning of the function, too.

Or should the ioctl maybe even be restricted to mop->gaddr =3D=3D 0 now? Is
there maybe also a way to validate that gaddr & PAGE_MASK really matches
the page that we have in sidad?

> +=09=09=09=09=09 mop->size))
> +=09=09=09=09r =3D -EFAULT;
> +=09=09=09break;
> +=09=09}
>  =09=09r =3D read_guest(vcpu, mop->gaddr, mop->ar, tmpbuf, mop->size);
>  =09=09if (r =3D=3D 0) {
>  =09=09=09if (copy_to_user(uaddr, tmpbuf, mop->size))
> @@ -4439,10 +4458,22 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu=
 *vcpu,
>  =09=09break;
>  =09case KVM_S390_MEMOP_LOGICAL_WRITE:
>  =09=09if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
> +=09=09=09if (kvm_s390_pv_is_protected(vcpu->kvm)) {
> +=09=09=09=09r =3D 0;
> +=09=09=09=09break;
> +=09=09=09}
>  =09=09=09r =3D check_gva_range(vcpu, mop->gaddr, mop->ar,
>  =09=09=09=09=09    mop->size, GACC_STORE);
>  =09=09=09break;
>  =09=09}
> +=09=09if (kvm_s390_pv_is_protected(vcpu->kvm)) {
> +=09=09=09r =3D 0;
> +=09=09=09if (copy_from_user((void *)vcpu->arch.sie_block->sidad +
> +=09=09=09=09=09   (mop->gaddr & ~PAGE_MASK), uaddr,
> +=09=09=09=09=09   mop->size))

dito, of course.

> +=09=09=09=09r =3D -EFAULT;
> +=09=09=09break;
> +=09=09}
>  =09=09if (copy_from_user(tmpbuf, uaddr, mop->size)) {
>  =09=09=09r =3D -EFAULT;
>  =09=09=09break;

 Thomas
