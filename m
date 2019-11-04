Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30419 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727838AbfKDORZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 09:17:25 -0500
Subject: Re: [RFC 09/37] KVM: s390: protvirt: Implement on-demand pinning
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-10-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <09115b82-40a7-2f06-c629-94cce65fd567@redhat.com>
Date: Mon, 4 Nov 2019 15:17:16 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-10-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24.10.19 13:40, Janosch Frank wrote:
> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
>=20
> Pin the guest pages when they are first accessed, instead of all at
> the same time when starting the guest.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>   arch/s390/include/asm/gmap.h |  1 +
>   arch/s390/include/asm/uv.h   |  6 +++++
>   arch/s390/kernel/uv.c        | 20 ++++++++++++++
>   arch/s390/kvm/kvm-s390.c     |  2 ++
>   arch/s390/kvm/pv.c           | 51 ++++++++++++++++++++++++++++++------
>   5 files changed, 72 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
> index 99b3eedda26e..483f64427c0e 100644
> --- a/arch/s390/include/asm/gmap.h
> +++ b/arch/s390/include/asm/gmap.h
> @@ -63,6 +63,7 @@ struct gmap {
>   =09struct gmap *parent;
>   =09unsigned long orig_asce;
>   =09unsigned long se_handle;
> +=09struct page **pinned_pages;
>   =09int edat_level;
>   =09bool removed;
>   =09bool initialized;
> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> index 99cdd2034503..9ce9363aee1c 100644
> --- a/arch/s390/include/asm/uv.h
> +++ b/arch/s390/include/asm/uv.h
> @@ -298,6 +298,7 @@ static inline int uv_convert_from_secure(unsigned lon=
g paddr)
>   =09return -EINVAL;
>   }
>  =20
> +int kvm_s390_pv_pin_page(struct gmap *gmap, unsigned long gpa);
>   /*
>    * Requests the Ultravisor to make a page accessible to a guest
>    * (import). If it's brought in the first time, it will be cleared. If
> @@ -317,6 +318,11 @@ static inline int uv_convert_to_secure(struct gmap *=
gmap, unsigned long gaddr)
>   =09=09.gaddr =3D gaddr
>   =09};
>  =20
> +=09down_read(&gmap->mm->mmap_sem);
> +=09cc =3D kvm_s390_pv_pin_page(gmap, gaddr);
> +=09up_read(&gmap->mm->mmap_sem);
> +=09if (cc)
> +=09=09return cc;
>   =09cc =3D uv_call(0, (u64)&uvcb);

So, a theoretical question: Is any in-flight I/O from paging stopped=20
when we try to pin the pages? I am no export on paging, but the comment=20
from Christian ("you can actually fault in a page that is currently=20
under paging I/O.") made me wonder.

Let's assume you could have parallel I/O on that page. You would do a=20
uv_call() and convert the page to secure/unencrypted. The I/O can easily=20
stumble over that (now inaccessible) page and report an error.

Or is any such race not possible because we are using=20
get_user_pages_fast() vs. get_user_pages()? (then, I'd love to see a=20
comment regarding that in the patch description)

--=20

Thanks,

David / dhildenb
