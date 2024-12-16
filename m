Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F66E203707;
	Mon, 16 Dec 2024 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344514; cv=none; b=DSoOLUrk8exA+xNsx1gEM6OxGLWchd8gEdyO4rgmHXKW++/XvAZ/onQoeq/YbkCoUC+sx1TuM3sWiWecPk+v2EhmjoRjsPLalb4ptnVjajH6+QJKaKbQ8u7hKhc2JNqXXa6ZaGa5cUFITx/EsU94fTeGPLC/5oyoQxZkyYDWTRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344514; c=relaxed/simple;
	bh=S/qqWVZlHflFxuV4/LsI0IhdhoP3u6+5V26ipGRIEH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pW7UVYioMptqchUUocD56t/SVEFwu8e6CING1SIbW2AViTpFus9KnpeozRcCciDCX7iRfX4kb53pu/OikQ8G2Fi9GtcmOPbLFpgMTeNtwPM/BXsXU28dFx+Hjepq34csUGqfDOk7GdlYzZBE/DAwrX6DIT8/eQY2ZYuQQ+uynUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OakJDnMo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OakJDnMo"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361f664af5so43076635e9.1;
        Mon, 16 Dec 2024 02:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734344511; x=1734949311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uo+Lw7zjxCxUVDImbWApPZHVFAVFzgykcL95SpGwcww=;
        b=OakJDnMoN61kcJlCBZSJ9ikKsil7D4hEzx/Vpbld/YdYEce/eoZWrs6m87Epel4DQ1
         8ive2j1HYKk3fh6z5xSB/YdjShGJUBVvTNCoRRiGUU1RWl5oWdIQSZhwNU+qF/PNYx62
         lw31hg6zh/WU0lX6NHXxi8YTqHybLfUqyK+1m9YMWtmCqT2FBocYh4uA+jxmyxOaVFpG
         RTQfec3f3ZY4AeYbjCoG5rgZjQDEyAxo7llwK7uCY2owFLJ72B3bXuhhYXIoNr3e5SW8
         YcVcLi9fCinHkubKAy3rE1jetyVCORWRKKNBwn6sT125uHEc5RBwV1Y84A1vCsTNBhCj
         24tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734344511; x=1734949311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uo+Lw7zjxCxUVDImbWApPZHVFAVFzgykcL95SpGwcww=;
        b=oZU4EjB4jIIIQo6UbqXD2/B5Tkzdl3KX7rZ53t/ba6zbRrnBel9Y+picNoPLmIoC3V
         b5uRQoQJxGFTMtvDSG1t3eyE/ekgn1rDRPgQaWyTw1rX6m6al1B6+RDvrxLtXGsCGLG6
         W6D9RK8HImnQrbFwZdOQfYnYJ6fC+El7Fsmw363pRXmnyzt5SM3r1dOPMfSf35bzTBIL
         LZYDUAhUFc9y84hebyp244H5CYh26F4Nx8AqcbGgy/ti/1Ra8jE3xaBr2Ob/v8ASiF6o
         HSVaoEnFiGvBbdXH4rBtYWbQNyTKLZpwrXQ3eI7Tz2up6mqQnghgIhdXjNF/rcgG/txO
         iIyg==
X-Forwarded-Encrypted: i=1; AJvYcCU3cbyfSi8MpoxLiram10PcFaX+8VR+jVfCap3saf9UWvPYO58ar2FTaxNB+qq89VfZq2GazWI4VlXETA==@vger.kernel.org, AJvYcCVttvdN0GUEwct1OhtNKVmC9hc85Wxwj3bxMbgpdmDJHkD7zOLvs89UdTLMts7qa0rqmje215Mg6c/59JM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9eZBedVkMLSFQ58VCyHvua1G5jp4/yTSShPAZIPrKKB4c7HjZ
	QRAFIv+mRY/sVP/0JsyN/0p/ni97Ojd8aYUFdBVk1txp6xLrWn/r
X-Gm-Gg: ASbGnctE6JozLc+nWVwwp0ciwFzcJTt1NOzqiGDvuu7QcYDBg9SWcz0oV+5Kl5nhOm3
	DxR+vHoIREVaTJI5V1fxJi4wzAop79TFdk9HTzUjNfmgYXD9RVc7USOUDT0vCYwQIceG5P1asPn
	VR1iQX6NznGLAWqyvXsXjXLj6PVuPjVA6X1B5ZHlWZiiUf//qRyizZHU3a5E0/Dnd+wRzQdOi+a
	PaK1pnEvKmnurOTGQwgsSTNepGwc+aoYEpRWtp7UpmtemDtOm8LD8Bp8Bx1BlrDe7UtzA8S
X-Google-Smtp-Source: AGHT+IE57/ONNWi8zLcjHXfGO97j6oHhQwEZEabcKaVjeXtxH58AFaUawvLjGnuEvmeRbxSS3ru4Ww==
X-Received: by 2002:a05:600c:3ba1:b0:434:a765:7f9c with SMTP id 5b1f17b1804b1-4362aa13613mr101241585e9.6.1734344511291;
        Mon, 16 Dec 2024 02:21:51 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436360159aasm80163435e9.6.2024.12.16.02.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 02:21:50 -0800 (PST)
Date: Mon, 16 Dec 2024 11:21:48 +0100
From: Dave Penkler <dpenkler@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: GPIB build failures
Message-ID: <Z1__PFvt3ujgbGGj@egonzo>
References: <Z1/u0u9Nu4aEHA5h@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1/u0u9Nu4aEHA5h@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>

On Mon, Dec 16, 2024 at 10:11:46AM +0100, Alexander Gordeev wrote:
> Hi Dave,
> 
> Drivers in drivers/staging/gpib/ cause multiple build errors (I guess not only)
> on s390, when allyesconfig configuration is used. Please, let me know if I am
> missing something.
> 
> Thanks!
Hi,
Arnd has submitted a patch for this which Greg will
"be queueing up this week and getting to Linus also this week."
-Dave
