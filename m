Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DEA65BD3
	for <linux-s390@vger.kernel.org>; Fri,  9 Feb 2024 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707465844; cv=none; b=TCiDtWmufUeq6j+C/7rkAV+jhjRjGOENE72X1vqRvzpq6ap8ZQyjLrKR8A5MvygXfq0EVWPL+VW1m7KoxaK/kwQM60iFDePK8NSyi365wNX+QKQLqxeYcIF7SqbbLnMEgLnDr+KjbI+75M9HfreL90RQ8jYmz5UrfUtY8/jk5QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707465844; c=relaxed/simple;
	bh=myrhyjmsNbc6MDcH0heIDOvedg+W3r+FiBw9MBnp3Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qg1iewqvhhzInzpH0B3u6u8CjqquzUSSTdj6ylLiEmndS8JTPAJAVS/aNAHfkUtp2CDrADsNidusJTawfsuwE0mjrCM2QMOIE0eewu/4uC7h2g+0MTbvdLhR4AaFIH+BNFqDuyksGBPXt1CsQ7NXM6yiTqoyGCCgvadTZUfzIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HdAmVzbs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdAmVzbs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707465841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=faE/LK4IJAeEyH7ZjqMtZX/ViQ+jKg9nw9ZeSbxZmiM=;
	b=HdAmVzbsg6yYXylBJhxf+Nm+ksz/HSyTqP2n3yGuhvwj7fV8mWuv4i3a86ztP8Rl96S59k
	95bAFXrltGKZvofnQjrxUSCB6V/fC93SpFnnRXXZXDBE+odWP8W28oIdmhZHW41Hq4wD/Y
	Yr1+bB1QWw6Ido5vSmCRw4976xr/uOY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-8RYam5jKMUS8sMZGRRux6w-1; Fri, 09 Feb 2024 03:03:59 -0500
X-MC-Unique: 8RYam5jKMUS8sMZGRRux6w-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-68cacbd7d73so11598296d6.3
        for <linux-s390@vger.kernel.org>; Fri, 09 Feb 2024 00:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707465839; x=1708070639;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=faE/LK4IJAeEyH7ZjqMtZX/ViQ+jKg9nw9ZeSbxZmiM=;
        b=ZmJqI0sa5kgcxMsAehbCVauJoMUpVuGHj8/DFJ5HJMGpC0Q/bhVNaVm/tYaom9/A8J
         eJuzm6Q5vYKdKUmYj1/Ly8Mb0NpaRCpUZasB3b5Doo66qmHD8RN1ceaiXeCwL3lVXSKW
         ZHtwKcJlCJWAO4OJbE0A2r0o3EAKvRDLgEHRCQu09z1oxte8L/4cKudmeW4B4E1UxgrG
         NOiYC9r8eR4TLeafGvQWVA+2XMm+izXvhxK3BLJs4j2wqfDguQpM6Ib6LrZg4kZLLku8
         i7wD3TIpm+Q3ZD2y/3ARQmoR4UWiVd8C1/QvcPkMG4j8sWxsKRAUj+dMzcByAOZ5Obdg
         QA5w==
X-Forwarded-Encrypted: i=1; AJvYcCWdm1kbv0HGlpLwCyq/PalUhMoz5nW84qbNDeae1jPyg74a7OfZTQjpQ5iZaP7ZqY0Tg+aRRzl0C9Nd7CO3XR1y3P2W7PYw8H/tOg==
X-Gm-Message-State: AOJu0Yx0zZLay6Pt6//zs6TsTdakjKz8FvfOPeESs5LLBRQOANSUPk/k
	Z+ICD8RFlFc3OqVVkj3K+21vOSmMf+c9urdniiMRGpAiC3k7ui1PipiMAS3PIF6PXO+Gt3m7qAO
	to5qlBCOr+Mx7zuCsVD6A8FIID8Mo+EezUdu3Y1dwz49VNo6pNsEA1tTfqhY=
X-Received: by 2002:a0c:f2c3:0:b0:68c:814e:5410 with SMTP id c3-20020a0cf2c3000000b0068c814e5410mr976893qvm.19.1707465839105;
        Fri, 09 Feb 2024 00:03:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH51X/CXuNxC3+hHzK8rvC/V3cxp3u9GUxeTMq/lAXErqJ+Tp2T2bQwIpIRQYR9MxuF6npl0g==
X-Received: by 2002:a0c:f2c3:0:b0:68c:814e:5410 with SMTP id c3-20020a0cf2c3000000b0068c814e5410mr976874qvm.19.1707465838862;
        Fri, 09 Feb 2024 00:03:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX20yFKEBRU1/oWDnU56mOKPVncgFDMKdfTosM/Yk+KIPkh78vhB1odUpVY/O4m6KLPfevoSLDiaOXv9XjHmD7MJMIRrvUPDiOZ5QYenFRecrs462DGWYC8hYOpqZddy999hbO7m+TUk8YNRXuFqFptAkHP3ED95yi5GJrhhbHR7LyYDiQXyqA5tzA3XZLQeo7zmQZtSkgEe2L4k2C1NE2T8xgS8VulTEE0kgeR6FA/kNr5wwjGduFG0xIuuvG1zPV1serdqneGovnMPSEgt2OxzNKEFMWGSKlNHiC3gERL+MycLx/d72un9mpTU7EHNHsouKwdDCj4Wy6Q255JwJ8/4IYNO8in88gUqjvuwTTy1aAU+7rK8KnMoVTihCgoc4x40gdROmEhKE2HAE2V7OLqW/XQrPv0gY/8hQBe5dlj9zOqu2Mpxwm3sLYOPkNP0f4ar0Tw44XyDYitI5tYSbNZw79AQneAOCJMZ5e4NhZsMemf2RV/MBQjDQb5KYZrufHkcCyRBUdKS2bVx5PxtmSfdRPA
Received: from [192.168.0.9] (ip-109-43-177-145.web.vodafone.de. [109.43.177.145])
        by smtp.gmail.com with ESMTPSA id pc8-20020a056214488800b0068c6d56d4f7sm595736qvb.92.2024.02.09.00.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 00:03:58 -0800 (PST)
Message-ID: <c143430d-482e-43bb-9c94-b6977c6482e5@redhat.com>
Date: Fri, 9 Feb 2024 09:03:53 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 6/8] migration: Add quiet migration
 support
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kvm@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Andrew Jones <andrew.jones@linux.dev>,
 Nico Boehr <nrb@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Eric Auger <eric.auger@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Marc Hartmayer
 <mhartmay@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, kvmarm@lists.linux.dev,
 kvm-riscv@lists.infradead.org
References: <20240209070141.421569-1-npiggin@gmail.com>
 <20240209070141.421569-7-npiggin@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240209070141.421569-7-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/02/2024 08.01, Nicholas Piggin wrote:
> Console output required to support migration becomes quite noisy
> when doing lots of migrations. Provide a migrate_quiet() call that
> suppresses console output and doesn't log a message.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   lib/migrate.c         | 12 ++++++++++++
>   lib/migrate.h         |  1 +
>   scripts/arch-run.bash |  4 ++--
>   3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/migrate.c b/lib/migrate.c
> index b7721659..4e0ab516 100644
> --- a/lib/migrate.c
> +++ b/lib/migrate.c
> @@ -18,6 +18,18 @@ void migrate(void)
>   	report_info("Migration complete");
>   }
>   
> +/*
> + * Like migrate() but supporess output and logs, useful for intensive

s/supporess/suppress/

> + * migration stress testing without polluting logs. Test cases should
> + * provide relevant information about migration in failure reports.
> + */
> +void migrate_quiet(void)
> +{
> +	puts("Now migrate the VM (quiet)\n");
> +	(void)getchar();
> +}
> +
> +

Remove one empty line, please!

>   /*
>    * Initiate migration and wait for it to complete.
>    * If this function is called more than once, it is a no-op.
> diff --git a/lib/migrate.h b/lib/migrate.h
> index 2af06a72..95b9102b 100644
> --- a/lib/migrate.h
> +++ b/lib/migrate.h
> @@ -7,4 +7,5 @@
>    */
>   
>   void migrate(void);
> +void migrate_quiet(void);
>   void migrate_once(void);
> diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
> index 0b45eb61..29cf9b0c 100644
> --- a/scripts/arch-run.bash
> +++ b/scripts/arch-run.bash
> @@ -152,7 +152,7 @@ run_migration ()
>   		-chardev socket,id=mon,path=${src_qmp},server=on,wait=off \
>   		-mon chardev=mon,mode=control > ${src_outfifo} &
>   	live_pid=$!
> -	cat ${src_outfifo} | tee ${src_out} &
> +	cat ${src_outfifo} | tee ${src_out} | grep -v "Now migrate the VM (quiet)" &
>   
>   	# The test must prompt the user to migrate, so wait for the "migrate"
>   	# keyword
> @@ -200,7 +200,7 @@ do_migration ()
>   		-mon chardev=mon,mode=control -incoming unix:${dst_incoming} \
>   		< <(cat ${dst_infifo}) > ${dst_outfifo} &
>   	incoming_pid=$!
> -	cat ${dst_outfifo} | tee ${dst_out} &
> +	cat ${dst_outfifo} | tee ${dst_out} | grep -v "Now migrate the VM (quiet)" &
>   
>   	# The test must prompt the user to migrate, so wait for the "migrate" keyword
>   	while ! grep -q -i "Now migrate the VM" < ${src_out} ; do

  Thomas

