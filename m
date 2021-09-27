Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783F1C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 17:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F60E6058D
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 17:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbhI0Rnn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 27 Sep 2021 13:43:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238273AbhI0Rna (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 27 Sep 2021 13:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632764511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Rt9qT67yf6Pyb+8KXiGshS9FYAzTa8kXZ1NwXtcm+0=;
        b=D5uWDQQSzdfwvMjsvZAgmMmAEUHSlDmzeBZSJQehjDjxDZrKe0MIqLcgD7GtISkru9UCXE
        OsCUzoww9gYxnivJ5V41aD4LL4O0QMY21LAerFkHWoNZi4Gmw5mRYyhK5A1T6UKgJ3zEZ7
        s+VBWRLI2C6eetRZ+vB0RehWSCAj9E8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-08Z1BQlqNK2DHtnHK_ldEw-1; Mon, 27 Sep 2021 13:41:50 -0400
X-MC-Unique: 08Z1BQlqNK2DHtnHK_ldEw-1
Received: by mail-wm1-f69.google.com with SMTP id v5-20020a1cac05000000b0030b85d2d479so553137wme.9
        for <linux-s390@vger.kernel.org>; Mon, 27 Sep 2021 10:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Rt9qT67yf6Pyb+8KXiGshS9FYAzTa8kXZ1NwXtcm+0=;
        b=3a2Ry/2R0T51aQC/kQmlUSzAv1bKJrXANH0rgOVAul17wfn13ew4+VwNMmdicS3Wmm
         AREBXTwAy4uQ++iDnxWrETsVekQRty5vgUB+NbiUo+hb83rNcckWiv+XJUIU0oaovLOg
         9PjyLOWwaskdLjZ8/P/crFM1YXN0mw0+BVkSaSWEtw3zKOhnBQXo5wVhP4c6h9wRakYq
         k+UW2CtPUgq7idlqeHMDVmLy59w9jGtyptNKERxUlwdaaE9bvo+5QbGDufAmbsUsEAg+
         d1XzYwZqPNKQ7Bt2Ol3n+k7h+NBIIrX6orCiiJJ2pd6qvieMaiRld6AqJMotqR4Z7jkz
         GScQ==
X-Gm-Message-State: AOAM531KVoBMSKiGHW88rXcar99ZqWGIldNiKGI/hNaO5T3MDTkG950Z
        bfdiWx5lJ7vDR7aEG1ukMvXwsh1h6n9ZzM2BUZvMw0U9RMGSOGWZ/WfTN7Z0S0MLXLtZpzw2ZWY
        YiV+pUKUitPI+YzFjXHdpgQ==
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr321082wmd.17.1632764509430;
        Mon, 27 Sep 2021 10:41:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQ1+eoNtpGMQr1DRUlfIXcJoZBO20R0H/6CG5qcAELeaeqEP/+0t0EJCosYC3ygoR8XTwWAw==
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr321070wmd.17.1632764509281;
        Mon, 27 Sep 2021 10:41:49 -0700 (PDT)
Received: from thuth.remote.csb (p549bb2bd.dip0.t-ipconnect.de. [84.155.178.189])
        by smtp.gmail.com with ESMTPSA id u2sm4511702wrr.35.2021.09.27.10.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 10:41:48 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 5/9] lib: s390x: uv: Add UVC_ERR_DEBUG
 switch
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     david@redhat.com, linux-s390@vger.kernel.org, seiden@linux.ibm.com,
        imbrenda@linux.ibm.com
References: <20210922071811.1913-1-frankja@linux.ibm.com>
 <20210922071811.1913-6-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <30a104a3-02a1-58a7-2377-de6221e7d20b@redhat.com>
Date:   Mon, 27 Sep 2021 19:41:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210922071811.1913-6-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 22/09/2021 09.18, Janosch Frank wrote:
> Every time something goes wrong in a way we don't expect, we need to
> add debug prints to some UVC to get the unexpected return code.
> 
> Let's just put the printing behind a macro so we can enable it if
> needed via a simple switch.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/asm/uv.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
> index 2f099553..0e958ad7 100644
> --- a/lib/s390x/asm/uv.h
> +++ b/lib/s390x/asm/uv.h
> @@ -12,6 +12,9 @@
>   #ifndef _ASMS390X_UV_H_
>   #define _ASMS390X_UV_H_
>   
> +/* Enables printing of command code and return codes for failed UVCs */
> +#define UVC_ERR_DEBUG	0

Do we maybe want a "#ifndef UVC_ERR_DEBUG" in front of this, so that we 
could also set the macro to 1 from individual *.c files (or from the Makefile)?

  Thomas

