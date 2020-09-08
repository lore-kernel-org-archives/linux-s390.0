Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27737 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728908AbgIHG3G (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 02:29:06 -0400
Date: Tue, 8 Sep 2020 08:28:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/2] s390x: uv: Add destroy page call
Message-ID: <20200908082849.7e4a661d.cohuck@redhat.com>
In-Reply-To: <20200907124700.10374-2-frankja@linux.ibm.com>
References: <20200907124700.10374-1-frankja@linux.ibm.com>
        <20200907124700.10374-2-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, david@redhat.com, hca@linux.ibm.com

On Mon,  7 Sep 2020 08:46:59 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> We don't need to export pages if we destroy the VM configuration
> afterwards anyway. Instead we can destroy the page which will zero it
> and then make it accessible to the host.
> 
> Destroying is about twice as fast as the export.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/include/asm/uv.h |  7 +++++++
>  arch/s390/kernel/uv.c      | 20 ++++++++++++++++++++
>  arch/s390/mm/gmap.c        |  2 +-
>  3 files changed, 28 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
