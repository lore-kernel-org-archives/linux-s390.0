Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34630 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389907AbgFXM0d (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 24 Jun 2020 08:26:33 -0400
Subject: Re: [kvm-unit-tests PATCH v9 09/12] s390x: Library resources for CSS
 tests
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-10-git-send-email-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9de11879-4429-bfe8-7f1e-1f5880764a6a@redhat.com>
Date: Wed, 24 Jun 2020 14:26:21 +0200
MIME-Version: 1.0
In-Reply-To: <1592213521-19390-10-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com

On 15/06/2020 11.31, Pierre Morel wrote:
> Provide some definitions and library routines that can be used by
> tests targeting the channel subsystem.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   lib/s390x/css.h      | 256 +++++++++++++++++++++++++++++++++++++++++++
>   lib/s390x/css_dump.c | 153 ++++++++++++++++++++++++++
>   s390x/Makefile       |   1 +
>   3 files changed, 410 insertions(+)
>   create mode 100644 lib/s390x/css.h
>   create mode 100644 lib/s390x/css_dump.c
[...]
> diff --git a/lib/s390x/css_dump.c b/lib/s390x/css_dump.c
> new file mode 100644
> index 0000000..0c2b64e
> --- /dev/null
> +++ b/lib/s390x/css_dump.c
> @@ -0,0 +1,153 @@
> +/*
> + * Channel subsystem structures dumping
> + *
> + * Copyright (c) 2020 IBM Corp.
> + *
> + * Authors:
> + *  Pierre Morel <pmorel@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2.
> + *
> + * Description:
> + * Provides the dumping functions for various structures used by subchannels:
> + * - ORB  : Operation request block, describes the I/O operation and points to
> + *          a CCW chain
> + * - CCW  : Channel Command Word, describes the command, data and flow control
> + * - IRB  : Interuption response Block, describes the result of an operation;
> + *          holds a SCSW and model-dependent data.
> + * - SCHIB: SubCHannel Information Block composed of:
> + *   - SCSW: SubChannel Status Word, status of the channel.
> + *   - PMCW: Path Management Control Word
> + * You need the QEMU ccw-pong device in QEMU to answer the I/O transfers.
> + */
> +
> +#include <libcflat.h>
> +#include <unistd.h>

Please don't use unistd.h in kvm-unit-tests - this header is not usable 
in cross-compilation environments:

  https://travis-ci.com/github/huth/kvm-unit-tests/jobs/353089278#L536

Thanks,
  Thomas
