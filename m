Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D22C4320A
	for <linux-s390@archiver.kernel.org>; Fri,  6 Aug 2021 07:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61DFC60F38
	for <linux-s390@archiver.kernel.org>; Fri,  6 Aug 2021 07:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243675AbhHFHam (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 6 Aug 2021 03:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243751AbhHFHaY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Aug 2021 03:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628235009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/BY4t2yJmbfSKPEbLTSJy0hz6AF9n9YxHRdnbcJfERs=;
        b=QTasJsWZTZOWt1Vh4h8C7ojHdRjdQ5uPwVkaKb8x41R0tHPo/7POEcQpeb41TFftDn1/Xv
        QVz5UHn331GeuZp7xFOcV1cUqnb0S6KlrthLwUqdEcaBk/o/vqlJC1foruRUmqxa0DVXJA
        s81D5kDGtEmed1Rxfxj/dJJvhXEv7cI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-rvwFtBt_MO-X4D2eExq7Wg-1; Fri, 06 Aug 2021 03:30:07 -0400
X-MC-Unique: rvwFtBt_MO-X4D2eExq7Wg-1
Received: by mail-wm1-f69.google.com with SMTP id 21-20020a05600c0255b02902571fa93802so2723983wmj.1
        for <linux-s390@vger.kernel.org>; Fri, 06 Aug 2021 00:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/BY4t2yJmbfSKPEbLTSJy0hz6AF9n9YxHRdnbcJfERs=;
        b=d8kH1wuV1SQkdjGf3na0bVLNaVGYSMWuqyPK+ndPp3vAMSV4YIuBHyyvIujwFzvOFn
         9FmvqfVzW8zpiMKcV8hOPIhz/viFWf+4H8czbCO3fLe9p039nu/pg3trnCSgGf7YrFJZ
         HijT9B7LhOWhkMffiKGwjgyXId/howNEuR69MATNehkHyphv+V6GJHZGSg12QMii6QcT
         Wew5KGZAL5EJK0leNDs2puwCff4a9M4yd5sePO+Bccd6Irx7oLa9L/R3WV9io8Y3yoII
         s3DzBjgCNP1G6nkWwMXNoZwTs/Phaa32BlYlUMlAwBx5xlDcHCdM19l6cKN20aoBti6m
         YrhA==
X-Gm-Message-State: AOAM533ZMrsECgacIG1oXZA3dn0EEiwDAh7awRX5NCswI20dJEp7lar4
        4oIhrDpf9GBh8vJj/kvV1F8MWnYMNke/69UHo6H0f598Cu3E3E5/UJk5vFt46pLtoGmxXDT3R9u
        YaJNPBHp2Yn8et8/z09DGvA==
X-Received: by 2002:a05:600c:3b94:: with SMTP id n20mr1781096wms.54.1628235005748;
        Fri, 06 Aug 2021 00:30:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVZHZyH4+bvjg65UxBPJGLejAZAJ2Ik8iYydKdbU4cBd0fD679iDO5ATxjE2sOFL4jRsl9dA==
X-Received: by 2002:a05:600c:3b94:: with SMTP id n20mr1781075wms.54.1628235005511;
        Fri, 06 Aug 2021 00:30:05 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6104.dip0.t-ipconnect.de. [91.12.97.4])
        by smtp.gmail.com with ESMTPSA id b6sm10178492wrn.9.2021.08.06.00.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 00:30:05 -0700 (PDT)
Subject: Re: [PATCH v3 02/14] KVM: s390: pv: avoid stall notifications for
 some UVCs
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc:     cohuck@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        thuth@redhat.com, pasic@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulrich.Weigand@de.ibm.com
References: <20210804154046.88552-1-imbrenda@linux.ibm.com>
 <20210804154046.88552-3-imbrenda@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7ef282bb-d90f-9cbb-678b-4293790fb8c6@redhat.com>
Date:   Fri, 6 Aug 2021 09:30:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804154046.88552-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 04.08.21 17:40, Claudio Imbrenda wrote:
> Improve make_secure_pte to avoid stalls when the system is heavily
> overcommitted. This was especially problematic in kvm_s390_pv_unpack,
> because of the loop over all pages that needed unpacking.
> 
> Also fix kvm_s390_pv_init_vm to avoid stalls when the system is heavily
> overcommitted.

I suggest splitting this change into a separate patch and adding a bit 
more meat to the description why using the other variant is possible in 
the called context. I was kind of surprise to find that change buried in 
this patch.

Then, you can give both patches a more descriptive patch subject.

> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Fixes: 214d9bbcd3a672 ("s390/mm: provide memory management functions for protected KVM guests")
> ---
>   arch/s390/kernel/uv.c | 29 +++++++++++++++++++++++------
>   arch/s390/kvm/pv.c    |  2 +-
>   2 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index aeb0a15bcbb7..68a8fbafcb9c 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -180,7 +180,7 @@ static int make_secure_pte(pte_t *ptep, unsigned long addr,
>   {
>   	pte_t entry = READ_ONCE(*ptep);
>   	struct page *page;
> -	int expected, rc = 0;
> +	int expected, cc = 0;
>   
>   	if (!pte_present(entry))
>   		return -ENXIO;
> @@ -196,12 +196,25 @@ static int make_secure_pte(pte_t *ptep, unsigned long addr,
>   	if (!page_ref_freeze(page, expected))
>   		return -EBUSY;
>   	set_bit(PG_arch_1, &page->flags);
> -	rc = uv_call(0, (u64)uvcb);
> +	/*
> +	 * If the UVC does not succeed or fail immediately, we don't want to
> +	 * loop for long, or we might get stall notifications.
> +	 * On the other hand, this is a complex scenario and we are holding a lot of
> +	 * locks, so we can't easily sleep and reschedule. We try only once,
> +	 * and if the UVC returned busy or partial completion, we return
> +	 * -EAGAIN and we let the callers deal with it.
> +	 */
> +	cc = __uv_call(0, (u64)uvcb);
>   	page_ref_unfreeze(page, expected);
> -	/* Return -ENXIO if the page was not mapped, -EINVAL otherwise */
> -	if (rc)
> -		rc = uvcb->rc == 0x10a ? -ENXIO : -EINVAL;
> -	return rc;
> +	/*
> +	 * Return -ENXIO if the page was not mapped, -EINVAL for other errors.
> +	 * If busy or partially completed, return -EAGAIN.
> +	 */
> +	if (cc == UVC_CC_OK)
> +		return 0;
> +	else if (cc == UVC_CC_BUSY || cc == UVC_CC_PARTIAL)
> +		return -EAGAIN;
> +	return uvcb->rc == 0x10a ? -ENXIO : -EINVAL;
>   }

That looks conceptually like the right thing to me.

-- 
Thanks,

David / dhildenb

