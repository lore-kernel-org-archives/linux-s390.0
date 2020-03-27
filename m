Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50119 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726217AbgC0KRc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 06:17:32 -0400
Subject: Re: [PATCH 2/2] s390x: add linux-s390 list
References: <20200324121722.9776-1-cohuck@redhat.com>
 <20200324121722.9776-3-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a7805e54-01a4-9070-af4b-f972c0036a32@redhat.com>
Date: Fri, 27 Mar 2020 11:17:23 +0100
MIME-Version: 1.0
In-Reply-To: <20200324121722.9776-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>

On 24.03.20 13:17, Cornelia Huck wrote:
> It makes sense to cc: patches there as well.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 471767a355c6..8912533e441d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -83,6 +83,7 @@ M: David Hildenbrand <david@redhat.com>
>  R: Janosch Frank <frankja@linux.ibm.com>
>  R: Cornelia Huck <cohuck@redhat.com>
>  L: kvm@vger.kernel.org
> +L: linux-s390@vger.kernel.org
>  F: s390x/*
>  F: lib/s390x/*
>  
> 

Added "MAINTAINERS: " as subject prefix and queued to

https://github.com/davidhildenbrand/kvm-unit-tests.git s390x-next

(rebased on Janosch MAINTAINERS change)

-- 
Thanks,

David / dhildenb
