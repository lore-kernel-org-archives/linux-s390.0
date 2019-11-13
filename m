Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33264 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727452AbfKMOuE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 13 Nov 2019 09:50:04 -0500
Subject: Re: [RFC 15/37] KVM: s390: protvirt: Add machine-check interruption
 injection controls
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-16-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6b0bef57-cbe3-99df-354e-061a12d4cc31@redhat.com>
Date: Wed, 13 Nov 2019 15:49:51 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-16-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24/10/2019 13.40, Janosch Frank wrote:
> From: Michael Mueller <mimu@linux.ibm.com>
>=20
> The following fields are added to the sie control block type 4:
>      - Machine Check Interruption Code (mcic)
>      - External Damage Code (edc)
>      - Failing Storage Address (faddr)
>=20
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 33 +++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm=
_host.h
> index 63fc32d38aa9..0ab309b7bf4c 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -261,16 +261,31 @@ struct kvm_s390_sie_block {
>  #define HPID_VSIE=090x5
>  =09__u8=09hpid;=09=09=09/* 0x00b8 */
>  =09__u8=09reservedb9[7];=09=09/* 0x00b9 */
> -=09__u32=09eiparams;=09=09/* 0x00c0 */
> -=09__u16=09extcpuaddr;=09=09/* 0x00c4 */
> -=09__u16=09eic;=09=09=09/* 0x00c6 */
> +=09union {
> +=09=09struct {
> +=09=09=09__u32=09eiparams;=09/* 0x00c0 */
> +=09=09=09__u16=09extcpuaddr;=09/* 0x00c4 */
> +=09=09=09__u16=09eic;=09=09/* 0x00c6 */
> +=09=09};
> +=09=09__u64=09mcic;=09=09=09/* 0x00c0 */
> +=09} __packed;
>  =09__u32=09reservedc8;=09=09/* 0x00c8 */
> -=09__u16=09pgmilc;=09=09=09/* 0x00cc */
> -=09__u16=09iprcc;=09=09=09/* 0x00ce */
> -=09__u32=09dxc;=09=09=09/* 0x00d0 */
> -=09__u16=09mcn;=09=09=09/* 0x00d4 */
> -=09__u8=09perc;=09=09=09/* 0x00d6 */
> -=09__u8=09peratmid;=09=09/* 0x00d7 */
> +=09union {
> +=09=09struct {
> +=09=09=09__u16=09pgmilc;=09=09/* 0x00cc */
> +=09=09=09__u16=09iprcc;=09=09/* 0x00ce */
> +=09=09};
> +=09=09__u32=09edc;=09=09=09/* 0x00cc */
> +=09} __packed;
> +=09union {
> +=09=09struct {
> +=09=09=09__u32=09dxc;=09=09/* 0x00d0 */
> +=09=09=09__u16=09mcn;=09=09/* 0x00d4 */
> +=09=09=09__u8=09perc;=09=09/* 0x00d6 */
> +=09=09=09__u8=09peratmid;=09/* 0x00d7 */
> +=09=09};
> +=09=09__u64=09faddr;=09=09=09/* 0x00d0 */
> +=09} __packed;

Maybe drop the __packed keywords since the struct members are naturally
aligned anyway?

 Thomas
