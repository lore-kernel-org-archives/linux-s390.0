Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482788;
	b=DeYcL9laO/ZTU/hgkY3vXOrNnS++EHoYVx9TT0kWAZcD0Oc1L25nhZNc97mNIuKm0WtL
	 9Q8C4nk6OvrTZnLGq2CqazFNTee0tV0lPThkDu8lt2BMmnooQ3+9pn4+aeUK9q3V7nvfS
	 GIkmQt7GSC5tT31z+I4IpHeqasy7SlJv+i83oRXUbOlbjb5kFCGSXqXgQowR1jyovKvTP
	 0WsRn0Te8V77DCf507ART0CQt+BtjYFLsGoA1EifyA28tKQh7yTZE19GMIguXvagBAwRe
	 z10biAV/ovHSThTGwkWvW+YO3vfd+czbamyklS0LO9mYj8skHUxiMQTjjLm67VG1ZRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=2nWBtEEn4hd48cIOC+JW/bLoHA1gTBtQ/8nPmmpZzBk=;
	b=Uet6sfOlv6VC5YJkG33zlyxqhBGaM0tEjpnRji5GkZGdPAnaxhnpYVoL/JQJ9wTYDp0v
	 gkKyLfeyOWOfw7qWttUta46ELE6/mstCYiFRkBak+SmlPH43r+0qCZqEbMsboz/jkXsis
	 NcdqkEUho3m+qOrW1YVjxPX2nhB9+q/Ul4F2m8hAYqGa3djryV+TN2HiOZHFjmyEPWcWc
	 vS1yUHZkJxunKQscwbuW4Dmwmc32iODc9jz7Owx00IJI5YCsCYFsQHhNm2E+Wt+uNUKxJ
	 8khUB7/5gmN66p1B/k8wJ8fnWwH8aeZiQyKX2NcAVFeh/M/LD9t6i08c6L0NxSPAEdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W9UGKRc2;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF7606B364
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 11:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60DF7606B364
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W9UGKRc2
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3719e3cb82bso153978eec.3
        for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 03:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794482787; x=1795087587; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2nWBtEEn4hd48cIOC+JW/bLoHA1gTBtQ/8nPmmpZzBk=;
        b=W9UGKRc2VpXLmhTp/WpfJWMZ8+yRuAb6+uRW/wiTSfJRv2O4YFBYyF2VrghSwiHmtj
         m88CI55CSUU09SUUnLyLquc8Rum0kVd/GVSZ0dyVx6hamjNBtfkVl+jxNggqxGMOH0rs
         x9SeNmVOrPcixQY99GpzlDmY201Ozk6VJeAjxeE+Mn3fkKmGXOdZreoPuUk+KdLeHIqc
         xfKvuJyKAoBobiXe4PODiMLA3u3LNONJd2fxNIPULiBxAjwmBOzn6GG6OmR5l5D1WFxq
         PoiPJ7eQ8GHDoNgo87TAOi235ekR9nfqaqJZ7BF6Lu18RXMrbJuupNFqYzOgPkVq2Uau
         6iKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794482787; x=1795087587;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2nWBtEEn4hd48cIOC+JW/bLoHA1gTBtQ/8nPmmpZzBk=;
        b=gmRqhWHDM+Qp6ULe6w2UbkJtNkHP1dFWMqB5LGnBp6AV1X9cBSWuooZ1kH0RmSzMjQ
         HNiFEYxedbmhjlOEXmd04DN3d4KtgUzfkNloCyJj895iSvi2lNYigQ1kudRy66RzYsTF
         QTjJKtO8LlFhjj7VqfXGYRGAzD94l9urvwiITMaGn73SgqV+bIypqoXqq/LIBtCvCkYJ
         H3pkdOlAVq/xATgfmCCEkni/2+YVzaR9qlkttVe3PMxSzthtfGuFzF5zUMK9BiNcLsEo
         XARW8/RfA20TvZIm+jOg3ZNlXaYghwULuxRWi/5wkiNONRWSBGzZY0dC2Sy6FCrSN3Jx
         KUGg==
X-Forwarded-Encrypted: i=1; AL+hErFmBUEu/dPMmgFe9h8ZA+b/8cv95ogpYXBxzgiSDBTTKiZYuAx8ZMF4nD+Dn19EG8nYsTM6sE91tPdU@vger.kernel.org
X-Gm-Message-State: APuU4Z9PqOF28kTynICrZbZyxE9qLkpZy/ai9xCktMIEhwGvbWlF4tVl
	EqAtBVF7jQ8pXP2e/zKJOz1tcvDsWgWZfzTTzmpaWTrPxfrX5iQwueOZ
X-Gm-Gg: AYBFou15xvbsK7gm1O9FL2jiO5RAiPENH20ccUVor9FDeDojQSgCoSOJq72SkYeIICh
	vvAPq0f7UJytAO7xowF0RGbrxf8hqVym0OHsg8GugG60elnazQvq5ITH6iOWMCQ7z50HWHc92u9
	KXOPTtxcZ0VzGlKwDTR3CBb89DcQxD8eZKAgXDSwn5GlFJuryM3NnHaNL1pxxcxu8UUpIXdPcqj
	hNpb6t/mIdrjLHptAr3KnWMlY+/yBxwA8l485XA7qL8H/Sfynd1eapjhx70bjLRZa51I6FHKKE3
	Lf86F1yubcedLrSqdSa+u9naGoczBefrCKkJNQKWOtxNI2Ls0xN7h0tt8nTpUT6Mndt4SYDjII4
	QTAi76DvxjLMYPGvkjqGGxC6DnoNA1L/kc3y/ZQ1q3ZSGuwfUFeotZrXHrKpwvyUqCr6NC830aX
	ZLPUUaoHmEJulI0WnLbRvNO2nDh7wErfC3gCDju4quSRpqi7eSN9f9XCSS6y4LCfYWUQD+AM3AO
	XLdcanwQ9+aEDaYuWyI6C7Gi6/sAHcG7hvQHSLki5lKImAKoiAHH0TdUHxWdb+E+crutSCpzduC
	tvaJnhkFxTCCed7zgK2FtbPeSzNezFQ/p3nl4xD7DBdD/E9bWaxH/4p/Exd28HA/SfU=
X-Received: by 2002:a05:693c:8113:b0:35f:ea17:d171 with SMTP id 5a478bee46e88-37684ceea1emr9219901eec.2.1794482787103;
        Thu, 12 Nov 2026 03:26:27 -0800 (PST)
Received: from o6.lan ([2602:fce1:44f:115e::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306e3sm27380131eec.7.2026.11.12.03.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 03:26:26 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] mm/zsmalloc: remove CONFIG_ZSMALLOC_STAT
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Xueyuan Chen <xueyuan.chen21@gmail.com>, 
 Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Helen Koike <helen.fornazier@gmail.com>, 
 Vignesh Raman <vignesh.raman@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-s390@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Nhat Pham <nphamcs@gmail.com>
In-Reply-To: <avUet_6jVqlWSP00@google.com>
References: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>
 <avUet_6jVqlWSP00@google.com>
Date: Thu, 12 Nov 2026 19:26:15 +0800
Message-Id: <179448277582.2553194.12524350925159624366.b4-reply@b4>
X-Mailer: b4 0.16.0

On 2026-11-12 11:05 +0900, Sergey Senozhatsky wrote:
> On (26/11/11 20:41), Xueyuan Chen wrote:
> > CONFIG_ZSMALLOC_STAT only controls the debugfs interface. The class
> > counters are updated regardless of this option.
> > 
> > Remove the CONFIG_ZSMALLOC_STAT guards and rely on the debugfs API
> > stubs when CONFIG_DEBUG_FS=n. Skip statistics setup silently when
> > debugfs is unavailable.
> > 
> > Remove the Kconfig entry and replace the existing CONFIG_ZSMALLOC_STAT
> > settings with CONFIG_DEBUG_FS=y. Update the English and Chinese
> > documentation to match, and clarify the pool name in the debugfs path.
> > 
> > Suggested-by: Nhat Pham <nphamcs@gmail.com>
> > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> > Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> 
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Thanks!
> 
> 


