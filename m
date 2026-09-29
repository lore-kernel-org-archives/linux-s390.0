Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CF146D568
	for <linux-s390@vger.kernel.org>; Tue, 29 Sep 2026 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697504; cv=none; b=MghL+3MNWSBSscPUZl3MAYGaGTOX8qEYMnh7A45BBTm4UJNADfcSFL/Z8IhqK4DZfiBof5vnYx2qp+mLytx9XUFO8J0gNUfBIwjHQJ9tIOheg3Q2Yl2iGIiZGhvxf9KQ2v97cipvh/PzY9zPMttk2ox8oJgh4zYgK7bTPOd28So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697504; c=relaxed/simple;
	bh=nR4yrTOIgVgspvjCPgKKmvkm5cZCrViKQN79fpTorck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQGnW1gJloY1pbEPWzCYCd0FU/AXn30hWIkU7mJXnNjDOnIfcA0B8cBMBKsmnsA0dS0wiaxjk/V4uiX4gdR/XetFrnigL6rVsvZc8wrwhbTt1JyxcmMuE1VznSPzjDwtDB4l+Gc5ApwR/WIWGUEHYlszufXuCYfHfbBLFHXB6so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TGjFZgg5; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TGjFZgg5"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so41089215e9.0
        for <linux-s390@vger.kernel.org>; Tue, 29 Sep 2026 08:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790697499; x=1791302299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gf4CL38l7K7zHB2Jr75kV3VIF1+DE+Av3C/FhqhlLqk=;
        b=TGjFZgg5lUHeZxukRtGDBpWWXiPuev8gp7o7FIX6qFXoKC2EajqRD+/ExUDCSfZjoC
         i4OrZjFiZGSOtA6mpUM4f/v/zeZAXWCL3g41cedVNWBPRLuxv+9Dd+SWUiKp5re4pZfU
         jJ7hvCUY3S01HlnQisdD/KK+9JhEQayTnTWsXyOQs91JsZXPSkOOZZ2+4l+vktxu61vb
         8w/OE2ayTWQXiV2FZWNafA6HdPrYCAqgm4k0PQXdk1/Vwauf44GR+0YcnVQSOaFVxjpB
         d+/mHzpjlC5QOs1jyDU2SN5c6YrW8WpQYyg2fsMt9DDG51eS4rnjRbgfKV2Dql7KmKt4
         ocqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697499; x=1791302299;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gf4CL38l7K7zHB2Jr75kV3VIF1+DE+Av3C/FhqhlLqk=;
        b=vggkrZfgQK/WKF9yIHwZmb2QJjiSH3u3GFbVpUx72yyUXTYtY7E5G9nKrSMlS/JGKY
         +w3w2oWwf6ukAQ9QSj7iNjh9hpMAMsXA5MNQTN8H2CNZQcgYGeZFsTzAFuLCjc1hU6HZ
         ZjdYLEYhvpzGdfnfPfjhLy8cm1RZYvGYMm2y0P0K5XVDGeF08SE51jJvbcqYbUbpQhsK
         ps69FvrLATZVXIVHyUZI/1kIMtOgVLGRgtUKuCbYlavBsWzFqLLZA4u/0Cj3iEcg1nkM
         9acARUh6c19MjkqMAomB8YGq9WcssZap08qj5l3FtMCZmXjHQT9trFSBlvGqA3jMgncF
         BnSQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+qDRnfmyzhpzmzEPWWRlNtPkDwZ7mxiso80nItIRWdTOpDveZF1sibeh9zUyRgPyKaaWs2VRYZiks@vger.kernel.org
X-Gm-Message-State: AFuF++m3U90sBxu5Xa31spup/Tz9IdsjgstykJFPWm3jXgpcnG1gD263
	dQ5z2Ib8jLv2RjOJCeMjSE+WMB4E1NiAsq0bwy4UQH3Nn5ZReMxHAm538jhd3cdzSVk=
X-Gm-Gg: AYBFou2lWqFz/+cszzCQkrDvTRVP2PjlLRex5yvh6xr/D7LzByzC0cU1juKPlP8skaK
	4Uad2uNThbNaunF3VRxCC4ZQyqSp40TH5mDtozlFaqWckd7o+Ezw+V93uhh+cNAG2fgE1m7KhGX
	N12/gqNqvPx4h4WdBEm52pz8zxRuiQSaY/+CKgtpt9rlrX731D9TcWCixnLkAg6X55yaiDkV3d8
	bZdqR9tnpHeJw1vD86SjEJLFYoHUE07OMhg+3UohJi8dkEpBikFOEwWuH/GJYiXT/IjQ5pY+m62
	ES0gcWyHxZkJYJWZ8IznXDzk9z0lZtAJnKQkAtK1dWFmXMkGh4/DWKP0ID87sEH9wm8W7XNNp6V
	wnNt/wapmZBOaETID6RX+H9cMOGNQt+h7UhMXuKbzH/2HlhBj19/hH9iBt0g9vGhmgMo/qMLbgY
	LBz9saxRdKFTWZ325HqFgp2BG+Wq+n6byaVEA1z9UIlPMy0RZ43nOQCJurAhRTYihBx/2JYi8Fo
	POY
X-Received: by 2002:a05:600c:1d1c:b0:49c:eb16:9fd with SMTP id 5b1f17b1804b1-49fe66c9ae3mr284330975e9.3.1790697499193;
        Tue, 29 Sep 2026 08:58:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::5:5c0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf9dfdbsm127631095e9.1.2026.09.29.08.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:58:18 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:58:16 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, linux-sound@vger.kernel.org, 
	bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 06/40] mm: make map_kernel_pages_[prepare,complete]
 internal and unexported
Message-ID: <arvf-dEnIzsXhzkL@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-6-4583d8a23bca@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-6-4583d8a23bca@kernel.org>

On Thu, Sep 17, 2026 at 05:22:15PM +0100, Lorenzo Stoakes (ARM) wrote:
> There's no reason to export the symbols for these functions which are only
> called from internal mm logic, additionally there's no reason for them to
> be declared in mm.h.
> 
> This patch therefore removes the exports and moves the declarations to
> mm/internal.h.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

