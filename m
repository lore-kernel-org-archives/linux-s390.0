Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1A4C47083
	for <linux-s390@archiver.kernel.org>; Wed,  2 Jun 2021 09:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741D56101B
	for <linux-s390@archiver.kernel.org>; Wed,  2 Jun 2021 09:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhFBJtA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 2 Jun 2021 05:49:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43905 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231506AbhFBJs7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Jun 2021 05:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622627236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ByEAV4YrwKVnhlwghStCjIo8Ke5CCjeHAPkaCAqWSBs=;
        b=GxW8i4xj1LR1yPW8mYmf+PpGBzIqt/NbinQpIZZCQdl+VzCJjXlODgl84tc7dm/xEl3dGA
        lz6Akb7vOEZO12a7iLa2uuHG2nebH9ByfdK/h5XqIHL99ioXxdJVmsR7suCOux01sZ8NR3
        /dzK4TChY81L9FavQVgzpVDAh51uWNs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-LAvne4enMSuzfdGfyiJUSQ-1; Wed, 02 Jun 2021 05:47:15 -0400
X-MC-Unique: LAvne4enMSuzfdGfyiJUSQ-1
Received: by mail-wr1-f72.google.com with SMTP id g3-20020adfd1e30000b02901122a4b850aso763793wrd.20
        for <linux-s390@vger.kernel.org>; Wed, 02 Jun 2021 02:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ByEAV4YrwKVnhlwghStCjIo8Ke5CCjeHAPkaCAqWSBs=;
        b=dY+7Gea8e5R9ABgEqJR1vLRHfAflVWxntl3S0hkNR47XGuJTQkoJhAbk7yOvOffiJ6
         cwkCuvO1jROBDyvmGs1VcDCJjRSILlXLAQhrbdA1XsQQ/WIOCSKN/rPzV1oku+U3dXaI
         l3xMDeI0CsVJ5TuNCuhNZESrnZz8AVeT+kR1ofhoTwkOAA8s3PLYRsW/ZzDZuZSAATee
         rhn9EpzciFyEBLpS0XlujWycEiv4rvvm5h7RXUNwnDzvANnNJw83ALt5i5+j48JoCbj/
         H6Xq/VYUOX1aJDjGZ6GhcAnlmkHkXDpi9sdTx88KQHb5RhdhwPKS7IDjeyLnBtaVSooU
         uBhA==
X-Gm-Message-State: AOAM533ww8rsyG9fCQhqw8ap4Zh17l+VTkdIvB3dbE43/PbbUcskx3Qg
        wMQT2Dwrwt1UU7poF2zckv861SiW6kFLhddKerjRZaEi/FAzlJWLXmVL9s3GkVft55srX0acfAi
        2PkuTSB0IX5e05fl/S/yKvA==
X-Received: by 2002:a05:6000:1089:: with SMTP id y9mr9606081wrw.412.1622627233746;
        Wed, 02 Jun 2021 02:47:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyUJSokevpnMmcmivUKSr723WrPQIhCwIs1GeO35ViokWlEl5+KpLP1m0RDaONZ1NPYTW+3g==
X-Received: by 2002:a05:6000:1089:: with SMTP id y9mr9606067wrw.412.1622627233594;
        Wed, 02 Jun 2021 02:47:13 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6b6d.dip0.t-ipconnect.de. [91.12.107.109])
        by smtp.gmail.com with ESMTPSA id d3sm5920103wrs.41.2021.06.02.02.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 02:47:13 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH] s390x: sie: Only overwrite r3 if it isn't
 needed anymore
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        thuth@redhat.com, cohuck@redhat.com
References: <20210602094352.11647-1-frankja@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <539ca61d-eaf8-f47f-c7ce-d5a520273517@redhat.com>
Date:   Wed, 2 Jun 2021 11:47:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602094352.11647-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 02.06.21 11:43, Janosch Frank wrote:
> The lmg overwrites r3 which we later use to reference the fprs and fpc.
> Let's do the lmg at the end where overwriting is fine.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
> 
> Finding this took me longer than I'd like to admit. :)
> 
> ---
>   s390x/cpu.S | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/s390x/cpu.S b/s390x/cpu.S
> index e2ad56c8..82b5e25d 100644
> --- a/s390x/cpu.S
> +++ b/s390x/cpu.S
> @@ -81,11 +81,11 @@ sie64a:
>   	stg	%r3,__SF_SIE_SAVEAREA(%r15)	# save guest register save area
>   
>   	# Load guest's gprs, fprs and fpc
> -	lmg	%r0,%r13,SIE_SAVEAREA_GUEST_GRS(%r3)
>   	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
>   	ld	\i, \i * 8 + SIE_SAVEAREA_GUEST_FPRS(%r3)
>   	.endr
>   	lfpc	SIE_SAVEAREA_GUEST_FPC(%r3)
> +	lmg	%r0,%r13,SIE_SAVEAREA_GUEST_GRS(%r3)
>   
>   	# Move scb ptr into r14 for the sie instruction
>   	lg	%r14,__SF_SIE_CONTROL(%r15)
> 

Oh, that's nasty

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

