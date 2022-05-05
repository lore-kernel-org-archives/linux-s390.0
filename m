Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA2DC433EF
	for <linux-s390@archiver.kernel.org>; Thu,  5 May 2022 12:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359305AbiEEMuK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 5 May 2022 08:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238479AbiEEMuI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 May 2022 08:50:08 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDE8E4B874
        for <linux-s390@vger.kernel.org>; Thu,  5 May 2022 05:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651754788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6vaRlr/7ULHx6gWuSvnNnjYCo18hzcHoYJDQoD2144Y=;
        b=RlXiVtwzIuSSasclZbDEuYYbJDaeiRODIcJXUWITNsO+ELous0ZMX1cm53bmFB87RXvA3P
        fz7AXq8g1pw9y8+qNLI6exGxrxzz2Ui6PbwRY7l9RZXHzLtVSpx1qeo/i7sARBqUUHr2xi
        rgCsKxkDow1u3HGAF89M9Lw8UsoooEQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-M7fCgU-WPWmPokjt6Dk1kQ-1; Thu, 05 May 2022 08:46:27 -0400
X-MC-Unique: M7fCgU-WPWmPokjt6Dk1kQ-1
Received: by mail-ej1-f70.google.com with SMTP id gn26-20020a1709070d1a00b006f453043956so2546514ejc.15
        for <linux-s390@vger.kernel.org>; Thu, 05 May 2022 05:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=6vaRlr/7ULHx6gWuSvnNnjYCo18hzcHoYJDQoD2144Y=;
        b=kbR1gU9NeronNFR/y8njHty02zqb8yAo+SLCki2dKe72MT/23MxWxn1uZN/2iGwuVY
         f9n69+Ke00edLYwCmWWfu6y3j3K4+QlSOR0zaAeUdfWGL41EAjpOJ/LoPXr3gLEA3pyP
         lK7ynv7k6/B9dBbgUi/xNH2p7UkZhi+afBWa5dOpIFczQUYYj2MJVrn1m34l21rIqnM3
         KUmq25G7639dojsy1dIQ2cj+d4CpIasvq6ub9SlbCGFayHSizUsNEwKIXWpDwhtmrQ0k
         39afqyNGzCGXED+KdkZ+JtbemCwU4y834FEA9S8u1HVwQRrUZxHiNsrnr7Jj1RYMSnhW
         89Pg==
X-Gm-Message-State: AOAM5307X25n0PAPBBHtTOQKccxkR7x02So5vW+5fMwpIeCIFuQUMtzb
        fBWl+UE0Y64cVGKU2u9hd+0DB8rijr/kjjkMyS1ZOxYH8iIqYHNjskI6eW98+h4kOnBcf1NwTaW
        DcDKWIShEcobcZRF4hFZ8PQ==
X-Received: by 2002:a17:907:2d93:b0:6f3:8524:6f92 with SMTP id gt19-20020a1709072d9300b006f385246f92mr26104535ejc.556.1651754785958;
        Thu, 05 May 2022 05:46:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxh0AuoTLb4NtFUKSzSmvuWG14SE3dq6/K9LQkEcxHXLqwacGXBsP3Jh5c8evy8eiZw9cDE4w==
X-Received: by 2002:a17:907:2d93:b0:6f3:8524:6f92 with SMTP id gt19-20020a1709072d9300b006f385246f92mr26104509ejc.556.1651754785685;
        Thu, 05 May 2022 05:46:25 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id c21-20020a056402121500b0042617ba63bdsm776943edw.71.2022.05.05.05.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 05:46:24 -0700 (PDT)
Message-ID: <8342100d-a9f6-2f6d-30d0-b3950661d0c6@redhat.com>
Date:   Thu, 5 May 2022 14:46:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YnPFjuBYZw/dj01U@osiris>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL] s390 updates for 5.18-rc6
In-Reply-To: <YnPFjuBYZw/dj01U@osiris>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 5/5/22 14:39, Heiko Carstens wrote:
> Hi Linus,
> 
> please pull s390 updates for 5.18-rc6. Please note that this pull
> request includes two s390 specific kvm commits, which normally would
> have been routed via the kvm tree.
> 
> Due to lack of other patches in the kvm tree Christian Borntraeger
> asked to get them upstream via the s390 tree:
> https://lore.kernel.org/linux-s390/249d0100-fa58-bf48-b1d2-f28e94c3a5f2@linux.ibm.com/

Needless to say, kvm patches have since materialized and I'll send a 
pull request later this week.

But anyway s390 is the architecture where I expect zero issues if KVM 
patches go in through arch maintainers.  Compared to other 
architectures, there are a lot more points of contact between KVM and 
the rest of arch/s390; you know the KVM code well; and honestly the 
whole architecture is mostly Amharic to me when it comes to the 
privileged interface.

Thanks,

Paolo

