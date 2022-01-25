Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A14C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 25 Jan 2022 13:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575292AbiAYNES (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 Jan 2022 08:04:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1574873AbiAYNA2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Jan 2022 08:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643115625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QhLcThaEu0PlskFzQFT7M5fP0clt93A0xhvHp5D289k=;
        b=NtpYdBqjgitJAYhUpwFE/Vqq1UBe2sOeKEQdVLZawcbNKGDc5vGec3on/5jPWP0ulw65uC
        3z4mhaayMt/ETtiFbOWPR8ndHxxHd3uzNqVRGqvtFKaL6a0+LMID4BzOFIpvgilSS66r15
        oZn362XzXjrsZrCwuhq1D/6HUpkLFIE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-2TIitHoQOyex0oADBMOZsQ-1; Tue, 25 Jan 2022 08:00:21 -0500
X-MC-Unique: 2TIitHoQOyex0oADBMOZsQ-1
Received: by mail-wm1-f69.google.com with SMTP id c16-20020a1c9a10000000b0034dd409329eso1432022wme.3
        for <linux-s390@vger.kernel.org>; Tue, 25 Jan 2022 05:00:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QhLcThaEu0PlskFzQFT7M5fP0clt93A0xhvHp5D289k=;
        b=x2PJ4GP0EXzHQdll8866KEajkj2RoxgLSXbhLXgE3OR5AqLbUWTTTw8Bs6RyjWMfoX
         fvbkwDUwNyurx2Z3t3qBC9Qet+RtDVouHG8Ut492zzzfJhix1qKDZPdV9yphCOZ/CWo7
         XtUu5A7LGx8/HeetDTPir39xkkBEH3HhJM6YdchWkJ34x5N+dwIViPMR/yz3+GYLZLei
         Gc/UCjVoz1uGiZbPNIimv5mGBQLkZORr1Lgm822tm8dOW7LFGLpIGijULAusGNzhmM7V
         7wkVwV3OQIEO2xVNoeA3i3wzucAAczZMFw51E3IIkqwp9VZZuK/+9v4DnJ+rBd+5AuEy
         DMbA==
X-Gm-Message-State: AOAM532XLfu+SH45gMPQiqctlOKpcIaqnP9tclyfpB8wRY37ZmbGqiAj
        dMQmDQBcbuqbXdP69N8xQvKCv7jvrZ82Jzq5w0Jru94yEe/2TzYsVwI4Wr6wTZeh6WedNYl2YNC
        RJmy1Ynl9VygKLIuAHx3TVg==
X-Received: by 2002:adf:d1ed:: with SMTP id g13mr3352963wrd.495.1643115608024;
        Tue, 25 Jan 2022 05:00:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5h9igq4e4apmtvdHXBXtAlwPbOJYJVq3Fp0yhdWOnYTW62PA01UrRJZkdZJcOoleBxG6oIg==
X-Received: by 2002:adf:d1ed:: with SMTP id g13mr3352938wrd.495.1643115607776;
        Tue, 25 Jan 2022 05:00:07 -0800 (PST)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id b2sm9779406wrd.64.2022.01.25.05.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 05:00:07 -0800 (PST)
Message-ID: <07910e67-a506-424c-f851-d1f279e3b8df@redhat.com>
Date:   Tue, 25 Jan 2022 14:00:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH kvm-unit-tests v1 2/8] s390x: Add test for PFMF
 low-address protection
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc:     frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@redhat.com
References: <20220121150931.371720-1-nrb@linux.ibm.com>
 <20220121150931.371720-3-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220121150931.371720-3-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 21/01/2022 16.09, Nico Boehr wrote:
> PFMF should respect the low-address protection when clearing pages, hence
> add some tests for it.
> 
> When low-address protection fails, clearing frame 0 is a destructive
> operation. It messes up interrupts and thus printing test results won't
> work properly. Hence, we first attempt to clear frame 1 which is not as
> destructive.
> 
> Doing it this way around increases the chances for the user to see a
> proper failure message instead of QEMU randomly quitting in the middle
> of the test run.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/pfmf.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/s390x/pfmf.c b/s390x/pfmf.c
> index 2f3cb110dc4c..aa1305292ee8 100644
> --- a/s390x/pfmf.c
> +++ b/s390x/pfmf.c
> @@ -113,6 +113,34 @@ static void test_1m_clear(void)
>   	report_prefix_pop();
>   }
>   
> +static void test_low_addr_prot(void)
> +{
> +	union pfmf_r1 r1 = {
> +		.reg.cf = 1,
> +		.reg.fsc = PFMF_FSC_4K
> +	};
> +
> +	report_prefix_push("low-address protection");
> +
> +	report_prefix_push("0x1000");
> +	expect_pgm_int();
> +	low_prot_enable();
> +	pfmf(r1.val, (void *)0x1000);
> +	low_prot_disable();
> +	check_pgm_int_code(PGM_INT_CODE_PROTECTION);
> +	report_prefix_pop();
> +
> +	report_prefix_push("0x0");
> +	expect_pgm_int();
> +	low_prot_enable();
> +	pfmf(r1.val, 0);
> +	low_prot_disable();
> +	check_pgm_int_code(PGM_INT_CODE_PROTECTION);
> +	report_prefix_pop();
> +
> +	report_prefix_pop();
> +}
> +
>   int main(void)
>   {
>   	bool has_edat = test_facility(8);
> @@ -124,6 +152,7 @@ int main(void)
>   	}
>   
>   	test_priv();
> +	test_low_addr_prot();
>   	/* Force the buffer pages in */
>   	memset(pagebuf, 0, PAGE_SIZE * 256);
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>

