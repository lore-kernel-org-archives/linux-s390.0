Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647D2C4332F
	for <linux-s390@archiver.kernel.org>; Thu, 21 Oct 2021 15:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E02F60F9F
	for <linux-s390@archiver.kernel.org>; Thu, 21 Oct 2021 15:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhJUPN5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 21 Oct 2021 11:13:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50119 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231803AbhJUPN5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Oct 2021 11:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634829100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x0T9sFaT53jZvS7u8t2/BNFrp32YelVjtprvyw23bFg=;
        b=OEgum7+dHQIFfEwV+HS6v8PO+MJdg5Xj5zs/Ki/XOnH/ZAagJ8cVHwJGoH1Taj/KR/ZccV
        VenEMk/ZbUjgTYBYkZoPth3qJlWds66kJSvsBUWn2LKdh0/HORzkwz82rMAheuZYvFz5pd
        mObXQtvvQo7t9AOc9Hl7LWW1HM4EDig=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-OH5D-_LaPiKuxR-yFgVUQQ-1; Thu, 21 Oct 2021 11:11:39 -0400
X-MC-Unique: OH5D-_LaPiKuxR-yFgVUQQ-1
Received: by mail-ed1-f72.google.com with SMTP id e14-20020a056402088e00b003db6ebb9526so624451edy.22
        for <linux-s390@vger.kernel.org>; Thu, 21 Oct 2021 08:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x0T9sFaT53jZvS7u8t2/BNFrp32YelVjtprvyw23bFg=;
        b=hdab7Gl5Qh8eiAXs2CGrvFKAltRUOeto9fN/orjL6eQ8eR+0UqI5P9gf4CkuH1u3D1
         TUtJuCDyqW8pdw+jRKsf/ZP4dYeGlX8Rz/1UGv5Bbra46Tz1UbEBWv9Bidzihn0qDMzl
         MpuJktyGuKftqzZJiwqJIlodUhqy0Pq5ON91Q7hDnKR0Fj8hy1q8KWS2YpjJAYGOHFpJ
         EZjl/IJlNzb1xuaqgRgtFq38ToAhriKire9+vkYhjmiMPf3UR/MAHJjw1ABLbkC8dQZO
         HpucQCiPNoNvSwu3kFHXDnUcCAbalNb0Kc3dFeWemZJNHdlrHQ0L30INiRU1kk/o4HtY
         iAmQ==
X-Gm-Message-State: AOAM533cYq6V7QC9V/VQ8ynbPzYEmYZp1O+qRA3p6vd8oUztoSqavWoh
        4LBHihxTGfk6BkM39rw9BLXSDGvkpj91tObt4FSOw+Ce9DIhnpemcL3grF7V/scemNY+IlieKmY
        UXeAVi3vJSRBB0+5LeAPx7w==
X-Received: by 2002:a17:907:2d28:: with SMTP id gs40mr8081224ejc.203.1634829098284;
        Thu, 21 Oct 2021 08:11:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvfbRxGC+EgYOwcg2nDZd+DGBjkAcpOLElKfhswN64XOk/c6IFv4/uzuyL3DXLD84T+HVPdg==
X-Received: by 2002:a17:907:2d28:: with SMTP id gs40mr8081207ejc.203.1634829098098;
        Thu, 21 Oct 2021 08:11:38 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id j3sm2620556ejy.65.2021.10.21.08.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 08:11:37 -0700 (PDT)
Message-ID: <177ebc1b-62fc-633a-5f49-ef2a1eab26a5@redhat.com>
Date:   Thu, 21 Oct 2021 17:11:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [kvm-unit-tests PATCH] MAINTAINERS: Add Claudio as s390x
 maintainer
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, thuth@redhat.com, borntraeger@de.ibm.com,
        drjones@redhat.com
References: <20211021145912.79225-1-frankja@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211021145912.79225-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 21/10/21 16:59, Janosch Frank wrote:
> Claudio has added his own tests, reviewed the tests of others and
> added to the common as well as the s390x library with excellent
> results. So it's time to make him a s390x maintainer.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2d4a0872..bab08e74 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -86,8 +86,8 @@ F: lib/ppc64/
>   S390X
>   M: Thomas Huth <thuth@redhat.com>
>   M: Janosch Frank <frankja@linux.ibm.com>
> +M: Claudio Imbrenda <imbrenda@linux.ibm.com>
>   S: Supported
> -R: Claudio Imbrenda <imbrenda@linux.ibm.com>
>   R: David Hildenbrand <david@redhat.com>
>   L: kvm@vger.kernel.org
>   L: linux-s390@vger.kernel.org
> 

Pushed, thanks!

Paolo

