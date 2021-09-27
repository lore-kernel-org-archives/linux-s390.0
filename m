Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6354C433F5
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 17:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF88460F9B
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 17:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbhI0Rsx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 27 Sep 2021 13:48:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236379AbhI0Rsn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 27 Sep 2021 13:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632764825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ryDhvxI0D4+x5a2eZW+6+xV/dil48ItaFsqys1pNbt0=;
        b=Y4cBvpljCuyqceqX/J0P5Z3yFLs8Ej8F2jqqrCkGmr3IA9SNdqTbGXeeIL++BUCpeQs+JF
        uKoA/C3uKi7nPn1dcHqDFLoKz/mw6JoxJ5VV2KZUpKYyjs9HBSiYpo9sKxm7XGmwroJJis
        IZPQbaJahri6A+FNHPKT1vCxws9mjgI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-Nl1cGz6qNxmwKsNGUtZJfg-1; Mon, 27 Sep 2021 13:47:03 -0400
X-MC-Unique: Nl1cGz6qNxmwKsNGUtZJfg-1
Received: by mail-wr1-f72.google.com with SMTP id a17-20020adfed11000000b00160525e875aso6812010wro.23
        for <linux-s390@vger.kernel.org>; Mon, 27 Sep 2021 10:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ryDhvxI0D4+x5a2eZW+6+xV/dil48ItaFsqys1pNbt0=;
        b=VdeMIKoFomHdZkyuk1lna3cL5tOpz8xJ1xANWb1R0Iw5NI3jDKfoMp+wSK0lfDiebQ
         Swwyo6LcOsEKGU0emuUd1juhVkam1rU2xDhpTxmtZe0d9X/7iqA1FhsrOiEamgsH8/2N
         uNphgjuq9GIDJVkqNAiLJUco+bRixGGUTv6bEyoWA5Ed7B/8NUfq1fbCkUxdC2JUULnJ
         ecoaL/S5dVfRfJZIKFTS9CxKnPYql8qGpStqPr+1aMkvez4iF36JadQZkiTSKIQeUSVC
         aR/i3KJ7pyI7A9HS9V/LZtQCjMFCH1NwSxXyrVNGw2oPo1cJVyGKDcIrxZMj0LXBABD7
         rDjg==
X-Gm-Message-State: AOAM530QOcUhPggtUwArIsyjoLEebHdlT4omSi2k+1NwjLFg3Qob/bTD
        l+MpcOeuPsAkbu4miWS8EueUfWUyvcGYf0c5LoPP7rLhjLA1D3KLRJs6NxqEiHVqBLt2KOOoCMb
        8XOUk202W6h8IYY1ydqSdBA==
X-Received: by 2002:adf:e783:: with SMTP id n3mr1332534wrm.37.1632764821988;
        Mon, 27 Sep 2021 10:47:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwG+02rrPNofwdceC460HuS7nCJCrPJYQ1riXHwCvcpyjKPJT0xMmfSiF/IGwq7Y/JE3c3Yyw==
X-Received: by 2002:adf:e783:: with SMTP id n3mr1332519wrm.37.1632764821806;
        Mon, 27 Sep 2021 10:47:01 -0700 (PDT)
Received: from thuth.remote.csb (p549bb2bd.dip0.t-ipconnect.de. [84.155.178.189])
        by smtp.gmail.com with ESMTPSA id c30sm17398156wrb.74.2021.09.27.10.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 10:47:01 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 7/9] s390x: Makefile: Remove snippet
 flatlib linking
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     david@redhat.com, linux-s390@vger.kernel.org, seiden@linux.ibm.com,
        imbrenda@linux.ibm.com
References: <20210922071811.1913-1-frankja@linux.ibm.com>
 <20210922071811.1913-8-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <329948a8-b4ea-1c4a-5392-3fd6aa8540f6@redhat.com>
Date:   Mon, 27 Sep 2021 19:47:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210922071811.1913-8-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 22/09/2021 09.18, Janosch Frank wrote:
> We can't link the flatlib as we do not export everything that it needs
> and we don't (want to) call the init functions.
> 
> In the future we might implement a tiny lib that uses select lib

s/select/selected/ ?

> object files and re-implements functions like assert() and
> test_facility() to be able to use some parts of the lib.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/s390x/Makefile b/s390x/Makefile
> index 5d1a33a0..d09c0a17 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -92,7 +92,7 @@ $(SNIPPET_DIR)/asm/%.gbin: $(SNIPPET_DIR)/asm/%.o $(FLATLIBS)
>   	$(OBJCOPY) -I binary -O elf64-s390 -B "s390:64-bit" $@ $@
>   
>   $(SNIPPET_DIR)/c/%.gbin: $(SNIPPET_DIR)/c/%.o $(snippet_asmlib) $(FLATLIBS)
> -	$(CC) $(LDFLAGS) -o $@ -T $(SRCDIR)/s390x/snippets/c/flat.lds $(patsubst %.gbin,%.o,$@) $(snippet_asmlib) $(FLATLIBS)
> +	$(CC) $(LDFLAGS) -o $@ -T $(SRCDIR)/s390x/snippets/c/flat.lds $(patsubst %.gbin,%.o,$@) $(snippet_asmlib)

Don't we need memcpy() and friends in some cases? ... well, likely not, 
otherwise linking would fail... So:

Reviewed-by: Thomas Huth <thuth@redhat.com>

