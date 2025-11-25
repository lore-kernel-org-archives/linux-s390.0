Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA6532D44F
	for <linux-s390@vger.kernel.org>; Tue, 25 Nov 2025 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764094237; cv=none; b=sT/BZ2ypFoiaOz3UEnLwj1RYAtk0mpE5z5RtVikDs8XQQ5YOwAg8AKVOdUvm6DDXMKvV3gWYtzdlepxUrT4XRyCuGx7JKav2B+TjSZaWxr7Fbed0tNFwJ4O5DFXsUgIFDVC/yfGOtHxex2GWIJJbC+QLl3OBagifnW6NzZlb/+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764094237; c=relaxed/simple;
	bh=ysTc2eDRKC1yaYlCntECXBP0Mr0bFCOoYm1AllRC9WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DE7ugZf4ib6FxJHlIPq7Hd2MNNO3U9y4OZeX94jOm2C1xjhNObMOPjTP49+HOdvcIAdHuojLamernRPFMBzwPvLU0UALXX/NHt7RrQYzqAI/jZ6uygedMK+TrYyUQjxm4G3VWrP/Ifc/mDX2Pwl+Ckr/ULGSbbSTuFokADYLmso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=XWTIDnSr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="XWTIDnSr"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-299e43c1adbso7181595ad.3
        for <linux-s390@vger.kernel.org>; Tue, 25 Nov 2025 10:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1764094235; x=1764699035; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Umec4MYCn7UWFTu95kobtomRxgANDBIZB5gZ37QVB98=;
        b=XWTIDnSrc9U5sBdvmmh6ehi8KkobtGGOTIds7XppVRtHqZQyd/NQ5rZh5S7TaXs/vG
         kQ4FELEbkHqzKSD2HU4a9K8C1Wk5WyP6yJZ13tWtSA9w6+A1vb2fA16oh2uCO5KLNCQg
         E/8Q/La6AOYPJ5t0rNY/p3ngGm1W0qZnzoEbSJf8WDuMi4HEW3NKxz8ZwHT7ykGR5Mfk
         42eJbpu0D1w7YeiBDimwp2f798gUlYqz/SE/hyhibdwRHPPg5GrMZlydteAFxgC2g3Qw
         d0gAKVKZ2ShZUSNJVtYpBWq9hRI19LTXqThxbtbHQ747PStxtLKgIAfdwSvYci4LP3g/
         ATyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764094235; x=1764699035;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Umec4MYCn7UWFTu95kobtomRxgANDBIZB5gZ37QVB98=;
        b=dvzRWz06RzQ5GM2L+plx63cmBPshWhtpdE8gR0oq0O4YTtQZXHT/sDwW/FAb/lNxhi
         MG2FO/B1jPW5Nyy3YsCg2XhCuno7WkI5MQjsra3Du3B/lDJPs5tk/w/X5oISQMlH+AOD
         QSCQa4R83pjwtxsnu8SXkrJtFMZJSYCOot1v+HaCQyCVcri98+BN6AWQ1EeKNrer0okZ
         p0QEoPygierjVwm5z+fK6jyJxDnonWLnsfOICYjUZs8vJ2RPErXqIniccJXwltvzLeVd
         JnBBPBM+58kf+cAz+m0URKsQcGGxIEle4t+YhPBQjQxEjHrLahSPlvgFGbTROfj471Dq
         coMg==
X-Forwarded-Encrypted: i=1; AJvYcCVEFRyfIpXgyAaOKQ8PW94oYn3EaAAgHdMVWcZvlGiiuYFTAM1Y16Kq94Be/fH8hN5kdMj0bYgVUJyM@vger.kernel.org
X-Gm-Message-State: AOJu0YxwLBcCAHh4BXuGvJh/g8//0QVCBY8eeD1wMyesL5ZpCPnxPYRk
	2IpQrbMapWsK7x1CSFmYBfjd012SmSXb1ZP//abuy+xfvb3eyZ6HQrfqFRiCQg95rMCrY66y4vb
	wHb22
X-Gm-Gg: ASbGncuu1am4p1m4XTbfFV2VOeAl71QSrv5Ol0MbvZYaWpo9iaMW1hcQosHouuyu5yJ
	/OknfcUBO8wDF/KdcTYLwaKne6GUdYzM8bvK5vwfs7JC6ilVegbuS/pgXOGx4id3s+70ZKTPhbf
	6PpWA07ciHFJ8ySp1zVKuIKc+JmYJlTxQTxuZ03X+EpeTbc0Pq6YG/ompAfuiMmk2WsBEHqmXap
	ThQHExx7qVUI4kMfjsgTCrIiIza9EO/VqKKdZ+QupyzdfqPxnh2CHddpHiK78AqsAoNAAX8opS2
	ACLWVVP7lAo7xPublKLbdNA++IsqkW3ZxL5vwX8lnXwClaoNrfHqtxQXp9SXCykA+QrjS6OOfT9
	FD+iRBJpQG8NAy+qZQWZBoSDeiUT71VpNsW7fRbLXN5xKErOMsqD/hzveTQ==
X-Google-Smtp-Source: AGHT+IGMaalvfN9l0DOr2S33Cgy8CQf0jRx582FHWei67nCNYyq/uZZfeYcD3+INNTene/3kJVhYsA==
X-Received: by 2002:a17:903:19f0:b0:297:f3a7:9305 with SMTP id d9443c01a7336-29b6bf6c143mr103444455ad.6.1764094235141;
        Tue, 25 Nov 2025 10:10:35 -0800 (PST)
Received: from t14 ([2001:5a8:47ec:d700:7dee:b1a1:fd3f:6b76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f174ba7dsm18606671b3a.64.2025.11.25.10.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 10:10:34 -0800 (PST)
Date: Tue, 25 Nov 2025 10:10:32 -0800
From: Jordan Rife <jordan@jrife.io>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH bpf-next 0/7] bpf: Implement BPF_LINK_UPDATE for
 tracing links
Message-ID: <gjfaxdq3qyz2q4ajgigwmqthhkoeffuym7sy4z764m4bvmfqdt@4eggpiyxff2i>
References: <20251118005305.27058-1-jordan@jrife.io>
 <CAADnVQJ-9JubH5r4oSwQneu3o6U6s8Fa0cjCsi=+6-R+9nkzHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ-9JubH5r4oSwQneu3o6U6s8Fa0cjCsi=+6-R+9nkzHw@mail.gmail.com>

On Fri, Nov 21, 2025 at 05:43:28PM -0800, Alexei Starovoitov wrote:
> On Mon, Nov 17, 2025 at 4:53 PM Jordan Rife <jordan@jrife.io> wrote:
> >
> > Implement update_prog for bpf_tracing_link_lops to enable
> > BPF_LINK_UPDATE for fentry, fexit, fmod_ret, freplace, etc. links.
> >
> > My initial motivation for this was to enable a use case where one
> > process creates and owns links pointing to "hooks" within a tc, xdp, ...
> > attachment and an external "plugin" loads freplace programs and updates
> > links to these hooks. Aside from that though, it seemed like it could
> > be useful to be able to atomically swap out the program associated with
> > an freplace/fentry/fexit/fmod_ret link more generally.
> 
> I don't think we should burden the kernel with link_update for fentry/fexit.
> bpf trampoline is already complex enough. I don't feel that
> additional complexity is justified.

OK. I could drop fentry/fexit from the series to avoid complexity with
the associated arch-specific stuff.

Jordan
