Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E040C48BC2
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 09:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3168B6115B
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 09:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhFGJ4e (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 7 Jun 2021 05:56:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49068 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230177AbhFGJ4e (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Jun 2021 05:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623059683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O+yk1vvk5M6nhVZdAiIPxD5S8BSa4ot0LAY3Z3zK7nU=;
        b=ZDWxE9fab6LjhRd/nFUTTkDs2sZooRWgTcGj87dBWeKFacm6Vf89dQ8FIWlVFjHwYKBRaq
        MF0A3y6+ixJI8+f643sp/+omRJFxcbbsRzr3C0UZS0Yy0fhOfPkCSMBNKnLAJzwrTefErq
        U7rmHSzeskAe4DCP9InbhGrwP73l/Dg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-84NpiBzUM7KiJOh_w4vVkQ-1; Mon, 07 Jun 2021 05:54:41 -0400
X-MC-Unique: 84NpiBzUM7KiJOh_w4vVkQ-1
Received: by mail-wr1-f72.google.com with SMTP id h10-20020a5d688a0000b0290119c2ce2499so2708621wru.19
        for <linux-s390@vger.kernel.org>; Mon, 07 Jun 2021 02:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O+yk1vvk5M6nhVZdAiIPxD5S8BSa4ot0LAY3Z3zK7nU=;
        b=ZuXrXqfU4zNTsbqSvg/9p0F9bJWT+4w894yFiKq3LBz1I82VyPIBu7KZyYxdXsXYEZ
         YMfoI38I5NyhXDGHs/bahkNQ32cpFAhgDTLqLi5cgvFI9Xvboull7mTAhm5FGP7OCbhV
         QtH2+olvgEMqxJk1jiHr1C16j0Izcn10LWBr6ZFfG6/cYFy40v6qgAS+mptQd/Mpi11i
         DDtgQwQqqiYjOA0KPd5X0dw2FVGruLxv+wlre4n8lYz7yGEqZJkm5qK/quQuerLOFX/d
         qIdLum0tY+eHth9+9OhqLq7o5DxKCacCsuwLPHaimn5qtGIQRLum3saNTxX76yAwC2kc
         a17g==
X-Gm-Message-State: AOAM530ztoHLER8F4xvuB+ePJLivyNkEZ+yJrKQKlkMbAELRfwGk7wRs
        +XQryauYhQZcEsd6W+agNMmFNJnYZTQdxfbVto8zTnP6iPGt1366KBrTqR6/PMFizjP3yFeY7mt
        /lahLcU8Hjaz8GGqn/LZCxW4JFIU9B/XXd9c6VVITNhZNXS+t3g8nvk70i+zGLQmbhF3hrQ==
X-Received: by 2002:a5d:6209:: with SMTP id y9mr16442467wru.50.1623059680745;
        Mon, 07 Jun 2021 02:54:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9eylN+klntKzHATJtBRS8zVzE0zWce3VnkSPto195bZq5iNDaPkxRVPjHm7PqvpVLUDgAfg==
X-Received: by 2002:a5d:6209:: with SMTP id y9mr16442451wru.50.1623059680525;
        Mon, 07 Jun 2021 02:54:40 -0700 (PDT)
Received: from thuth.remote.csb (pd957536e.dip0.t-ipconnect.de. [217.87.83.110])
        by smtp.gmail.com with ESMTPSA id m37sm7765719wms.46.2021.06.07.02.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 02:54:40 -0700 (PDT)
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org
References: <20210318125015.45502-1-frankja@linux.ibm.com>
 <20210318125015.45502-4-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 3/3] s390x: run: Skip PV tests when tcg is
 the accelerator
Message-ID: <92be69b9-227a-d01c-6877-738a4482b8c6@redhat.com>
Date:   Mon, 7 Jun 2021 11:54:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210318125015.45502-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18/03/2021 13.50, Janosch Frank wrote:
> TCG doesn't support PV.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/run | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/s390x/run b/s390x/run
> index df7ef5ca..82922701 100755
> --- a/s390x/run
> +++ b/s390x/run
> @@ -19,6 +19,11 @@ else
>       ACCEL=$DEF_ACCEL
>   fi
>   
> +if [ "${1: -7}" == ".pv.bin" ] || [ "${TESTNAME: -3}" == "_PV" ] && [ $ACCEL == "tcg" ]; then

Put $ACCEL in quotes?

With that nit fixed:

Reviewed-by: Thomas Huth <thuth@redhat.com>


> +	echo "Protected Virtualization isn't supported under TCG"
> +	exit 2
> +fi
> +
>   M='-machine s390-ccw-virtio'
>   M+=",accel=$ACCEL"
>   command="$qemu -nodefaults -nographic $M"
> 

