Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D99DC433EF
	for <linux-s390@archiver.kernel.org>; Wed, 13 Oct 2021 11:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4207D60E8B
	for <linux-s390@archiver.kernel.org>; Wed, 13 Oct 2021 11:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhJMLTR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 13 Oct 2021 07:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54068 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229535AbhJMLTR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Oct 2021 07:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634123833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5TdvhY7A1PKQTW5dYxQK5JvraKuh0yKwBhUeqrGb7YY=;
        b=S+7dENFF7i0m2zxeairEBsuj+SlHO1PVavUQj+4M07cJHhGDYYMF9N5Cr506rfbR4LPqOz
        CdMCtSEmHiZUZbqQ0s9AiOUJLfh+4ly4gaBbGaj1IeTFWBrhrhwr+kgDHLk64w+y+GZZtf
        wrcZDIED1USbQKeH2coscI0L/3RCWYA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-NLzn6n07OBW4iLIH2k4yRQ-1; Wed, 13 Oct 2021 07:17:12 -0400
X-MC-Unique: NLzn6n07OBW4iLIH2k4yRQ-1
Received: by mail-wr1-f72.google.com with SMTP id k2-20020adfc702000000b0016006b2da9bso1723242wrg.1
        for <linux-s390@vger.kernel.org>; Wed, 13 Oct 2021 04:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5TdvhY7A1PKQTW5dYxQK5JvraKuh0yKwBhUeqrGb7YY=;
        b=7hCgvTZkOMQx6iSh+/Kk5o6prthq0xQXCwvyJ/YEBlIg9fshx3xrDQFd7NLpAw2RwR
         MZuJeZ5js8RakYdui+djn3anoHJ82erRvjBX7H+UA+bB0ZYUEqb3ztoTpyY0OtqcZcGL
         LN27s++ttHAh5+bh1pNQ7+M2W2aAyf2JIfI5hh4YMLEv2ZU3WReiHduVNHYJHmQl8RiG
         bN6l5OtuDood7A4AL2HBBrUWt8TxVB5lbIGeoNV4PaDZKifn/pYujp8adSXZA14BhlYi
         5h91h6nt3Q+butk95vH/+8rQUhvEWwpmsjtqM+367s9ARAT+ccmltFrS5WR/td6NapL6
         MiPA==
X-Gm-Message-State: AOAM531qikh5Rm0d9uL2pEzEzGKkBJJchxNNl3W1Jp5YgaC/VWttzyaP
        0M6yOr3rmbbYOdXg+lnd60XrB5Xf+6AWi/DXy5LynnOfTnlUq8qwjoOheQWS4EozScQcImXqTNB
        s7JQK+4W9PMXOhKJLiLRd6Q==
X-Received: by 2002:a1c:3b44:: with SMTP id i65mr12040882wma.129.1634123831510;
        Wed, 13 Oct 2021 04:17:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXRdXy2LZcbx6d8hytLN9yIL+mfjK6dYZHPkYfgk5BnMEJTZlYPG9mVNeqLfHJc9UAreBEqg==
X-Received: by 2002:a1c:3b44:: with SMTP id i65mr12040865wma.129.1634123831328;
        Wed, 13 Oct 2021 04:17:11 -0700 (PDT)
Received: from thuth.remote.csb (p54886540.dip0.t-ipconnect.de. [84.136.101.64])
        by smtp.gmail.com with ESMTPSA id u2sm12703481wrr.35.2021.10.13.04.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 04:17:10 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 1/2] lib: s390x: Fix PSW constant
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, seiden@linux.ibm.com
References: <20211013102722.17160-1-frankja@linux.ibm.com>
 <20211013102722.17160-2-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <40322aa0-1eb6-c34e-7201-ee9422e88067@redhat.com>
Date:   Wed, 13 Oct 2021 13:17:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211013102722.17160-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 13/10/2021 12.27, Janosch Frank wrote:
> Somehow the ";" got into that patch and now complicates compilation.
> Let's remove it and put the constant in braces.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/asm/arch_def.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index b34aa792..40626d72 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -53,7 +53,7 @@ struct psw {
>   #define PSW_MASK_PSTATE			0x0001000000000000UL
>   #define PSW_MASK_EA			0x0000000100000000UL
>   #define PSW_MASK_BA			0x0000000080000000UL
> -#define PSW_MASK_64			PSW_MASK_BA | PSW_MASK_EA;
> +#define PSW_MASK_64			(PSW_MASK_BA | PSW_MASK_EA)

Reviewed-by: Thomas Huth <thuth@redhat.com>

