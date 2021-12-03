Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D39C433F5
	for <linux-s390@archiver.kernel.org>; Fri,  3 Dec 2021 11:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380327AbhLCLSe (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 3 Dec 2021 06:18:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380319AbhLCLSe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Dec 2021 06:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638530110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G45w1FLYygVqAzFHywO4cY0u523vQldmgJZptWKg5q0=;
        b=YPUuwN9TZ+IM+94um95XusQyUvHFqOu0a9/9yFQOV6udDpSk8KWwY1sfuSMUsM9FB46mqG
        qPuvVktIOz+gS0n4/FL4Mu0jcTOVmH2LWlc2lClo8BGRtGqtiKGQY1/ZPxwGvRO6NeHTgB
        43mybHwAaKutHU2rnEMDvEBZzEsnYQU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-irrbRYIEPVKJbxf_h8J_GA-1; Fri, 03 Dec 2021 06:15:09 -0500
X-MC-Unique: irrbRYIEPVKJbxf_h8J_GA-1
Received: by mail-wm1-f71.google.com with SMTP id g11-20020a1c200b000000b003320d092d08so1363987wmg.9
        for <linux-s390@vger.kernel.org>; Fri, 03 Dec 2021 03:15:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=G45w1FLYygVqAzFHywO4cY0u523vQldmgJZptWKg5q0=;
        b=r5p1k2zPKr7Jvlns16p3kPa4/h/hakUgGfvlNEky0V2+Q2jhqXI+3J0RtjHbAVIRyH
         AUfoUl7cfuFfCz9eNkW9fYTj0DuB5UuoWZ6UVlZfcT+Wu2Ly46PGzVYlsX2l4TEKzW6k
         fWUtbTPVIVeaJNC8w5D6qX3s2kouNIKaDbPT81cTZZUr+1syiAQLf6lUxGmOTxCTxFkm
         xy+AmByVys3KLSR1ceeHdVEdRxe4QYLQXFwlIzW4nySmVamCyarnRwaHLxJi9GnfQgpc
         kVmtHMI/Qher04nqNX60pcTVXylnyr6ZS530d1nxiLWQzqwodEydmmkrSiQ9Dpn+siN/
         JsIA==
X-Gm-Message-State: AOAM5313Y+7tQy8vJzrx93o2pGP+hhzNWmDFr4NCdfVii/yPtPuEZdba
        IGVKo2w3+xzjCm7OY6pt6FOnEWa/iUJ+/qyP5+BEAceDH2+zJZpbueCpfkTIulwy/5l5WAQnL2s
        zdLqd5YIfRa7lZOMzMnheEw==
X-Received: by 2002:a05:6000:18a7:: with SMTP id b7mr20842121wri.308.1638530107776;
        Fri, 03 Dec 2021 03:15:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKE0VgkiuqW6DiF85/sBaycphGQAWQd2HM9sfCgQWmAoXVDJ56AUB1rd1ujLxxV7kYGpBFZg==
X-Received: by 2002:a05:6000:18a7:: with SMTP id b7mr20842073wri.308.1638530107331;
        Fri, 03 Dec 2021 03:15:07 -0800 (PST)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id d2sm2372584wmb.31.2021.12.03.03.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 03:15:06 -0800 (PST)
Message-ID: <6e8f0354-bf35-3e59-c99d-046ee1979d1f@redhat.com>
Date:   Fri, 3 Dec 2021 12:15:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <82750b44-6246-3f3c-4562-3d64d7378448@redhat.com>
 <20211125144726.1414645-1-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [kvm-unit-tests PATCH] s390x: Add strict mode to specification
 exception interpretation test
In-Reply-To: <20211125144726.1414645-1-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 25/11/2021 15.47, Janis Schoetterl-Glausch wrote:
> While specification exception interpretation is not required to occur,
> it can be useful for automatic regression testing to fail the test if it
> does not occur.
> Add a `--strict` argument to enable this.

Thank you very much for adding this!

Some comments below...

> `--strict` takes a list of machine types (as reported by STIDP)
> for which to enable strict mode, for example
> `--strict 8562,8561,3907,3906,2965,2964`
> will enable it for models z15 - z13.
> Alternatively, strict mode can be enabled for all but the listed machine
> types by prefixing the list with a `!`, for example
> `--strict !1090,1091,2064,2066,2084,2086,2094,2096,2097,2098,2817,2818,2827,2828`
> will enable it for z/Architecture models except those older than z13.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
> 
> Apparently my message with inline patch did not make it to the mailing
> list for some reason, so here's the patch again.
> 
>   s390x/spec_ex-sie.c | 59 ++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 53 insertions(+), 6 deletions(-)
> 
> diff --git a/s390x/spec_ex-sie.c b/s390x/spec_ex-sie.c
> index 5dea411..9a063f9 100644
> --- a/s390x/spec_ex-sie.c
> +++ b/s390x/spec_ex-sie.c
> @@ -7,6 +7,7 @@
>    * specification exception interpretation is off/on.
>    */
>   #include <libcflat.h>
> +#include <stdlib.h>
>   #include <sclp.h>
>   #include <asm/page.h>
>   #include <asm/arch_def.h>
> @@ -36,7 +37,7 @@ static void reset_guest(void)
>   	vm.sblk->icptcode = 0;
>   }
>   
> -static void test_spec_ex_sie(void)
> +static void test_spec_ex_sie(bool strict)
>   {
>   	setup_guest();
>   
> @@ -61,14 +62,60 @@ static void test_spec_ex_sie(void)
>   	report(vm.sblk->icptcode == ICPT_PROGI
>   	       && vm.sblk->iprcc == PGM_INT_CODE_SPECIFICATION,
>   	       "Received specification exception intercept");
> -	if (vm.sblk->gpsw.addr == 0xdeadbeee)
> -		report_info("Interpreted initial exception, intercepted invalid program new PSW exception");
> -	else
> -		report_info("Did not interpret initial exception");
> +	{
> +		const char *msg;

Could you please move the variable declaration to the beginning of the 
function? Then you could get rid of the curly brackets and one level of 
indentation.

> +		msg = "Interpreted initial exception, intercepted invalid program new PSW exception";
> +		if (strict)
> +			report(vm.sblk->gpsw.addr == 0xdeadbeee, msg);
> +		else if (vm.sblk->gpsw.addr == 0xdeadbeee)
> +			report_info(msg);
> +		else
> +			report_info("Did not interpret initial exception");
> +	}
>   	report_prefix_pop();
>   	report_prefix_pop();
>   }
>   
> +static bool parse_strict(char **argv)
> +{
> +	uint16_t machine_id;
> +	char *list;
> +	bool ret;
> +
> +	if (!*argv)
> +		return false;

I think this works ok with out current implementation of argv, but that's an 
"inofficial" implementation detail, so in case this ever gets changed, it 
might be better to check argc first before dereferencing argv here ... so 
could you please add a check for argc, too?

> +	if (strcmp("--strict", *argv))
> +		return false;
> +
> +	machine_id = get_machine_id();
> +	list = argv[1];
> +	if (!list) {
> +		printf("No argument to --strict, ignoring\n");
> +		return false;

You could also support --strict without arguments - that could turn on the 
strict mode unconditionally, I think.

> +	}
> +	if (list[0] == '!') {
> +		ret = true;
> +		list++;
> +	} else
> +		ret = false;
> +	while (true) {
> +		long input = 0;
> +
> +		if (strlen(list) == 0)
> +			return ret;
> +		input = strtol(list, &list, 16);
> +		if (*list == ',')
> +			list++;
> +		else if (*list != '\0')
> +			break;
> +		if (input == machine_id)
> +			return !ret;
> +	}
> +	printf("Invalid --strict argument \"%s\", ignoring\n", list);
> +	return ret;
> +}
> +
>   int main(int argc, char **argv)
>   {
>   	if (!sclp_facilities.has_sief2) {
> @@ -76,7 +123,7 @@ int main(int argc, char **argv)
>   		goto out;
>   	}
>   
> -	test_spec_ex_sie();
> +	test_spec_ex_sie(parse_strict(argv + 1));
>   out:
>   	return report_summary();
>   }
> 

  Thomas

