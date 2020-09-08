Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30330 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728115AbgIHGjt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 02:39:49 -0400
Date: Tue, 8 Sep 2020 08:39:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 2/2] s390x: Add 3f program exception handler
Message-ID: <20200908083937.5eae4a4b.cohuck@redhat.com>
In-Reply-To: <20200907124700.10374-3-frankja@linux.ibm.com>
References: <20200907124700.10374-1-frankja@linux.ibm.com>
        <20200907124700.10374-3-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, david@redhat.com, hca@linux.ibm.com

On Mon,  7 Sep 2020 08:47:00 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Program exception 3f (secure storage violation) can only be detected
> when the CPU is running in SIE with a format 4 state description,
> e.g. running a protected guest. Because of this and because user
> space partly controls the guest memory mapping and can trigger this
> exception, we want to send a SIGSEGV to the process running the guest
> and not panic the kernel.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> CC: <stable@vger.kernel.org> # 5.7+
> Fixes: 084ea4d611a3 ("s390/mm: add (non)secure page access exceptions handlers")
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kernel/pgm_check.S |  2 +-
>  arch/s390/mm/fault.c         | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
