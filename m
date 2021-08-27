Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E555C432BE
	for <linux-s390@archiver.kernel.org>; Fri, 27 Aug 2021 07:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6C060F5B
	for <linux-s390@archiver.kernel.org>; Fri, 27 Aug 2021 07:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244340AbhH0HSp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 27 Aug 2021 03:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235220AbhH0HSp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Aug 2021 03:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630048676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zokzz+bzAXSf7i3x6Blv6DyelumaP1+GzIzKZycrfQw=;
        b=A0zJPeoYZs+q0HOFjvjatuTSIYAAtL/qPOehfbL+7tK7fVdx9sUmW4rbxqN0ED9bCjvaPj
        HsXTrgALBi+Y3urOiLQBI+yNQ7ulZn8CLoADgQISoJ0+1fiRY3naLHgpXdaJaxKpcxn3O8
        KIqoEkXjLRLtdrfVar8pVH7Vckmyd10=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-CLGxtPJPPB21S3xssHeZEA-1; Fri, 27 Aug 2021 03:17:54 -0400
X-MC-Unique: CLGxtPJPPB21S3xssHeZEA-1
Received: by mail-wr1-f72.google.com with SMTP id i16-20020adfded0000000b001572ebd528eso1557607wrn.19
        for <linux-s390@vger.kernel.org>; Fri, 27 Aug 2021 00:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zokzz+bzAXSf7i3x6Blv6DyelumaP1+GzIzKZycrfQw=;
        b=IEsA71ChhICjSaCjeI2/vBZnw5G46YwDEwwFoTqqK/WJZbcTDXZN0b59QxCeH28Pcs
         QRysPVqKvDErkRMHS3CSzvQEbjXF0QI910IbLZF1bjJDRb+X64yWAe5W1y0Pbz/kpSJM
         iaVPXhDaOt0W7m7DKGCgf+rqUA86QeBzSgu4oogw54MUAfl7Xr+WfohRwZEu3+AKiavF
         Guj8i2rLyB0R7BYd3/r/IZ7IFmUMbah3/KZdpKRQFyT/wkSJqznIZj4uZ0eio07BCXWk
         Ud8BmH8NvRBNEfS5VA4wP/JyRvXbZp87TJuijb8Dr/9ePc00RQS3LMdLmFbxxAs/NrND
         SNjQ==
X-Gm-Message-State: AOAM532Gljfy52T42MaY7z+dqKuodWU/oqGyJr6lQxjujfbFt/82MGKI
        Rctsn/OeV/9CLTzk9zmEl2dnL1dR7BBGXkSHUMVKay/8I4UEjl7IS3rqbHtw1JVUgD0SnlAmEAO
        D+2+sdpsi0RALHrvvumyP4w==
X-Received: by 2002:a7b:c387:: with SMTP id s7mr17617819wmj.26.1630048673559;
        Fri, 27 Aug 2021 00:17:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ1MwCNV3XDJZouyQqsDbByJSfBXZPqGyg72LECbBbxQ1E/nGZu1vMYc07MDvbNErPZJ9+2w==
X-Received: by 2002:a7b:c387:: with SMTP id s7mr17617801wmj.26.1630048673348;
        Fri, 27 Aug 2021 00:17:53 -0700 (PDT)
Received: from thuth.remote.csb (dynamic-046-114-148-182.46.114.pool.telefonica.de. [46.114.148.182])
        by smtp.gmail.com with ESMTPSA id o8sm4393593wmp.42.2021.08.27.00.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 00:17:52 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH v2 2/3] s390x: uv-host: Explain why we set
 up the home space and remove the space change
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <20210820114000.166527-1-frankja@linux.ibm.com>
 <20210820114000.166527-3-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <7745cd84-f250-4559-c8f3-a0751324d987@redhat.com>
Date:   Fri, 27 Aug 2021 09:17:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210820114000.166527-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 20/08/2021 13.39, Janosch Frank wrote:
> UV home addresses don't require us to be in home space but we need to
> have it set up so hw/fw can use the home asce to translate home
> virtual addresses.
> 
> Hence we add a comment why we're setting up the home asce and remove
> the address space since it's unneeded.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>   s390x/uv-host.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/s390x/uv-host.c b/s390x/uv-host.c
> index 426a67f6..28035707 100644
> --- a/s390x/uv-host.c
> +++ b/s390x/uv-host.c
> @@ -444,13 +444,18 @@ static void test_clear(void)
>   
>   static void setup_vmem(void)
>   {
> -	uint64_t asce, mask;
> +	uint64_t asce;
>   
>   	setup_mmu(get_max_ram_size(), NULL);
> +	/*
> +	 * setup_mmu() will enable DAT and set the primary address
> +	 * space but we need to have a valid home space since UV calls
> +	 * take home space virtual addresses.
> +	 *
> +	 * Hence we just copy the primary asce into the home space.
> +	 */
>   	asce = stctg(1);
>   	lctlg(13, asce);
> -	mask = extract_psw_mask() | 0x0000C00000000000UL;
> -	load_psw_mask(mask);
>   }
>   
>   int main(void)
> 

Acked-by: Thomas Huth <thuth@redhat.com>

