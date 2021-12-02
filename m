Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1F2C433F5
	for <linux-s390@archiver.kernel.org>; Thu,  2 Dec 2021 11:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357206AbhLBLQf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 2 Dec 2021 06:16:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234763AbhLBLQf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Dec 2021 06:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638443592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zDx7pyskBIHWNmIa7jFxsgFUTyyGtRftiQzsPbzbtNA=;
        b=P/4vKxMlXMmk3XGcqk8TdEqSDZJXh7nXy2d0ipf/hon+lDzUmhqOWVZ2u/HgzHvudX0i2l
        KjuztmnRHrm0OQmTSS1aNsJspBXKUqd9XTSDL1Y8dyXR+eNjpMTmNwbKrQotafV/MTL5Ep
        JaFhBtJeNoqQAw3HUh5zBCpp5hr3lI4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-WkqMhPRfNGWv4U8mC0ufSA-1; Thu, 02 Dec 2021 06:13:11 -0500
X-MC-Unique: WkqMhPRfNGWv4U8mC0ufSA-1
Received: by mail-wm1-f72.google.com with SMTP id v62-20020a1cac41000000b0033719a1a714so13806558wme.6
        for <linux-s390@vger.kernel.org>; Thu, 02 Dec 2021 03:13:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=zDx7pyskBIHWNmIa7jFxsgFUTyyGtRftiQzsPbzbtNA=;
        b=d2v2zD8zHBN2LQJik16RBZcoA4FxRWj1rNWnIIbs/rflFvRLIwIaUkjiBrmzDB1pXJ
         Q77RWvpPE+9W+Gi4/qSLdpUf8NqTAyQ38lGwj5OkTEt5ZChfgiWwtRRe/l2ziyUYPKvz
         MXopvMVuhpDXuE3Lc1+8U701T7uK4z6ERpt+x8vVefT1A/1mOXFqKHqK+zi7xmBOBjZk
         kQhviF0xl/XAOtKNMG8i6rekz2iLGKjSS987m2dY3uKFc9mRpXwU8Nsok0TIkE7PvkhN
         KfyZaOZ38f+4E9h0VgA7UveeJhZGa85kqEFglHitQXmONSeLyqduY6cnskjYWpVnMe7/
         8mhQ==
X-Gm-Message-State: AOAM530H+quD7WKzeOdOFjNYNBJsXeY3/XeujYrtkk90vZTpfZz8e/p1
        7jWAHrcb5/TY38t/e2a+gI2OF31kne8x+JTg/0AmGm1FTjqqbX4XNIWFhtBjLNCTmClds8mmymk
        wdiUZ1cN3EKbQK+9/VC6xTg==
X-Received: by 2002:adf:aa08:: with SMTP id p8mr13699008wrd.572.1638443590170;
        Thu, 02 Dec 2021 03:13:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzObIE/bfAsh/wgaVECiwfDHjoqoOJjiYXV4XCikcLWWPCsFub6kr0pn3SA7/j8ZQURAjT1w==
X-Received: by 2002:adf:aa08:: with SMTP id p8mr13698979wrd.572.1638443589924;
        Thu, 02 Dec 2021 03:13:09 -0800 (PST)
Received: from ?IPV6:2003:d8:2f44:9200:3344:447e:353c:bf0b? (p200300d82f4492003344447e353cbf0b.dip0.t-ipconnect.de. [2003:d8:2f44:9200:3344:447e:353c:bf0b])
        by smtp.gmail.com with ESMTPSA id r17sm1940286wmq.5.2021.12.02.03.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 03:13:09 -0800 (PST)
Message-ID: <95160439-2aa9-765f-9f06-16952e42a495@redhat.com>
Date:   Thu, 2 Dec 2021 12:13:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sebastian Mitterle <smitterl@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20211202095843.41162-1-david@redhat.com>
 <20211202095843.41162-3-david@redhat.com>
 <20211202120113.2dd279a8@p-imbrenda>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [kvm-unit-tests PATCH v1 2/2] s390x: firq: floating interrupt
 test
In-Reply-To: <20211202120113.2dd279a8@p-imbrenda>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

>> +static void wait_for_sclp_int(void)
>> +{
>> +	/* Enable SCLP interrupts on this CPU only. */
>> +	ctl_set_bit(0, CTL0_SERVICE_SIGNAL);
>> +
>> +	set_flag(1);
> 
> why not just WRITE_ONCE/READ_ONCE?

Because I shamelessly copied that from s390x/smp.c ;)

>> +	set_flag(0);
>> +
>> +	/* Start CPU #1 and let it wait for the interrupt. */
>> +	psw.mask = extract_psw_mask();
>> +	psw.addr = (unsigned long)wait_for_sclp_int;
>> +	ret = smp_cpu_setup(1, psw);
>> +	if (ret) {
>> +		report_skip("cpu #1 not found");
> 
> ...which means that this will hang, and so will all the other report*
> functions. maybe you should manually unset the flag before calling the
> various report* functions.

Good point, thanks!

> 
>> +		goto out;
>> +	}
>> +
>> +	/* Wait until the CPU #1 at least enabled SCLP interrupts. */
>> +	wait_for_flag();
>> +
>> +	/*
>> +	 * We'd have to jump trough some hoops to sense e.g., via SIGP
>> +	 * CONDITIONAL EMERGENCY SIGNAL if CPU #1 is already in the
>> +	 * wait state.
>> +	 *
>> +	 * Although not completely reliable, use SIGP SENSE RUNNING STATUS
>> +	 * until not reported as running -- after all, our SCLP processing
>> +	 * will take some time as well and make races very rare.
>> +	 */
>> +	while(smp_sense_running_status(1));
>> +
>> +	h = alloc_page();
> 
> do you really need to dynamically allocate one page?
> is there a reason for not using a simple static buffer? (which you can
> have aligned and statically initialized)

I don't really have a strong opinion. I do prefer dynamic alloctions,
though, if there isn't a good reason not to use them. No need to mess
with page alignments manually.

> 
>> +	memset(h, 0, sizeof(*h));
> 
> otherwise, if you really want to allocate the memory, get rid of the
> memset; the allocator always returns zeroed memory (unless you
> explicitly ask not to by using flags)

Right. "special" FLAG_DONTZERO in that semantics in that allocator.

> 
>> +	h->length = 4096;
>> +	ret = servc(SCLP_CMDW_READ_CPU_INFO, __pa(h));
>> +	if (ret) {
>> +		report_fail("SCLP_CMDW_READ_CPU_INFO failed");
>> +		goto out_destroy;
>> +	}
>> +
>> +	/*
>> +	 * Wait until the interrupt gets delivered on CPU #1, marking the
> 
> why do you expect the interrupt to be delivered on CPU1? could it not
> be delivered on CPU0?

We don't enable SCLP interrupts + external interrupts on CPU #0 because
we'll only call sclp_setup_int() on CPU #1.

> 
>> +	 * SCLP requests as done.
>> +	 */
>> +	sclp_wait_busy();
> 
> this is logically not wrong (and should stay, because it makes clear
> what you are trying to do), but strictly speaking it's not needed since
> the report below will hang as long as the SCLP busy flag is set. 

Right. But it's really clearer to just have this in the code.


-- 
Thanks,

David / dhildenb

