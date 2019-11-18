Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50872 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726322AbfKRRiz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Nov 2019 12:38:55 -0500
Date: Mon, 18 Nov 2019 18:38:42 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 36/37] KVM: s390: protvirt: Support cmd 5 operation state
Message-ID: <20191118183842.36688a81.cohuck@redhat.com>
In-Reply-To: <20191024114059.102802-37-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
        <20191024114059.102802-37-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

On Thu, 24 Oct 2019 07:40:58 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Code 5 for the set cpu state UV call tells the UV to load a PSW from
> the SE header (first IPL) or from guest location 0x0 (diag 308 subcode
> 0/1). Also it sets the cpu into operating state afterwards, so we can
> start it.

I'm a bit confused by the patch description: Does this mean that the UV
does the transition to operating state? Does the hypervisor get a
notification for that?

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
>  =09default:
>  =09=09r =3D -ENOTTY;
>  =09}
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 2846ed5e5dd9..973007d27d55 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1483,6 +1483,7 @@ enum pv_cmd_id {
>  =09KVM_PV_VM_UNSHARE,
>  =09KVM_PV_VCPU_CREATE,
>  =09KVM_PV_VCPU_DESTROY,
> +=09KVM_PV_VCPU_SET_IPL_PSW,
>  };
> =20
>  struct kvm_pv_cmd {
