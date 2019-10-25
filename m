Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21232 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436984AbfJYJE6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Oct 2019 05:04:58 -0400
Subject: Re: [RFC 05/37] s390: KVM: Export PV handle to gmap
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-6-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ff7418ed-ce4b-2343-8f08-01eeac6f816e@redhat.com>
Date: Fri, 25 Oct 2019 11:04:49 +0200
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-6-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24.10.19 13:40, Janosch Frank wrote:
> We need it in the next patch, when doing memory management for the
> guest in the kernel's fault handler, where otherwise we wouldn't have
> access to the handle.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   arch/s390/include/asm/gmap.h | 1 +
>   arch/s390/kvm/pv.c           | 1 +
>   2 files changed, 2 insertions(+)
>=20
> diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
> index 37f96b6f0e61..6efc0b501227 100644
> --- a/arch/s390/include/asm/gmap.h
> +++ b/arch/s390/include/asm/gmap.h
> @@ -61,6 +61,7 @@ struct gmap {
>   =09spinlock_t shadow_lock;
>   =09struct gmap *parent;
>   =09unsigned long orig_asce;
> +=09unsigned long se_handle;
>   =09int edat_level;
>   =09bool removed;
>   =09bool initialized;
> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> index 94cf16f40f25..80aecd5bea9e 100644
> --- a/arch/s390/kvm/pv.c
> +++ b/arch/s390/kvm/pv.c
> @@ -169,6 +169,7 @@ int kvm_s390_pv_create_vm(struct kvm *kvm)
>   =09=09kvm_s390_pv_dealloc_vm(kvm);
>   =09=09return -EINVAL;
>   =09}
> +=09kvm->arch.gmap->se_handle =3D uvcb.guest_handle;
>   =09return rc;
>   }
>  =20
>=20

I'd suggest squashing that into the patch that needs it.

--=20

Thanks,

David / dhildenb
