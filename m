Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FA8C433EF
	for <linux-s390@archiver.kernel.org>; Wed,  9 Feb 2022 13:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiBINQ5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Feb 2022 08:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbiBINQz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Feb 2022 08:16:55 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58EAC05CBBA
        for <linux-s390@vger.kernel.org>; Wed,  9 Feb 2022 05:16:57 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id x5so1671281qtw.10
        for <linux-s390@vger.kernel.org>; Wed, 09 Feb 2022 05:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=00zXVWqiIIWmqW86EePr+9PjPrQ814Ku4hB+RmWAzVE=;
        b=O6jcEE5sfFGLsdLvyVYmVvv0eI3/ZISLBScADt5gl3GCiZr4XJsUbvKdbByPitU8aX
         Xz10avwmXHoXXdNfaBWfCGb2KW90KGZtbURff0EfNlIPOvnTkFp+kknDz8eQrNJg2mIh
         sK9bINFCmj0UfTLPFKbxdYFDeZIygmZ9Hh+3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=00zXVWqiIIWmqW86EePr+9PjPrQ814Ku4hB+RmWAzVE=;
        b=y38HYLV+wcE4v662KfC48Jk28zSBlYxNW1QalGu/OvZt8Rg/ED/T7GLSzxeYGycl1n
         wADeqv3flZ6ZaVHIeg2+ju+Xh70GKOYlgxLYWeibhwSMGhedKEJJalL7sCs2/40Dqh5M
         JyJZqHaecNcyXRbwdzKZisphmpflvDBhZptolpMpOx0Ek+t+00rNCNMhsxSPDE2PfPZU
         edI8TYye3CBt/z3lXyRPMIlvoixThf3jLRJRfinjgkvmRtPAn+cfrbTypqfJb6gTLpP4
         BAM4N6xI56Q9BFzdQl9ao0RqQdcx+BS7MLcXyY5rYugXi3VOc9YD9QlfaPFZj+eNh0vw
         ZGyw==
X-Gm-Message-State: AOAM531ZD8gXDMCJux+lNbTiaThHIOzf9JffL6C5H5dml2FeTfdX+fFQ
        aqn13AmavlFIJs1Cbgjjw7wBKg==
X-Google-Smtp-Source: ABdhPJyGbmCVNJq7whVXntybKDMHFLHfJgy5dnYQpVdbz5i7W2IQdFcQ6DMilTc6vOjw3UAE86GmZQ==
X-Received: by 2002:ac8:7f0a:: with SMTP id f10mr1244788qtk.619.1644412616806;
        Wed, 09 Feb 2022 05:16:56 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-127.dsl.bell.ca. [216.209.220.127])
        by smtp.gmail.com with ESMTPSA id k20sm9071209qtx.64.2022.02.09.05.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 05:16:56 -0800 (PST)
Date:   Wed, 9 Feb 2022 08:16:54 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 05/11] KVM: s390: Add optional storage key checking to
 MEMOP IOCTL
Message-ID: <20220209131654.7txhwrax322rjje2@meerkat.local>
References: <20220207165930.1608621-1-scgl@linux.ibm.com>
 <20220207165930.1608621-6-scgl@linux.ibm.com>
 <48d1678f-746c-dab6-5ec3-56397277f752@linux.ibm.com>
 <71f07914-d0b2-e98b-22b2-bc05f04df2da@linux.ibm.com>
 <6ea27647-fbbe-3962-03a0-8ca5340fc7fd@linux.ibm.com>
 <29ac0e5c-f77b-04b2-bbf5-cf5a5ca78921@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29ac0e5c-f77b-04b2-bbf5-cf5a5ca78921@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Feb 09, 2022 at 10:34:19AM +0100, Christian Borntraeger wrote:
> CC Konstantin,
> 
> I hope you can find the right people. Looks that my (and Janis) emaildid not make it to linux-s390 and kvm at vger lists.
> Message-ID: <6ea27647-fbbe-3962-03a0-8ca5340fc7fd@linux.ibm.com>

I see it in the archives, though:
https://lore.kernel.org/linux-s390/6ea27647-fbbe-3962-03a0-8ca5340fc7fd@linux.ibm.com
https://lore.kernel.org/kvm/6ea27647-fbbe-3962-03a0-8ca5340fc7fd@linux.ibm.com

Perhaps it was just delayed?

-K
