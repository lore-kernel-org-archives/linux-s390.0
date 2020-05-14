Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30170 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgENMD3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 May 2020 08:03:29 -0400
Date: Thu, 14 May 2020 14:03:15 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v6 05/10] s390x: Library resources for
 CSS tests
Message-ID: <20200514140315.6077046b.cohuck@redhat.com>
In-Reply-To: <1587725152-25569-6-git-send-email-pmorel@linux.ibm.com>
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
        <1587725152-25569-6-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Fri, 24 Apr 2020 12:45:47 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> These are the include and library utilities for the css tests patch
> series.

"Provide some definitions and library routines that can be used by
tests targeting the channel subsystem."

?

> 
> Debug function can be activated by defining DEBUG_CSS before the
> inclusion of the css.h header file.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/css.h      | 256 +++++++++++++++++++++++++++++++++++++++++++
>  lib/s390x/css_dump.c | 157 ++++++++++++++++++++++++++
>  2 files changed, 413 insertions(+)
>  create mode 100644 lib/s390x/css.h
>  create mode 100644 lib/s390x/css_dump.c

(...)

> diff --git a/lib/s390x/css_dump.c b/lib/s390x/css_dump.c
> new file mode 100644
> index 0000000..2f33fab
> --- /dev/null
> +++ b/lib/s390x/css_dump.c
> @@ -0,0 +1,157 @@
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
> + * - CCW  : Channel Command Word, describes the data and flow control

"describes the command, data, and flow control" ?

> + * - IRB  : Interuption response Block, describes the result of an operation

s/operation/operation;/

> + *          holds a SCSW and model-dependent data.
> + * - SCHIB: SubCHannel Information Block composed of:

> + *   - SCSW: SubChannel Status Word, status of the channel.
> + *   - PMCW: Path Management Control Word
> + * You need the QEMU ccw-pong device in QEMU to answer the I/O transfers.
> + */

(...)

Otherwise, looks good.
