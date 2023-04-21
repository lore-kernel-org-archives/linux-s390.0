Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163ADC77B76
	for <linux-s390@archiver.kernel.org>; Fri, 21 Apr 2023 17:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjDURWk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 21 Apr 2023 13:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjDURWj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 21 Apr 2023 13:22:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1376610F
        for <linux-s390@vger.kernel.org>; Fri, 21 Apr 2023 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682097711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F5BUIZCZG7tWuEnNiXnezg1wpCr6XGmaYZLZ1JJftNg=;
        b=f2/2kk20U+Iop9wYx6XlW3+Hi3HdXMPy05QDDkDItx2RXUacaBuAWcCO1C/DCmhXh9Mwbo
        s0TjnDOAJMeXS6r2F38YtIvft4Zk9Sj1hG2QYoFkN7xzK83u1ZctC8NX4wtUIPbFwrAQRI
        ygHuCUEmgc4yMJBbfJ6t5Jz8aiy3WA8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-7n6wWY4cMnmu2j4vN2EMvA-1; Fri, 21 Apr 2023 13:21:41 -0400
X-MC-Unique: 7n6wWY4cMnmu2j4vN2EMvA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f17b8d24bbso13059825e9.2
        for <linux-s390@vger.kernel.org>; Fri, 21 Apr 2023 10:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682097699; x=1684689699;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5BUIZCZG7tWuEnNiXnezg1wpCr6XGmaYZLZ1JJftNg=;
        b=jLDqzZw/3VeRZHP6lDehOXHeZqWNw9Xtp0lIjhfu/+b7HdPEh26FZdcr+gs+xYC5Cf
         yuDzzRQa36Pm18BpuUNp4WuURywmJr6Sw1nVPbXOPin3zZyvHNC5AUPyRB4OcnwdE9Vi
         WrnrYtwLhMG4gaNPIEVXF6pExWYyYUcWitLZZ05Ws7amJgKOaLM5Ye8xbtjP8g1Q3cTo
         MRiNkAwka+grG9XQTTo/xvr+xyNWI3xX4LoTB0l11lwwQTgDDXNfkZGI4uBP7GwDksM7
         2MAIFrLZDeuMhJAG3ix/eHSjfvf/NWqBPDTzD2EGig+3I8nIeWrF3B004iw9L2H9DF9d
         kv7w==
X-Gm-Message-State: AAQBX9fguRIsqY+/eDlNeRfsKqlR0WA+CENU0GT9cL7nCI5QESljru+Q
        0ej3XB2EXyxAoJE9bryXRGa+wRQWsDQuBb0Pg/yBGVfXWLL8g7Okr94+48suSgHaR0L9y8/TjOZ
        SXz3rSKPqQEAxO0OUr3LxVQ==
X-Received: by 2002:a05:600c:2306:b0:3f1:72ec:4016 with SMTP id 6-20020a05600c230600b003f172ec4016mr2580972wmo.0.1682097699584;
        Fri, 21 Apr 2023 10:21:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350aFn+YAjtfSjCVKeXGhCWAiZWMdwsuDncB3Nwm1fVnTmqMnOAjnMKFGp80Ll5DTm/pP7pP0nA==
X-Received: by 2002:a05:600c:2306:b0:3f1:72ec:4016 with SMTP id 6-20020a05600c230600b003f172ec4016mr2580947wmo.0.1682097699200;
        Fri, 21 Apr 2023 10:21:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6a00:e38f:c852:dc11:9146? (p200300cbc7176a00e38fc852dc119146.dip0.t-ipconnect.de. [2003:cb:c717:6a00:e38f:c852:dc11:9146])
        by smtp.gmail.com with ESMTPSA id g10-20020a7bc4ca000000b003f171234a08sm5302275wmk.20.2023.04.21.10.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 10:21:38 -0700 (PDT)
Message-ID: <f809162e-4adc-cf9b-35f4-0f1b098ad283@redhat.com>
Date:   Fri, 21 Apr 2023 19:21:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 1/3] mm/ksm: unmerge and clear VM_MERGEABLE when
 setting PR_SET_MEMORY_MERGE=0
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
References: <20230418051342.1919757-1-shr@devkernel.io>
 <20230418152849.505124-1-david@redhat.com>
 <20230418152849.505124-2-david@redhat.com>
 <qvqwr0sei6sl.fsf@devbig1114.prn1.facebook.com>
 <d476d75d-74a8-9cad-a60e-4b5ecb149719@redhat.com>
Organization: Red Hat
In-Reply-To: <d476d75d-74a8-9cad-a60e-4b5ecb149719@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

>> I understand we want to keep the name "symmetric" with
>> ksm_enable_merge_any, but it also unmerges the ksm pages. Do we want to
>> reflect that in the function name?
> 
> ksm_disable_merge_any_umerge() is suboptimal.
> 
> As ksm_disable_merge_any() now reverts what ksm_enable_merge_any() ended
> up doing, I think it's just fine.
> 
> (it would be a different story if we'd be using "set" / "clear"
> terminology instead of "enable" / "disable").
> 
> We can describe that in the comment.
> 
>>
>> Can we add a comment for the function?
> 
> Can do for symmetry with ksm_enable_merge_any().
> 

+/**
+ * ksm_disable_merge_any - Disable merging on all compatible VMA's of the mm,
+ *                        previously enabled via ksm_enable_merge_any().
+ *
+ * Disabling merging implies unmerging any merged pages, like setting
+ * MADV_UNMERGEABLE would. If unmerging fails, the whole operation fails and
+ * merging on all compatible VMA's remains enabled.
+ *
+ * @mm: Pointer to mm
+ *
+ * Returns 0 on success, otherwise error code
+ */


-- 
Thanks,

David / dhildenb

