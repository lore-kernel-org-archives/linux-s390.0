Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90E422DF85
	for <linux-s390@vger.kernel.org>; Sat, 12 Jul 2025 22:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752358296; cv=none; b=WEHP2N8hLfySLpjaum2YT34HVVmsNo3yAYxS2XMgY7JyLcIjARcBetcVwjhJqczyrnQTblzy7aJU/HhXsSgfGOstuynPTnQvqsFKSOtezcn0EV4pjs/FMCkHJWiY90rNqXWa4V2Rp786urjyb2AZW5stNn6vBKwX2Vf+qMbkYMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752358296; c=relaxed/simple;
	bh=Ae8NoXwXSlJEHjBfj9+SvAwqq53ABo/o138ibg61o/8=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxocBS8lxMz/9+RArsNL70z8mEyRBbT0IHXFljGRllsLWJmHnTkqJTJXtKxww/Vm2F7+0sSdKPMLjpHDG0pML92XtPfwAFIAgW/fT9igSI8B8jvmf45t5xhOQBiYbMhYt9h9SEHn8IHAzZxmt3XnO+diqnt/GDtDk0D1ITkzpBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaLnbdc/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaLnbdc/"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-456107181f8so58815e9.2
        for <linux-s390@vger.kernel.org>; Sat, 12 Jul 2025 15:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752358293; x=1752963093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIEQX44X/NeDZwLNKmN4YY266j4thbPs2H0dkeS01cM=;
        b=aaLnbdc/GNqsktAtLbxNGs+okmttUPGZNhMZ56RGTxk/xlO7fom0qc4NW4eWJcUeZh
         D/q+5dRvDuSHibmgsmnSQpSrgWt7TWLmwYS3QdFjH7OgKbjKEW+/VmiqbnBcRsUPEXc2
         1XNR7xpiHuA9cZBEaxXW/tOorWed8VQeyfTZthzQFexohrIX8ddeNDsEa1MYYHYuoR0M
         0iOMYckiOZ6P1taIkp+ipcq4zU6BfLV2lrbO3dVnAxqvxbVK3BL7Xv3krnIshJSqiNBI
         Gw8M+hsH3KDiW91jF7pu8oo0jVOyx01GDaQlM68zBbYiVHZqHLKzaTiSipCXut6pxpPp
         Mlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752358293; x=1752963093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIEQX44X/NeDZwLNKmN4YY266j4thbPs2H0dkeS01cM=;
        b=rHOYOQPsqrOalITso5a9gIHH7z4D9Hl2gsoSP6xmHLeuCzP27p72eZAJ4JNIqiKdQ/
         DTPnxoSzIPL0Pje6UxaInV5WAvSTkxjN0BvQHtMi0T1fnSxTZ2a/D21bIOX9jMZJxZeP
         Q4zFPbcVV1qgBhjFWhbDYOCoD+BCWWeWT7BmycS7FNIUZPLsXJmINy+QlCTD0GM4bSkx
         mPDXNpJsaVTZcSMfNyYVvfd3jqZ7FnHZuj2XIf2Mslng2T6nEJDP0kmqrnPsQ6stF1Bm
         Bez85dEv9PTJvl/MCeAhyuaIWFy2PVDCPG8MFCarqRFUAOsrcRdTaj6G8YaaBDBHyw7b
         rEBw==
X-Forwarded-Encrypted: i=1; AJvYcCUOQg95RmGSuxIftFoLcqM2wYMfr5OJVfQ28iXn8OReOTI1mu2DS8eR4XgLBhNG4Gv4Iccj/Y6vOjDz@vger.kernel.org
X-Gm-Message-State: AOJu0YxA9eyFsUccAmU0rBeymJQA2X/dzxu0ET0yIQ0ItE0r/qAN+48Q
	6rTj2o2fi91kAlPE4JHUlTwVJbdgFpkrUTGSNz0IUOrDfg2fmc2n+mw=
X-Gm-Gg: ASbGncvhwyWcx76ufYTssFVav1QzJnLfb09I1J2xg9Onuaa6ikcQ+lrFBjQ6koUdO9A
	lC9vRCXubonQ/M8ZXZPpf0OSvwwGKLmaOU2FAnUs21x9b1SLrZX2vY72I1oN73Nbrlwv20sPsuA
	ayLdEWMLDGMsjTXD9EN8mQJVOt3qbMx+sH9CB3podyvgR2OTdYU5fuRlKcDnF67y1hTmg97d2EZ
	xOEGGcSESW2uQJlYl/xRAeW7AzBZOocWzUpvyjW7PSBlLMoaU2OLu6uROyfh5A4gSeo2/Mw8828
	Ze2aoEGGYuO3Jgg/HoFUiHxazXXDaF8sYGwLw2g5eZG5KgHeprdsstmEshuDltkcu+EalU1deni
	/E7is9GI7jSOsprbvSwpvWo6+TT6KHZ7s3IYqhDka5OzpBKOrS0eTniy6ndZrznH2ST4t6A3T
X-Google-Smtp-Source: AGHT+IH6BHzG3H2KccIJu8rf1vckh5EEY0odAEa8FuernOJ/eh7pAdASrImw9HeMXjAV1lg5R54kSA==
X-Received: by 2002:a05:600c:4f52:b0:43d:fa58:81d2 with SMTP id 5b1f17b1804b1-454f4286ee1mr26157335e9.9.1752358292709;
        Sat, 12 Jul 2025 15:11:32 -0700 (PDT)
Received: from localhost (182.red-80-39-24.staticip.rima-tde.net. [80.39.24.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5032e9esm125825635e9.3.2025.07.12.15.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jul 2025 15:11:32 -0700 (PDT)
Message-ID: <76bde3f1-0f06-46fc-8e0a-729e6629024c@gmail.com>
Date: Sun, 13 Jul 2025 00:11:30 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] multipath-tools: fix default blacklist of s390 devices
Cc: Stefan Haberland <sth@linux.ibm.com>, Nigel Hislop
 <hislop_nigel@emc.com>,
 Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Hannes Reinecke <hare@suse.de>,
 Martin Wilck <mwilck@suse.com>, Benjamin Marzinski <bmarzins@redhat.com>,
 Christophe Varoqui <christophe.varoqui@opensvc.com>,
 S390-ML <linux-s390@vger.kernel.org>, DM-DEVEL-ML
 <dm-devel@lists.linux.dev>, Nigel Hislop <hislop_nigel@dell.com>
References: <20250712201454.215404-1-xose.vazquez@gmail.com>
Content-Language: en-US, en-GB, es-ES
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
In-Reply-To: <20250712201454.215404-1-xose.vazquez@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/25 10:14 PM, Xose Vazquez Perez wrote:

>   libmultipath/hwtable.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libmultipath/hwtable.c b/libmultipath/hwtable.c
> index 081d119c..4ca4245c 100644
> --- a/libmultipath/hwtable.c
> +++ b/libmultipath/hwtable.c
> @@ -687,7 +687,7 @@ static struct hwentry default_hw[] = {
>   		/* PAV DASD FBA */
>   		.vendor        = "IBM",
>   		.product       = "S/390 DASD FBA",
> -		.bl_product    = "S/390",
> +		.bl_product    = "S/390 DASD FBA",
>   		.uid_attribute = "ID_UID",
>   		.no_path_retry = NO_PATH_RETRY_QUEUE,
>   		.pgpolicy      = MULTIBUS,

Is PAV really supported on FBA devices ???
And other than 3390 and 3380(3390 model 2/3 in track-compatibility mode) ECKD types ?

Source, z/vm docs: https://www.vm.ibm.com/storman/pav/pav2.html#2001

Thanks.
