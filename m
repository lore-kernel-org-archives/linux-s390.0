Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406C8C433FE
	for <linux-s390@archiver.kernel.org>; Thu, 13 Jan 2022 14:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbiAMOga (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 13 Jan 2022 09:36:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56306 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235686AbiAMOgY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Jan 2022 09:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642084583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IgjOVeBDkVjVu0DqCL0W103eS8yEjSifpQfplyuzn/Y=;
        b=ZaiwGDdWfZwx8JltNgxB4A2UMy8N76VWQtN7baQlWzNcfo6gpXTV64Wy2Yykg0ZtkJNsbt
        LbYmtu7TAqRGFRqivv4HQRyc7jeQFG7uGu51YIqkggt/aooYmFrw652Gyd5ewm0BWN31t2
        mYodJDSDE65AkEX2sUzQqut3hieKiIw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-lzjnX6pqO5qbjJJ77uISZA-1; Thu, 13 Jan 2022 09:36:20 -0500
X-MC-Unique: lzjnX6pqO5qbjJJ77uISZA-1
Received: by mail-ed1-f69.google.com with SMTP id t1-20020a056402524100b003f8500f6e35so5545330edd.8
        for <linux-s390@vger.kernel.org>; Thu, 13 Jan 2022 06:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IgjOVeBDkVjVu0DqCL0W103eS8yEjSifpQfplyuzn/Y=;
        b=39lNHxrk0/7+60zUC8f1yebxUci38UDcxCJFMwIWiTeYO92ke9/wDnZRIfy6IjwAqB
         wWrQ9vPPg9fLNY/LCgXFtFsizcSxMpjEKPRKZuySJn7KZmXseziInArvQhF6866N/f20
         GlFKLz81Yp5nxBVZDT5UF00JJck5JCqyYqy2uswLnUdGbwYVhqez96pWBc6ZBrU5Qkt0
         7Xh2fO/oGmfC8tKH4kw5/R2ygOLPQeEUut7t8bU01LvpmgS/J/DGFbyXvdsCrkF89wwo
         ycrg0319wOY0r/LJ3+q/vhwW/1TL5w/rLo2yjhCpGhaP8Oi/KTl7FlJSojZXPh/qPZNx
         gCgA==
X-Gm-Message-State: AOAM532t2VDkNVubpFPCkp62C/HbXVH7DzkTYFEjvLeZci0bzQinJhhb
        J+1sAZEQ9rYBhVcut1mbO3b8DNbp5RlP9mw4OHJti4l0ytD0wWQswqirhP3Z2qt24/1YtAPVD+C
        JQyjKCKv3rhAEW/v5lsH+4Q==
X-Received: by 2002:a17:907:6e0c:: with SMTP id sd12mr3795824ejc.536.1642084578972;
        Thu, 13 Jan 2022 06:36:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOD4ZuNaqfWJsHOyQAzWBVTLHAz0c77AXhRgw1f3/AHOJfF9Qynw12hmuu+NaWD8zPJOqGKw==
X-Received: by 2002:a17:907:6e0c:: with SMTP id sd12mr3795799ejc.536.1642084578695;
        Thu, 13 Jan 2022 06:36:18 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id gb35sm941164ejc.36.2022.01.13.06.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 06:36:17 -0800 (PST)
Message-ID: <bdad7add-408f-e649-c796-6f83420077fc@redhat.com>
Date:   Thu, 13 Jan 2022 15:36:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: KVM: Warn if mark_page_dirty() is called without an active vCPU
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     butterflyhuangxx@gmail.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanjc@google.com,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <e8f40b8765f2feefb653d8a67e487818f66581aa.camel@infradead.org>
 <20220113120609.736701-1-borntraeger@linux.ibm.com>
 <e9e5521d-21e5-8f6f-902c-17b0516b9839@redhat.com>
 <b6d9785d769f98da0b057fac643b0f088e346a94.camel@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <b6d9785d769f98da0b057fac643b0f088e346a94.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 1/13/22 13:30, David Woodhouse wrote:
> Are you proposing that as an officially documented part of the already
> horrid API, or a temporary measure:)

Hopefully temporary, but honestly you never know how these things go.

Paolo

