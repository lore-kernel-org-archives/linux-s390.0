Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387989AbfGYHk4 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 25 Jul 2019 03:40:56 -0400
Date: Thu, 25 Jul 2019 09:40:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: vfio-ccw: Remove myself as the
 maintainer
Message-ID: <20190725094053.2367e272.cohuck@redhat.com>
In-Reply-To: <355a4ac2923ff3dcf2171cb23d477440bd010b34.1564003698.git.alifm@linux.ibm.com>
References: <cover.1564003698.git.alifm@linux.ibm.com>
        <355a4ac2923ff3dcf2171cb23d477440bd010b34.1564003698.git.alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: farman@linux.ibm.com, pasic@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

[added the missing qemu mailing lists]

On Wed, 24 Jul 2019 17:35:46 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> I will not be able to continue with my maintainership responsibilities
> going forward, so remove myself as the maintainer.

Thank you again for your work!

> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index acbad13..fe2797a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1452,7 +1452,6 @@ F: include/hw/vfio/
>  vfio-ccw
>  M: Cornelia Huck <cohuck@redhat.com>
>  M: Eric Farman <farman@linux.ibm.com>
> -M: Farhan Ali <alifm@linux.ibm.com>
>  S: Supported
>  F: hw/vfio/ccw.c
>  F: hw/s390x/s390-ccw.c

Queued to s390-fixes.
