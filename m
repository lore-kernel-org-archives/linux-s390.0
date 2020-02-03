Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23204 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727885AbgBCLHL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Feb 2020 06:07:11 -0500
Date: Mon, 3 Feb 2020 12:06:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v5 2/7] s390x: smp: Fix ecall and emcall
 report strings
Message-ID: <20200203120659.5bac2010.cohuck@redhat.com>
In-Reply-To: <20200201152851.82867-3-frankja@linux.ibm.com>
References: <20200201152851.82867-1-frankja@linux.ibm.com>
        <20200201152851.82867-3-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

On Sat,  1 Feb 2020 10:28:46 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Instead of "smp: ecall: ecall" we now get "smp: ecall: received".
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/smp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
