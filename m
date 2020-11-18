Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30982 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727476AbgKRRn5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Nov 2020 12:43:57 -0500
Date: Wed, 18 Nov 2020 18:43:45 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 1/5] s390x: Add test_bit to library
Message-ID: <20201118184345.30b7ba9d.cohuck@redhat.com>
In-Reply-To: <20201117154215.45855-2-frankja@linux.ibm.com>
References: <20201117154215.45855-1-frankja@linux.ibm.com>
        <20201117154215.45855-2-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

On Tue, 17 Nov 2020 10:42:11 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Query/feature bits are commonly tested via MSB bit numbers on
> s390. Let's add test bit functions, so we don't need to copy code to
> test query bits.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/bitops.h   | 16 ++++++++++++++++
>  lib/s390x/asm/facility.h |  3 ++-
>  2 files changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
