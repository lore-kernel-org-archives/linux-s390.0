Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE19253F0D
	for <linux-s390@vger.kernel.org>; Wed, 19 Mar 2025 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379620; cv=none; b=sJwKoQP6sVeEJYZ2hkFb5MOdmHwYi59UFv4Dcd5k48sSqu+6ZSi/xelSP/HsU83iTAY7YlYCOX4+MFdwRBHXeOoR1rDHBYq9g71aA4tEgV7sOaWXCMOx0LoIuC0YWT94UM9ugrNZTgZoDmTC9JiZalOZeygNFYXsggLVufC0teM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379620; c=relaxed/simple;
	bh=tK60PvB18wBvxWYt9lvP7XZvyX62+1Eh/q18fiab6Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvS8QVN0pZ+AQMVHp2nrtEp6+Qh7tPVDfr3hYvSIOqjAEdzlEWrXrZW/oHfM36D8HEh0tGQe4DV4bifTJNs7jNQZCeH4JV4y3JVfEgdR5t4c2xaSUVHCVoeVlK7N/dPofa+zBMed5yarmNKbl/5gYLEeIxgQ+9/tn4crjnlRm/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cqzk+EdP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cqzk+EdP"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so4290213f8f.2
        for <linux-s390@vger.kernel.org>; Wed, 19 Mar 2025 03:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742379616; x=1742984416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWxtYxkS3ZmfTDBR3Ubow/eGPhpGRxs9B2tOpbPHly4=;
        b=Cqzk+EdPpIhDnCwd4eZQhRJmj37M2X58h2HO5uNqgSIH22V9OW14Iab3Ju3v2/JBGK
         FkBh+Vl+ywlPDXLek56OVX9eR8guijL21wCkGBOrgCBDqWVTlUyF3Y3fKKCO3l7SLWUk
         jOEddmM13XNbr2OwEDURPTNxBfXb5OlBEi/oxCUifpl1mr3whqiOhSu0CRKjMMNuUjh9
         9slN6j9TtWAO77QjCTesk6z9yRW7BBsUpTsypOZ+aWphqBGd+J7kGPNlXEE96Wdpk08M
         GbHQt7vH+zR/MLbHBv0S8POfgt0v5joJzok+xCZjw6r4elUMOvJEV4DVk/8Cg1gP+Ack
         KKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742379616; x=1742984416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWxtYxkS3ZmfTDBR3Ubow/eGPhpGRxs9B2tOpbPHly4=;
        b=D9ngWyz0EnnSOd2PhCYaIsYuhIT0sEKRDq9cdhd9huir9yvMIpfJ5C/8ftFuHPotrv
         9IJKerMOuIG4KNwak5SesEsGgxxqodQJDMzEVSTKGhrsojpNTDrdFHo/3Ec/o/R3uZfR
         SDqHAJaw4aJTEVVUdqPgySwax0clMxTyJ2y/eNWlpT9Jeq5ty8dIU+5eNCYJhAiVbt96
         1AibrE5griKGtq/dVCMnYce2drGbNuG3dGfGGvgvj8qwbUWkRO1LJkHF8LfRp9jOxJVY
         K9Ursdy/Pz55isrkgEXKYDoFG13gv9sntSf8iz9xRzLcGozjlXCIEE7tKoH0VABl+j9g
         L7RQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+bPssd1xqKhjUh1JgzH/lcGz9YTKVp+YhfF+VzbrdgJ7K96lLx2bIfY4VglIzap/JM6iW3jIETBMp@vger.kernel.org
X-Gm-Message-State: AOJu0YxykdbEWlWN4QPFnDxRtcbvTe4/HNs108tkEjz4MZrw3nPDC7K5
	L6DXmoDHPSL3WP9Z1PCNIcYy5z7ewyZyzSDBz+dDYCPGl3+qhQ7UtqRjshioKyc=
X-Gm-Gg: ASbGncsiAiWWB/ib6Ws113AfNUKxzzRdzTMnqZTKR592kAJYh/mE2Hdrsd6UaTFWWiq
	P//SBfDu31Hf43A7ijxi7gHxuFnA5XJy/MboBaliEUkp0tGkJAJNgBhPDOXJZpvIUF89DMDX63H
	RoXHwsR8MoPkDMI5t5YTdzE6+JWDsxRWaTgVwBz2ycTzayEnZCq276IjxXS67H9J51wllnrKllq
	R3Eg2uxchTzX0aKZLCSeIEaKR0bEzL9GJMb9bO/Luiwgs3hin4FDU9tJf8kqoTOa6cPzb+8EEt2
	kSpKs3Jh+/BQbe4l4subVR8snEegC8jO2pXaAnIp0Kpn0IaV2A==
X-Google-Smtp-Source: AGHT+IHjcG6/IeV2BOfDblPqcpvGjw3L7kajd7hg9EDti/4DwNoU0L0nZRG8X9Tat0FLH2nt55nwLg==
X-Received: by 2002:a05:6000:1541:b0:390:e655:f998 with SMTP id ffacd0b85a97d-399739ca2a8mr1441536f8f.26.1742379615798;
        Wed, 19 Mar 2025 03:20:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395c7df3506sm21189338f8f.11.2025.03.19.03.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:20:15 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:20:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Will Deacon <will@kernel.org>,
	Alessandro Carminati <acarmina@redhat.com>,
	linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, loongarch@lists.linux.dev, x86@kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 07/14] arm64: Add support for suppressing warning
 backtraces
Message-ID: <fc197abf-e65a-439f-9d35-83f4665519f3@stanley.mountain>
References: <20250313114329.284104-1-acarmina@redhat.com>
 <20250313114329.284104-8-acarmina@redhat.com>
 <20250313122503.GA7438@willie-the-truck>
 <CAGegRW5r3V2-_44-X353vS-GZwDYG=SVwc6MzSGE8GdFQuFoKA@mail.gmail.com>
 <20250318155946.GC13829@willie-the-truck>
 <a64bf821-ea90-4fd9-92ec-13bf7b7a3067@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a64bf821-ea90-4fd9-92ec-13bf7b7a3067@csgroup.eu>

On Wed, Mar 19, 2025 at 09:05:27AM +0100, Christophe Leroy wrote:
> 
> Doesn't sparse and/or checkpatch complain about 0 being used in lieu of NULL
> ?

Sparse does have a "Using plain integer as NULL pointer" warning, yes.

I can't apply this patchset and I haven't been following the conversation
closely (plus I'm pretty stupid as well) so I'm not sure if it will
trigger here...

regards,
dan carpenter

