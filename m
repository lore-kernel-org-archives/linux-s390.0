Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40502 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726365AbfKOI1k (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 15 Nov 2019 03:27:40 -0500
Subject: Re: [RFC 25/37] KVM: s390: protvirt: STSI handling
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-26-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4891580a-422a-3d85-f20e-c4c194487d34@redhat.com>
Date: Fri, 15 Nov 2019 09:27:28 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-26-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24/10/2019 13.40, Janosch Frank wrote:
> Save response to sidad and disable address checking for protected
> guests.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kvm/priv.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index ed52ffa8d5d4..06c7e7a10825 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -872,7 +872,7 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
> =20
>  =09operand2 =3D kvm_s390_get_base_disp_s(vcpu, &ar);
> =20
> -=09if (operand2 & 0xfff)
> +=09if (!kvm_s390_pv_is_protected(vcpu->kvm) && (operand2 & 0xfff))
>  =09=09return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);

I'd prefer if you could put the calculation of operand2 also under the
!pv if-statement:

=09if (!kvm_s390_pv_is_protected(vcpu->kvm)) {
=09=09operand2 =3D kvm_s390_get_base_disp_s(vcpu, &ar);
=09=09if (operand2 & 0xfff)
=09=09=09return kvm_s390_inject_program_int(vcpu,
=09=09=09=09=09=09    PGM_SPECIFICATION);
=09}

... that makes it more obvious that operand2 is only valid in the !pv
case and you should get automatic compiler warnings if you use it otherwise=
.

>  =09switch (fc) {
> @@ -893,8 +893,13 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>  =09=09handle_stsi_3_2_2(vcpu, (void *) mem);
>  =09=09break;
>  =09}
> +=09if (kvm_s390_pv_is_protected(vcpu->kvm)) {
> +=09=09memcpy((void *)vcpu->arch.sie_block->sidad, (void *)mem,
> +=09=09       PAGE_SIZE);
> +=09=09rc =3D 0;
> +=09} else
> +=09=09rc =3D write_guest(vcpu, operand2, ar, (void *)mem, PAGE_SIZE);

Please also use braces for the else-branch (according to
Documentation/process/coding-style.rst).

 Thomas
