Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C907CC433EF
	for <linux-s390@archiver.kernel.org>; Fri, 29 Apr 2022 16:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378751AbiD2QGO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 29 Apr 2022 12:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378749AbiD2QGO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 29 Apr 2022 12:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B4A063BF9
        for <linux-s390@vger.kernel.org>; Fri, 29 Apr 2022 09:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651248174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WIhTauvSxJmt5ljV+5KC586UIv4xmU4lJh3RdFTAIGo=;
        b=DBY9g5xO1X70Z2lOAMERwz4qRtO3zka1VzFy1peIpdbA5VAht06uiA01ITDXue51h3ylsj
        rSd4nwfOAvs3g8ljnE25QNeVSPVN6oQcpUl4ZJPrkZsfE7cpSXjZ8HXAO6Zl3y08VW7+MJ
        pjk7brTkPgvuEPyONLbzAstqiAGJByc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-Xu2XG0pDMr2eFzHEnnyN8w-1; Fri, 29 Apr 2022 12:02:51 -0400
X-MC-Unique: Xu2XG0pDMr2eFzHEnnyN8w-1
Received: by mail-wr1-f70.google.com with SMTP id k29-20020adfb35d000000b0020adc94662dso3199946wrd.12
        for <linux-s390@vger.kernel.org>; Fri, 29 Apr 2022 09:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=WIhTauvSxJmt5ljV+5KC586UIv4xmU4lJh3RdFTAIGo=;
        b=EwFw7hTs+G/SIGhXLbNlzwO5ozV/pJDb0oQahLKftderjJ7c32VXmMbyRArX1BV/wI
         vQ1NBQgSV/kfSZeRl43FQeuEAdbcCwisjpFmPKQJiF2rtaGWfI9T7eNgbalKI2syHlSN
         V2PmFk0LtTshgIyNPdXIH1Bhi2zdgRqfmHI5tdicimZEPy0MT578/iqKY9Vu9PZn6eTM
         /lUAnHB4INFGMtXmz5EPhBREOZBESpYsVMACZydF4HBolrxfKyb415pbfNC28N11OUbZ
         Qs2B5PssC+GVlwB9bZhV/Hr/N1y6jvRbT5RMRq8o0+70xu9WBnLdj3VdG0cEtWOzj8rC
         UM4w==
X-Gm-Message-State: AOAM532+EXPa3wRhyMxi2qaic6c9aPYAixpcszt2TnoxXwLp0L3NGCtG
        7Dt+r2RrQznZVefjHEHjZrEXJUnAEc/YqNMEf5dasQLcrAt3RJX2BYMbXQzQ4ADsuHwuCZPlA6/
        5NxcfD1DHw8kOW/V79CXGKw==
X-Received: by 2002:a1c:a181:0:b0:392:8f7e:d2f8 with SMTP id k123-20020a1ca181000000b003928f7ed2f8mr3992033wme.30.1651248170015;
        Fri, 29 Apr 2022 09:02:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtWszNbmEk6KmVxF3TrG7Df8Yb54zA5wj0GQzGaAPgvjGBhkjxg9HbgcTGJSulwdFOHFEu4w==
X-Received: by 2002:a1c:a181:0:b0:392:8f7e:d2f8 with SMTP id k123-20020a1ca181000000b003928f7ed2f8mr3992008wme.30.1651248169714;
        Fri, 29 Apr 2022 09:02:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:fe00:bbeb:98e6:617a:dea1? (p200300cbc707fe00bbeb98e6617adea1.dip0.t-ipconnect.de. [2003:cb:c707:fe00:bbeb:98e6:617a:dea1])
        by smtp.gmail.com with ESMTPSA id bi26-20020a05600c3d9a00b0038ed39dbf00sm2978660wmb.0.2022.04.29.09.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 09:02:49 -0700 (PDT)
Message-ID: <54927e4b-3be7-f186-747c-f14097aa2df9@redhat.com>
Date:   Fri, 29 Apr 2022 18:02:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH/RFC] KVM: s390: vsie/gmap: reduce gmap_rmap overhead
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Janosch Frank <frankja@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20220429151526.1560-1-borntraeger@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220429151526.1560-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 29.04.22 17:15, Christian Borntraeger wrote:
> there are cases that trigger a 2nd shadow event for the same
> vmaddr/raddr combination. (prefix changes, reboots, some known races)
> This will increase memory usages and it will result in long latencies
> when cleaning up, e.g. on shutdown. To avoid cases with a list that has
> hundreds of identical raddrs we check existing entries at insert time.
> As this measurably reduces the list length this will be faster than
> traversing the list at shutdown time.
> 
> In the long run several places will be optimized to create less entries
> and a shrinker might be necessary.
> 
> Fixes: 4be130a08420 ("s390/mm: add shadow gmap support")
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>  arch/s390/mm/gmap.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 69c08d966fda..0fc0c26a71f2 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -1185,12 +1185,19 @@ static inline void gmap_insert_rmap(struct gmap *sg, unsigned long vmaddr,
>  				    struct gmap_rmap *rmap)
>  {
>  	void __rcu **slot;
> +	struct gmap_rmap *temp;
>  
>  	BUG_ON(!gmap_is_shadow(sg));
>  	slot = radix_tree_lookup_slot(&sg->host_to_rmap, vmaddr >> PAGE_SHIFT);
>  	if (slot) {
>  		rmap->next = radix_tree_deref_slot_protected(slot,
>  							&sg->guest_table_lock);
> +		for (temp = rmap->next; temp; temp = temp->next) {
> +			if (temp->raddr == rmap->raddr) {
> +				kfree(rmap);
> +				return;
> +			}
> +		}
>  		radix_tree_replace_slot(&sg->host_to_rmap, slot, rmap);
>  	} else {
>  		rmap->next = NULL;

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

