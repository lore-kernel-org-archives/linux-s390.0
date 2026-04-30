Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D554239B49D
	for <linux-s390@vger.kernel.org>; Thu, 30 Apr 2026 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542959; cv=none; b=IOrxc4GX9uoUYFAhGyR4M2NE0p6epLXFA1G7kGEp1VXByRj3gtE2eP80zNx5zbI6UnqRkReEohNPLoBMfC+sJoJDvnn1fCcFHrU0Ljoq6TymnhTqbh/uVlM/bCDx3t/bcfZBx7zJfJhm/86eF6mDI6+E52rfaX/RFzDXEuJjVj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542959; c=relaxed/simple;
	bh=e+DHo+Hin6tbOEgPyAMwBLvRBK/cIqtKdfNFEOcMdd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skYsXk/KOji7/00UQeM3DJN4lDMdDfBOLjx6F3dWtRVQVVKD1VZNBLRFT0C7Pv0hzQIhPgr2TzVKgsVsD6gBrUXivGD4hgb/Jj08Ac/brY0CLB+I0LDXqAoqNOf+Uf+0VEAiJdnqPOdqyKbubzqa/t6f6Ig9nzaVOiE/xB1QWU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WfXwV6s7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WfXwV6s7"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891f625344so7829415e9.0
        for <linux-s390@vger.kernel.org>; Thu, 30 Apr 2026 02:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777542956; x=1778147756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/+mCPnhobn1Shg1eHQXCbaDaEjG124ocTnpLUhaGbSk=;
        b=WfXwV6s7GfmFEBktby/coAR7JZAQFjiJuGl6jL8HyHDgTy2Xbf9ZT47LroQA4z2LoK
         bnB2yNZ3HkeNCsMdcAawhqFRKI6bTDS5aaMaCGL5rhy2TXnZ3HHfUXlpctLuynWiikvW
         E3kIgqNbaGsSSajkUFK73z+RF9UGLITd2il1DMyQN28JUivPjpTlA48jq38qZdYO5N/7
         g8ORVe0G/Naa9x3lM5ar2qajMk69rTngPao2LA2BCajkpfL1ogUZc3mKm6P2EGMGbyQR
         De6wSpApBwjr8a47xwDdSbmtQ4XxZ5mYXmFywC0mBAO3Eyzq8E4hmHczZCgtcnIBi4u1
         uOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777542956; x=1778147756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+mCPnhobn1Shg1eHQXCbaDaEjG124ocTnpLUhaGbSk=;
        b=CDK6LISXo6AxPY7U5waQPgbLGyuDaLdtauUoyefb18P+G0ZRPTxw58O0TaLzfR3DGR
         dA284Sh4MBsYgbiKjfL4XUc7Zo6L2a1+Hj0gH9+dHhs14pGDbsuRVq4eViR16+Z/EHxl
         D7JbLd4mC1UOoG7ZrNgvUCpHlESwZca29a9SPpzgr2AVPEZwrL7wbDDGq55RHqRBcVWU
         yqMHRhF+VesOWLOWCnZkeNiWl+qUutlDOzja65V2Ic8jgakPji3z/uUnlF7TtBnmbOKF
         b1glv4faiUba7GmYOlVoLTRdJG7mD5REvHgMe22DF79WAsMJi2jVEehEXdYGxoOnB90r
         sFJw==
X-Forwarded-Encrypted: i=1; AFNElJ/+0bA8UaZ63bjXBCca8HX6J2AXeU7HMbyFw2bT3OclfBsdWU24eY5dR2dh5zvZ/QiDdeg5nlGMUW5c@vger.kernel.org
X-Gm-Message-State: AOJu0YwyxQvy4Ti5qAGNCfK6O2EPuV7CRTjGAwqCBs2e7JXeCK8d2d55
	HOonT1wBhzgfCDACP6OiHJWNdyUFsLyrA1KtE1z5y6CdNjiHOBcY6ogwArHHliG0MKhbHi+qZTF
	D1YPE7gA=
X-Gm-Gg: AeBDiesiWfpE/p5StpUXeHRpQcFnmNhQHRMMHhcUAygLi7qzwdT33l0CrzYzwxPHUYU
	e9GzTlj1iykmOunFRsRnjEnodKX05pYT8FvS2mdmTvKPG5NuOVDwegQLwGzQhXDH1bjtJiAb5Jb
	5zNTMHVi7RJbUqsiHVPrE6GSq32Ykf4S8NiglZ3op875aC9MtU7OjGI4TNmlOGtLgEf30VSwfOp
	4Pd0D28BMde7f4+vvDvj7/f7twii3YzJQ2uZ+QQdxQiix3NS0y6YpaNUbzo5JshJwvGxy+acIPR
	t9gauHlQWuLGlfmlyyS/LcKKElk+zco9Nmt9Av06310Urql4YFiOER2EuVBPaszH6jckRpE8uQj
	Ml+wPOpP0vAb3BZt0G0QkbhsqV6joJ6StoYdEKLUlNqnCYDpXTFVreekN3G5uXC60gPq5JsAABX
	K2upEMDtjfzemNenCY1sjMio/07hla8yLBynfrhfb035kiFr0=
X-Received: by 2002:a05:600c:4f52:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-48a85e684a8mr27887335e9.6.1777542956173;
        Thu, 30 Apr 2026 02:55:56 -0700 (PDT)
Received: from localhost (109-81-16-145.rct.o2.cz. [109.81.16.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c3235b0sm38663215e9.31.2026.04.30.02.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 02:55:55 -0700 (PDT)
Date: Thu, 30 Apr 2026 11:55:54 +0200
From: Michal Hocko <mhocko@suse.com>
To: Minchan Kim <minchan@kernel.org>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, brauner@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v2] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <afMnKrYT0xG_a-b3@tiehlicka>
References: <20260429211359.3829683-1-minchan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429211359.3829683-1-minchan@kernel.org>

On Wed 29-04-26 14:13:59, Minchan Kim wrote:
> This policy differs from the global OOM killer, which kills all processes
> sharing the same mm to guarantee memory reclamation at all costs (preventing
> system hangs).

Incorrect, we do the same for memcg OOM killer as well. This is not
about preventing system hands. But rather to 

> However, process_mrelease() is invoked by userspace policy.
> If it fails due to sharing, userspace can simply adapt and select another
> victim process (such as another background app in Android case) to release
> memory. We do not need to force success or affect processes that were not
> targeted.

This is a wrong justification for the proposed semantic. You seem to be
assuming this is just fine rather than this would be problematic for
reasons a), b) and c). If there are no strong reasons _against_
following the global policy then we should stick with it. There are very
good reasons why we are doing that on the global level.

If for no other reasons then the proposed semantic severly criples the
shared MM case. You are left with a racy kill and call process_mrelease
approach. You certainly do not want to allow a simple way for tasks to
evade your LMK, do you? So just choose something else is a very bad
approach.

So unless you are aware of a specific reason(s) where collective kill is a
clearly an incorrect behavior then I believe the proper way is to kill
all processes sharing the mm (unless you are crossing any security
boundary when doing that).
-- 
Michal Hocko
SUSE Labs
