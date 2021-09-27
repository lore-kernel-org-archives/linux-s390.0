Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74606C433FE
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 15:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5472A60EB4
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 15:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhI0P2r (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 27 Sep 2021 11:28:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235117AbhI0P2r (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 27 Sep 2021 11:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632756429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L4NMWxT3cfbxRVFFnxXJnEGfN7af8pHyx3dvW9V5X/8=;
        b=bHkVPvezixlbP2QVCdFHGW69kKeRn6Zafh8ck1eoS0qiFENaa8doTbaJNoLMSlLI5d2D5b
        7iQihDt/0kJ1BGJhp60TgfzPiFIqV22AxH5ZgGitDMpkYKLH5tIa34FSZmKcw0nFivHHF7
        k3p0acee3aCPONsHBe69gBMHkwJT9TM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-B31bVlGNMDe3hwHl89igDw-1; Mon, 27 Sep 2021 11:27:00 -0400
X-MC-Unique: B31bVlGNMDe3hwHl89igDw-1
Received: by mail-wr1-f72.google.com with SMTP id c8-20020adfef48000000b00160646ed62cso2629913wrp.18
        for <linux-s390@vger.kernel.org>; Mon, 27 Sep 2021 08:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L4NMWxT3cfbxRVFFnxXJnEGfN7af8pHyx3dvW9V5X/8=;
        b=DMJDPbn83r30lPYQuj68vLrnAm0gHIDrMs+O6Yy7sPcZ6xCJRbpWC2bd4OablRB5Sg
         oE22IgaiLbBLJ9fIKuvR+kxMZVwcX2+DpOvxgiyPIEvQG9NAltJQySJOkcm3uPBVcYFV
         gskiKs+5sVpSmWp7bwVBeslHzY+qAEm6pSlbeFg5VmuC3XYOe7ViWXBz7J1Q0gN7erdk
         Jn9Tnw2rUWFhBbmhFBsVYcs98mkLPigOKyogK6MI9EueoIvMpnvy5FJhY/iARvsR/2of
         Ba9xbYqMg1dgygFKy0UVEXxR312OX2f3nNq1DLvcL8MOWSbCwaOQSWXahicZW90X9zbz
         WtJg==
X-Gm-Message-State: AOAM531Ru2P5wpNci7PfTiyiDRN1JezJOOtiAogVshVRk3wkNbA+qirt
        D2ACKaxnv2Ezt2K4cxJe5JZ1QNpIN0BtUZkkXzJGsMSQ0fOEDZ98xTwiN+qgGm3s8yA4RaMHPPi
        uPZbHcnWgbyv6okBxFDaDow==
X-Received: by 2002:a05:600c:220e:: with SMTP id z14mr531309wml.84.1632756419164;
        Mon, 27 Sep 2021 08:26:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynSE4/E24J38JDzGwXrRxW5fcEgu/rr7EQCWyK0XK829+8JlB1tXqSvVH1kA6JoNxSkjvbdQ==
X-Received: by 2002:a05:600c:220e:: with SMTP id z14mr531292wml.84.1632756419001;
        Mon, 27 Sep 2021 08:26:59 -0700 (PDT)
Received: from thuth.remote.csb (p549bb2bd.dip0.t-ipconnect.de. [84.155.178.189])
        by smtp.gmail.com with ESMTPSA id c9sm15606090wmb.41.2021.09.27.08.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 08:26:58 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 3/9] s390x: uv-host: Fence a destroy cpu
 test on z15
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     david@redhat.com, linux-s390@vger.kernel.org, seiden@linux.ibm.com,
        imbrenda@linux.ibm.com
References: <20210922071811.1913-1-frankja@linux.ibm.com>
 <20210922071811.1913-4-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <8035a911-4a76-50ed-cb07-edce48abdb9c@redhat.com>
Date:   Mon, 27 Sep 2021 17:26:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210922071811.1913-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 22/09/2021 09.18, Janosch Frank wrote:
> Firmware will not give us the expected return code on z15 so let's
> fence it for the z15 machine generation.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/asm/arch_def.h | 14 ++++++++++++++
>   s390x/uv-host.c          | 11 +++++++----
>   2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index aa80d840..c8d2722a 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -219,6 +219,20 @@ static inline unsigned short stap(void)
>   	return cpu_address;
>   }
>   
> +#define MACHINE_Z15A	0x8561
> +#define MACHINE_Z15B	0x8562
> +
> +static inline uint16_t get_machine_id(void)
> +{
> +	uint64_t cpuid;
> +
> +	asm volatile("stidp %0" : "=Q" (cpuid));
> +	cpuid = cpuid >> 16;
> +	cpuid &= 0xffff;
> +
> +	return cpuid;
> +}
> +
>   static inline int tprot(unsigned long addr)
>   {
>   	int cc;
> diff --git a/s390x/uv-host.c b/s390x/uv-host.c
> index 66a11160..5e351120 100644
> --- a/s390x/uv-host.c
> +++ b/s390x/uv-host.c
> @@ -111,6 +111,7 @@ static void test_config_destroy(void)
>   static void test_cpu_destroy(void)
>   {
>   	int rc;
> +	uint16_t machineid = get_machine_id();
>   	struct uv_cb_nodata uvcb = {
>   		.header.len = sizeof(uvcb),
>   		.header.cmd = UVC_CMD_DESTROY_SEC_CPU,
> @@ -125,10 +126,12 @@ static void test_cpu_destroy(void)
>   	       "hdr invalid length");
>   	uvcb.header.len += 8;
>   
> -	uvcb.handle += 1;
> -	rc = uv_call(0, (uint64_t)&uvcb);
> -	report(rc == 1 && uvcb.header.rc == UVC_RC_INV_CHANDLE, "invalid handle");
> -	uvcb.handle -= 1;
> +	if (machineid != MACHINE_Z15A && machineid != MACHINE_Z15B) {
> +		uvcb.handle += 1;
> +		rc = uv_call(0, (uint64_t)&uvcb);
> +		report(rc == 1 && uvcb.header.rc == UVC_RC_INV_CHANDLE, "invalid handle");
> +		uvcb.handle -= 1;
> +	}

So this is a bug in the firmware? Any chance that it will still get fixed 
for the z15? If so, would it make sense to turn this into a report_xfail() 
instead?

  Thomas

