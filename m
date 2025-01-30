Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00F81E9B3F;
	Thu, 30 Jan 2025 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738255419; cv=none; b=TMAHhEhMuYQRJ79oMfJkzmAimjV8avWQUUShpT4yCqDZqlhWHV0lAUY+aDpjzvCDMOiPz4UOTGIySi7h76ewqTrhmVvwyDAw3Vs9+dPR91vW6q/JB86fAefNmK5J129eww5MCMcrPJKp3KSxMN+X/VAQNOxbxBU6D3hedSkLxzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738255419; c=relaxed/simple;
	bh=hhBv3POVUd1nGdTtjZ0JNABIBnHNg87TTTD5MkbEwDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HfwDvRO/jefVm+1TFC6ySMacZ/rZhIQ4K2Nf57VCnB99/Zd5OyMpXT7QQlfzhqhpTHKviKf8veufcoLEMCEeBH8YrXEgJBJFjafjYlVFfEpuGqAR7vaOHAgedTLbqcQhxWmSpp68MkryepWAp+qt72rV7MJCVTPtrrrBC/mzQRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQHzppv3; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQHzppv3"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d896be3992so7036706d6.1;
        Thu, 30 Jan 2025 08:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738255417; x=1738860217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ubib907lOWhPsp5HRG3z3MJOH5T78yaPo3zxk31gW0=;
        b=HQHzppv3CGcScoFmv3sXz2u/FXXSVtsQa3hU5tzVA+pcJ3guPP+HNOrz12UQFLZlRO
         QFdlPJbbbbT/0eUXqFEb1bU5QpUFXO9ffXypqjJpFt/FIWejChsSlv6nj9jjVlgsw+WN
         fZnUkXUxUqdmqV6vL/kIHWg2Ob994UZ49K2t1CTfOsD81suyPSbGCh9kyjZibV99F+1b
         hmNZQru/20D5yqLptEiAwEr8hNV0KyP0fm6f4aHk4eRih5Hmrk5dVKCMwIiNdje1lcYH
         qn9M2F4QPo3BBmK2T0zvZBGpioimhuWXuxvwNxIdCsZt5pn75j5WTRLdmRYU9Uo7LNWg
         6CLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738255417; x=1738860217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ubib907lOWhPsp5HRG3z3MJOH5T78yaPo3zxk31gW0=;
        b=RF82fjzFpzL7nDpS6sSdMntSZwLtAszu8o5apAZNSzOHv+3riTiDx//oaa+cfFhqSn
         Hw4hq0fTPUub782LS2/i2MWtLWdkFwiApRem/vkq1S+5+X7NkJaLs1hPObsao6PU6Ek+
         4ntyroJoRBctW/tVvfqNQ+5Nuy+JePY7JGEKuKSSuKZgFQq2Wyut7JsPCxXe4UiMs7pV
         s0whBPt9nEK0xT8l6TnPlozOC+nz/z3FQVSLW0NYjpzISuGBIVOpnAKAPwGzb6FHzcq2
         MV18lmmwuCoBVIadvaubFEqNI9OKTOOtbcOCAmRusUYRk/I9yULUdOp1ulmSwN8t+vY1
         T6fg==
X-Forwarded-Encrypted: i=1; AJvYcCW16Szwfq4Km27X1LhgoH+WBILTUV43+VARd7VHN8Nb7iIAWq7AcRlY9uayxUv54jAFClnRqjj6kaiS9A==@vger.kernel.org, AJvYcCWJr0bD9bvKRopXdm4ZBVW4YJCOz5c9s41O7FfhPpOA33wac3OO3YzBGNSrHPlv0lC6Vs9kljsZqw44lxcu@vger.kernel.org, AJvYcCXBHrlWep4imGZJHexs5qscm2KybXJkpyN2egTdJ3oKl/AVGw2eFWcxbg5V8QELO8y6qMCtS+DOles=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGpnkEzNi93wXU/1nDy5dCYGj1cwYsX+JXldgojmJGzQt/WViz
	ipUYwjtPBrQjIhSWLE6Gs+xsLQj3Nl8hTbFKl+28rAPnvlccAJi5CHiRVLPd/lQE+rVR8RVRLzX
	rMDBTci5O75/vl5QyS6fxH5T7k8kFMHDG
X-Gm-Gg: ASbGncuG6q1bXYmGPilZFWSLJ1TkF8+MgUCUMGU83VnThYFlUPoqZuG6kmco0rM7ksA
	O6V91ItDxr1HSvgGbCOfIXym9VOT6OvBdvfi5Ldzvu1pxO5mzt1lXeOUKpugbCoALaFxD+NWIDf
	1ypDDmm8PsyIP7uplS+mCdnvwmikse
X-Google-Smtp-Source: AGHT+IGujsprEQv3Xe96Am1wYMjLyKljLO/L5COIus+Qx4iC2crERg2iTYERWLe7OP6zybHi4ADnqt1Mhikbkr35Ywo=
X-Received: by 2002:a05:6214:62e:b0:6d8:850a:4d69 with SMTP id
 6a1803df08f44-6e243bf360cmr98636336d6.1.1738255416728; Thu, 30 Jan 2025
 08:43:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129180633.3501650-1-yosry.ahmed@linux.dev> <20250129180633.3501650-3-yosry.ahmed@linux.dev>
In-Reply-To: <20250129180633.3501650-3-yosry.ahmed@linux.dev>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 30 Jan 2025 08:43:26 -0800
X-Gm-Features: AWEUYZm4BFGxHAow5GcdNZEfMlp7AvFEDULDBjH8He2bC6lpApDMAOQZJlKfIPQ
Message-ID: <CAKEwX=PK5MF2wixPngQuU74kQvzVNX8tpEwsLz0PRhKY1cYSNg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: zbud: remove zbud
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 10:06=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev=
> wrote:
>
> The zbud compressed pages allocator is rarely used, most users use
> zsmalloc. zbud consumes much more memory (only stores 1 or 2 compressed
> pages per physical page). The only advantage of zbud is a marginal
> performance improvement that by no means justify the memory overhead.
>
> Historically, zsmalloc had significantly worse latency than zbud and
> z3fold but offered better memory savings.  This is no longer the case as
> shown by a simple recent analysis [1].  In a kernel build test on tmpfs
> in a limited cgroup, zbud 2-3% less time than zsmalloc, but at the cost
> of using ~32% more memory (1.5G vs 1.13G). The tradeoff does not make
> sense for zbud in any practical scenario.
>
> The only alleged advantage of zbud is not having the dependency on
> CONFIG_MMU, but CONFIG_SWAP already depends on CONFIG_MMU anyway, and
> zbud is only used by zswap.
>
> Remove zbud after z3fold's removal, leaving zsmalloc as the one and only
> zpool allocator. Leave the removal of the zpool API (and its associated
> config options) to a followup cleanup after no more allocators show up.
>
> Deprecating zbud for a few cycles before removing it was initially
> proposed [2], like z3fold was marked as deprecated for 2 cycles [3].
> However, Johannes rightfully pointed out that the 2 cycles is too short
> for most downstream consumers, and z3fold was deprecated first only as a
> courtesy anyway.
>
> [1]https://lore.kernel.org/lkml/CAJD7tkbRF6od-2x_L8-A1QL3=3D2Ww13sCj4S3i4=
bNndqF+3+_Vg@mail.gmail.com/
> [2]https://lore.kernel.org/lkml/Z5gdnSX5Lv-nfjQL@google.com/
> [3]https://lore.kernel.org/lkml/20240904233343.933462-1-yosryahmed@google=
.com/
>
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Acked-by: Nhat Pham <nphamcs@gmail.com>
