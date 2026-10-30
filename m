Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333155;
	b=EqxqUGp9F5QzkMBlfay3EBsvx3Y2D78ZNqIqqKVAxrLEmXqeuW7f1gT9t4Uo5snwdLYm
	 LGCIi6yrybr4NTwP6XIAoFq4PTuU0Z3Qs64jtyv/WSZxsUyAzwD9G0NL5aIaqlO4BzjDz
	 0HLP7tZfNSd4npxcbG42WHTB7SG8gwY+M3O3ZW2kzB+rMnZZC5CxLn8MwETKHdY70buKV
	 KrHDRaD/eoiLjF/nnqljV3MOJfYI42F0snZftSFZ+iM/IFh4igYSPnGCIVUIC0mA2ao8z
	 EW8/QB/XP2kXtegbxmp23AU5Evd+V2fW4FC83zgkYbTUyYQQ5yW5e0YzuYd6xuJQczw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
	b=YfxV0F9NqJBUtESiMyN+PkMbRto/463UHbNsXxHlLIVZYcECctxge9f/gzShKFpMugw/
	 guHD/4WwetlA+6kwxCWeVaVUMsqa3BJnf5Kli6jl3U8/3BSb6OnKcanUuFaPzVYaG901d
	 TuZY3U3wgvLtPxsa7LiOV+qbIwKUS88G2T/lsaXsGVPSQMagRNbfxekjRQ57CZu7YjI46
	 kAqU6FCJRJXliR+aP675nHWBSCwwVohejT6+8t66czg782Fkbv1ZMpa0axH7aNuV/5f7O
	 z0+Jv82jq08npc7/Z4NodpkiBDiAH3L308DSwL8hc+lucy++U9na6mWzD2UF96VxBIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="cZUI88/L";
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80FD606A326
	for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 04:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E80FD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cZUI88/L
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3514b90bb89so632143eec.1
        for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 21:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793333154; x=1793937954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
        b=cZUI88/L9F1F6vaHkoJiPubaFvpBx9ZOZoFIH4WzYEl9uT8+1501kBXRQ+iQnW1rG/
         4Fw7u6pK2bhGr83aiABmILWeko3myUezgpD4yxFu1q8ofu7DAw3nd3xwaeMW+dOR7WjW
         fF2I6XSi4uBYslctXHDwkVQCwzAYXH2+VEB4ld4ijUFXCUVYiKPoDWGSOArpmY2b6MgQ
         9ZvnqUJjjMcJdZxPtAbFTkDp6O48lwLVb7JSCvyQcehPpzJbJ6jeHUnZCR3iOiOfxhs1
         cwBXgsfbLoMorO9ZFOLAr33BI+k9rnycgZilL+r2ECnd+fRbSczk3whlomOJkp24wZFS
         GQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333154; x=1793937954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
        b=wAS/H0U6zFvvLDaB3BJ5vkjjNq1g9F/04FtwjdJmQiki2kTCRqsQkuCMX13gaA7nJq
         KOQS5O2cA8jx7ZerxDGqAxfmN5AkP9WMSxKD5dmNR4wI9nr9YiLzaK6xOk3lcE+L/z07
         dYDxzPVD+lrA4P64ZG/vdNBPFpbCYt+IfTE8N20uUVv6Vt8HQJi6GLfEqDQ/Po47RxwY
         ZKZNaGw6XkuzEJb1HbgrOLdLdYDa+wo6lLqzchHM8eSevgoAhwbp3o31SY+upR8/nXRk
         fK7xgQJbfBK6tmFQdxaIPysq9N8D809EOk9wqff4YukuE30oWba4YiBAUm4UAOamd3PK
         XDdA==
X-Forwarded-Encrypted: i=1; AKwUvByfJVMVP+W4Rm7DgETKIBbEFa2jcuh07STynWWOvW+CmWgv4TNlYJjS/nkHbvzoqe0IYLEKq21hPFhc@vger.kernel.org
X-Gm-Message-State: AFq9FYLCbw2bMtiMweY23j6zGC9QlS+u5P8U9utmABY7/EtsksnshQFg
	Pmx0BCXQ+R8AiXSEpE3Qnd9VzfCLIXk36VKransLHlTrTzmAQit0S3RAPyRZGbPVO7M=
X-Gm-Gg: AYBFou19Ymf0cv/utfvHmEBPe8pZu7YNp903jAOotg97gJYYO2+VUub/9FJq5NKyHxI
	iti0ms+s1mhU3v7zwChUG4/1MdgwqgazyD9/AD3qWwlRN7Vp9Oj49hAVI4uUSryqNd3dT/PMhLh
	uXQ46A0qMu646HLMmUV/kNwDP1+rrzsciaXIecsVraQEIr17r3J84UyiFVmO2zusgbxwyCD7eNS
	0r56Pf0bdEnioorwdgCZY7PS3YosFDZGrLXKs5GeMQfiLC7gRamj/1XtEHBciI+PXeuI28NJ2AR
	CGqRjbeDrPpihemCrRJO4QrAK52lO05joICe9ena/1KVU3XGCxtJ9OEQtU7O8ysYhh8gNbp2+d/
	FNFkGl4tdSBWgBX3LFFC5oIJnLanwuZL4b3zoyCTw/nWx206FzL0UkGgxlSq2cU3SuixfJhYAA7
	ablUfAhZ6VCUCS4DrQpJz3BAxD7kIwbePuC8G7ftg2N+Q/MHOtowPiOs9KQGDCsAiRJJyqMYG0g
	XrK1+ssN+ozvmd8ruXhDte5Q8S5Yuv4/9Vi7/MgfPao48FtaZmeuceACk5ccSacAbzzOt8bfscF
	lmF1qz5fdReXuNH3c7Ucdzhd5KDNTwQ=
X-Received: by 2002:a05:7301:53cb:b0:35c:e696:2d4a with SMTP id 5a478bee46e88-36a423ea99dmr1772736eec.24.1793333153319;
        Thu, 29 Oct 2026 21:05:53 -0700 (PDT)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm3512579eec.15.2026.10.29.21.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:05:52 -0700 (PDT)
Date: Fri, 30 Oct 2026 09:35:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kees Cook <kees@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev,
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
Message-ID: <auQXnep2xKpuNJOF@vireshk-B250M-D3H>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-5-irogers@google.com>
 <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
 <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
 <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>
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
In-Reply-To: <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>

On 28-10-26, 16:39, Rafael J. Wysocki (Intel) wrote:
> I'd expect the driver core to pick up the series as a whole then, so
> please feel free to add
> 
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # cpufreq

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
