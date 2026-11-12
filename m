Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443196;
	b=PklsDSXcZi4Iov0N9wKWOQX+WQOpWHs66vmq3P2IOizzwVWskLA8wKt6nK4tzuHUhYi0
	 cc6lOCjR6UoftxVOJ9gwAMhnI6akE0Txjx4ptQrGLWyA1l2aiM2ACIP0wcEUwLpEqDX1g
	 dRuefcmVbfW0vyKyDTi2KzZGU0ISDYVKjdxnqiqr7RWXDVRQZOVuKdc3cNvkF455tJyGq
	 Me7u5/P+klr076fId4c79s3EYtLSlDmoCW5aQ0sEivXU1ToFlTZxph2fEIz1703ZSHMJp
	 7/0K9XICTxDTKPIYcyO1PYaD6+KTbX2/iRa+IaBBn9vPQ8CuxxY5L2U4HnyMrw+KLrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443196;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=3JaUIX8TvleTZ/eyRqexb46r9ox6QF7gVm6ONPKED1k=;
	b=aWyKF62iMLG4F2S/ylNhExVD6FlI6yjMEBo53Fd9bv5mUrB+7YD+OZM1trSHOfT8IkjX
	 k7GhAxfaGV+uhG8eJFIRlMGguffMqalfKQBP+EYw7wAgmGyk/M3+Hrxfb9MIg9ki32a+p
	 LEuiVFI7lJ4O2SeMkCe5FYLSW+LNf06ed4NnThnc6AXvxB9xOhtWG5JOWizf4/giJDOJj
	 DqlWYpvDk919Z9i/Booyreq+0Gj7MPhtczc8zNpD0vzg7yHuq7PQ6mtVMEloRtjpi1zyH
	 NirrkhQQG7g5uAyEdEVaFwfy8m7YuvxqwdsOO/wQkHhfayumhJHVbOMiS8U0OpDCj4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rafqYhJO;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCCB606A31C;
	Thu, 12 Nov 2026 00:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDCCB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rafqYhJO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=3JaUIX8TvleTZ/eyRqexb46r9ox6QF7gVm6ONPKED1k=; b=rafqYhJOPOa4iyEQfoTvTZ4K6T
	JVbDXCbUOkzGjrQC/xfo2SUILYVmHnv+jE1DpCEUr5UyyUxk3wCBssj1LE/zlM9WK6X0g2rkRthwf
	yvfLdVgeFnsmpeZ63A8wNgZzMoPPVqhz+1cMNxhKwCoJxTwN7iPj5kz2Je+KnDPde5Np+p7Pg9+iO
	EOyofX6A557DYr4wnLBnWDkTd7V0+fj6dLF6mYRJ39yinQRTOo/ezE2ND398UgI9HguHC9op42+ko
	fsvSXzyYASfK+vM9pYCGI+HWF0RRni/yWCbKDFhSA+4aIBXHGZTApjFR6G3Fukte5JrpDtPvere0F
	Tj8w+vCQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIe6-00000008Em9-1nv8;
	Thu, 12 Nov 2026 00:26:30 +0000
Message-ID: <a7b1d671-18b0-44e8-b112-ab66893b3bf4@infradead.org>
Date: Wed, 11 Nov 2026 16:26:29 -0800
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/zsmalloc: remove CONFIG_ZSMALLOC_STAT
To: Xueyuan Chen <xueyuan.chen21@gmail.com>, Minchan Kim
 <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Helen Koike
 <helen.fornazier@gmail.com>, Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Nhat Pham <nphamcs@gmail.com>
References: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/26 4:41 AM, Xueyuan Chen wrote:
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

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
> Drop CONFIG_ZSMALLOC_STAT instead of making the counters conditional. The
> option only controls the debugfs interface, while the class counters are
> updated unconditionally. Removing it simplifies the code.
> 
> Following Nhat's suggestion, remove CONFIG_ZSMALLOC_STAT and rely on
> the existing debugfs API stubs when CONFIG_DEBUG_FS=n.
> ---
> Changes in v3:
> - Squash the three patches into one (Nhat, Sergey).
> - Add Nhat's Reviewed-by.
> - Update the documentation wording.
> - Link to v2: https://patch.msgid.link/20261109-zsmalloc_stat-v2-0-caee41684aba@gmail.com
> 
> Changes in v2:
> - Drop CONFIG_ZSMALLOC_STAT instead of making the counters conditional.
> - Update configuration files and documentation.
> - Link to v1: https://patch.msgid.link/20261106-zsmalloc_stat-v1-1-b574f4714adf@gmail.com
> ---
>  Documentation/mm/zsmalloc.rst                    |  4 +--
>  Documentation/translations/zh_CN/mm/zsmalloc.rst |  2 +-
>  arch/s390/configs/debug_defconfig                |  2 +-
>  arch/s390/configs/defconfig                      |  2 +-
>  drivers/gpu/drm/ci/arm.config                    |  2 +-
>  drivers/gpu/drm/ci/arm64.config                  |  2 +-
>  drivers/gpu/drm/ci/x86_64.config                 |  2 +-
>  mm/Kconfig                                       |  9 -------
>  mm/zsmalloc.c                                    | 33 ++----------------------
>  9 files changed, 10 insertions(+), 48 deletions(-)


-- 
~Randy
