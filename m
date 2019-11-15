Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24600 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726521AbfKOLZ0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 06:25:26 -0500
Subject: Re: [RFC 36/37] KVM: s390: protvirt: Support cmd 5 operation state
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-37-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b7880d6a-0d94-800a-654c-7d44c21b7154@redhat.com>
Date: Fri, 15 Nov 2019 12:25:14 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-37-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24/10/2019 13.40, Janosch Frank wrote:
> Code 5 for the set cpu state UV call tells the UV to load a PSW from
> the SE header (first IPL) or from guest location 0x0 (diag 308 subcode
> 0/1). Also it sets the cpu into operating state afterwards, so we can
> start it.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/include/asm/uv.h | 1 +
>  arch/s390/kvm/kvm-s390.c   | 4 ++++
>  include/uapi/linux/kvm.h   | 1 +
>  3 files changed, 6 insertions(+)
>=20
> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> index 33b52ba306af..8d10ae731458 100644
> --- a/arch/s390/include/asm/uv.h
> +++ b/arch/s390/include/asm/uv.h
> @@ -163,6 +163,7 @@ struct uv_cb_unp {
>  #define PV_CPU_STATE_OPR=091
>  #define PV_CPU_STATE_STP=092
>  #define PV_CPU_STATE_CHKSTP=093
> +#define PV_CPU_STATE_OPR_LOAD=095
> =20
>  struct uv_cb_cpu_set_state {
>  =09struct uv_cb_header header;
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index cc5feb67f145..5cc9108c94e4 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4652,6 +4652,10 @@ static int kvm_s390_handle_pv_vcpu(struct kvm_vcpu=
 *vcpu,
>  =09=09r =3D kvm_s390_pv_destroy_cpu(vcpu);
>  =09=09break;
>  =09}
> +=09case KVM_PV_VCPU_SET_IPL_PSW: {
> +=09=09r =3D kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR_LOAD);
> +=09=09break;
> +=09}

Nit: No need for the curly braces here.

 Thomas
