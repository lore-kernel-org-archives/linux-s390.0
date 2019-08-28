Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfH1Lla (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Aug 2019 07:41:30 -0400
Subject: Re: [kvm-unit-tests PATCH v2 3/4] s390x: Bump march to zEC12
References: <20190828113615.4769-1-frankja@linux.ibm.com>
 <20190828113615.4769-4-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6f206d2f-758b-6171-517c-a4e5648b3f3a@redhat.com>
Date: Wed, 28 Aug 2019 13:41:25 +0200
MIME-Version: 1.0
In-Reply-To: <20190828113615.4769-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 28/08/2019 13.36, Janosch Frank wrote:
> TCG has majored a lot and can now support many newer instructions, so
> there's no need to compile with the ancient march z900.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/s390x/Makefile b/s390x/Makefile
> index 76db0bb..07bd353 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -25,7 +25,7 @@ CFLAGS += -std=gnu99
>  CFLAGS += -ffreestanding
>  CFLAGS += -I $(SRCDIR)/lib -I $(SRCDIR)/lib/s390x -I lib
>  CFLAGS += -O2
> -CFLAGS += -march=z900
> +CFLAGS += -march=zEC12
>  CFLAGS += -fno-delete-null-pointer-checks
>  LDFLAGS += -nostdlib -Wl,--build-id=none

Works with the QEMU in the gitlab-ci, so:

Tested-by: Thomas Huth <thuth@redhat.com>
