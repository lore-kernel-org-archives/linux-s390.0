Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39287 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388262AbfJVLya (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 22 Oct 2019 07:54:30 -0400
Subject: Re: [kvm-unit-tests PATCH v1 1/5] s390x: remove redundant defines
References: <1571741584-17621-1-git-send-email-imbrenda@linux.ibm.com>
 <1571741584-17621-2-git-send-email-imbrenda@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <775bd0cb-0fdb-84c6-b0a6-bf8b4b603b3e@redhat.com>
Date: Tue, 22 Oct 2019 13:54:21 +0200
MIME-Version: 1.0
In-Reply-To: <1571741584-17621-2-git-send-email-imbrenda@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 22/10/2019 12.53, Claudio Imbrenda wrote:
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/sclp.h | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
> index 4e69845..f00c3df 100644
> --- a/lib/s390x/sclp.h
> +++ b/lib/s390x/sclp.h
> @@ -27,8 +27,6 @@
>  #define SCLP_ASSIGN_STORAGE                     0x000D0001
>  #define SCLP_CMD_READ_EVENT_DATA                0x00770005
>  #define SCLP_CMD_WRITE_EVENT_DATA               0x00760005
> -#define SCLP_CMD_READ_EVENT_DATA                0x00770005
> -#define SCLP_CMD_WRITE_EVENT_DATA               0x00760005
>  #define SCLP_CMD_WRITE_EVENT_MASK               0x00780005
> =20
>  /* SCLP Memory hotplug codes */
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
