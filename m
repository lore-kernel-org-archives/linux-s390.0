Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E60E95A8E
	for <linux-s390@archiver.kernel.org>; Mon,  9 Oct 2023 11:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbjJILa7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 9 Oct 2023 07:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbjJILax (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Oct 2023 07:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1401703
        for <linux-s390@vger.kernel.org>; Mon,  9 Oct 2023 04:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696850986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N7mGg0R3DrljgvJw1y1ejeFG5groXtawWx848a8zT7M=;
        b=Wq79EOwlrkBxw3+Hr6gKVFqS43VC28gAcB3RKTEveBZK2b8YB1ReNuOpGgA6P4jn9lIZwo
        dBV0/tPKyD0Mnkv2i6hQM5DmCaag3taypqDCZKLe7v6fBDZDXmmaa0mzn3gL5jXMq9KBpE
        UOSIR7T1qZxMRUVskFIwf/TeWKaj9ec=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-EsASE0bPPhqJpbgqUI4Vyg-1; Mon, 09 Oct 2023 07:29:41 -0400
X-MC-Unique: EsASE0bPPhqJpbgqUI4Vyg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-418ce89e56cso53927551cf.0
        for <linux-s390@vger.kernel.org>; Mon, 09 Oct 2023 04:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696850981; x=1697455781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7mGg0R3DrljgvJw1y1ejeFG5groXtawWx848a8zT7M=;
        b=CQsIUA8LNXa4DtjOazrjF1829J+JRQnLkS4WbbvNhFvEzNTY3lr7GXSAdd+KwzZ/e0
         uvfFG9uA2PxVD1siJjD+RrFdZiyte3tlUoir5Y5hqs73ii7Tw/umYnThxr2USfVb+aJT
         nojjt/bBBJ7oQGistfa73O9Sl228/G4xif0B+X3a6IldUwFU39hFpPTHg87NVJ5G5CQm
         uKqr0nOCa0ABaCQuotLXTFXK+wAAl6yloLmrodYJ0WHamrJ3a0mskWKzelFjUXuOPLkV
         Nh7mn18oKhnssG3hMbonRRdZepBlaOjOdsgZZwzZXIxRFxGtNaxBd62gc4w3G7wymxTV
         L8Uw==
X-Gm-Message-State: AOJu0YyQrdgzucGI5Q/H4q7Z/oeT33Ciu3xa1k6yuHrohUZ2zMIeyXJ8
        yegXU6gCjoUGMRxQM+mL/0oygldIIMWk+1TV6qUNCitDmndV8CYtbDE/QXo/XwTsrBWWqrAMLd7
        zhL7GQZcES9yWCnrRABN7LQ==
X-Received: by 2002:a05:6214:5ece:b0:65c:fec4:30a1 with SMTP id mn14-20020a0562145ece00b0065cfec430a1mr16083511qvb.55.1696850981414;
        Mon, 09 Oct 2023 04:29:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqNXr7WTdcy5s+sDGx50As8M2XI8LIkeXeM5nKPCfmHcAFZLWCxvpJzCcvYF/o5/ZKNSoq2A==
X-Received: by 2002:a05:6214:5ece:b0:65c:fec4:30a1 with SMTP id mn14-20020a0562145ece00b0065cfec430a1mr16083496qvb.55.1696850981156;
        Mon, 09 Oct 2023 04:29:41 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-27.web.vodafone.de. [109.43.176.27])
        by smtp.gmail.com with ESMTPSA id l19-20020a0ce513000000b006616fbcc077sm3811795qvm.129.2023.10.09.04.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 04:29:40 -0700 (PDT)
Message-ID: <082a6b8b-6138-bf42-3f5e-0c2995bfe382@redhat.com>
Date:   Mon, 9 Oct 2023 13:29:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [kvm-unit-tests PATCH v1] arch-run: migration: properly handle
 crashing outgoing QEMU
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, pbonzini@redhat.com, andrew.jones@linux.dev
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230926120828.1830840-1-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230926120828.1830840-1-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 26/09/2023 14.08, Nico Boehr wrote:
> When outgoing (live) QEMU crashes or times out during migration, we
> currently hang forever.
> 
> This is because we don't exit the loop querying migration state when QMP
> communication fails.
> 
> Add proper error handling to the loop and exit when QMP communication
> fails for whatever reason.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
> Sorry I accidentally sent this only to s390x maintainers and forgot
> Paolo and Andrew, hence resending.
> 
>   scripts/arch-run.bash | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
> index 518607f4b75d..de9890408e24 100644
> --- a/scripts/arch-run.bash
> +++ b/scripts/arch-run.bash
> @@ -162,8 +162,14 @@ run_migration ()
>   	migstatus=`qmp ${qmp1} '"query-migrate"' | grep return`
>   	while ! grep -q '"completed"' <<<"$migstatus" ; do
>   		sleep 1
> -		migstatus=`qmp ${qmp1} '"query-migrate"' | grep return`
> -		if grep -q '"failed"' <<<"$migstatus" ; then
> +		if ! migstatus=`qmp ${qmp1} '"query-migrate"'`; then
> +			echo "ERROR: Querying migration state failed." >&2
> +			echo > ${fifo}
> +			qmp ${qmp2} '"quit"'> ${qmpout2} 2>/dev/null
> +			return 2
> +		fi
> +		migstatus=`grep return <<<"$migstatus"`
> +		if grep -q '"failed"' <<<"$migstatus"; then
>   			echo "ERROR: Migration failed." >&2
>   			echo > ${fifo}
>   			qmp ${qmp1} '"quit"'> ${qmpout1} 2>/dev/null

Reviewed-by: Thomas Huth <thuth@redhat.com>

and pushed to the repository.

