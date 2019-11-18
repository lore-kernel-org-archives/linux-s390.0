Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43847 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726314AbfKRQjz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Nov 2019 11:39:55 -0500
Date: Mon, 18 Nov 2019 17:39:42 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 23/37] KVM: s390: protvirt: Make sure prefix is always
 protected
Message-ID: <20191118173942.0252b731.cohuck@redhat.com>
In-Reply-To: <20191024114059.102802-24-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
        <20191024114059.102802-24-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

On Thu, 24 Oct 2019 07:40:45 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

Add at least a short sentence here?

> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index eddc9508c1b1..17a78774c617 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3646,6 +3646,15 @@ static int kvm_s390_handle_requests(struct kvm_vcp=
u *vcpu)
>  =09=09rc =3D gmap_mprotect_notify(vcpu->arch.gmap,
>  =09=09=09=09=09  kvm_s390_get_prefix(vcpu),
>  =09=09=09=09=09  PAGE_SIZE * 2, PROT_WRITE);
> +=09=09if (!rc && kvm_s390_pv_is_protected(vcpu->kvm)) {
> +=09=09=09rc =3D uv_convert_to_secure(vcpu->arch.gmap,
> +=09=09=09=09=09=09  kvm_s390_get_prefix(vcpu));
> +=09=09=09WARN_ON_ONCE(rc && rc !=3D -EEXIST);
> +=09=09=09rc =3D uv_convert_to_secure(vcpu->arch.gmap,
> +=09=09=09=09=09=09  kvm_s390_get_prefix(vcpu) + PAGE_SIZE);
> +=09=09=09WARN_ON_ONCE(rc && rc !=3D -EEXIST);
> +=09=09=09rc =3D 0;

So, what happens if we have an error other than -EEXIST (which
presumably means that we already protected it) here? The page is not
protected, and further accesses will get an error? (Another question:
what can actually go wrong here?)

> +=09=09}
>  =09=09if (rc) {
>  =09=09=09kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
>  =09=09=09return rc;
