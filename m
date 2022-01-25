Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4363C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 25 Jan 2022 16:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1585840AbiAYQpJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 Jan 2022 11:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1585458AbiAYQmm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 25 Jan 2022 11:42:42 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9C8C06173B
        for <linux-s390@vger.kernel.org>; Tue, 25 Jan 2022 08:42:41 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id e16so9399459pgn.4
        for <linux-s390@vger.kernel.org>; Tue, 25 Jan 2022 08:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fe5Frex5F9qhKyeczM1uiiIIUViquqjIs4vha32Vn+U=;
        b=IFhUkK5zhjB/3ZpVSjkQPBf3ZR/YNIIvZAEdqCubNe8G6IRzY4l36jM8pE0+cZCVbe
         zaefomdrOSEZj7BnXgebyoc2qGPFb0GJXEqoCc0O1umTnWMHGH0LuafU//4thLFYfYLu
         qutuOdS4jMxCLx+VhfuLOXBjnh/aTlAd8en48LDxT+Sv0jkQTb7b5bJwdBqasEKHtFcP
         XPxSCXri/KTiqME3A1B06jywbHtdericVwdDAYp+/4Rm66eAQwNZx0gN3ogQzfX2Ywz9
         Z6T7+Ab1i06poPkAKvnNJOHA8N9ovKKaE9uHehbIKgdqeE9TMF2BKHlQ3Rla7Yi9NXO6
         Dmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fe5Frex5F9qhKyeczM1uiiIIUViquqjIs4vha32Vn+U=;
        b=mZxls5Q8IV4VgIVOsZOiNFKoqH8su2UoSsLIMHTMfylbc86d/PvedMAG6iDLkQGSoV
         E6qnS2YivhhDUqJGpC19/PQ0zT2wenmUIDvqoUHklTaW4p0plM20NdFJtVlWnIQt9erQ
         GsCHM0ooDB883FHyhGDwoct8DdZWgq1z10gwItBBqZ3ZwJfAtGY+uUvWdgcEWrQw3Q3C
         k4yoozwfwadZvD/KBd6jST2WXU+4J2yB8OXkhCd935YL/fFnVnLubGVMIxVJHrfX+53z
         bj/dP/PFNs2x3cTsV4IjYFJtcgu+SIVID4cb3qsjcz9K+yZQvBMQCAGGQdfm3V/Y6vsk
         IltA==
X-Gm-Message-State: AOAM5324rrlyVU7DhHuTyNTj4MwLnJl2xfEooI2Fxu6hhxHeSpDhryz4
        E5tKboezJNbDBFiYvQuASFg=
X-Google-Smtp-Source: ABdhPJwBYNdpbgg4JoKg5iAbSSEIU2CbUZeZyMJ7mfYsH+dezL6ygYmoHV4QKqYR9jQCia3MRs28EA==
X-Received: by 2002:a05:6a00:174c:b0:4c9:e7ee:87b8 with SMTP id j12-20020a056a00174c00b004c9e7ee87b8mr7785962pfc.28.1643128961357;
        Tue, 25 Jan 2022 08:42:41 -0800 (PST)
Received: from [192.168.1.33] (154.red-83-50-83.dynamicip.rima-tde.net. [83.50.83.154])
        by smtp.gmail.com with ESMTPSA id h13sm21747117pfv.16.2022.01.25.08.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 08:42:41 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= 
        <philippe.mathieu.daude@gmail.com>
Message-ID: <daa1cb44-e089-7aa3-b34c-52090076f840@amsat.org>
Date:   Tue, 25 Jan 2022 17:42:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH qemu] s390x: sck: load into a temporary not into in1
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc:     linux-s390@vger.kernel.org, thuth@redhat.com,
        richard.henderson@linaro.org
References: <20220125122914.567599-1-nrb@linux.ibm.com>
 <9a888391-1020-89b0-65ed-5c93f2cc8642@redhat.com>
 <c0b5e6151a330f58f6794ee4fac19e6319810613.camel@linux.ibm.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
In-Reply-To: <c0b5e6151a330f58f6794ee4fac19e6319810613.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 25/1/22 15:54, Nico Boehr wrote:
> On Tue, 2022-01-25 at 14:13 +0100, David Hildenbrand wrote:
>> I think you can actually just reuse in2_m2_64a, similar as we handle
>> SCKC
> 
> I tried my SCK tests with your patch, it works just as well and seems
> much cleaner, thanks.
> 
> Do you want to send this or should I make a v2 and add you as
> Suggested-by?

v2 ;)

