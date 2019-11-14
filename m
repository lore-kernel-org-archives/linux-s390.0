Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45511 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726179AbfKNOod (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Nov 2019 09:44:33 -0500
Subject: Re: [RFC 19/37] KVM: s390: protvirt: Add new gprs location handling
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-20-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <049b8634-c195-4b3f-4d9c-83a1df7f03f7@redhat.com>
Date: Thu, 14 Nov 2019 15:44:18 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-20-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24/10/2019 13.40, Janosch Frank wrote:
> Guest registers for protected guests are stored at offset 0x380.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  4 +++-
>  arch/s390/kvm/kvm-s390.c         | 11 +++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm=
_host.h
> index 0ab309b7bf4c..5deabf9734d9 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -336,7 +336,9 @@ struct kvm_s390_itdb {
>  struct sie_page {
>  =09struct kvm_s390_sie_block sie_block;
>  =09struct mcck_volatile_info mcck_info;=09/* 0x0200 */
> -=09__u8 reserved218[1000];=09=09/* 0x0218 */
> +=09__u8 reserved218[360];=09=09/* 0x0218 */
> +=09__u64 pv_grregs[16];=09=09/* 0x380 */
> +=09__u8 reserved400[512];

Maybe add a "/* 0x400 */" comment to be consisten with the other lines?

>  =09struct kvm_s390_itdb itdb;=09/* 0x0600 */
>  =09__u8 reserved700[2304];=09=09/* 0x0700 */
>  };

 Thomas
