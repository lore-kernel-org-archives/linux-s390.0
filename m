Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54767 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731525AbfJVPoR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 22 Oct 2019 11:44:17 -0400
Subject: Re: [kvm-unit-tests PATCH v1 1/5] s390x: remove redundant defines
References: <1571741584-17621-1-git-send-email-imbrenda@linux.ibm.com>
 <1571741584-17621-2-git-send-email-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <bc05cdfa-60f5-007c-8df3-ab32f024cda3@redhat.com>
Date: Tue, 22 Oct 2019 17:44:06 +0200
MIME-Version: 1.0
In-Reply-To: <1571741584-17621-2-git-send-email-imbrenda@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 22.10.19 12:53, Claudio Imbrenda wrote:
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/sclp.h | 2 --
>   1 file changed, 2 deletions(-)
>=20
> diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
> index 4e69845..f00c3df 100644
> --- a/lib/s390x/sclp.h
> +++ b/lib/s390x/sclp.h
> @@ -27,8 +27,6 @@
>   #define SCLP_ASSIGN_STORAGE                     0x000D0001
>   #define SCLP_CMD_READ_EVENT_DATA                0x00770005
>   #define SCLP_CMD_WRITE_EVENT_DATA               0x00760005
> -#define SCLP_CMD_READ_EVENT_DATA                0x00770005
> -#define SCLP_CMD_WRITE_EVENT_DATA               0x00760005
>   #define SCLP_CMD_WRITE_EVENT_MASK               0x00780005
>  =20
>   /* SCLP Memory hotplug codes */
>=20

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb
