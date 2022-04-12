Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EA0C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 12 Apr 2022 10:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244066AbiDLKmD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354753AbiDLKdm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Apr 2022 06:33:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A04C5BD06
        for <linux-s390@vger.kernel.org>; Tue, 12 Apr 2022 02:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649756033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WeWevPYgNWBpJXA96t4hpuZdB+k5JbdqpxXMJm2gkXs=;
        b=XfhQdusdJRRxz/6gnbVA93B8o+tDTH2IXZxjyvCmrCsZFFr0DHPeKhZOy8CM7m/oo7xj/V
        Nx8mSrntf4ib7VTbT5vC3v6BWFtVkHr60liJnhH6HOaXxNE5v2M+UiayJpYH26jqBzRLlx
        E+W1/STUXpg0mofGbLT1CHV/x5nRE4Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-vDKqmeZ0NjWzQ3VBiSt7Eg-1; Tue, 12 Apr 2022 05:33:51 -0400
X-MC-Unique: vDKqmeZ0NjWzQ3VBiSt7Eg-1
Received: by mail-wm1-f72.google.com with SMTP id c125-20020a1c3583000000b0038e3f6e871aso5736162wma.8
        for <linux-s390@vger.kernel.org>; Tue, 12 Apr 2022 02:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WeWevPYgNWBpJXA96t4hpuZdB+k5JbdqpxXMJm2gkXs=;
        b=Od/XJqgxeu8NZYmzspnW0dPJFwBuA+6lSCoFc/3RdOp1h3GLpnuF7rdPdpc5KD6ayy
         uHF5aRHKfrKfogQlxrTR+7cSmTC+kylBNv35SYX4x9XmgG+boJHFBS6H0amdI6uQWwaZ
         XoKigg9rEjl0UeMNYligudZwM9o0QYWPLNwrCX3Jv3wVodleIcBg/TuqwDVxkea9iS6U
         B8/cy53jYyU4FmxSag7mH41pUGvBTG3u0I8jeZLo4qN103GhTPw59YWW/Ov2BUMI+zhS
         HOxDnNy21D9p6mHtBQbTbrc3B/k4RbCYE3YZmtamq+dEg2EvWR9YUt47bm8r/kBHBo2x
         5Tsw==
X-Gm-Message-State: AOAM530O0zB1V+qexeXGIv7K5ANHsFVVhwbSDsPiITAAt3uDhNEC0ebr
        ONcozk2QVwE1WJio/6RKrV/4Mua0aErPgYG20+8FyTM+CYCYuedWk8p4ZVSz7ZwSHxomlurjchH
        MoxgiaCJ0VO6IK7Oyl3Acmg==
X-Received: by 2002:a05:600c:4ecc:b0:38e:354d:909 with SMTP id g12-20020a05600c4ecc00b0038e354d0909mr3381787wmq.33.1649756030227;
        Tue, 12 Apr 2022 02:33:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQZ8YWhTQHJqSTnxz84V1suA86KaCiCkNGpqspOSTk2riKnfCekPnWy6Y4EwJ69895Ace0Cw==
X-Received: by 2002:a05:600c:4ecc:b0:38e:354d:909 with SMTP id g12-20020a05600c4ecc00b0038e354d0909mr3381779wmq.33.1649756030060;
        Tue, 12 Apr 2022 02:33:50 -0700 (PDT)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id v8-20020a1cf708000000b0034d7b5f2da0sm1926370wmh.33.2022.04.12.02.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 02:33:49 -0700 (PDT)
Message-ID: <d458e729-1497-b3d7-16fc-eac3e6c54945@redhat.com>
Date:   Tue, 12 Apr 2022 11:33:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [kvm-unit-tests PATCH v1 1/3] s390x: epsw: fix
 report_pop_prefix() when running under non-QEMU
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc:     frankja@linux.ibm.com, imbrenda@linux.ibm.com
References: <20220412092941.20742-1-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220412092941.20742-1-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12/04/2022 11.29, Nico Boehr wrote:
> When we don't run in QEMU, we didn't push a prefix, hence pop won't work. Fix
> this by pushing the prefix before the QEMU check.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   s390x/epsw.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/s390x/epsw.c b/s390x/epsw.c
> index 5b73f4b3db6c..d8090d95a486 100644
> --- a/s390x/epsw.c
> +++ b/s390x/epsw.c
> @@ -97,13 +97,13 @@ static void test_epsw(void)
>   
>   int main(int argc, char **argv)
>   {
> +	report_prefix_push("epsw");
> +
>   	if (!host_is_kvm() && !host_is_tcg()) {
>   		report_skip("Not running under QEMU");
>   		goto done;
>   	}
>   
> -	report_prefix_push("epsw");
> -
>   	test_epsw();
>   
>   done:

Reviewed-by: Thomas Huth <thuth@redhat.com>

