Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382F0C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 15 Oct 2021 09:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F2760F70
	for <linux-s390@archiver.kernel.org>; Fri, 15 Oct 2021 09:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbhJOJKL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 15 Oct 2021 05:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236166AbhJOJKK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Oct 2021 05:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634288883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hJqXmdMFj3XAcDTBzK//awAGj1JnVHCl7MMIlwOu05Y=;
        b=PNUmbxVmxYPWDk91XU40uZ8jiGV7z1SF24fMlJmdEh2gDC8Cuqm4i8ekL1vAfolKMuC5Y3
        KWVZDWsyOARF3mnrIq+uGwerTMOeQWM1gkiD3Nhb3oZ9d0mIqXEW23WBB47nTq0EKz4EeO
        OBZnhsRhyXjsBZs1DNuPKY1BcY9FcFA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-vezRihlEN9i99gyWR5dM7Q-1; Fri, 15 Oct 2021 05:08:00 -0400
X-MC-Unique: vezRihlEN9i99gyWR5dM7Q-1
Received: by mail-ed1-f70.google.com with SMTP id c25-20020a056402143900b003dc19782ea8so4129142edx.3
        for <linux-s390@vger.kernel.org>; Fri, 15 Oct 2021 02:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hJqXmdMFj3XAcDTBzK//awAGj1JnVHCl7MMIlwOu05Y=;
        b=bZ2QQjA+Ao74PMgQdkFrAan29L8IgSLELc4k8EqCwT8luCSvTJg9tLSaGpEE2X1PG1
         MDlTeyiAKPxbiSNxZoBx4PNv6M8A92nYsZuFGyDshOjVTeID5hmhH61lTWeKmhho/6P6
         JlVra0WEkaaV/gjIgmpJpr/Gcer48btgO4zLS/ZQ61XdeibTCGxDbpPUbra5cxTakGuM
         dTL0J6AJKhxx0WU3GID/RhmUpFoa3GNrKbQN4JDRyw/325x/UQ5ER87rZpnLQpGry63W
         h36Y6j5dG+VVRotpavBnTNrScGZhgWSFYv6uLoyqRYKg9ZKNpAnij1ch8cF4QX8DpqpY
         pNKw==
X-Gm-Message-State: AOAM5330Vdv65/Aw7t6/JUPBfnbhcb5c11P5/eloFXWmxsrT3F68um35
        84BNr1DyYXboSk+LlVdcWzMwFmue5NnK90mjO4kDwKqQvp4brwup5e3dlGkQqE8c5kQZbokPkfk
        +Y102Tcj05Enrlrl2mNjXAQ==
X-Received: by 2002:a17:906:7113:: with SMTP id x19mr5489024ejj.557.1634288879251;
        Fri, 15 Oct 2021 02:07:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMPJOeGYgYVhEVPIYGY8hDGQ/Y5o3fYULf44dGpiwY5cIXIHynpZokIe5BfdDi1RZ1oSkyzg==
X-Received: by 2002:a17:906:7113:: with SMTP id x19mr5489003ejj.557.1634288879004;
        Fri, 15 Oct 2021 02:07:59 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id dt4sm3616006ejb.27.2021.10.15.02.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 02:07:58 -0700 (PDT)
Message-ID: <5ca4405e-e2a8-a940-1c5f-e3a78894d337@redhat.com>
Date:   Fri, 15 Oct 2021 11:07:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] KVM: kvm_stat: do not show halt_wait_ns
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Stefan Raspl <raspl@de.ibm.com>
References: <20211006121724.4154-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211006121724.4154-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 06/10/21 14:17, Christian Borntraeger wrote:
> Similar to commit 111d0bda8eeb ("tools/kvm_stat: Exempt time-based
> counters"), we should not show timer values in kvm_stat. Remove the new
> halt_wait_ns.
> 
> Fixes: 87bcc5fa092f ("KVM: stats: Add halt_wait_ns stats for all architectures")
> Cc: Jing Zhang <jingzhangos@google.com>
> Cc: Stefan Raspl <raspl@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>   tools/kvm/kvm_stat/kvm_stat | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/kvm/kvm_stat/kvm_stat b/tools/kvm/kvm_stat/kvm_stat
> index b0bf56c5f120..5a5bd74f55bd 100755
> --- a/tools/kvm/kvm_stat/kvm_stat
> +++ b/tools/kvm/kvm_stat/kvm_stat
> @@ -742,7 +742,7 @@ class DebugfsProvider(Provider):
>           The fields are all available KVM debugfs files
>   
>           """
> -        exempt_list = ['halt_poll_fail_ns', 'halt_poll_success_ns']
> +        exempt_list = ['halt_poll_fail_ns', 'halt_poll_success_ns', 'halt_wait_ns']
>           fields = [field for field in self.walkdir(PATH_DEBUGFS_KVM)[2]
>                     if field not in exempt_list]
>   
> 

Applied, thanks.

Paolo

