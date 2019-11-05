Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36970 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390314AbfKETeE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Nov 2019 14:34:04 -0500
Subject: Re: [kvm-unit-tests PATCH 1/2] s390x: Add CR save area
References: <20191105162828.2490-1-frankja@linux.ibm.com>
 <20191105162828.2490-2-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <32fd3fc1-be79-d552-c8da-e341ca058651@redhat.com>
Date: Tue, 5 Nov 2019 20:33:58 +0100
MIME-Version: 1.0
In-Reply-To: <20191105162828.2490-2-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

On 05.11.19 17:28, Janosch Frank wrote:
> If we run with DAT enabled and do a reset, we need to save the CRs to
> backup our ASCEs on a diag308 for example.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/asm-offsets.c  | 2 +-
>   lib/s390x/asm/arch_def.h | 4 ++--
>   lib/s390x/interrupt.c    | 4 ++--
>   lib/s390x/smp.c          | 2 +-
>   s390x/cstart64.S         | 9 ++++++---
>   5 files changed, 12 insertions(+), 9 deletions(-)
>=20
> diff --git a/lib/s390x/asm-offsets.c b/lib/s390x/asm-offsets.c
> index 6e2d259..4b213f8 100644
> --- a/lib/s390x/asm-offsets.c
> +++ b/lib/s390x/asm-offsets.c
> @@ -57,7 +57,7 @@ int main(void)
>   =09OFFSET(GEN_LC_SW_INT_GRS, lowcore, sw_int_grs);
>   =09OFFSET(GEN_LC_SW_INT_FPRS, lowcore, sw_int_fprs);
>   =09OFFSET(GEN_LC_SW_INT_FPC, lowcore, sw_int_fpc);
> -=09OFFSET(GEN_LC_SW_INT_CR0, lowcore, sw_int_cr0);
> +=09OFFSET(GEN_LC_SW_INT_CRS, lowcore, sw_int_crs);
>   =09OFFSET(GEN_LC_MCCK_EXT_SA_ADDR, lowcore, mcck_ext_sa_addr);
>   =09OFFSET(GEN_LC_FPRS_SA, lowcore, fprs_sa);
>   =09OFFSET(GEN_LC_GRS_SA, lowcore, grs_sa);
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 96cca2e..07d4e5e 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -78,8 +78,8 @@ struct lowcore {
>   =09uint64_t=09sw_int_fprs[16];=09=09/* 0x0280 */
>   =09uint32_t=09sw_int_fpc;=09=09=09/* 0x0300 */
>   =09uint8_t=09=09pad_0x0304[0x0308 - 0x0304];=09/* 0x0304 */
> -=09uint64_t=09sw_int_cr0;=09=09=09/* 0x0308 */
> -=09uint8_t=09=09pad_0x0310[0x11b0 - 0x0310];=09/* 0x0310 */
> +=09uint64_t=09sw_int_crs[16];=09=09=09/* 0x0308 */
> +=09uint8_t=09=09pad_0x0310[0x11b0 - 0x0388];=09/* 0x0388 */
>   =09uint64_t=09mcck_ext_sa_addr;=09=09/* 0x11b0 */
>   =09uint8_t=09=09pad_0x11b8[0x1200 - 0x11b8];=09/* 0x11b8 */
>   =09uint64_t=09fprs_sa[16];=09=09=09/* 0x1200 */
> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
> index 5cade23..c9e2dc6 100644
> --- a/lib/s390x/interrupt.c
> +++ b/lib/s390x/interrupt.c
> @@ -124,13 +124,13 @@ void handle_ext_int(void)
>   =09}
>  =20
>   =09if (lc->ext_int_code =3D=3D EXT_IRQ_SERVICE_SIG) {
> -=09=09lc->sw_int_cr0 &=3D ~(1UL << 9);
> +=09=09lc->sw_int_crs[0] &=3D ~(1UL << 9);
>   =09=09sclp_handle_ext();
>   =09} else {
>   =09=09ext_int_expected =3D false;
>   =09}
>  =20
> -=09if (!(lc->sw_int_cr0 & CR0_EXTM_MASK))
> +=09if (!(lc->sw_int_crs[0] & CR0_EXTM_MASK))
>   =09=09lc->ext_old_psw.mask &=3D ~PSW_MASK_EXT;
>   }
>  =20
> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
> index 7602886..f57f420 100644
> --- a/lib/s390x/smp.c
> +++ b/lib/s390x/smp.c
> @@ -189,7 +189,7 @@ int smp_cpu_setup(uint16_t addr, struct psw psw)
>   =09cpu->lowcore->sw_int_grs[15] =3D (uint64_t)cpu->stack + (PAGE_SIZE *=
 4);
>   =09lc->restart_new_psw.mask =3D 0x0000000180000000UL;
>   =09lc->restart_new_psw.addr =3D (uint64_t)smp_cpu_setup_state;
> -=09lc->sw_int_cr0 =3D 0x0000000000040000UL;
> +=09lc->sw_int_crs[0] =3D 0x0000000000040000UL;
>  =20
>   =09/* Start processing */
>   =09rc =3D sigp_retry(cpu->addr, SIGP_RESTART, 0, NULL);
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 8e2b21e..0455591 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -93,7 +93,7 @@ memsetxc:
>   =09/* save grs 0-15 */
>   =09stmg=09%r0, %r15, GEN_LC_SW_INT_GRS
>   =09/* save cr0 */

Comment needs an update

> -=09stctg=09%c0, %c0, GEN_LC_SW_INT_CR0
> +=09stctg=09%c0, %c15, GEN_LC_SW_INT_CRS
>   =09/* load initial cr0 again */
>   =09larl=09%r1, initial_cr0
>   =09lctlg=09%c0, %c0, 0(%r1)
> @@ -107,13 +107,16 @@ memsetxc:
>  =20
>   =09.macro RESTORE_REGS
>   =09/* restore fprs 0-15 + fpc */
> +=09/* load initial cr0 again */

Two comments in a wrong look wrong.

> +=09larl=09%r1, initial_cr0
> +=09lctlg=09%c0, %c0, 0(%r1)

This hunk does somewhat not fit to this patch description. This needs an=20
explanation or should be moved to a separate patch.

>   =09la=09%r1, GEN_LC_SW_INT_FPRS
>   =09.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
>   =09ld=09\i, \i * 8(%r1)
>   =09.endr
>   =09lfpc=09GEN_LC_SW_INT_FPC
>   =09/* restore cr0 */

Comments needs an update

> -=09lctlg=09%c0, %c0, GEN_LC_SW_INT_CR0
> +=09lctlg=09%c0, %c15, GEN_LC_SW_INT_CRS
>   =09/* restore grs 0-15 */
>   =09lmg=09%r0, %r15, GEN_LC_SW_INT_GRS
>   =09.endm
> @@ -150,7 +153,7 @@ diag308_load_reset:
>   smp_cpu_setup_state:
>   =09xgr=09%r1, %r1
>   =09lmg     %r0, %r15, GEN_LC_SW_INT_GRS
> -=09lctlg   %c0, %c0, GEN_LC_SW_INT_CR0
> +=09lctlg   %c0, %c0, GEN_LC_SW_INT_CRS
>   =09br=09%r14
>  =20
>   pgm_int:
>=20

Apart from that looks good.

--=20

Thanks,

David / dhildenb
