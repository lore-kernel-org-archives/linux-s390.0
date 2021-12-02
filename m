Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B28C433F5
	for <linux-s390@archiver.kernel.org>; Thu,  2 Dec 2021 11:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357017AbhLBL3p (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 2 Dec 2021 06:29:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345845AbhLBL3o (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Dec 2021 06:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638444382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lDz7Gl7O/a6QxEzSyH8lRwP13RtbZV0kax667QfBu/c=;
        b=EF9rm+keEA60ywDxV1dna3wR2KkANUzHGCsw65kDpGAoU6QDqFBXtu+MsjI7HcYu3G4XYg
        XZ1mgKSGuS1GWeGHBNFhN4LGNpGSOZI35q1P4dsnET4TmUKQ8xplT1Z4QqkildXyMaGYJ+
        3aG+dm/ZOfGKWrRFzXHvVhW4vje6L7I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-B89nv0TfOcmnB-VQwK3C6A-1; Thu, 02 Dec 2021 06:26:21 -0500
X-MC-Unique: B89nv0TfOcmnB-VQwK3C6A-1
Received: by mail-wm1-f71.google.com with SMTP id i131-20020a1c3b89000000b00337f92384e0so1529308wma.5
        for <linux-s390@vger.kernel.org>; Thu, 02 Dec 2021 03:26:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=lDz7Gl7O/a6QxEzSyH8lRwP13RtbZV0kax667QfBu/c=;
        b=3D7XLWaIQJMI5FwIgXrfkQgYmkjhvvkIbQUyv13GUB7KwP6qKNcQHGhJYH+3EmkN9m
         c0THIg8rljIJJvJuTnVX8Qo0GX4XikckhnsS2taEigBYj1pulhSihj/5QqfPjJFNzzwI
         45rdfqaBowD0LUJQCfrW/30ny87Blhh0A4cjeowlSBYTZJTD/wUjZULLH5h2pcJ2yTx8
         X1eDAifNRAtJsMF9MnENx1VgMV+kWaLXA8vxsEK6OBJ/G4M2N+pK748XKym1iUvVLMc5
         2Q+XrZeWGU5Gy4MQ8AlZhpyaoGo5XVoPdHxIrfA85kDnJ3G+6UVZn3TwKn0b+tAKY2CA
         E7xA==
X-Gm-Message-State: AOAM532LQkuLJujoruEsnyfctym42fWinyjEcGHc222oCJCMuznMl+P8
        A19DX907Zgt2Bjwp1D4T9S8QfUxMi0ddCvBVWzYERqgd5BW+M/0Dx4LYnkC2uM93cM0Ej1zt9lH
        FeLbmbS2k14/7SQcph18TDQ==
X-Received: by 2002:a05:600c:202:: with SMTP id 2mr5681812wmi.134.1638444380197;
        Thu, 02 Dec 2021 03:26:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxMDm2ZHgmwsMQE5O2JaJyj6R5MG6Z9006cnJBbuG9m6i0+3MgupmDqot5W08j+xUfC3Vawig==
X-Received: by 2002:a05:600c:202:: with SMTP id 2mr5681780wmi.134.1638444379976;
        Thu, 02 Dec 2021 03:26:19 -0800 (PST)
Received: from ?IPV6:2003:d8:2f44:9200:3344:447e:353c:bf0b? (p200300d82f4492003344447e353cbf0b.dip0.t-ipconnect.de. [2003:d8:2f44:9200:3344:447e:353c:bf0b])
        by smtp.gmail.com with ESMTPSA id j11sm2402688wrt.3.2021.12.02.03.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 03:26:19 -0800 (PST)
Message-ID: <ea6ec055-2682-44b1-2aae-20dfcebf9b85@redhat.com>
Date:   Thu, 2 Dec 2021 12:26:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [kvm-unit-tests PATCH v1 2/2] s390x: firq: floating interrupt
 test
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sebastian Mitterle <smitterl@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20211202095843.41162-1-david@redhat.com>
 <20211202095843.41162-3-david@redhat.com>
 <20211202120113.2dd279a8@p-imbrenda>
 <95160439-2aa9-765f-9f06-16952e42a495@redhat.com>
Organization: Red Hat
In-Reply-To: <95160439-2aa9-765f-9f06-16952e42a495@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 02.12.21 12:13, David Hildenbrand wrote:
>>> +static void wait_for_sclp_int(void)
>>> +{
>>> +	/* Enable SCLP interrupts on this CPU only. */
>>> +	ctl_set_bit(0, CTL0_SERVICE_SIGNAL);
>>> +
>>> +	set_flag(1);
>>
>> why not just WRITE_ONCE/READ_ONCE?
> 
> Because I shamelessly copied that from s390x/smp.c ;)

Oh, and also because WRITE_ONCE/READ_ONCE are semantically the wrong
thing to use:

"Prevent the compiler from merging or refetching reads or writes. The
compiler is also forbidden from reordering successive instances of
READ_ONCE and WRITE_ONCE"

We need memory barriers to prevent reordering with surrounding code.

-- 
Thanks,

David / dhildenb

