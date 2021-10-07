Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D777C433EF
	for <linux-s390@archiver.kernel.org>; Thu,  7 Oct 2021 09:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8013960FC3
	for <linux-s390@archiver.kernel.org>; Thu,  7 Oct 2021 09:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhJGJOC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 7 Oct 2021 05:14:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36856 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231661AbhJGJOB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Oct 2021 05:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633597928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cL2AYQZt9EJmxIocfW/F95MTjSXhoGnSEOcdkz+hNRA=;
        b=QmccYgiwp3WVFuITM09RdKVQYCpgnye7zW/FMcFWedR3YtRrCpXumbgh1NdekaHSKhVCvp
        BHynuyMW7L4JZZvr3rACFI5VY/mtJzadcENnwNIE0Ed9K20+Tsv0CwTYl1fSXgT2ejdZTx
        3fjf241YWXH7AvUGDHIqR681hweWaRs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-3xGTwBRQN3eCLBnDKYxH4A-1; Thu, 07 Oct 2021 05:11:52 -0400
X-MC-Unique: 3xGTwBRQN3eCLBnDKYxH4A-1
Received: by mail-wr1-f69.google.com with SMTP id r21-20020adfa155000000b001608162e16dso4142603wrr.15
        for <linux-s390@vger.kernel.org>; Thu, 07 Oct 2021 02:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cL2AYQZt9EJmxIocfW/F95MTjSXhoGnSEOcdkz+hNRA=;
        b=IMyZ0SsSVa+j+e8Itd9mVCuLAmFCXN8nU/MFWUlhpCAU/RC4LzkwdB74FgMFF5oo4E
         822m9EvYGyyTIOdKHSy1knc/36BPqqcXLJKGN92DK3Q/GfLjh6qcAsOgoFOaq1otW9pZ
         CcNSrcI37vyCKAilT3rDSrL6cArGcsow2+yRDHcj7xxXQD06udQGSQ5XK2TTp+IhdoPi
         kHgC83bjKgdo7/TYMPI6rIi7ePyH+im0rcxosCQeH+t9uzxV3FC6BWJMgGNNeP75AVak
         JH61Iw6UTPwPcXV9LjcIrDVtyHtCPT1l0TonpqUVLqKZMgjjFGKprHbtSG9Rjkby+yRA
         VN+A==
X-Gm-Message-State: AOAM531H4zYOcbGHw9idkhy3tsD965SI0wHAf3M5jCXwgT2C+Mb3LPD1
        8adVM4HroPSpAbfib0yiH4Lfo5A3H2BsVbQWghC+xoHJDT+8iCfOsINbDDqMde7zXwukMr5w01f
        aB7H9Lm/vQKSnEP7rn9YvtA==
X-Received: by 2002:adf:b1d7:: with SMTP id r23mr3974114wra.145.1633597911716;
        Thu, 07 Oct 2021 02:11:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFBp3oRQeGhxR6zxv/NNmV1Xj2k340GDruIacyFt9QzrvM4W/CByUKsQWLlWqEcLHDuEABmA==
X-Received: by 2002:adf:b1d7:: with SMTP id r23mr3974104wra.145.1633597911580;
        Thu, 07 Oct 2021 02:11:51 -0700 (PDT)
Received: from thuth.remote.csb (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id f1sm26529941wri.43.2021.10.07.02.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 02:11:51 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH v3 7/9] s390x: Add sthyi cc==0 r2+1
 verification
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, seiden@linux.ibm.com, scgl@linux.ibm.com
References: <20211007085027.13050-1-frankja@linux.ibm.com>
 <20211007085027.13050-8-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <18a10bec-aee5-700f-9004-b4a200dcebed@redhat.com>
Date:   Thu, 7 Oct 2021 11:11:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211007085027.13050-8-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 07/10/2021 10.50, Janosch Frank wrote:
> On success r2 + 1 should be 0, let's also check for that.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>   s390x/sthyi.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/s390x/sthyi.c b/s390x/sthyi.c
> index db90b56f..4b153bf4 100644
> --- a/s390x/sthyi.c
> +++ b/s390x/sthyi.c
> @@ -24,16 +24,16 @@ static inline int sthyi(uint64_t vaddr, uint64_t fcode, uint64_t *rc,
>   {
>   	register uint64_t code asm("0") = fcode;
>   	register uint64_t addr asm("2") = vaddr;
> -	register uint64_t rc3 asm("3") = 0;
> +	register uint64_t rc3 asm("3") = 42;
>   	int cc = 0;
>   
> -	asm volatile(".insn rre,0xB2560000,%[r1],%[r2]\n"
> -		     "ipm	 %[cc]\n"
> -		     "srl	 %[cc],28\n"
> -		     : [cc] "=d" (cc)
> -		     : [code] "d" (code), [addr] "a" (addr), [r1] "i" (r1),
> -		       [r2] "i" (r2)
> -		     : "memory", "cc", "r3");
> +	asm volatile(
> +		".insn   rre,0xB2560000,%[r1],%[r2]\n"
> +		"ipm     %[cc]\n"
> +		"srl     %[cc],28\n"
> +		: [cc] "=d" (cc), "+d" (rc3)
> +		: [code] "d" (code), [addr] "a" (addr), [r1] "i" (r1), [r2] "i" (r2)
> +		: "memory", "cc");
>   	if (rc)
>   		*rc = rc3;
>   	return cc;
> @@ -139,16 +139,18 @@ static void test_fcode0(void)
>   	struct sthyi_hdr_sctn *hdr;
>   	struct sthyi_mach_sctn *mach;
>   	struct sthyi_par_sctn *par;
> +	uint64_t rc = 42;
>   
>   	/* Zero destination memory. */
>   	memset(pagebuf, 0, PAGE_SIZE);
>   
>   	report_prefix_push("fcode 0");
> -	sthyi((uint64_t)pagebuf, 0, NULL, 0, 2);
> +	sthyi((uint64_t)pagebuf, 0, &rc, 0, 2);
>   	hdr = (void *)pagebuf;
>   	mach = (void *)pagebuf + hdr->INFMOFF;
>   	par = (void *)pagebuf + hdr->INFPOFF;
>   
> +	report(!rc, "r2 + 1 == 0");

Could you please check for "rc == CODE_SUCCES" (since we've got that for 
this purpose)?

With that change:
Reviewed-by: Thomas Huth <thuth@redhat.com>

