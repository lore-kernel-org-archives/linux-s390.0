Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0E9C433F5
	for <linux-s390@archiver.kernel.org>; Thu, 27 Jan 2022 10:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiA0KpS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 27 Jan 2022 05:45:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbiA0KpR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Jan 2022 05:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643280317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LU9IZHUu3pCtTqOpPktPpnR6th1g3m239iDevRfSw9Q=;
        b=AqO6avMiqY9yXqiOLKw00+AsYHf980WjGFa4xo6PgEXHBVu7sOjxKGsN+lWKmRYJpCej4U
        3WJPCV8brq/72la7b/PGIWBzxLw1uPacha9WY94I32t/MzR0hpNZlybYnrThKojoPx+0s3
        qFKeze+3e4fxFNx0KHFi0nwQjE7SleY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-wP05fxLQNuONK3btt0_oFQ-1; Thu, 27 Jan 2022 05:45:15 -0500
X-MC-Unique: wP05fxLQNuONK3btt0_oFQ-1
Received: by mail-wm1-f71.google.com with SMTP id n6-20020a05600c3b8600b00350f4349a19so776457wms.1
        for <linux-s390@vger.kernel.org>; Thu, 27 Jan 2022 02:45:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=LU9IZHUu3pCtTqOpPktPpnR6th1g3m239iDevRfSw9Q=;
        b=4K3SOOXtSgPheNvbd6J0kYb1cOrNELQ3icj9GPCW30iepodEt+WoQqFiE25cnWGIQ3
         bE75fPEVtIsqkQFHYS2AwaIlG9oCYRd9ksivr/583HO/V2kGIKlUtLiJCQwUUZsDLRhq
         wRdyBE0q1Oyx80rn+cPP/v5vmd/b+6nBEXjT0QOC58CYQkOnfFRH0rt7Pn/4x1EOvZOH
         3emfk7iwIK3AisMU7fIaC2QsYCt4PZ+9gzfGSURG3pR+nxQtPhHRVpwX0FbQhMbUjnlx
         3Ux2rtb+WQ5jnKE4etcJUk8Nno3Egj0Y2UHhMaqXNr+4+zztFvS6jMBsL+JOLORl2MUo
         VwHQ==
X-Gm-Message-State: AOAM533XllC2iTUO0bL08GwmFXYmafg0e/aTLphso01tQ8qK232XOY1j
        ZxnBjMUjKmpPt6Fp5oN5S8oHQYSI4WLxkL9SpCXkpgEKsHCLIT2D91HqKdzFnJUcN4QvimvxzSC
        +lOc5sSCKpqJL/2IXFgZc5w==
X-Received: by 2002:a5d:55c3:: with SMTP id i3mr2506446wrw.250.1643280314450;
        Thu, 27 Jan 2022 02:45:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwbhWQ0cYEvOP9nAWExDN0GxmdfDamScYe4v++JhkcPJg+QDUrNymhc8QXi8IyJQwLs/KH+9A==
X-Received: by 2002:a5d:55c3:: with SMTP id i3mr2506429wrw.250.1643280314175;
        Thu, 27 Jan 2022 02:45:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:8300:4812:9d4f:6cd8:7f47? (p200300cbc70d830048129d4f6cd87f47.dip0.t-ipconnect.de. [2003:cb:c70d:8300:4812:9d4f:6cd8:7f47])
        by smtp.gmail.com with ESMTPSA id m14sm2305616wrp.4.2022.01.27.02.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 02:45:13 -0800 (PST)
Message-ID: <463337d3-dad9-abbc-b0e3-544e08160234@redhat.com>
Date:   Thu, 27 Jan 2022 11:45:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH qemu v2] s390x: sck: load into a temporary not into in1
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, qemu-devel@nongnu.org
Cc:     linux-s390@vger.kernel.org, thuth@redhat.com,
        richard.henderson@linaro.org
References: <20220126084201.774457-1-nrb@linux.ibm.com>
 <a90563ea-2740-d4ca-d2f3-6b6861faf0de@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <a90563ea-2740-d4ca-d2f3-6b6861faf0de@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 27.01.22 11:32, Janosch Frank wrote:
> On 1/26/22 09:42, Nico Boehr wrote:
>> We previously loaded into in1, but in1 is not filled during
>> disassembly and hence always zero. This leads to an assertion failure:
>>
>>    qemu-system-s390x: /home/nrb/qemu/include/tcg/tcg.h:654: temp_idx:
>>    Assertion `n >= 0 && n < tcg_ctx->nb_temps' failed.`
>>
>> Instead, use in2_la2_m64a to load from storage into in2 and pass that to
>> the helper, which matches what we already do for SCKC.
>>
>> This fixes the SCK test I sent here under TCG:
>> <https://www.spinics.net/lists/kvm/msg265169.html>
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> 
> @David: Was this already broken when it was implemented?
> I.e. do we want a "Fixes: 9dc67537 ("s390x/tcg: implement SET CLOCK ")" tag?

That sounds about right.

-- 
Thanks,

David / dhildenb

