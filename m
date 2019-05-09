Return-Path: <SRS0=ZS0J=TJ=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: jjherne@linux.ibm.com
Subject: Re: [PATCH 04/10] s390/mm: force swiotlb for protected virtualization
References: <20190426183245.37939-5-pasic@linux.ibm.com>
 <ad23f5e7-dc78-04af-c892-47bbc65134c6@linux.ibm.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu, 9 May 2019 14:05:20 -0400
MIME-Version: 1.0
In-Reply-To: <ad23f5e7-dc78-04af-c892-47bbc65134c6@linux.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Message-Id: <4c7a990a-7f11-17f3-2024-18acaf7ceb06@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Cornelia Huck ," <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin ," <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, "Thomas Huth ," <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, "Vasily Gorbik ," <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

> Subject: [PATCH 04/10] s390/mm: force swiotlb for protected virtualization
> Date: Fri, 26 Apr 2019 20:32:39 +0200
> From: Halil Pasic <pasic@linux.ibm.com>
> To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuc=
k@redhat.com>,=20
> Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.=
ibm.com>
> CC: Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundat=
ion.org, Michael=20
> S. Tsirkin <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thoma=
s Huth=20
> <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Vikto=
r Mihajlovski=20
> <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Fran=
k=20
> <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farha=
n Ali=20
> <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
>=20
> On s390, protected virtualization guests have to use bounced I/O
> buffers.=A0 That requires some plumbing.
>=20
> Let us make sure, any device that uses DMA API with direct ops correctly
> is spared from the problems, that a hypervisor attempting I/O to a
> non-shared page would bring.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  =A0arch/s390/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0 4 +++
>  =A0arch/s390/include/asm/mem_encrypt.h | 18 +++++++++++++
>  =A0arch/s390/mm/init.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
 50 +++++++++++++++++++++++++++++++++++++
>  =A03 files changed, 72 insertions(+)
>  =A0create mode 100644 arch/s390/include/asm/mem_encrypt.h
>=20
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 1c3fcf19c3af..5500d05d4d53 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -1,4 +1,7 @@
>  =A0# SPDX-License-Identifier: GPL-2.0
> +config ARCH_HAS_MEM_ENCRYPT
> +=A0=A0=A0=A0=A0=A0=A0 def_bool y
> +
>  =A0config MMU
>  =A0=A0=A0=A0 def_bool y
>  =A0@@ -191,6 +194,7 @@ config S390
>  =A0=A0=A0=A0 select ARCH_HAS_SCALED_CPUTIME
>  =A0=A0=A0=A0 select VIRT_TO_BUS
>  =A0=A0=A0=A0 select HAVE_NMI
> +=A0=A0=A0 select SWIOTLB
>  =A0=A0 config SCHED_OMIT_FRAME_POINTER
> diff --git a/arch/s390/include/asm/mem_encrypt.h b/arch/s390/include/asm/=
mem_encrypt.h
> new file mode 100644
> index 000000000000..0898c09a888c
> --- /dev/null
> +++ b/arch/s390/include/asm/mem_encrypt.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef S390_MEM_ENCRYPT_H__
> +#define S390_MEM_ENCRYPT_H__
> +
> +#ifndef __ASSEMBLY__
> +
> +#define sme_me_mask=A0=A0=A0 0ULL
> +
> +static inline bool sme_active(void) { return false; }
> +extern bool sev_active(void);
> +

I noticed this patch always returns false for sme_active. Is it safe to ass=
ume that=20
whatever fixups are required on x86 to deal with sme do not apply to s390?

> +int set_memory_encrypted(unsigned long addr, int numpages);
> +int set_memory_decrypted(unsigned long addr, int numpages);
> +
> +#endif=A0=A0=A0 /* __ASSEMBLY__ */
> +
> +#endif=A0=A0=A0 /* S390_MEM_ENCRYPT_H__ */
> +
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 3e82f66d5c61..7e3cbd15dcfa 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -18,6 +18,7 @@
>  =A0#include <linux/mman.h>
>  =A0#include <linux/mm.h>
>  =A0#include <linux/swap.h>
> +#include <linux/swiotlb.h>
>  =A0#include <linux/smp.h>
>  =A0#include <linux/init.h>
>  =A0#include <linux/pagemap.h>
> @@ -29,6 +30,7 @@
>  =A0#include <linux/export.h>
>  =A0#include <linux/cma.h>
>  =A0#include <linux/gfp.h>
> +#include <linux/dma-mapping.h>
>  =A0#include <asm/processor.h>
>  =A0#include <linux/uaccess.h>
>  =A0#include <asm/pgtable.h>
> @@ -42,6 +44,8 @@
>  =A0#include <asm/sclp.h>
>  =A0#include <asm/set_memory.h>
>  =A0#include <asm/kasan.h>
> +#include <asm/dma-mapping.h>
> +#include <asm/uv.h>
>  =A0 pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
>  =A0@@ -126,6 +130,50 @@ void mark_rodata_ro(void)
>  =A0=A0=A0=A0 pr_info("Write protected read-only-after-init data: %luk\n"=
, size >> 10);
>  =A0}
>  =A0+int set_memory_encrypted(unsigned long addr, int numpages)
> +{
> +=A0=A0=A0 int i;
> +
> +=A0=A0=A0 /* make all pages shared, (swiotlb, dma_free) */

This comment should be "make all pages unshared"?

> +=A0=A0=A0 for (i =3D 0; i < numpages; ++i) {
> +=A0=A0=A0=A0=A0=A0=A0 uv_remove_shared(addr);
> +=A0=A0=A0=A0=A0=A0=A0 addr +=3D PAGE_SIZE;
> +=A0=A0=A0 }
> +=A0=A0=A0 return 0;
> +}
> +EXPORT_SYMBOL_GPL(set_memory_encrypted);
> +
> +int set_memory_decrypted(unsigned long addr, int numpages)
> +{
> +=A0=A0=A0 int i;
> +=A0=A0=A0 /* make all pages shared (swiotlb, dma_alloca) */
> +=A0=A0=A0 for (i =3D 0; i < numpages; ++i) {
> +=A0=A0=A0=A0=A0=A0=A0 uv_set_shared(addr);
> +=A0=A0=A0=A0=A0=A0=A0 addr +=3D PAGE_SIZE;
> +=A0=A0=A0 }
> +=A0=A0=A0 return 0;
> +}
> +EXPORT_SYMBOL_GPL(set_memory_decrypted);

The addr arguments for the above functions appear to be referring to virtua=
l addresses.=20
Would vaddr be a better name?

> +
> +/* are we a protected virtualization guest? */
> +bool sev_active(void)
> +{
> +=A0=A0=A0 return is_prot_virt_guest();
> +}
> +EXPORT_SYMBOL_GPL(sev_active);
> +
> +/* protected virtualization */
> +static void pv_init(void)
> +{
> +=A0=A0=A0 if (!sev_active())
> +=A0=A0=A0=A0=A0=A0=A0 return;
> +
> +=A0=A0=A0 /* make sure bounce buffers are shared */
> +=A0=A0=A0 swiotlb_init(1);
> +=A0=A0=A0 swiotlb_update_mem_attributes();
> +=A0=A0=A0 swiotlb_force =3D SWIOTLB_FORCE;
> +}
> +
>  =A0void __init mem_init(void)
>  =A0{
>  =A0=A0=A0=A0 cpumask_set_cpu(0, &init_mm.context.cpu_attach_mask);
> @@ -134,6 +182,8 @@ void __init mem_init(void)
>  =A0=A0=A0=A0 set_max_mapnr(max_low_pfn);
>  =A0=A0=A0=A0=A0=A0=A0=A0 high_memory =3D (void *) __va(max_low_pfn * PAG=
E_SIZE);
>  =A0+=A0=A0=A0 pv_init();
> +
>  =A0=A0=A0=A0 /* Setup guest page hinting */
>  =A0=A0=A0=A0 cmma_init();
>  =A0-- 2.16.4
>=20
>=20

--=20
-- Jason J. Herne (jjherne@linux.ibm.com)
