Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B28DC43219
	for <linux-s390@archiver.kernel.org>; Tue, 12 Apr 2022 10:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357577AbiDLKMM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238810AbiDLIkQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Apr 2022 04:40:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8301E386
        for <linux-s390@vger.kernel.org>; Tue, 12 Apr 2022 01:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649750819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DBLeI4YaJokPAygbCEyNRovV9qI9o815SAPbEDuub1s=;
        b=VP9HZnPHLYUq6O48lYJyPj0sRZTUzOvDq5xC1hh2gT1KfiJqTh9mXjWAQTznaI6q49ZEup
        vi1vGSEhve5OJ77U+K8s93ar34n609+dX6xeRAy0ivS96kiQg/9klXitrG+EgqSI8ITU5o
        f9fTTMHfVJYyszfl5ACV6rJY7J4Ba+c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-KKyosC0LO_21WxMRyL9xEQ-1; Tue, 12 Apr 2022 04:06:57 -0400
X-MC-Unique: KKyosC0LO_21WxMRyL9xEQ-1
Received: by mail-wm1-f70.google.com with SMTP id n21-20020a05600c4f9500b0038e3b0aa367so632438wmq.1
        for <linux-s390@vger.kernel.org>; Tue, 12 Apr 2022 01:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DBLeI4YaJokPAygbCEyNRovV9qI9o815SAPbEDuub1s=;
        b=EyxCPYq5160XrK5nVEJ4Ev+XmAQRA4O2gf6IEFL3fsIvki8nxs6griaFRBOZ3x8Wu7
         S79yvVcK72Nv6zEfPjy0/R3sEd8qYgLips8Suppk9aajhFh+5XDfZaGqJRVrNldV4V2p
         IzvmX07E9TUIdOn4clb4nDkdtBfOK69/DfSFb7tTnPzbXhYJH4Fw40ftrezsJELASsAZ
         WLamBMFq0fACyHVHw4G4wjogHAfl0HQndJtbx1zUnFXAJNVAoc4WrmuXKVlS/NY737Ms
         8FhC1tP6Fyfsl4X7d0mUcWBVF60iDZYh8vGzloqve8SgNM7h279yu+PVTWsTpQNVlhsu
         tbRw==
X-Gm-Message-State: AOAM530w2LA6oS5JT1z777gONVXNSEdwU6BlRGtWFjPMXDwkWer/Al8l
        S09IhhZwIyWPT1aQ+UXsiQ3aVhbUkW/L8v227Ix3GZxiWenhED5Qg3pTcC880TCQO5Zkj3L+jq8
        m19zEFhq5t0gTw1qB65m/HA==
X-Received: by 2002:a05:600c:1990:b0:38c:c0a2:c0ab with SMTP id t16-20020a05600c199000b0038cc0a2c0abmr2917259wmq.72.1649750816567;
        Tue, 12 Apr 2022 01:06:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyirCPyskdO5e2sY0gyTYmwZZqPERZLETq+FzC5u7mRnrRXPXUpZycQcZI40q4HP90YIRcMxQ==
X-Received: by 2002:a05:600c:1990:b0:38c:c0a2:c0ab with SMTP id t16-20020a05600c199000b0038cc0a2c0abmr2917245wmq.72.1649750816394;
        Tue, 12 Apr 2022 01:06:56 -0700 (PDT)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id i19-20020a05600c355300b0038e1d69af52sm1660404wmq.7.2022.04.12.01.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 01:06:55 -0700 (PDT)
Message-ID: <e3574fa6-c69f-deb2-397f-ef1f6f6c59f0@redhat.com>
Date:   Tue, 12 Apr 2022 10:06:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [kvm-unit-tests PATCH v1 3/4] s390x: don't run migration tests
 under PV
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc:     frankja@linux.ibm.com, imbrenda@linux.ibm.com
References: <20220411100750.2868587-1-nrb@linux.ibm.com>
 <20220411100750.2868587-4-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220411100750.2868587-4-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/04/2022 12.07, Nico Boehr wrote:
> PV doesn't support migration, so don't run the migration tests there.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   s390x/run               | 5 +++++
>   scripts/s390x/func.bash | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/s390x/run b/s390x/run
> index 2bcdabbaa14f..24138f6803be 100755
> --- a/s390x/run
> +++ b/s390x/run
> @@ -20,6 +20,11 @@ if [ "${1: -7}" = ".pv.bin" ] || [ "${TESTNAME: -3}" = "_PV" ] && [ "$ACCEL" = "
>   	exit 2
>   fi
>   
> +if [ "${1: -7}" = ".pv.bin" ] || [ "${TESTNAME: -3}" = "_PV" ] && [ "$MIGRATION" = "yes" ]; then
> +	echo "Migration isn't supported under Protected Virtualization"
> +	exit 2
> +fi
> +
>   M='-machine s390-ccw-virtio'
>   M+=",accel=$ACCEL"
>   command="$qemu -nodefaults -nographic $M"
> diff --git a/scripts/s390x/func.bash b/scripts/s390x/func.bash
> index bf799a567c3b..2a941bbb0794 100644
> --- a/scripts/s390x/func.bash
> +++ b/scripts/s390x/func.bash
> @@ -21,7 +21,7 @@ function arch_cmd_s390x()
>   	"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
>   
>   	# run PV test case
> -	if [ "$ACCEL" = 'tcg' ]; then
> +	if [ "$ACCEL" = 'tcg' ] || find_word "migration" "$groups"; then
>   		return
>   	fi
>   	kernel=${kernel%.elf}.pv.bin

Acked-by: Thomas Huth <thuth@redhat.com>

