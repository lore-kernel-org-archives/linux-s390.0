Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AE1C433F5
	for <linux-s390@archiver.kernel.org>; Mon, 17 Jan 2022 08:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbiAQI1a (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:27:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43633 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232342AbiAQI1a (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Jan 2022 03:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642408049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5AiDyqvFvh3yOegzgJFQoLQBwCo7wbjcGj2xMIv/7xE=;
        b=Uh0Ge4sIDwHsYqm674ok8WIDLWlWcXEoD7bIxN3h0qJn4BjFUd/hEVvW9ufqAvet7D9xIH
        1jwHYfPR5Kbben5KpK2mBOH/Nruy73L5kAUNiegxJaAt3YXbXdRNg8z4OSlsZGl/g4bEhU
        21x+ylUpKzrR7KGbks8Y1Z9ePSvAs9Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-SPOh4V6aOeeiwiZwSERg3w-1; Mon, 17 Jan 2022 03:27:28 -0500
X-MC-Unique: SPOh4V6aOeeiwiZwSERg3w-1
Received: by mail-wm1-f69.google.com with SMTP id 24-20020a05600c229800b0034bfa8a1531so3545152wmf.1
        for <linux-s390@vger.kernel.org>; Mon, 17 Jan 2022 00:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5AiDyqvFvh3yOegzgJFQoLQBwCo7wbjcGj2xMIv/7xE=;
        b=Tz9tKKCdIT85cifB9sHd+ozUjauvllMzH4EveI/8EMvlPx+8/7k9qnyTmIveTLAxzB
         9CHFJpcdsYBM8UZakyUABYs5azDRHkVn9p/EFE2loVNqX39RPylZiNsf/LVQ5Ms1ys9J
         1ZZUb+A5OoR29MIrdKoaSshNuUDKi2mERHGlTaHRkj7q87xTwy9ECyq9QQ+nQgJ7jzuF
         xhPM5kZUWHQJyCdp/ezu7v0Cv51C0/uoU8DkQYct4/AJZwrQOjtCE3UGUAXpHlgJTAKN
         rE1WKlwwk+VtN0Cl1f15zbqEEUU4EGuus4f8FbPdCQpTZDJCQ+I36Y8yLzOuEgyaqMWt
         z0eA==
X-Gm-Message-State: AOAM533svh/JvKLdvSu5l24ewVdvFNt2AyT74UnslymxZB+lwWzMq+Jm
        jVBwvrJe5Qj/drWUIf4qKGv1fxHO5OVnfTIa9azEwGfbprJb6gYf7Ij3SjmKd3IeTyLJeJCix1k
        aEOu9wydiOyofMTWjBnNIng==
X-Received: by 2002:a05:600c:1e8e:: with SMTP id be14mr7423362wmb.30.1642408046963;
        Mon, 17 Jan 2022 00:27:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmSkskdohPD3R4PDk0Urfw0voyV4lTR4GN3RTrgxGfrqifw7hI7f7kMWAl75gDkdsEbn4Ksg==
X-Received: by 2002:a05:600c:1e8e:: with SMTP id be14mr7423345wmb.30.1642408046819;
        Mon, 17 Jan 2022 00:27:26 -0800 (PST)
Received: from [192.168.8.100] (tmo-098-68.customers.d1-online.com. [80.187.98.68])
        by smtp.gmail.com with ESMTPSA id p2sm15764709wmg.44.2022.01.17.00.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 00:27:26 -0800 (PST)
Message-ID: <41d23c24-7395-c7a0-047b-03c6abb71020@redhat.com>
Date:   Mon, 17 Jan 2022 09:27:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 05/30] s390/airq: pass more TPI info to airq handlers
Content-Language: en-US
To:     Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, freude@linux.ibm.com,
        pasic@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220114203145.242984-1-mjrosato@linux.ibm.com>
 <20220114203145.242984-6-mjrosato@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220114203145.242984-6-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 14/01/2022 21.31, Matthew Rosato wrote:
> A subsequent patch will introduce an airq handler that requires additional
> TPI information beyond directed vs floating, so pass the entire tpi_info
> structure via the handler.  Only pci actually uses this information today,
> for the other airq handlers this is effectively a no-op.
> 
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   arch/s390/include/asm/airq.h     | 3 ++-
>   arch/s390/kvm/interrupt.c        | 4 +++-
>   arch/s390/pci/pci_irq.c          | 9 +++++++--
>   drivers/s390/cio/airq.c          | 2 +-
>   drivers/s390/cio/qdio_thinint.c  | 6 ++++--
>   drivers/s390/crypto/ap_bus.c     | 9 ++++++---
>   drivers/s390/virtio/virtio_ccw.c | 4 +++-
>   7 files changed, 26 insertions(+), 11 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

