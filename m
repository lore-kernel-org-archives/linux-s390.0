Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1812E9EA4
	for <linux-s390@vger.kernel.org>; Tue,  2 Sep 2025 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804936; cv=none; b=KAvkNIR+gr0V1lGWRPK3Lg2ONRLELj4x+gM9K4htTtWg0pnPj7pwuTVTaz8J4citqS5DyMZoF5+GpzfIF7ZQQAxSDcREJ8u7ZhI2yvnQjMeanjdg5xqmw1p/9EWNtnHZ9gBd7IcyuPTW/d/XjAeRfYE9uNc6eywE+qWAAYa0n4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804936; c=relaxed/simple;
	bh=Pv1NlzKjL0xFo8BfGbhy/7KnNZN8WrItjraHEOkXixw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QsO21xYfqfcgZ2G2Y78IL/Uotjy5kf8/L2FdH6tcjfCvtvW3wN1xYzrr8WxFXVh2h0ImrP0TEvfn7/oLWO4eaLTwWv+Y1M3FlevGQuTZ8Dy04+5Bkqfz5ttNKpRh+clHNbB0B712eu77MzwizVcTd4egKF90pHQbg3QHA96AXIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=BjJ4DkI0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="BjJ4DkI0"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b804ed966so15860045e9.2
        for <linux-s390@vger.kernel.org>; Tue, 02 Sep 2025 02:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1756804931; x=1757409731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Be300C9M54HN2j6qqn3KzILYOn0Dm/rUn/s4aJntRQ=;
        b=BjJ4DkI0nOIeBWi829gHdcdGEnRHe1ZnQO1njdb+Jyp0kjPhbqnc/pH3IqlbX/mPRt
         KImIiC5IOBhDUsCOe+bsijMfqcLKa+dXYa461vlf8W43jDTp2NN/HyQttUmEPfTyMDsa
         +znjOYbf7zmMPfsw7iujVXgeGLUXtwGXlQ+SY2EucQk11hSB12zyiFkHuuLs1Vp+GMQK
         znrByajiS5QwRXsCGGX/uEAkboujg3cDsCxXhSDvaaKtpi9xTJYSIPVmQMJW+nANv+26
         x3bpMDTCAYkVqg6BQ0C/DVGa/O/iwl4l6QGYI8jJHyq5e0aZ7lgtishdDOyJn3yv5f02
         d/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756804931; x=1757409731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Be300C9M54HN2j6qqn3KzILYOn0Dm/rUn/s4aJntRQ=;
        b=B3jHniB1ZZzTCExKVZGp/mDGvwhpvx0sJQmZL13z4TrmQqKmxDFrx5WKWpZj+Rbvye
         ln/J12ziV+dtmuk5CoGG3ew0Q+28eka68WE7QGxUtmAjUSPH/9GyLMxwjKD0egg7Ajrl
         ywuMOOIytIYKLgh/9RA/HjZXU2Td5fnVuybEo7ORfAQ1ngpo4sl2TthBpG+56BG/Tb6X
         VjpnjZaeD07eEy/6rmWknLb/yyRZA67TsKrMSy56lKkvpe6cDpOGPy//egQ8Jqa2MiVV
         LiNHh0h56noA34e+Psw6iAdJk+zsNVBggd0SnA59uBYZQu6ALvlXyZF+Skb6yqJLJ4RZ
         g8Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXe8KM3vNSBQWQHhrrzPFwFScreVWbUIioL6rGRTBBcOgT/KvrUxe67WS8joT7kVKMf+j6/0PH8r9xR@vger.kernel.org
X-Gm-Message-State: AOJu0YxbLuboD76wZ6M772f0jzrh4mem756jC/L7IAr0GgyISCAwtdrJ
	7v/6a7QefUS6a/oLt/iqjPDRb8TekN7zJjiEEmw9T7JZMcoclvEOPOUkIOCU58JkTTg=
X-Gm-Gg: ASbGnctw2n0S7GaBErQwLhig8pQC288x5OS9bR2SlNsf/eWrBFYcBXPv8rdGxA/RVsK
	9lSEYBtZYhQJi0tqVu5p1klyKHL9mSh0FxyD5eWfG1WdZDd1q33ZT/40WkA0/AxIP39b8AXflPy
	z007Dh4UW9oRvrX1OaQrwNgJ3ulCyefHHCBQQ3Yu6CxVoKWEPavrFw24ybzXZDa2MQ5pLeeX69j
	bCUY1/wQpSOkU9XLIwM49/RTxUybuh8VAe1zAupa95QZV52PAvozFypAWcjPAPf8W3hhTxc66sp
	z1x5sbXaNxyRbxapUq0R0QoCriWocbxBR6+Akcb+nsZl1f83apSb+UWHBVJnvSeiVv/LQUZzoXn
	EnyfaHMKcVmOWANfcX5Q3SwJPBe4HAf4z7nM=
X-Google-Smtp-Source: AGHT+IFjGWdM7r4OC2xPYq10JBW42QzIVS9ISDbv655toZnOdc57tKWSkMByc2ni755H7QY3mBnVYA==
X-Received: by 2002:a05:600c:a04:b0:45b:7d24:beac with SMTP id 5b1f17b1804b1-45b8553335amr94619035e9.10.1756804930815;
        Tue, 02 Sep 2025 02:22:10 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0b9402299sm17994846f8f.18.2025.09.02.02.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 02:22:10 -0700 (PDT)
Message-ID: <4bbf5590-7591-4dfc-a23e-0bda6cb31a80@ursulin.net>
Date: Tue, 2 Sep 2025 10:22:09 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/37] drm/i915/gem: drop nth_page() usage within SG
 entry
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>,
 Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>,
 kasan-dev@googlegroups.com, kvm@vger.kernel.org,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@axis.com,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Marco Elver <elver@google.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
 Peter Xu <peterx@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
 wireguard@lists.zx2c4.com, x86@kernel.org, Zi Yan <ziy@nvidia.com>
References: <20250901150359.867252-1-david@redhat.com>
 <20250901150359.867252-27-david@redhat.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250901150359.867252-27-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 01/09/2025 16:03, David Hildenbrand wrote:
> It's no longer required to use nth_page() when iterating pages within a
> single SG entry, so let's drop the nth_page() usage.
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_pages.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
> index c16a57160b262..031d7acc16142 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
> @@ -779,7 +779,7 @@ __i915_gem_object_get_page(struct drm_i915_gem_object *obj, pgoff_t n)
>   	GEM_BUG_ON(!i915_gem_object_has_struct_page(obj));
>   
>   	sg = i915_gem_object_get_sg(obj, n, &offset);
> -	return nth_page(sg_page(sg), offset);
> +	return sg_page(sg) + offset;
>   }
>   
>   /* Like i915_gem_object_get_page(), but mark the returned page dirty */

LGTM. If you want an ack to merge via a tree other than i915 you have 
it. I suspect it might be easier to coordinate like that.

Regards,

Tvrtko

