Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571300;
	b=MAIRQ5m2QP9vuHfLlsuvO2j7FJSxzlc/b0TMfw/J63OB0SqFQa8T6SxVzoChWZLV/lzA
	 DqNwcPY6ph8LM8ip0OjESOKDaqSYQ5NKWcLMzjTWgq2UH1ySu0qm6kdn2/517zJUB2Jri
	 59EPKEqrI1DiWEum3l/OwlFt7QSbdnWThJD2yaHXYRpr+0dFz5gROPZX9XBPgpd2hg3rL
	 DBTGYJOA8JUtga6fu2NvjY+1XnW3/WpepUG/LP23MZXH/gWmljFAOFlcPAjgV6bAHf9U9
	 qP9IBLEov22lto7cqcATEyx4frO2uj32yMGjJ/ufPo0scBFqayb0H6oaJpyK2VA6r+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=kudVfvR8j8oKpMlnT4HRJXKZnsjg3IZPx8xqv9ln/aY=;
	b=2pRV9R9x0jGkImjJjW5jr3RrWPKppa1CU+4ld6KJ4Qpu3Ra/x1PW9OQFqCLygY51RrWZ
	 YRtR5mfTWBILrkZa66q4aZZPIykJbEqm/uK0obPn02GJ3R4eJcQ7Nf+vAg3lHbK71nVn+
	 5SWcK1yhTq6snwRcJp/CATjbT/q9uoR9ElUKFRC4CpfNNTR55XcefU6/61/D9VtNIrG1U
	 jHhBGhfIzy0x4n/MwQwQc7ZMgMBA4NgnYA5srCRprTvY1vP8tWoIBMlqgjl4C0Z7DOfLq
	 VsS1Biu2JfQGl+3wBsmiH21oM6D8uXl4CEji5ANjFv0BJcMl+DgPzYbCWlLNXwb5wPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d+pL95pW;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6894F606A8D1
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 12:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6894F606A8D1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d+pL95pW
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33c10faf6easo111003eec.0
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 04:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794571299; x=1795176099; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kudVfvR8j8oKpMlnT4HRJXKZnsjg3IZPx8xqv9ln/aY=;
        b=d+pL95pWTQ3jrjsxlqw989H+pRIcGJv3p+LmtTJBiGIde7CnsOXvSoqBApHnEmkY8W
         CIHbYQSmM2kh35Pl3BlaLCxZsVNZ0fu5sfL8j8UFuehkrJgEFnYzZc/3eToNysPq+YfX
         vmfJh2csbKkvlEQdIreMGP7eViXk2+5J/H98WxURJB66Z/B1NiyOgng86GIXSJhfsKHj
         fQqXXta6cctfbhUb5bLPwttwNlXQzr2BDXsDxq7Oi37tkKMNlCKRK/fTjjo06N4N6/hF
         OmS/OaWk0J2tj9/UAJeyq0nEXNwh8YKS68TtURAi0Otfyp++uyReuokYx+SdBU6zoRLx
         rbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794571299; x=1795176099;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kudVfvR8j8oKpMlnT4HRJXKZnsjg3IZPx8xqv9ln/aY=;
        b=ASHYfkAGCa1dOsFSm5cTkQUo8tKd02szcqHkZQORPDm/IisUzU5lCUqKmHubwIFL+G
         7NFg6/HUI609CJamwc9DdX97cQb1jNyKB2UwFVMfbNpSSgZlDOXvB8z8ocegNj+xRyiq
         Ju6l6PPFCQviv3WVZVD/DYb9bffj784Nt69bKAIrnC+4WESGhaqvmsC4I8hknLsZR/F4
         fTQ3jo9G1cSLfXY6P6vxOxVefsdKLyfnHz6ksY5O8Mkg5MjapYYUzqPuDAvyS4hV4qiv
         cdn/RiyYF5qqaWzTOoRdnSbrTjDy8KuAyXHFRMVVSk3TehAWOKMe8rugu9SgCmdlvdYe
         AN2w==
X-Forwarded-Encrypted: i=1; AL+hErFwND62MHGs6IAeGFmLp2YUJx7l1bIZg74KSVS1Kumzn441TMry+AR67K2n/4X01vKmpBQy4SsmOAU/@vger.kernel.org
X-Gm-Message-State: APuU4Z/mIe46//OgqZ2yYKdg5/FmfAzMKZpuzXl6KcXn9LHj43TixOBk
	0irDSDdW6pGBEtE1EC+7CfWioKpPUt6WBaYYn2kKFnODwykDMKxZSYzbvM4PM8S68HReAw==
X-Gm-Gg: AYBFou1QbKHXOIyga+Un73We9sG1cPCfBYqrGpHgKz+OKJFbSe0nxdQU9e7mnzpkJzY
	pRu3UrB+AVIMtXzuZCFaFNDXdlILSyaZF8lYpVRu74R8w+w6E57Bzyf3/o5exu52hDMsmKBNhN+
	pnvcplewCQOCoHZ/OiDDmFCf9gi+E3jlma5X0Cb0lJfFZRK8CLqaUqUjE4AK7o44OYWZrRSoN7A
	Mhr4+++ELTJ2KyeD7JFNnA1Ow+3VNjiRwI1IX+0zOiWS23NsQG/1BP5jrVqWc36g8/LnTCwhmzY
	y/7DsEN1H8rldCwr9gtYlF9UsuXoVmdGbVmpvX8OLUKmfHieSStWudw65VKG6aErC3MigDsg6rR
	6MkjU+924jX11LGvoj8km8YJC47QJBH17ufiYkPt4NVcAMBbLme798F5gWw8RbD1uGZt4r7XspH
	PqafmYe+agCHnPj5z9AvWLs7yQPFSPmOI5p8NvKTp0VStb31PTrf4qGkHA5o1uA5Bg5u9CPczH/
	FddFIS+oDHCYogo3jn5i/JK0GeDL6lP5nO9fnJm3FBVUbMUrSRC1pEBiIiwz2Awtu2C4yGxdQ6p
	OmD41Uf5vu3PQeYlzk4gAt7BnytLeMHHUTl9vVsn/aPzK+PY7hbTFpOEHTOY1HKWGOnTV4OjirS
	QaFu4Cx+P5GeP
X-Received: by 2002:a05:701b:290a:b0:127:def:dd72 with SMTP id a92af1059eb24-1b5030f8a7dmr3059602c88.2.1794571299135;
        Fri, 13 Nov 2026 04:01:39 -0800 (PST)
Received: from o6.lan ([2602:fce1:44f:115e::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50313d8f5sm11650418c88.3.2026.11.13.04.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:01:38 -0800 (PST)
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
In-Reply-To: <avZyo_hCRonuhXW6@google.com>
References: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>
 <avZyo_hCRonuhXW6@google.com>
Date: Fri, 13 Nov 2026 20:01:28 +0800
Message-Id: <179457128804.2142163.14813125534208665209.b4-reply@b4>
X-Mailer: b4 0.16.0

On 2026-11-13 11:19 +0900, Sergey Senozhatsky wrote:
> On (26/11/11 20:41), Xueyuan Chen wrote:
> [..]
> > diff --git a/Documentation/mm/zsmalloc.rst b/Documentation/mm/zsmalloc.rst
> > index d2bbecd78e14..4c0786378dc3 100644
> > --- a/Documentation/mm/zsmalloc.rst
> > +++ b/Documentation/mm/zsmalloc.rst
> > @@ -33,8 +33,8 @@ proper handle-based APIs.
> >  stat
> >  ====
> >  
> > -With CONFIG_ZSMALLOC_STAT, we could see zsmalloc internal information via
> > -``/sys/kernel/debug/zsmalloc/<user name>``. Here is a sample of stat output::
> > +With CONFIG_DEBUG_FS, we could see zsmalloc internal information via
> > +``/sys/kernel/debug/zsmalloc/<pool-name>``. Here is a sample of stat output::
> 
> While we are at it,
> We use zramX throughout Documentation/admin-guide/blockdev/zram.rst
> and in some other files as well.  So let's just replace user/pool name
> with
> 
> 	/sys/kernel/debug/zsmalloc/zramX/classes
Zswap has its own zsmalloc pool too. How about this?

	/sys/kernel/debug/zsmalloc/{zramX,zswapX}/classes
> 
> Here and in the Chinese translation.
> 
> 


