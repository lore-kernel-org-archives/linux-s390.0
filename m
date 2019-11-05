Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31372 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390495AbfKERvi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Nov 2019 12:51:38 -0500
Date: Tue, 5 Nov 2019 18:51:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 13/37] KVM: s390: protvirt: Add interruption injection
 controls
Message-ID: <20191105185124.495d4820.cohuck@redhat.com>
In-Reply-To: <20191024114059.102802-14-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
        <20191024114059.102802-14-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

On Thu, 24 Oct 2019 07:40:35 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> From: Michael Mueller <mimu@linux.ibm.com>
>=20
> Define the interruption injection codes and the related fields in the
> sie control block for PVM interruption injection.
>=20
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm=
_host.h
> index 6cc3b73ca904..82443236d4cc 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -215,7 +215,15 @@ struct kvm_s390_sie_block {
>  =09__u8=09icptcode;=09=09/* 0x0050 */
>  =09__u8=09icptstatus;=09=09/* 0x0051 */
>  =09__u16=09ihcpu;=09=09=09/* 0x0052 */
> -=09__u8=09reserved54[2];=09=09/* 0x0054 */
> +=09__u8=09reserved54;=09=09/* 0x0054 */
> +#define IICTL_CODE_NONE=09=09 0x00
> +#define IICTL_CODE_MCHK=09=09 0x01
> +#define IICTL_CODE_EXT=09=09 0x02
> +#define IICTL_CODE_IO=09=09 0x03
> +#define IICTL_CODE_RESTART=09 0x04
> +#define IICTL_CODE_SPECIFICATION 0x10
> +#define IICTL_CODE_OPERAND=09 0x11
> +=09__u8=09iictl;=09=09=09/* 0x0055 */
>  =09__u16=09ipa;=09=09=09/* 0x0056 */
>  =09__u32=09ipb;=09=09=09/* 0x0058 */
>  =09__u32=09scaoh;=09=09=09/* 0x005c */
> @@ -252,7 +260,8 @@ struct kvm_s390_sie_block {
>  #define HPID_KVM=090x4
>  #define HPID_VSIE=090x5
>  =09__u8=09hpid;=09=09=09/* 0x00b8 */
> -=09__u8=09reservedb9[11];=09=09/* 0x00b9 */
> +=09__u8=09reservedb9[7];=09=09/* 0x00b9 */
> +=09__u32=09eiparams;=09=09/* 0x00c0 */
>  =09__u16=09extcpuaddr;=09=09/* 0x00c4 */
>  =09__u16=09eic;=09=09=09/* 0x00c6 */
>  =09__u32=09reservedc8;=09=09/* 0x00c8 */
> @@ -268,8 +277,16 @@ struct kvm_s390_sie_block {
>  =09__u8=09oai;=09=09=09/* 0x00e2 */
>  =09__u8=09armid;=09=09=09/* 0x00e3 */
>  =09__u8=09reservede4[4];=09=09/* 0x00e4 */
> -=09__u64=09tecmc;=09=09=09/* 0x00e8 */
> -=09__u8=09reservedf0[12];=09=09/* 0x00f0 */
> +=09union {
> +=09=09__u64=09tecmc;=09=09/* 0x00e8 */
> +=09=09struct {
> +=09=09=09__u16=09subchannel_id;=09/* 0x00e8 */
> +=09=09=09__u16=09subchannel_nr;=09/* 0x00ea */
> +=09=09=09__u32=09io_int_parm;=09/* 0x00ec */
> +=09=09=09__u32=09io_int_word;=09/* 0x00f0 */
> +=09=09};
> +=09} __packed;
> +=09__u8=09reservedf4[8];=09=09/* 0x00f4 */

IIUC, for protected guests, you won't get an interception for which
tecmc would be valid anymore, but need to put the I/O interruption
stuff at the same place, right?

My main issue is that this makes the control block definition a bit
ugly, since the f0 value that's unused in the non-protvirt case is not
obvious anymore; but I don't know how to express this without making it
even uglier :(

>  #define CRYCB_FORMAT_MASK 0x00000003
>  #define CRYCB_FORMAT0 0x00000000
>  #define CRYCB_FORMAT1 0x00000001
