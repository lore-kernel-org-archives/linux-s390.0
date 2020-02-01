Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52393 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727336AbgBAS5p (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 1 Feb 2020 13:57:45 -0500
Subject: Re: [kvm-unit-tests PATCH v5 4/7] s390x: Add cpu id to interrupt
 error prints
References: <20200201152851.82867-1-frankja@linux.ibm.com>
 <20200201152851.82867-5-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <09e0f324-aef3-b39a-1862-3a015635dc3f@redhat.com>
Date: Sat, 1 Feb 2020 19:57:35 +0100
MIME-Version: 1.0
In-Reply-To: <20200201152851.82867-5-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

On 01/02/2020 16.28, Janosch Frank wrote:
> It's good to know which cpu broke the test.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  lib/s390x/interrupt.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
