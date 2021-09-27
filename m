Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FACC433EF
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 17:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34B9160F44
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 17:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbhI0RpX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 27 Sep 2021 13:45:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237630AbhI0RpU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 27 Sep 2021 13:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632764621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=56cp6DuOx03UDlPp5wTq9ZqnaoI7a1YZthbcSmDRL7g=;
        b=ehbkhVMGRdSU8TFLYsQ4qvHJh0blnTK9kftwVUsPGX4uMpSC0GtDv3InSBYXHgrWGAxRMk
        WAN2/jCpyaqbVdVptN+I3p9nRYAw4a+Z6jtpU502cw3kSKo12YxarTBlu0aN2OkE8fcDCH
        spYRpNRqMUQV19prhQNwiaknadhGylo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-9bTeJJh0NquHwZ8kofZYog-1; Mon, 27 Sep 2021 13:43:40 -0400
X-MC-Unique: 9bTeJJh0NquHwZ8kofZYog-1
Received: by mail-wm1-f69.google.com with SMTP id b139-20020a1c8091000000b002fb33c467c8so556328wmd.5
        for <linux-s390@vger.kernel.org>; Mon, 27 Sep 2021 10:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=56cp6DuOx03UDlPp5wTq9ZqnaoI7a1YZthbcSmDRL7g=;
        b=U5pdnVAdxoPY8iomN5+SRPCBko7L89l7TPA7FBBRj4m1p8JtBNP4xrfRo9iY1vTQpe
         7nn21XeP1vKRM//F4MlUK+xas0+feODV0tE5KSQo2Czstuxkbz6PEAGf8knVrFP1+Fu6
         kJQTT9sWL561fFpQQwau45GrOKP6V46ppNm0o35DwyPidRC6vQiymx5GPWNSLe6kZ9It
         zk/ctOIofCYg9X+9w2f4/lZFSLNxd6K+xxq1KvwYNHjCQzLCOKdoHr7xxvLnrAs9x+8E
         kYToaxKMKhHIxorbCMwi4CD+ChYAklaWzuI+gij1jE+ivvy8PFH4fVVmxr7pxeoIaP46
         omtw==
X-Gm-Message-State: AOAM533brrihf2Zt3xaICXMF5q0O5+RYkhm2EhxyiYCRCfYxf+MTMX4j
        tVmQmQKuZnQbhl+ysG15cj0PE6C/oM3kf+HgdQrDP5FyB1md9ztJnMY4bdl0xSHZvpVlpHLfB/+
        vfFZkVdMPK7OA1HRzaEvgxA==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr352391wmc.76.1632764619122;
        Mon, 27 Sep 2021 10:43:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdt4YCm5ni07STcm76GfQh9gIfBSpYs/TXpV0Iqj2OntD1J2Cw0IgeSRk1XOznWZQUpTpUZw==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr352376wmc.76.1632764618974;
        Mon, 27 Sep 2021 10:43:38 -0700 (PDT)
Received: from thuth.remote.csb (p549bb2bd.dip0.t-ipconnect.de. [84.155.178.189])
        by smtp.gmail.com with ESMTPSA id a25sm158782wmj.34.2021.09.27.10.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 10:43:38 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 6/9] lib: s390x: Print PGM code as hex
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     david@redhat.com, linux-s390@vger.kernel.org, seiden@linux.ibm.com,
        imbrenda@linux.ibm.com
References: <20210922071811.1913-1-frankja@linux.ibm.com>
 <20210922071811.1913-7-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <dc7ea29a-62d9-b8d8-e3df-e71393f83beb@redhat.com>
Date:   Mon, 27 Sep 2021 19:43:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210922071811.1913-7-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 22/09/2021 09.18, Janosch Frank wrote:
> We have them defined as hex constants in lib/s390x/asm/arch_def.h so
> why not print them as hex values?
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/interrupt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
> index 126d4c0a..27d3b767 100644
> --- a/lib/s390x/interrupt.c
> +++ b/lib/s390x/interrupt.c
> @@ -169,7 +169,7 @@ static void print_pgm_info(struct stack_frame_int *stack)
>   		  lc->pgm_old_psw.addr <= (uintptr_t)sie_exit);
>   
>   	printf("\n");
> -	printf("Unexpected program interrupt %s: %d on cpu %d at %#lx, ilen %d\n",
> +	printf("Unexpected program interrupt %s: %#x on cpu %d at %#lx, ilen %d\n",
>   	       in_sie ? "in SIE" : "",
>   	       lc->pgm_int_code, stap(), lc->pgm_old_psw.addr, lc->pgm_int_id);
>   	print_int_regs(stack);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

