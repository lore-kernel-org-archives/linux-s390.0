Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BDCC4332F
	for <linux-s390@archiver.kernel.org>; Wed, 23 Nov 2022 00:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiKWA4W (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 22 Nov 2022 19:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiKWA4V (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 22 Nov 2022 19:56:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECB9C723E
        for <linux-s390@vger.kernel.org>; Tue, 22 Nov 2022 16:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669164918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aF7/2foVpEFS7EtJrtidG83b2asU3hWjYsy4BUecKfU=;
        b=FIHw5TaGr6oQp7joJdwp3Y4GrgorfdwUZ9yUSwXYAyKRYcdEn7ZRw2g90DLz0kNqFIGMGx
        5QSUekeFNnGtIb+61EGp4CD/Fx2AKaNXzrHyJQEeRwyjhgPcumEmB7ZX2swfinvFPZKPwI
        6HbGs6GjDImOE8I50SwO8ZZQ0iK3TvM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-146-_R3h57iqM5ym3v9TW1jPOw-1; Tue, 22 Nov 2022 19:55:16 -0500
X-MC-Unique: _R3h57iqM5ym3v9TW1jPOw-1
Received: by mail-pf1-f200.google.com with SMTP id y23-20020aa78057000000b00574277cb386so1255653pfm.16
        for <linux-s390@vger.kernel.org>; Tue, 22 Nov 2022 16:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF7/2foVpEFS7EtJrtidG83b2asU3hWjYsy4BUecKfU=;
        b=uaXhslBieF5KY0WiZSonA5aps7Q2ETXC8F6+E9eM7MebgvVhidFQ1FFxb8ZnXybsoR
         ttCtaMe77MyLTfMZdy7piAtFKN+yh4DKpG8aj8Cf84iXlIAMO/Am0l7nQhu30mnp4xtc
         6qA3KJCBJZVxfXgP7KAGZ5m4ijc5jMDFBoy5XKsRW+dpPDVhGTGOzpTyqECGAinxx0W+
         rY5KBcOPQceK7n8oinSd/37UqePapywvLgN/Fb2Ujnv7WqALUw01HqycxJAsooVPgM45
         L43TJldYYemq96YDLWQ2LWIH8+lsQnx78He3cav4FBHX/Hu04hXczA4kRIsuBXeM3UcZ
         L+Ug==
X-Gm-Message-State: ANoB5pmIkw1zynYCmhjhfLlW1qiUoj1lEevN5Ky6jo11uUrv3L/biIHj
        /ADTJKV1nMvq85wdtFyFEVy/u5jcBvs1i04J3Y/MRPVwaTSXv9WbHMg4gZ074jMV67DwucEO/XF
        JCXUKIJSKADHd41M+W0yqoQ==
X-Received: by 2002:a63:565e:0:b0:46e:bcc1:a28f with SMTP id g30-20020a63565e000000b0046ebcc1a28fmr5986147pgm.408.1669164915689;
        Tue, 22 Nov 2022 16:55:15 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6SY5uzfyZkQfox6l1AVbBTdoWvAzzF3EYm8zF40IS7nL6i4eU6Gl7YQvDisX2vPoUAGKlnHw==
X-Received: by 2002:a63:565e:0:b0:46e:bcc1:a28f with SMTP id g30-20020a63565e000000b0046ebcc1a28fmr5986133pgm.408.1669164915365;
        Tue, 22 Nov 2022 16:55:15 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090a67c400b00212735c8898sm155313pjm.30.2022.11.22.16.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 16:55:14 -0800 (PST)
Date:   Wed, 23 Nov 2022 08:52:51 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     kexec@lists.infradead.org, Matthew Garrett <mjg59@srcf.ucam.org>,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Philipp Rudo <prudo@redhat.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Matthew Garrett <mjg59@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH] lockdown: s390: kexec_file: don't skip signature
 verification when not secure IPLed
Message-ID: <20221123005251.h4t2t2lv6tqb5nrp@Rk>
References: <20221121072715.836323-1-coxu@redhat.com>
 <your-ad-here.call-01669130104-ext-3635@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <your-ad-here.call-01669130104-ext-3635@work.hours>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Nov 22, 2022 at 04:15:04PM +0100, Vasily Gorbik wrote:
>On Mon, Nov 21, 2022 at 03:27:15PM +0800, Coiby Xu wrote:
>> --- a/arch/s390/kernel/machine_kexec_file.c
>> +++ b/arch/s390/kernel/machine_kexec_file.c
>> @@ -33,10 +33,6 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
>>  	unsigned long sig_len;
>>  	int ret;
>>
>> -	/* Skip signature verification when not secure IPLed. */
>> -	if (!ipl_secure_flag)
>> -		return 0;
>
>Looking at s390_verify_sig() especially before commit 0828c4a39be5
>("kexec, KEYS, s390: Make use of built-in and secondary keyring for
>signature verification") I think this condition actually expresses
>2 things:
>1. the firmware is secure IPL capable and secure IPL keys are
>   provided and present in platform keyring.
>2. secure IPL is enabled.
>
>Wouldn't this change have implications for machines with older firmware
>which doesn't support secure IPL? In this case platform keyring won't
>have any secure IPL keys (since firmware doesn't provide them)
>and any properly signed kernels will be rejected for kexec in this
>function. Unless secure IPL keys are also present in built-in or secondary
>keyring (which is possible after commit 0828c4a39be5) - is that what
>distributions normally do?

Thanks for pointing me to the above commit and reminding me older
firmware doesn't support secure IPL! But I don't think this change will
break machines with older firmwares which doesn't support secure IPL.
Distributions like Fedora/RHEL have downstream-only patch that enable
lockdown automatically when secure boot is enabled. Since there is no
secure IPL, lockdown won't be enabled which means
kimage_validate_signature (kernel/kexec_file.c) doesn't enforce
signature verification (sorry I should change the commit subject which
is misleading). For the case where users manually enables lockdown, I
assume they know what lockdown means and expect signature verification
to be enforced instead to be silently bypassed.

-- 
Best regards,
Coiby

