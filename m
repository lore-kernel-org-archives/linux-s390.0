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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A2BC47082
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 09:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B10F61130
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 09:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFGJsy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 7 Jun 2021 05:48:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230200AbhFGJsx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Jun 2021 05:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623059222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eDC5Gg9PMJ8D90yo3uH4QtVW+Fhvs8D9cIZIY9SdUQE=;
        b=XYIhc6XeBIJLKF35g/Ay/dHq+mluOEbvwOM91hF5Q6LIFSoU8MnCgMQVytKv0WgIYfUhqe
        6LZZQYWCs2s80/usTc1KFsWjMydBTs+SyEgwwl62HaYdmIh5JkXXoMYc3HzgZgaSde2hA7
        ygxS7dQxfpcZk/YbNTAW0MjAw09cuU0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-Ba1rgVktP4WkxmD-VT_a-g-1; Mon, 07 Jun 2021 05:46:52 -0400
X-MC-Unique: Ba1rgVktP4WkxmD-VT_a-g-1
Received: by mail-wr1-f72.google.com with SMTP id m27-20020a056000025bb0290114d19822edso7607788wrz.21
        for <linux-s390@vger.kernel.org>; Mon, 07 Jun 2021 02:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eDC5Gg9PMJ8D90yo3uH4QtVW+Fhvs8D9cIZIY9SdUQE=;
        b=VBb8RsJyT5LWX2gezUxRnMe7FPV1Min6wGx671OrwU92DxdkcD8bSY+MNnkCTqeFrw
         ZfJZopZv1zTT99xmj3yVDUniiL64CRhc536GWA4Ts8rMuzF9uOyMOyaYTkuQB8iF0dHp
         s+Ugv0lnomWx0EWXq86hCI9BkT/RzfgFNEVU1lejFSaBCxfTos0LxaIRnD2PnQLOgEy7
         Ph+MAMeYZucZeyF5VZviQJv3twt9vdKx0US3NrHjYFPul8lhu+4AAoIrZ0p505sRyHJ7
         LWkGwfcM3hGpGb7m1dhUhKpbVvzECFeFUZiiWFa6nxLNg6aZevz4WoABufNkrnidkeTW
         q1kA==
X-Gm-Message-State: AOAM531FtRAnij7Hh4AJktvvMswdDWZRQvt36/34S8WMmO/4yhcmbrpS
        K6n7wqeeYyY5n30Ixdwu4G1NrH1xfiyn/8MLc19j5juEcWeO1P5Tw8KIEm2zoBV6Xji3+of2x/V
        gWbmuOTDnZ+YUxxzqU+EtIVZOqvun4zxVXDWtqgwX8yYR26E+S2XcWlX6+W8jndz9rb1NYQ==
X-Received: by 2002:a5d:630f:: with SMTP id i15mr16045778wru.155.1623059210948;
        Mon, 07 Jun 2021 02:46:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7yUn1EBw8AQzKvxX7emcvlSe6/C0uAbBIg0m2i6ZiXMXtkO1i9hCVQynyYvhXd1llqIfeHg==
X-Received: by 2002:a5d:630f:: with SMTP id i15mr16045761wru.155.1623059210694;
        Mon, 07 Jun 2021 02:46:50 -0700 (PDT)
Received: from thuth.remote.csb (pd957536e.dip0.t-ipconnect.de. [217.87.83.110])
        by smtp.gmail.com with ESMTPSA id 32sm16773659wrs.5.2021.06.07.02.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 02:46:50 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 1/3] s390x: Don't run PV testcases under
 tcg
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org
References: <20210318125015.45502-1-frankja@linux.ibm.com>
 <20210318125015.45502-2-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <65c4318b-5319-48e2-5e81-b20a3de66e53@redhat.com>
Date:   Mon, 7 Jun 2021 11:46:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210318125015.45502-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18/03/2021 13.50, Janosch Frank wrote:
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

Reviewed-by: Thomas Huth <thuth@redhat.com>

