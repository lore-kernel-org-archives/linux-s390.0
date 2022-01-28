Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739E7C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 28 Jan 2022 10:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiA1KBk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 28 Jan 2022 05:01:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231169AbiA1KBj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 28 Jan 2022 05:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643364098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v68MJEoDCvAlfTpX+eF/vA70bwnzsgjAdyequeEm8OU=;
        b=F3bOyWN7u0U8nTyK4AT63P8mfCEcsQjnSLCYOgkChFyPgfcztlugpjPWtDM9mYrfRcPrJF
        BSN5AB/LMsPtEWQXC/c/QBtOdGmWwMzc8+ChtiO/CD8u6Dyx/jBdxw+sTbIeu3moCHlSmO
        GUVGjhp9+pNRp4y7YjUNPeKA2E06wHg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-PItrjPvkPaeVIYuTfROdqA-1; Fri, 28 Jan 2022 05:01:37 -0500
X-MC-Unique: PItrjPvkPaeVIYuTfROdqA-1
Received: by mail-wr1-f70.google.com with SMTP id g17-20020adfa591000000b001da86c91c22so2075690wrc.5
        for <linux-s390@vger.kernel.org>; Fri, 28 Jan 2022 02:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v68MJEoDCvAlfTpX+eF/vA70bwnzsgjAdyequeEm8OU=;
        b=Ph2ZQW0o2Wk5VOF8eNksztVDcvPcg287xnPACcV9ZysVgdZ9gCMkR8crukdZrkOyvE
         L0lF8wyxr/sIMaqiPxlTyND0QmsYeZBDXSfZOdK/ZaG0Htp7iZq3qaF5LxPk914j3smi
         OCWD3SZYdTdAb48U+Hc4zLM7lgPwHk7uGscXFkAZDGOtYRNzaUV5/SOCcce5kbm1AX9n
         TGS+wCXj7t3xcV0BSF4p0WebbQFcVSOruaPQoYD3bYnR3xlVVPYSMtu4FJhN2S+DC+LL
         sSqehrGVBUHUKV3OnppuEHx6jNRD7zjc4XOSog6up+Wb3rtlmauhfY+kDBBAYpkriA8n
         MLSQ==
X-Gm-Message-State: AOAM533Pu9AlRfgDOh+GXOuxFmVryE5omVQ8jjO/VwmtbW5y9rXij+E+
        cwLEECMLDtZuW7YVeFzd6W40Nr1bVvc7E5BHAioU4wlYEGn/WWqJiggA9soLeJmzHxkPM3RFlfT
        dqFuBJCO+JuuoOheWC0pYkg==
X-Received: by 2002:a5d:6f13:: with SMTP id ay19mr6549681wrb.142.1643364096496;
        Fri, 28 Jan 2022 02:01:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPMVqmcjgdQvzbSAcg8Lt4tnZKlahOkes8AhdNGV97MHEExIeL5qWlk93V87mi5ayhXV7/Hg==
X-Received: by 2002:a5d:6f13:: with SMTP id ay19mr6549666wrb.142.1643364096270;
        Fri, 28 Jan 2022 02:01:36 -0800 (PST)
Received: from [192.168.8.100] (tmo-096-196.customers.d1-online.com. [80.187.96.196])
        by smtp.gmail.com with ESMTPSA id t14sm1555187wmq.43.2022.01.28.02.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 02:01:35 -0800 (PST)
Message-ID: <db8200f2-8c67-f0ed-931c-7406412a6024@redhat.com>
Date:   Fri, 28 Jan 2022 11:01:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH qemu v2] s390x: sck: load into a temporary not into in1
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, qemu-devel@nongnu.org
Cc:     linux-s390@vger.kernel.org, richard.henderson@linaro.org
References: <20220126084201.774457-1-nrb@linux.ibm.com>
 <a90563ea-2740-d4ca-d2f3-6b6861faf0de@linux.ibm.com>
 <463337d3-dad9-abbc-b0e3-544e08160234@redhat.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <463337d3-dad9-abbc-b0e3-544e08160234@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 27/01/2022 11.45, David Hildenbrand wrote:
> On 27.01.22 11:32, Janosch Frank wrote:
>> On 1/26/22 09:42, Nico Boehr wrote:
>>> We previously loaded into in1, but in1 is not filled during
>>> disassembly and hence always zero. This leads to an assertion failure:
>>>
>>>     qemu-system-s390x: /home/nrb/qemu/include/tcg/tcg.h:654: temp_idx:
>>>     Assertion `n >= 0 && n < tcg_ctx->nb_temps' failed.`
>>>
>>> Instead, use in2_la2_m64a to load from storage into in2 and pass that to
>>> the helper, which matches what we already do for SCKC.
>>>
>>> This fixes the SCK test I sent here under TCG:
>>> <https://www.spinics.net/lists/kvm/msg265169.html>
>>>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
>>
>> @David: Was this already broken when it was implemented?
>> I.e. do we want a "Fixes: 9dc67537 ("s390x/tcg: implement SET CLOCK ")" tag?
> 
> That sounds about right.

Thanks, queued to my s390x-next branch now:

https://gitlab.com/thuth/qemu/-/commits/s390x-next/

  Thomas


