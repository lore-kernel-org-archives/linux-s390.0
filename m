Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:39448 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbgC0KQI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 06:16:08 -0400
Subject: Re: [PATCH 1/2] s390x: add myself as reviewer
References: <20200324121722.9776-1-cohuck@redhat.com>
 <20200324121722.9776-2-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <af4c9a66-8dcf-5fe0-82de-a2237a534fb7@redhat.com>
Date: Fri, 27 Mar 2020 11:16:01 +0100
MIME-Version: 1.0
In-Reply-To: <20200324121722.9776-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>

On 24.03.20 13:17, Cornelia Huck wrote:
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 48da1dbdd1ac..471767a355c6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -81,6 +81,7 @@ S390X
>  M: Thomas Huth <thuth@redhat.com>
>  M: David Hildenbrand <david@redhat.com>
>  R: Janosch Frank <frankja@linux.ibm.com>
> +R: Cornelia Huck <cohuck@redhat.com>
>  L: kvm@vger.kernel.org
>  F: s390x/*
>  F: lib/s390x/*
> 

Added "MAINTAINERS: " as subject prefix and queued to

https://github.com/davidhildenbrand/kvm-unit-tests.git s390x-next

(rebased on Janosch MAINTAINERS change)

-- 
Thanks,

David / dhildenb
