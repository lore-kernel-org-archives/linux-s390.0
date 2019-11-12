Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46596 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726986AbfKLJ0L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Nov 2019 04:26:11 -0500
Subject: Re: [kvm-unit-tests PATCH v2 1/3] s390x: Fix initial cr0 load
 comments
References: <20191111153345.22505-1-frankja@linux.ibm.com>
 <20191111153345.22505-2-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <55d20cae-aa91-beec-a7b2-b1145b9983b0@redhat.com>
Date: Tue, 12 Nov 2019 10:25:58 +0100
MIME-Version: 1.0
In-Reply-To: <20191111153345.22505-2-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 11/11/2019 16.33, Janosch Frank wrote:
> We need to load cr0 to have access to all fprs during save and restore
> of fprs. Saving conditionally on basis of the CR0 AFP bit would be a
> pain.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/cstart64.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 8e2b21e..043e34a 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -94,7 +94,7 @@ memsetxc:
>  =09stmg=09%r0, %r15, GEN_LC_SW_INT_GRS
>  =09/* save cr0 */
>  =09stctg=09%c0, %c0, GEN_LC_SW_INT_CR0
> -=09/* load initial cr0 again */
> +=09/* load a cr0 that has the AFP control bit which enables all FPRs */
>  =09larl=09%r1, initial_cr0
>  =09lctlg=09%c0, %c0, 0(%r1)
>  =09/* save fprs 0-15 + fpc */
> @@ -139,7 +139,7 @@ diag308_load_reset:
>  =09xgr=09%r2, %r2
>  =09br=09%r14
>  =09/* Success path */
> -=09/* We lost cr0 due to the reset */
> +=09/* load a cr0 that has the AFP control bit which enables all FPRs */
>  0:=09larl=09%r1, initial_cr0
>  =09lctlg=09%c0, %c0, 0(%r1)
>  =09RESTORE_REGS
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
