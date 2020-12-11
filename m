Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51713 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730528AbgLKMIY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 11 Dec 2020 07:08:24 -0500
Subject: Re: [kvm-unit-tests PATCH v3 2/8] s390x: Consolidate sclp read info
References: <20201211100039.63597-1-frankja@linux.ibm.com>
 <20201211100039.63597-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a1d80ebe-4d4d-bc98-85aa-ab7e87468492@redhat.com>
Date: Fri, 11 Dec 2020 13:06:48 +0100
MIME-Version: 1.0
In-Reply-To: <20201211100039.63597-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 11/12/2020 11.00, Janosch Frank wrote:
> Let's only read the information once and pass a pointer to it instead
> of calling sclp multiple times.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  lib/s390x/io.c   |  1 +
>  lib/s390x/sclp.c | 31 +++++++++++++++++++++++++------
>  lib/s390x/sclp.h |  3 +++
>  lib/s390x/smp.c  | 27 +++++++++++----------------
>  4 files changed, 40 insertions(+), 22 deletions(-)

Acked-by: Thomas Huth <thuth@redhat.com>
