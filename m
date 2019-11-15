Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37335 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727135AbfKOLXQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 15 Nov 2019 06:23:16 -0500
Subject: Re: [RFC 35/37] KVM: s390: Fix cpu reset local IRQ clearing
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-36-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6128cef9-5780-a5dd-68a1-62d7cfeaf05a@redhat.com>
Date: Fri, 15 Nov 2019 12:23:03 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-36-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24/10/2019 13.40, Janosch Frank wrote:
> The architecture states that we need to reset local IRQs for all CPU
> resets. Because the old reset interface did not support the normal CPU
> reset we never did that.
>=20
> Now that we have a new interface, let's properly clear out local IRQs
> and let this commit be a reminder.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index ba6144fdb5d1..cc5feb67f145 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3485,6 +3485,8 @@ static int kvm_arch_vcpu_ioctl_reset(struct kvm_vcp=
u *vcpu,
>  =09=09 * non-protected case.
>  =09=09 */
>  =09=09rc =3D 0;
> +=09=09kvm_clear_async_pf_completion_queue(vcpu);
> +=09=09kvm_s390_clear_local_irqs(vcpu);
>  =09=09if (kvm_s390_pv_handle_cpu(vcpu)) {
>  =09=09=09rc =3D uv_cmd_nodata(kvm_s390_pv_handle_cpu(vcpu),
>  =09=09=09=09=09   UVC_CMD_CPU_RESET, &ret);
>=20

I think you could squash this into patch 33/37 where you've introduced
the RESET_NORMAL (and adjust the patch description there).

 Thomas
