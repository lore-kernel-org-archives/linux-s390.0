Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727977AbgKRRqw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Nov 2020 12:46:52 -0500
Date: Wed, 18 Nov 2020 18:46:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 2/5] s390x: Consolidate sclp read info
Message-ID: <20201118184640.203438f6.cohuck@redhat.com>
In-Reply-To: <20201117154215.45855-3-frankja@linux.ibm.com>
References: <20201117154215.45855-1-frankja@linux.ibm.com>
        <20201117154215.45855-3-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

On Tue, 17 Nov 2020 10:42:12 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Let's only read the information once and pass a pointer to it instead
> of calling sclp multiple times.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/io.c   |  1 +
>  lib/s390x/sclp.c | 29 +++++++++++++++++++++++------
>  lib/s390x/sclp.h |  3 +++
>  lib/s390x/smp.c  | 23 +++++++++--------------
>  4 files changed, 36 insertions(+), 20 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
