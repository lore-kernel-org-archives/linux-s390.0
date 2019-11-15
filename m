Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33135 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727132AbfKOKEf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 05:04:35 -0500
Subject: Re: [RFC 31/37] KVM: s390: protvirt: Add diag 308 subcode 8 - 10
 handling
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-32-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a1c263ff-954e-a7c3-28b4-e9bd866eb35f@redhat.com>
Date: Fri, 15 Nov 2019 11:04:23 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-32-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24/10/2019 13.40, Janosch Frank wrote:
> If the host initialized the Ultravisor, we can set stfle bit 161
> (protected virtual IPL enhancements facility), which indicates, that
> the IPL subcodes 8, 9 and are valid. These subcodes are used by a
> normal guest to set/retrieve a IPIB of type 5 and transition into
> protected mode.
>=20
> Once in protected mode, the VM will loose the facility bit, as each

So should the bit be cleared in the host code again? ... I don't see
this happening in this patch?

 Thomas


> boot into protected mode has to go through non-protected. There is no
> secure re-ipl with subcode 10 without a previous subcode 3.
>=20
> In protected mode, there is no subcode 4 available, as the VM has no
> more access to its memory from non-protected mode. I.e. each IPL
> clears.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kvm/diag.c     | 6 ++++++
>  arch/s390/kvm/kvm-s390.c | 5 +++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
> index 3fb54ec2cf3e..b951dbdcb6a0 100644
> --- a/arch/s390/kvm/diag.c
> +++ b/arch/s390/kvm/diag.c
> @@ -197,6 +197,12 @@ static int __diag_ipl_functions(struct kvm_vcpu *vcp=
u)
>  =09case 4:
>  =09=09vcpu->run->s390_reset_flags =3D 0;
>  =09=09break;
> +=09case 8:
> +=09case 9:
> +=09case 10:
> +=09=09if (!test_kvm_facility(vcpu->kvm, 161))
> +=09=09=09return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +=09=09/* fall through */
>  =09default:
>  =09=09return -EOPNOTSUPP;
>  =09}
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 500972a1f742..8947f1812b12 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2590,6 +2590,11 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned lon=
g type)
>  =09if (css_general_characteristics.aiv && test_facility(65))
>  =09=09set_kvm_facility(kvm->arch.model.fac_mask, 65);
> =20
> +=09if (is_prot_virt_host()) {
> +=09=09set_kvm_facility(kvm->arch.model.fac_mask, 161);
> +=09=09set_kvm_facility(kvm->arch.model.fac_list, 161);
> +=09}
> +
>  =09kvm->arch.model.cpuid =3D kvm_s390_get_initial_cpuid();
>  =09kvm->arch.model.ibc =3D sclp.ibc & 0x0fff;
> =20
>=20
