Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40003 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726369AbgBCLEY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Feb 2020 06:04:24 -0500
Date: Mon, 3 Feb 2020 12:04:12 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v5 1/7] s390x: smp: Cleanup smp.c
Message-ID: <20200203120412.7ae7bb60.cohuck@redhat.com>
In-Reply-To: <20200201152851.82867-2-frankja@linux.ibm.com>
References: <20200201152851.82867-1-frankja@linux.ibm.com>
        <20200201152851.82867-2-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

On Sat,  1 Feb 2020 10:28:45 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Let's remove a lot of badly formatted code by introducing the
> wait_for_flag() and set_flag functions.
> 
> Also let's remove some stray spaces and always set the tesflag before

s/tesflag/testflag/

> using it.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  s390x/smp.c | 55 ++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 33 insertions(+), 22 deletions(-)
