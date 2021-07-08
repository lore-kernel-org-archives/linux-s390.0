Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A729AC07E96
	for <linux-s390@archiver.kernel.org>; Thu,  8 Jul 2021 17:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9065761606
	for <linux-s390@archiver.kernel.org>; Thu,  8 Jul 2021 17:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhGHREb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 8 Jul 2021 13:04:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229469AbhGHREa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Jul 2021 13:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625763708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qrTw81pAWG02uTbPb7XSSF4Zb1NaxCpE5fYNmmLl5pU=;
        b=M9ppLJYDetXbse+Aw8sevBjyc9KGwAf01JXaHk7C/W3IbbCaD4Mct5/mbzfZTz+dr0WHZh
        /UswW9rAqHRxRSRoPahdXMRJTR3zsh36icxkQEYc7qh9U1Tio0jQiC+2/hYDdESFmrvvN+
        1mipZ3GeLbljrSdojNp+w3gVIkvsDKg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-3aFU4YRiMzq9W2mThObTSQ-1; Thu, 08 Jul 2021 13:01:47 -0400
X-MC-Unique: 3aFU4YRiMzq9W2mThObTSQ-1
Received: by mail-ed1-f70.google.com with SMTP id bx13-20020a0564020b4db02903a02214fad8so1472923edb.1
        for <linux-s390@vger.kernel.org>; Thu, 08 Jul 2021 10:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qrTw81pAWG02uTbPb7XSSF4Zb1NaxCpE5fYNmmLl5pU=;
        b=VESw4P1olXxMXkfWUT+UM3w9Iox6f4ge71faS0lj42FpUb6M9UWYg09SBpb0Ci6XH3
         YHcVwAV6Iql0pUOuZEIM8YrxbDaISpsqM8rR16EuLZehkvmaQdbPJCuFxmzLdJHtGPXQ
         8gtJ6E91NTJYDDSSLcMHuL2HQ3/FUF9mNr/LMZHwiF8XmJPpeiLCPNt3JckfsBg9dU86
         cB6kO6e/Gx+5xhNFS8orL20MGuwNFFl5TijO+Ln02JgnjcXfCz2NPbg4F0cuLTCB2e9Z
         iZF+ULdOveSs/9kGWPsRSC8yF59p+2kJ/bIRd6GaQbHeHQuzwMYcj8HdobTGLxNanI8r
         kYmQ==
X-Gm-Message-State: AOAM532itowhwXkpc1RYCoxij382NAgw7qX1pJlhGZgnSXR+4P4sfQH6
        InxN8xrDbGfUnKHJtW1SF0dDuSM0fOQRmZRx9ZTU2yrOCcQujAL5RH44uuJhqxhUyG1HqzzCWUh
        JDLv9QY1dthU2Vci3b9DLBw==
X-Received: by 2002:aa7:d84a:: with SMTP id f10mr5208307eds.45.1625763706077;
        Thu, 08 Jul 2021 10:01:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTIJoVBFYN0UNaZ4TmCId++KAC/jy/ikyGen2oMBIt7ifi7GkPOYCPc1N8fllDzrANAf21Pg==
X-Received: by 2002:aa7:d84a:: with SMTP id f10mr5208290eds.45.1625763705950;
        Thu, 08 Jul 2021 10:01:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id jl10sm1231007ejc.56.2021.07.08.10.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 10:01:45 -0700 (PDT)
Subject: Re: [GIT PULL 0/2] KVM: selftests: Fixes for 5.14
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210706083626.10941-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d23a0180-8560-b50d-6dfe-17ee24400794@redhat.com>
Date:   Thu, 8 Jul 2021 19:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706083626.10941-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 06/07/21 10:36, Christian Borntraeger wrote:
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.14-1

Pulled, thanks.

Paolo

