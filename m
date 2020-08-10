Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21224 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726141AbgHJMVU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Aug 2020 08:21:20 -0400
Date: Mon, 10 Aug 2020 14:21:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 1/3] s390x: Add custom pgm cleanup
 function
Message-ID: <20200810142109.77cac24c.cohuck@redhat.com>
In-Reply-To: <20200807111555.11169-2-frankja@linux.ibm.com>
References: <20200807111555.11169-1-frankja@linux.ibm.com>
        <20200807111555.11169-2-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

On Fri,  7 Aug 2020 07:15:53 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Sometimes we need to do cleanup which we don't necessarily want to add
> to interrupt.c, so let's add a way to register a cleanup function.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  lib/s390x/asm/interrupt.h |  1 +
>  lib/s390x/interrupt.c     | 12 +++++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
