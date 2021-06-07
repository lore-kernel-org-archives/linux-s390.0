Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3283C47082
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 09:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839D26008E
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 09:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhFGJ5m (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 7 Jun 2021 05:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50055 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230255AbhFGJ5l (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Jun 2021 05:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623059750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wkHX6pObXanNlJ8UdRQUA8q1lmcsT7SZQ8EkbY0Tba0=;
        b=YCOEEjgaGN2f9pMCYnCsmRdUFmWlMiUeD0M3peB6LVH3UwpvdG0sm2lGRQ6JxpUBo6xddi
        W5lAug4CrLT0m0XfKMAk1zONwxrji56PgsxWjFuXvn0zjMfwlziMPz2l0i6/g6r7fiYT0e
        1Td4jOJ4TEKv4Gm2KTS1HB6rFex4NRg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-Hrn4LPtAOhSsTeL4XK8c9w-1; Mon, 07 Jun 2021 05:55:49 -0400
X-MC-Unique: Hrn4LPtAOhSsTeL4XK8c9w-1
Received: by mail-wr1-f72.google.com with SMTP id u5-20020adf9e050000b029010df603f280so7619060wre.18
        for <linux-s390@vger.kernel.org>; Mon, 07 Jun 2021 02:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wkHX6pObXanNlJ8UdRQUA8q1lmcsT7SZQ8EkbY0Tba0=;
        b=o/BfLcfRt1n1ymjIRcbJ3J1Qmp9EYwIVRH/CFSVamDVG/P5pj2c3hK5EY0pTwa83IV
         FzgBJMJBaGCCy12/Os3TSd04T2NbyNaSvduRINryxYT2K7pMHo7/0nYQ2dH0wRHXyO+x
         6PLUlj5qHg2hfwmX9ZcDtdnp2Q89+/+zkazY4NauIwiZQXrSrLdVdRCepWnm0Prnj+Tw
         SVnqTwo4IBlJx8AKV28HJ0kHJ2qLaDVYdzVJSGWeZkaBScUE7LCSIEac9fhDTVYsni1v
         RlrSO0zUWGpZroRg11DSIWM/LXSOUHYThIHNBe48w61ogOnV/Ase1/zmWR7cz8btQAe6
         YnoQ==
X-Gm-Message-State: AOAM531LLYxSPOXTXuDxKu/VwDm/pZw/9p5zbvVg+Mw+ZOtUrYeY0aV4
        9j+lSNtvH8mCLAUkjutSat4s2nUjCWNlHrLSTctYuL9rPwdtm8wvLhXC5NulO/ymJli7bf6Ywva
        17zQFUT9nvjkz1ww2MEP5uOz6pdVAmzQ+VoT1Ml/E8JR2Z/BfJmOV9BTWs3ogWYoYQeefQQ==
X-Received: by 2002:a05:6000:50d:: with SMTP id a13mr15852522wrf.130.1623059748329;
        Mon, 07 Jun 2021 02:55:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6moH5xg7FDfTLpCOtRTgo0mbOP7tmH+soh2teAVItLpQbTOitZXCEX1x8kJ7qbpgUAaIEQQ==
X-Received: by 2002:a05:6000:50d:: with SMTP id a13mr15852503wrf.130.1623059748102;
        Mon, 07 Jun 2021 02:55:48 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6188.dip0.t-ipconnect.de. [91.12.97.136])
        by smtp.gmail.com with ESMTPSA id l31sm2247988wms.31.2021.06.07.02.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 02:55:47 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 1/3] s390x: Don't run PV testcases under
 tcg
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     thuth@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org
References: <20210318125015.45502-1-frankja@linux.ibm.com>
 <20210318125015.45502-2-frankja@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <10456eb5-b473-7eea-3fb7-1da08e5a9ce8@redhat.com>
Date:   Mon, 7 Jun 2021 11:55:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210318125015.45502-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18.03.21 13:50, Janosch Frank wrote:
> The UV call facility is only available on hardware.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   scripts/s390x/func.bash | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/s390x/func.bash b/scripts/s390x/func.bash
> index b3912081..bf799a56 100644
> --- a/scripts/s390x/func.bash
> +++ b/scripts/s390x/func.bash
> @@ -21,6 +21,9 @@ function arch_cmd_s390x()
>   	"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
>   
>   	# run PV test case
> +	if [ "$ACCEL" = 'tcg' ]; then
> +		return
> +	fi
>   	kernel=${kernel%.elf}.pv.bin
>   	testname=${testname}_PV
>   	if [ ! -f "${kernel}" ]; then
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

