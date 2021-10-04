Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09529C433F5
	for <linux-s390@archiver.kernel.org>; Mon,  4 Oct 2021 07:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E658D61360
	for <linux-s390@archiver.kernel.org>; Mon,  4 Oct 2021 07:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhJDIAw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 4 Oct 2021 04:00:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49190 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229609AbhJDIAv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Oct 2021 04:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633334342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JWKzHhBNVWSFAM9ozeumGeLFGzAACD+GMCb+b6UXpM0=;
        b=du2hzf5aH6GeyBA180sTXgdTHczUj/Yu5uQLkY7+rFadm5gRbThjO4sVmqGSFSoCEOlZKN
        /np7o6BJ3YDCR9EA1HkXn99M4jgQ5okiOxUcIPh3rKwAsDeN9XwsSPznhGJAFnMIW5jeH2
        69/ByBKORMPx3U/foTVS5WEUZgwqaDo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-xg34amb-P2udAR39CNIuTQ-1; Mon, 04 Oct 2021 03:59:01 -0400
X-MC-Unique: xg34amb-P2udAR39CNIuTQ-1
Received: by mail-ed1-f69.google.com with SMTP id k2-20020a50ce42000000b003dadf140b15so4651574edj.19
        for <linux-s390@vger.kernel.org>; Mon, 04 Oct 2021 00:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JWKzHhBNVWSFAM9ozeumGeLFGzAACD+GMCb+b6UXpM0=;
        b=buAo215m4XacEbu17Tmv2rlfsZ1P+yHVKx2Bx4I4NJXwOEJ9ds6bLL9H47OcHdz9Zg
         QxAGFtgj1wwLb3mysU7JKx0s4ga6ntj6NgLdl7d0oGpFqy13uTKoLx38wBl/FhL3Tn1O
         UtBl+4KE9HvZUpGfi/IzG5dhNoqp9N9YMUIQfythwLtye09bLTo1kcrIgI3lCORpxn4c
         0hYr+JefVhvtJAydcq7ALKWzEsBLrKk2/1iIBfUMPj2xCitFapJyl+tb/COUGYD+Uxf5
         BYL+Nco2n68RUZSZoEDSpbhhmFV4Ud8vvtKeewNvqmnW9++HiD5po8UEnQqXpTT/s8pu
         jECQ==
X-Gm-Message-State: AOAM532cSYIfQfKLxcUjwAiQ0LMxUrMCigYGzvQYv2rYKP6h0rGIu67k
        MmeoaLCQv02diFbDSltygRH9tfWpJ2wqa9MxcZMb8Qv4aL1ij6qzpWKFNfCZsBoGZ+UrrNi1FFI
        NfSApPBVH8G7IGTfVkfYD7w==
X-Received: by 2002:aa7:c911:: with SMTP id b17mr7041838edt.5.1633334340160;
        Mon, 04 Oct 2021 00:59:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzz4OR73zDiy9DChgDRER5fiNhRZ8aL0vtSC9rUlUA4MiSMjlQA7FTEerKyTi4bzfUJP4G0Lw==
X-Received: by 2002:aa7:c911:: with SMTP id b17mr7041828edt.5.1633334340004;
        Mon, 04 Oct 2021 00:59:00 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id g9sm6224244ejo.60.2021.10.04.00.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 00:58:59 -0700 (PDT)
Message-ID: <4e940025-bca2-c694-ff36-e3d0fe0dd304@redhat.com>
Date:   Mon, 4 Oct 2021 09:58:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [GIT PULL 0/1] KVM: s390: allow to compile without warning with
 W=1
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210930125440.22777-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20210930125440.22777-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 30/09/21 14:54, Christian Borntraeger wrote:
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.15-1

Pulled, thanks!

Paolo

