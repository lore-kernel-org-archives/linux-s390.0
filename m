Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9374C433FE
	for <linux-s390@archiver.kernel.org>; Thu,  7 Oct 2021 09:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6CF6113E
	for <linux-s390@archiver.kernel.org>; Thu,  7 Oct 2021 09:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbhJGJqI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 7 Oct 2021 05:46:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40309 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230389AbhJGJqH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Oct 2021 05:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633599854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VplPmaU1StyYkGRWpkJjJq1VIPPWnfQsc4epwDxxEuo=;
        b=hPlkNhyJlbTpbyScA19HpLWVTodQUVqjnvzyClvepKXrwYf/X7T0uaWOThk4bg8tlgp1l2
        Shz7rQ2tbf2f1v5yw86x5IzkKvaSCQWIvT7cXphYwDNIiV+eK3OLaM4v05wkz4+Ho4k6PD
        lHMXPytsv+B9AZ9QVLXoQ1a0O3iJkEM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-yEqG9VmlPI2SF4bI0mnHxg-1; Thu, 07 Oct 2021 05:44:13 -0400
X-MC-Unique: yEqG9VmlPI2SF4bI0mnHxg-1
Received: by mail-wr1-f71.google.com with SMTP id e12-20020a056000178c00b001606927de88so4215070wrg.10
        for <linux-s390@vger.kernel.org>; Thu, 07 Oct 2021 02:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VplPmaU1StyYkGRWpkJjJq1VIPPWnfQsc4epwDxxEuo=;
        b=wSgokttb8BKogk3tMSAO01x+sxjYUMXdt2ECxMin9N7n5Ry/5zv5JpA0hhqLIZa2Pm
         8U3e/GSNbPrcukcPCJjcEIp7tilUulDKLtTc4YX8OtjFlCV1CEXwBfsLPKqSrigHIJa1
         0BNe0eT1nO9jZo+/2Ttl50ZBPeCkAczF0J0BbEQ/6/KpWJvMTWFo2uGZITwilJ8z54I+
         XsvVl/zEIKmCVxgnpUd6z/u+Ij4RRs1ojySB0iAr86tDDidGjk7pIuYUMkU8TOvuHr+s
         RoAiFKSYdgcop3pZViGOyIUGPTQj18gswpvRtvZ4EDaDqprE0+UjeRIkvkwH+9n3qXEQ
         T0mA==
X-Gm-Message-State: AOAM531BX/QyqL/Glc8NDuPARIPNH2ZE8ulYw6fgL/5D2Xy1aKbh6f5C
        4NYw8BCgz6Exy41SLLAbDTJ+PpESwlYm1B//uX26+wPwXuCBbFIp/hOTMdtKDWf1nfiG3ozCpOo
        8jCuPnIsJFlFfqLB9BbFY7w==
X-Received: by 2002:a5d:64e2:: with SMTP id g2mr4122482wri.323.1633599851968;
        Thu, 07 Oct 2021 02:44:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEDcmyCCv6xjzDl/4mg+qgjtqTYB/OD3bV0KHCrlyvddXBUAlb0Yt/JRJesHR+wS+XbBcS/A==
X-Received: by 2002:a5d:64e2:: with SMTP id g2mr4122457wri.323.1633599851746;
        Thu, 07 Oct 2021 02:44:11 -0700 (PDT)
Received: from thuth.remote.csb (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id q3sm7526264wmc.25.2021.10.07.02.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 02:44:11 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH v3 9/9] s390x: snippets: Define all things
 that are needed to link the lib
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, seiden@linux.ibm.com, scgl@linux.ibm.com
References: <20211007085027.13050-1-frankja@linux.ibm.com>
 <20211007085027.13050-10-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <c3bed287-5c4c-a54b-4276-391c6cdb37f4@redhat.com>
Date:   Thu, 7 Oct 2021 11:44:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211007085027.13050-10-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 07/10/2021 10.50, Janosch Frank wrote:
> Let's just define all of the needed things so we can link libcflat.
> 
> A significant portion of the lib won't work, like printing and
> allocation but we can still use things like memset() which already
> improves our lives significantly.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/snippets/c/cstart.S | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/s390x/snippets/c/cstart.S b/s390x/snippets/c/cstart.S
> index 031a6b83..2d397669 100644
> --- a/s390x/snippets/c/cstart.S
> +++ b/s390x/snippets/c/cstart.S
> @@ -20,6 +20,20 @@ start:
>   	lghi	%r15, stackptr
>   	sam64
>   	brasl	%r14, main
> +/*
> + * Defining things that the linker needs to link in libcflat and make
> + * them result in sigp stop if called.
> + */
> +.globl sie_exit
> +.globl sie_entry
> +.globl smp_cpu_setup_state
> +.globl ipl_args
> +.globl auxinfo
> +sie_exit:
> +sie_entry:
> +smp_cpu_setup_state:
> +ipl_args:
> +auxinfo:

I think this likely could be done in a somewhat nicer way, e.g. by moving 
mem_init() and sclp_memory_setup() into a separate .c file in the lib, and 
by moving expect_pgm_int(), fixup_pgm_int() and friends into another 
separate .c file, too, so that we e.g. do not need to link against the code 
that uses sie_entry and sie_exit ... but that's a major rework on its own, 
so for the time being:

Acked-by: Thomas Huth <thuth@redhat.com>

