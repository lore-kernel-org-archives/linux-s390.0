Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58082 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728175AbfJ3Px0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 30 Oct 2019 11:53:26 -0400
Subject: Re: [RFC 13/37] KVM: s390: protvirt: Add interruption injection
 controls
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-14-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c09046eb-380f-d930-8e99-42b9cc8a62ae@redhat.com>
Date: Wed, 30 Oct 2019 16:53:17 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-14-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24.10.19 13:40, Janosch Frank wrote:
> From: Michael Mueller <mimu@linux.ibm.com>
>=20
> Define the interruption injection codes and the related fields in the
> sie control block for PVM interruption injection.
>=20
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h | 25 +++++++++++++++++++++----
>   1 file changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm=
_host.h
> index 6cc3b73ca904..82443236d4cc 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -215,7 +215,15 @@ struct kvm_s390_sie_block {
>   =09__u8=09icptcode;=09=09/* 0x0050 */
>   =09__u8=09icptstatus;=09=09/* 0x0051 */
>   =09__u16=09ihcpu;=09=09=09/* 0x0052 */
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
>   =09__u16=09ipa;=09=09=09/* 0x0056 */
>   =09__u32=09ipb;=09=09=09/* 0x0058 */
>   =09__u32=09scaoh;=09=09=09/* 0x005c */
> @@ -252,7 +260,8 @@ struct kvm_s390_sie_block {
>   #define HPID_KVM=090x4
>   #define HPID_VSIE=090x5
>   =09__u8=09hpid;=09=09=09/* 0x00b8 */
> -=09__u8=09reservedb9[11];=09=09/* 0x00b9 */
> +=09__u8=09reservedb9[7];=09=09/* 0x00b9 */
> +=09__u32=09eiparams;=09=09/* 0x00c0 */
>   =09__u16=09extcpuaddr;=09=09/* 0x00c4 */
>   =09__u16=09eic;=09=09=09/* 0x00c6 */
>   =09__u32=09reservedc8;=09=09/* 0x00c8 */
> @@ -268,8 +277,16 @@ struct kvm_s390_sie_block {
>   =09__u8=09oai;=09=09=09/* 0x00e2 */
>   =09__u8=09armid;=09=09=09/* 0x00e3 */
>   =09__u8=09reservede4[4];=09=09/* 0x00e4 */
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

I only wonder if we should give this member a fitting name, e.g., "ioparams=
"

> +=09} __packed;
> +=09__u8=09reservedf4[8];=09=09/* 0x00f4 */
>   #define CRYCB_FORMAT_MASK 0x00000003
>   #define CRYCB_FORMAT0 0x00000000
>   #define CRYCB_FORMAT1 0x00000001
>=20


--=20

Thanks,

David / dhildenb
