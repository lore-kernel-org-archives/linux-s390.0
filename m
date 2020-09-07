Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52342 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728815AbgIGSAF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Sep 2020 14:00:05 -0400
Subject: Re: [PATCH v2 1/2] s390x: uv: Add destroy page call
References: <20200907124700.10374-1-frankja@linux.ibm.com>
 <20200907124700.10374-2-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <76c62134-d672-b55f-dc24-14898e4fb2af@redhat.com>
Date: Mon, 7 Sep 2020 19:59:52 +0200
MIME-Version: 1.0
In-Reply-To: <20200907124700.10374-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: borntraeger@de.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, david@redhat.com, hca@linux.ibm.com

On 07/09/2020 14.46, Janosch Frank wrote:
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
