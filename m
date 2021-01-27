Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234866AbhA0KtL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 Jan 2021 05:49:11 -0500
Date: Wed, 27 Jan 2021 11:47:27 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v5 2/3] s390x: define UV compatible I/O
 allocation
Message-ID: <20210127114727.1be31923.cohuck@redhat.com>
In-Reply-To: <1611322060-1972-3-git-send-email-pmorel@linux.ibm.com>
References: <1611322060-1972-1-git-send-email-pmorel@linux.ibm.com>
        <1611322060-1972-3-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com

On Fri, 22 Jan 2021 14:27:39 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> To centralize the memory allocation for I/O we define
> the alloc_io_mem/free_io_mem functions which share the I/O
> memory with the host in case the guest runs with
> protected virtualization.
> 
> These functions allocate on a page integral granularity to
> ensure a dedicated sharing of the allocated objects.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/malloc_io.c | 71 +++++++++++++++++++++++++++++++++++++++++++
>  lib/s390x/malloc_io.h | 45 +++++++++++++++++++++++++++
>  s390x/Makefile        |  1 +
>  3 files changed, 117 insertions(+)
>  create mode 100644 lib/s390x/malloc_io.c
>  create mode 100644 lib/s390x/malloc_io.h

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
