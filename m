Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449124;
	b=U4Fu+maLaUIgJHep7t1CAXDcaP6TehrVfgG42ZB08Dwrac7bqBUGh3miL5B4uFTd/ZE3
	 XUlSF6M2RSRPVhuK915oLrnnpGDEQ3nHHmzJxVD3vM2p+P5I96O4gHveu6D5NDuwZBMyo
	 xiCwYQYCKmLPnsB+4P1bOMd80S/2NJSLgYpKIHdKOwSuuPC0c7l7iSS+ygYOy2NOmfTmZ
	 AM8DcP3mzSvXMUYZhpizb9V5iItF4B0mJRTmoaEmSY5W7fdeC+zlB/jv6i1n6ZqjPWJSV
	 rNwPTeuKOmeuabpgFANnP4RdhuZyrFFmcVthTam2dZV8DwkA1v5h6QGcypqNtJ7gpHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=qKzq1YaHaTK/cMOsuVlloBBGSRBcO+4dM5JD9G9qTYM=;
	b=uwOjdbxFhdo6q7GlIB9RUmk4vHJIYkimLjmWVB2Y0eXmbuAg+o1n7LR4etRCHJPu6IK2
	 H6H7fFjLsyQ0K8JSg4hu0TA6kqt0CmZh1wvv68RtwfHpmYTYM1DQLzyQRWIpUN55ZF+IK
	 8hOtx8S4fib0EvuRNouYzJ/1IlDFi1wJY3ixjPLeV4jywwInbn2XD6pOnrNHEMB77k4ws
	 lHgBgOjCXt9P0vbWzCXW8SWLA0bS9q3BVKlCa/gVHGPDMOUvzN1MKnQEmnGsSKV+rASX4
	 uw6zi+nrENCtZKD4TDENF05v4xdSkzT2oakvU4ajmxbdKWo1z+CiE3EVCwyhYlAC9vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=M8LMUd9p;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B4D606A323
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 02:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40B4D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=M8LMUd9p
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b0d09df973so2943481a91.0
        for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 18:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794449122; x=1795053922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qKzq1YaHaTK/cMOsuVlloBBGSRBcO+4dM5JD9G9qTYM=;
        b=M8LMUd9pSI4E189tEYTQVVCeqMNbmM8OBOGdL5r1WCP+ApYPIFhMe0GulCPpc/maC6
         v9xWV2K8DWgADKMPZxbEZBtBgtXib/TA5zvfMr1oREvVJC04J0SflCaRXieUd+SQZqHV
         AecGMblpWBVJMHQl+geL5R3Hc+6KlnC6RG6f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794449122; x=1795053922;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qKzq1YaHaTK/cMOsuVlloBBGSRBcO+4dM5JD9G9qTYM=;
        b=FEnTbrVNEYWet+2fqSrjXPbe5D+6jofAU9ohFNijEn6sXKbOreX9ILjqv73HOT1LoZ
         PGAQsfUg7JJ83m/uZcdvkhpMVovxNUWkzG6TK0txyaNbG27wTUoYEK7VK1lSc6qnhQQB
         6jYqnjK4w6o1l7PGkTLUNho7tlKFFvUZaa18V6cHnS+aaytfHsP4lrgUqXOJEQkU/Nru
         8TyUUelocm0YfIuuYWWmEM1X7Fq4iTaiEQJDT8YXFCCiLoP/2i2yjQrdNVWFtuG+vE7c
         sVq1KkvL6Zi4FXUzI0VkC7vDVSgjlF9hC76Mp5VJ2//nIujXB+GMiV9uZIAsURj0kRwz
         QTHA==
X-Forwarded-Encrypted: i=1; AL+hErFnq8wjte8sP55Wi2aV5IhRRuc6dVBHyP3MUEH1tdgGFpykpXH4XfdDlFzLY421j2qNk07qEQGYSJDV@vger.kernel.org
X-Gm-Message-State: APuU4Z9mJc+oPPHLkhjaGPIE43sOFUoggMC6UXJuiMhXEp3WASjQY413
	PL6XcN2bUOlrADe3/zt9gc05qWDwmvRLPHdNz1aMJzOkhEDcL1HKU2OPB2N9F0KVZQ==
X-Gm-Gg: AYBFou0J9zmAJREVG+D7BlJZfG5Mm3cjQW5nGVFquKlzDmrKYxH0f/GgaE2U5rpNIEV
	nfxRBLkICQDfIe7HINAzPe+oQIS1raGvYYaMrqkNEt6ZvD2MNOQ+PVsq1QclgmrIyom/gsTGT4O
	y1AZzLWR9PCBsbuYDvimQbVSV3HqRuuxEh/Gyb8EsdgF4dJ2c3m0ljorV+IWOSV6jjpQOuTGyOn
	e4O2a050PhG5guX72axVa16/OqYinuIH8twhalZO/ElFstLm7zPEC+KM79qY0f507tP4wjG4mHX
	Yo2IaXqyzODB3ufY8G1t6PS5QOacZXwFU6iwacswZKic2nROctrRHy8q9HhQ4LP+h2eMHlvL4XU
	jS7sHCNASijPyqnHTYOjw3uTiLFJi9BXYRv3nKjx1jDP654tHnWJqRDoS89UyyuvreqMMEp6VnE
	6aGbDbDqcwAkJAwCpbhgZAXwhX8UTZaFedsxtPaVPtDTOFeoUp2Q32tHjT96iBveOje6SapkgIZ
	kDICksoAlz23DR9LAjSsGv4ofBPocXFZyTbGneGzfZjmcq+6xgI6LoQEWizghGOsqH6QJMWRsJY
	+z2LQxvh0iIJjbe258j/9Ie1MkCX6fDvTOMQ2f6RQ7ApeDd3vvcT9SJ/EKaCgaelo75Iyw==
X-Received: by 2002:a17:90b:4ad0:b0:3a7:3474:b1ee with SMTP id 98e67ed59e1d1-3b182f1adcdmr4140105a91.60.1794449122530;
        Wed, 11 Nov 2026 18:05:22 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:ace7:ac44:3dca:1bb4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c6c9c5sm1832060a91.1.2026.11.11.18.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 18:05:21 -0800 (PST)
Date: Thu, 12 Nov 2026 11:05:13 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Xueyuan Chen <xueyuan.chen21@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Helen Koike <helen.fornazier@gmail.com>, Vignesh Raman <vignesh.raman@collabora.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v3] mm/zsmalloc: remove CONFIG_ZSMALLOC_STAT
Message-ID: <avUet_6jVqlWSP00@google.com>
References: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>

On (26/11/11 20:41), Xueyuan Chen wrote:
> CONFIG_ZSMALLOC_STAT only controls the debugfs interface. The class
> counters are updated regardless of this option.
> 
> Remove the CONFIG_ZSMALLOC_STAT guards and rely on the debugfs API
> stubs when CONFIG_DEBUG_FS=n. Skip statistics setup silently when
> debugfs is unavailable.
> 
> Remove the Kconfig entry and replace the existing CONFIG_ZSMALLOC_STAT
> settings with CONFIG_DEBUG_FS=y. Update the English and Chinese
> documentation to match, and clarify the pool name in the debugfs path.
> 
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
