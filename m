Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB348C433F5
	for <linux-s390@archiver.kernel.org>; Thu, 10 Feb 2022 09:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbiBJJFy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:05:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238175AbiBJJFy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Feb 2022 04:05:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEC77103B
        for <linux-s390@vger.kernel.org>; Thu, 10 Feb 2022 01:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644483950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+VOVU28uEg+VeYFn6fPIKbXayXxxCm00kEtsj2qS9E4=;
        b=jTp/p23Vv5gUusgY0y92mjkw2uNRRDuHI2KrQ97hGpcw8ZW+qUut7TAcITyvjOjV6EmEox
        niRN459RkffzJWvA93ytB1rj98XSweSDHQ4X/YKjjXU7dm2VzW1HsXCaTGRcYbIFno1nAA
        jq5v5N1kQ0w1fg+3gGxx0XlEeB14vpM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-vH3iUPZpPxu550QFhO_nmA-1; Thu, 10 Feb 2022 04:05:49 -0500
X-MC-Unique: vH3iUPZpPxu550QFhO_nmA-1
Received: by mail-wm1-f70.google.com with SMTP id w5-20020a1cf605000000b00354d2d83490so537535wmc.4
        for <linux-s390@vger.kernel.org>; Thu, 10 Feb 2022 01:05:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+VOVU28uEg+VeYFn6fPIKbXayXxxCm00kEtsj2qS9E4=;
        b=6wq0krz7PX6NU9HJj45GA17A7PCUeflziLi+PbvXoKBeKPlfKD1uu8lJZAGTPyAGbL
         IfpoUwH2zJpeQl2TTibz1Ak0c4ZAUUipb21KmV1mOvWPPf4QHJgnE2MpT6Tqt69F0hT/
         GTbhHyhS2L6PoznFIzr62Va5CcV2CtvPoa/gmjuBhyFKSSZYINObZ5Vj8lg38inZWtLb
         Nckhea2Ly3sm5MYThsM265dFsIk+IboEjcs3z8cPYPPGiRnnxmDMQUnWYraEeV1Z6osB
         jfd/PTygyz5r1Y7cRb4rtMkDpO2cttmyaldPMoEAzrr9yDXCF6y+Lcvbs2sgfaFJt9Bx
         8DSg==
X-Gm-Message-State: AOAM533b8ioJ8uYsT+/3uBVyFxcdFh7rgdo1E7WWFdP0i3snZgBvECGl
        tOLG1on17fFhjdb7o4PZdMgP9Nk2V0K6LQPqg8D4jnbE48nlYKBY4WS5g/oqwhreIPQcOUwE7uD
        p3S7JAEr9t+VgrdJe878AUA==
X-Received: by 2002:a5d:5850:: with SMTP id i16mr5437640wrf.519.1644483948446;
        Thu, 10 Feb 2022 01:05:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwyBtzTD1Ovs/rO1vUFtla6MQxgaKntQcwkuH+mF+pA1KP5W/+ccgvohdnShFgAliAOSiAYnw==
X-Received: by 2002:a5d:5850:: with SMTP id i16mr5437623wrf.519.1644483948255;
        Thu, 10 Feb 2022 01:05:48 -0800 (PST)
Received: from [192.168.8.104] (tmo-098-218.customers.d1-online.com. [80.187.98.218])
        by smtp.gmail.com with ESMTPSA id t1sm22134179wre.45.2022.02.10.01.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 01:05:47 -0800 (PST)
Message-ID: <4281a418-317d-cfd5-3446-edb7c720d761@redhat.com>
Date:   Thu, 10 Feb 2022 10:05:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] KVM: s390: MAINTAINERS: promote Claudio Imbrenda
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20220210085310.26388-1-borntraeger@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220210085310.26388-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/02/2022 09.53, Christian Borntraeger wrote:
> Claudio has volunteered to be more involved in the maintainership of
> s390 KVM.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f41088418aae..cde32aebb6ef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10548,8 +10548,8 @@ F:	arch/riscv/kvm/
>   KERNEL VIRTUAL MACHINE for s390 (KVM/s390)
>   M:	Christian Borntraeger <borntraeger@linux.ibm.com>
>   M:	Janosch Frank <frankja@linux.ibm.com>
> +M:	Claudio Imbrenda <imbrenda@linux.ibm.com>
>   R:	David Hildenbrand <david@redhat.com>
> -R:	Claudio Imbrenda <imbrenda@linux.ibm.com>
>   L:	kvm@vger.kernel.org
>   S:	Supported
>   W:	http://www.ibm.com/developerworks/linux/linux390/

Reviewed-by: Thomas Huth <thuth@redhat.com>

