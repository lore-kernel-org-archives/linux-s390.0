Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33192 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726074AbgGUHdK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Jul 2020 03:33:10 -0400
Subject: Re: [kvm-unit-tests PATCH 3/3] s390x: Ultavisor guest API test
References: <20200717145813.62573-1-frankja@linux.ibm.com>
 <20200717145813.62573-4-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6f4cd41a-aa33-d9c9-b998-1257429b3c4a@redhat.com>
Date: Tue, 21 Jul 2020 09:32:57 +0200
MIME-Version: 1.0
In-Reply-To: <20200717145813.62573-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, imbrenda@linux.ibm.com

On 17/07/2020 16.58, Janosch Frank wrote:
> Test the error conditions of guest 2 Ultravisor calls, namely:
>      * Query Ultravisor information
>      * Set shared access
>      * Remove shared access
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/uv.h  |  68 +++++++++++++++++++
>  s390x/Makefile      |   1 +
>  s390x/unittests.cfg |   3 +
>  s390x/uv-guest.c    | 156 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 228 insertions(+)
>  create mode 100644 lib/s390x/asm/uv.h
>  create mode 100644 s390x/uv-guest.c
[...]
> diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
> index b35269b..38c3257 100644
> --- a/s390x/unittests.cfg
> +++ b/s390x/unittests.cfg
> @@ -92,3 +92,6 @@ extra_params = -device virtio-net-ccw
>  [skrf]
>  file = skrf.elf
>  smp = 2
> +
> +[uv-guest]
> +file = uv-guest.elf
> \ No newline at end of file

Add the newline, please.

 Thomas
