Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670FAC0015E
	for <linux-s390@archiver.kernel.org>; Mon, 24 Jul 2023 08:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjGXIaB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 24 Jul 2023 04:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGXIaA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 24 Jul 2023 04:30:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584F099
        for <linux-s390@vger.kernel.org>; Mon, 24 Jul 2023 01:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690187343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=juUjWpa2JI7RTYhcunGhZz1VwOp9DGNQea7nBpEHlNU=;
        b=KCot501I8LTjV88CKz0jI6uodIp47rRTL8ByWS8+ykBpAEl76nvBtwWWTigbr2p5cDij8A
        YeC9YiZui2JyszmMJ8YECPovmVnklwMuJ4GjBwvZ8e4qadjOc6T04LLKMCRNU7Dbb6BfHS
        RbnnYyf1vG8OiNjvBdLQZQ2dFiz6wZA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-sm6Vk5pZODWa0OYPg76ixQ-1; Mon, 24 Jul 2023 04:29:00 -0400
X-MC-Unique: sm6Vk5pZODWa0OYPg76ixQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b710c5677eso35103601fa.0
        for <linux-s390@vger.kernel.org>; Mon, 24 Jul 2023 01:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690187339; x=1690792139;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=juUjWpa2JI7RTYhcunGhZz1VwOp9DGNQea7nBpEHlNU=;
        b=PZFGJZ9iJEoumg9Hz5K5DTmUOd2sk7/oXHt++FGUDknMIyeQTPjS8UA9q7p2NbNWq/
         y7/xX5LMwkCAXSvrpVBedyLBwKkGXYzLY/iMb5qoqUsxDaLz/UNyY6GXJaXJBx2gxLb4
         Pwn35N72PBYrbahFyDpXLilyv08v1HCgJGGPfr3Xhez6p1SOw/YvvF19idQkztDnzFaL
         WTqRxXhW+BxGjEsIXy2WZlhzFzDWI6W5QjGbZwI/LOaE/6s4tTYa8mQpFZQsmVR6vrGH
         NnPhSfEy8tX9/XF5/W4oOhKHC0TJioayC3Q/kDiakucSxpexdDSVVCPepDl52HlmaBNN
         fSJw==
X-Gm-Message-State: ABy/qLZQSjOMXO0ZCGfwVZCjYhQWN/6xdmjboBpSdV0URbrrUPh3i1Sk
        IaFazwEWM1LeB1kyC14dOmD8VV/ixrOPx/Z/BafJw6A7dco6h4HVw1ur7qqnGozSARCXJJV6jxF
        5eyw936Kq+FKLmgeIRAnnew==
X-Received: by 2002:a2e:9556:0:b0:2b8:3797:84e4 with SMTP id t22-20020a2e9556000000b002b8379784e4mr5537003ljh.18.1690187339032;
        Mon, 24 Jul 2023 01:28:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEPImP9LxpC4V4IiV0Qbz2b0sQNi/ieeqXGoS0C6c6DyTzijmwojb+7Q3nGHs3QwkHU5zCWZg==
X-Received: by 2002:a2e:9556:0:b0:2b8:3797:84e4 with SMTP id t22-20020a2e9556000000b002b8379784e4mr5536993ljh.18.1690187338677;
        Mon, 24 Jul 2023 01:28:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f45:d000:62f2:4df0:704a:e859? (p200300d82f45d00062f24df0704ae859.dip0.t-ipconnect.de. [2003:d8:2f45:d000:62f2:4df0:704a:e859])
        by smtp.gmail.com with ESMTPSA id y19-20020a05600c20d300b003fd2d33f972sm5371895wmm.38.2023.07.24.01.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 01:28:58 -0700 (PDT)
Message-ID: <80ab8ed9-ec6e-2bfa-62d6-da63d98c03e7@redhat.com>
Date:   Mon, 24 Jul 2023 10:28:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/6] KVM: s390: interrupt: Fix single-stepping
 userspace-emulated instructions
Content-Language: en-US
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Freimann <jfreimann@redhat.com>
References: <20230721120046.2262291-1-iii@linux.ibm.com>
 <20230721120046.2262291-5-iii@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230721120046.2262291-5-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

> +		rc = -ENOIOCTLCMD;
> +		break;
>   	}
> -	return -ENOIOCTLCMD;
> +

This really needs a comment. :)

> +	if (!rc)
> +		vcpu->guest_debug &= ~KVM_GUESTDBG_EXIT_PENDING;
> +
> +	return rc;
>   }
>   
>   static int kvm_s390_handle_pv_vcpu_dump(struct kvm_vcpu *vcpu,

-- 
Cheers,

David / dhildenb

