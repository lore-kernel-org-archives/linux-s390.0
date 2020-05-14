Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23022 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725878AbgENHPr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 May 2020 03:15:47 -0400
Subject: Re: [PATCH v6 1/2] s390/setup: diag318: refactor struct
References: <20200513221557.14366-1-walling@linux.ibm.com>
 <20200513221557.14366-2-walling@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c6fc70d4-9bb4-6651-fce3-6fc2834bd9a6@redhat.com>
Date: Thu, 14 May 2020 09:15:32 +0200
MIME-Version: 1.0
In-Reply-To: <20200513221557.14366-2-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com

On 14/05/2020 00.15, Collin Walling wrote:
> The diag318 struct introduced in include/asm/diag.h can be
> reused in KVM, so let's condense the version code fields in the
> diag318_info struct for easier usage and simplify it until we
> can determine how the data should be formatted.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  arch/s390/include/asm/diag.h | 6 ++----
>  arch/s390/kernel/setup.c     | 3 +--
>  2 files changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
