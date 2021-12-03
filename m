Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3CFC433F5
	for <linux-s390@archiver.kernel.org>; Fri,  3 Dec 2021 18:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239904AbhLCS1R (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 3 Dec 2021 13:27:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47525 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353156AbhLCS1R (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Dec 2021 13:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638555832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+pDRF6cB/sJYqT3IVxVNty7bhBqHG6OavKQCuyOln1c=;
        b=goVZ+iGALXcpwdynP7ar3el/lqdfANmJiACVwQ8/czXStG5mI8N6cVEZehgWEzACcULNjI
        bQ4dU6e1vRaDefKA41WUAwsqKbmdlyGdyyWsu8dtLHewh+ZkYKgVx/T1gww/sQte1hi4bh
        ueKK4G/GBW4WwmK9w1pKAwfq3Wlfnt8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-366-gk4i1hZmOiSuK0bAJKH4gg-1; Fri, 03 Dec 2021 13:23:51 -0500
X-MC-Unique: gk4i1hZmOiSuK0bAJKH4gg-1
Received: by mail-wm1-f69.google.com with SMTP id v62-20020a1cac41000000b0033719a1a714so1898949wme.6
        for <linux-s390@vger.kernel.org>; Fri, 03 Dec 2021 10:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=+pDRF6cB/sJYqT3IVxVNty7bhBqHG6OavKQCuyOln1c=;
        b=VaQnpMHe1RizVbiuXQOreap8WmjWIA2WIpBm6/C1Xdkv6cN9sk8eLytqUxxPNEnEEg
         yYowe4BKDoaCURxsW7tQmXUIwrTF2NcvgLay8zwpaBKzuN4djjMJmazCEqCiMaZTPv7x
         s1TNbnan1KFY052VmdiJOAnixkiJmGpyntxmKxxHFFXrtpyEA6skmWGpRudT1j3Jc65/
         FZjfZIBSHXhtnLx+/NK5bZ66aP6oTyR8RP9bmgAoXQ8T7XC0Wp6u7dEs0cM+ZKJ/UJIi
         C59bkUx5WvPXep6YiuSjqGXGCtPjnipCQQmZpcofrPN6sGkzMGiV5MsKbgw+N4zB6Zsm
         gHMQ==
X-Gm-Message-State: AOAM532wSTlR1ezJ6oJ6VVUcpDGGpypK30GngFXGrR5OBdJdUeD3sCLi
        Bn++3z/7jnG0Kwp7vbB+IkHl5PcVlplJlrvQ4wdLZs/dYfP0sJw1BWqm68mMHQYWQbZ1v7PBqL5
        0HP2S3D753UkY465FcEdWZg==
X-Received: by 2002:a5d:4582:: with SMTP id p2mr24037417wrq.364.1638555829755;
        Fri, 03 Dec 2021 10:23:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgScVm0ahMVeJknlG/nTGbRtlc3XM/r81Rluu/t0OC1lqum52WQQbqlBgeB6XwI6AMbOKslg==
X-Received: by 2002:a5d:4582:: with SMTP id p2mr24037392wrq.364.1638555829571;
        Fri, 03 Dec 2021 10:23:49 -0800 (PST)
Received: from ?IPV6:2003:d8:2f44:9200:3344:447e:353c:bf0b? (p200300d82f4492003344447e353cbf0b.dip0.t-ipconnect.de. [2003:d8:2f44:9200:3344:447e:353c:bf0b])
        by smtp.gmail.com with ESMTPSA id g124sm5652832wme.28.2021.12.03.10.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 10:23:48 -0800 (PST)
Message-ID: <fa95d6e6-27be-7abf-7b1e-bb6bb9d62214@redhat.com>
Date:   Fri, 3 Dec 2021 19:23:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [kvm-unit-tests PATCH v2 2/2] s390x: firq: floating interrupt
 test
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>
Cc:     kvm@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sebastian Mitterle <smitterl@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20211202123553.96412-1-david@redhat.com>
 <20211202123553.96412-3-david@redhat.com>
 <11f0ff2f-2bae-0f1b-753f-b0e9dc24b345@redhat.com>
 <20211203121819.145696b0@p-imbrenda>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211203121819.145696b0@p-imbrenda>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


>>> +	if (smp_query_num_cpus() < 3) {
>>> +		report_skip("need at least 3 CPUs for this test");
>>> +		goto out;
>>> +	}
>>> +
>>> +	if (stap()) {
>>> +		report_skip("need to start on CPU #0");
>>> +		goto out;
>>> +	}  
>>
>> I think I'd rather turn this into an assert() instead ... no strong opinion 
>> about it, though.
> 
> I agree, including the part about no strong opinions (which is why I
> did not comment on it before)

Would it be the case on any system we might end up running, even under
LPAR ... and whoever could run these tests ?

> 
>>
>>> +
>>> +	/*
>>> +	 * We want CPU #2 to be stopped. This should be the case at this
>>> +	 * point, however, we want to sense if it even exists as well.
>>> +	 */
>>> +	ret = smp_cpu_stop(2);
>>> +	if (ret) {
>>> +		report_skip("CPU #2 not found");  
>>
>> Since you already queried for the availablity of at least 3 CPUs above, I 
>> think you could turn this into a report_fail() instead?
> 
> either that or an assert, but again, no strong opinions
> 

Just because there are >= 3 CPUs doesn't imply that CPU #2 is around.

What we could remove is the "if (smp_query_num_cpus() < 3) {" check, though!

Thanks!

-- 
Thanks,

David / dhildenb

