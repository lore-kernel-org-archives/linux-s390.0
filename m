Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22C4C433FE
	for <linux-s390@archiver.kernel.org>; Tue, 21 Dec 2021 18:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbhLUSlL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 21 Dec 2021 13:41:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241405AbhLUSlK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Dec 2021 13:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640112070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OuXvMVBgPkcC4bssaqxCL8o/Urd9sxPp4kAV+3sZ2Pw=;
        b=jEEwqMuG5yE5DfFD5E3XrVkyCCty06NJfdl4PKiEjGRv2xYDxQQ+EDZz87LlqKpY2sQYv2
        kHSNFj7Fpn6xZZgiWhvTISvI+uqjZIhj8CeY1iXXokru1JJXrZWZL6QCahNjtCKIcrrZS+
        g9NP+2K0nfD3P8Ghpa2lF5u+Y2Upieo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-pWSFUIV8P3eEAUgyidlt-Q-1; Tue, 21 Dec 2021 13:41:08 -0500
X-MC-Unique: pWSFUIV8P3eEAUgyidlt-Q-1
Received: by mail-wm1-f71.google.com with SMTP id v62-20020a1cac41000000b0033719a1a714so3098431wme.6
        for <linux-s390@vger.kernel.org>; Tue, 21 Dec 2021 10:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OuXvMVBgPkcC4bssaqxCL8o/Urd9sxPp4kAV+3sZ2Pw=;
        b=H4nl8z8wEONYM6lpe/hl4SkiskDBqJczCh6dFJ9fdAqrFBxdyRd2181DNRMIYzo9t2
         sWK/E869rLerq2rXovRQB7wlxCImey4Wq8rR35HFQ8w1qYeZaFVg6Su8+it4HdQMnOmk
         NcTpLV3QQcw7y6YkVRZ60oQcupkt3uPSKkGzH1H1vufUYWSFHamtdS6gvZsmhT9YleOE
         A+bnaPuSpiTN66Gf9AqdWMg+rQ8BkGuaWMAQUEWQpkxr3wc+HoP2aECRkC/wqdQ0ERqn
         dfVOC5oFxaACWf2j2AxnVHFfMC4aNJSdVpluxyt4C5imHmq3gn0hbwmpf6J+AjA8b0U8
         91UQ==
X-Gm-Message-State: AOAM531DbosvGxVCo7esTO0KkWyuQmQ6OT+ABKDFoMRevKqT8JG4XQ51
        1BG1SAcUMGwRZGX/b2TX9USP83vfMJ3Fz4YfNTtsqpSTV0iIxzESClDoez/hbp9QFqJCHR9h1hq
        aOUo40amjG7lOFoJmor8dgA==
X-Received: by 2002:a1c:cc0f:: with SMTP id h15mr3843005wmb.38.1640112067178;
        Tue, 21 Dec 2021 10:41:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhXc12lA864aBzj2Wv1/GXJ/rJfU4ohEmYhTErGNpZGU1SI/y93362YUwUd3TySNWCEvujVQ==
X-Received: by 2002:a1c:cc0f:: with SMTP id h15mr3842987wmb.38.1640112066960;
        Tue, 21 Dec 2021 10:41:06 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id p18sm5514695wmq.0.2021.12.21.10.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 10:41:06 -0800 (PST)
Message-ID: <be53a3f3-071a-f309-a1be-00d893dee470@redhat.com>
Date:   Tue, 21 Dec 2021 19:41:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [GIT PULL 0/6] KVM: s390: Fix and cleanup for 5.17
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>
References: <20211220181104.595009-1-borntraeger@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211220181104.595009-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12/20/21 19:10, Christian Borntraeger wrote:
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.17-1

Pulled, thanks.

Paolo

