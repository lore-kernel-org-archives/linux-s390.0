Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E303A8749
	for <linux-s390@vger.kernel.org>; Wed, 29 Apr 2026 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777450727; cv=none; b=ZhYjY2laZUCcUFGgBwywhLvbGAv5H5MCGmZqvPsxrOQi4IZedUEUqisMSX+aUfT8TYmKig27/CN1I74e6V4yH8oElHv12X0dmg0mukvGiDXSm8WJci3HRGZH9416ruTxvrisjUzpir+jnM3mJBIzItoSpaJVFEjVQ1flh2aeRls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777450727; c=relaxed/simple;
	bh=s8rbV6KtrzDov1Gx7EUtRtnDKhu4wwiVSF4nPpfRfRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKjJ5eB/JR82Jo4etyLcjjY6QiiQ3yOaWXTmq0zFwg88e4QPatjj+q2q5SeaBoSZSd+ei73kiQZIEUSGXiX/LARoewWFJoOsex3g1muC+1ehRFoDEwGRWMoMWOWD2PoMuENj6XQpkC3HdOjJxb8i/LTbA0hdW3xb08mt7MmGN34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Dbp4uK6f; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Dbp4uK6f"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48374014a77so157162765e9.3
        for <linux-s390@vger.kernel.org>; Wed, 29 Apr 2026 01:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777450724; x=1778055524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8mYcczxMu07MlbUpDzgqU5H8GryZdhtCkRhAJDByPzk=;
        b=Dbp4uK6fFvHXqVTDw87HcwvOCGf+XIeKY/q6MZJFddIiYQIfkNV3tVnW3st/ENYoZi
         Yz+yBqJtlIDqy2XBfkni67lkCzkcZ2Fjavr90o0xVd5yfR2/faTAE5e8QNZe2EKN0jr0
         VwjXqzFgAASsYi4Pke0fCI1n/4v3ke48loFZZFNpjw+LLP5AqvScXyAfpim9wXNozG1R
         Nz8RS/e55Se/AHCHzTPt49YMq1sSNjSMVlzuI4osOHbCGajdUJOLCMuVEExSm7KaJpvX
         DFPHPA7KMbbyuhj9GP0aVG6sbuOugncaQDMj9HJAQd9SoWjlC9HvUn4tV/uu2YuHCMuA
         i2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777450724; x=1778055524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mYcczxMu07MlbUpDzgqU5H8GryZdhtCkRhAJDByPzk=;
        b=BiV19Ee24HddIPqKLZcA2H1E+6RGu7jpXoiRCuG7aUFpCfsFDyE99Heh5m72ZuEj6F
         +hoVnx9F6M1uI6tls61ZATYza5Q/S1dMiYglqJquEEYtVdulDiug+fq/rCJe0PIwtRAT
         /iHR05G8Ns7qIa7SjVCno4PXr4vJWAzfg74idbdkD4v6UlofeSEcQU1beLcqAaT1glEM
         PWvSXxdrvv1QLM4d/S2Fy7HUD51W2zBTFkiBtKk6IcX1LIk/PigJMb1Kew/g4+CW2QTB
         jsgDLeF3tQ0pF1UuwqDOJJhIc9JjFNcjZzDjdflRvufvTwx4O2v4u66fesRrRmEa2EJS
         iGPw==
X-Forwarded-Encrypted: i=1; AFNElJ8XR54H3JzQiF5TifAIX/nFaQ8YWFJEAxyM5AIl0OcirrTBo9gzTeQMV0DBbmjv2efOXqckfRm+kDqC@vger.kernel.org
X-Gm-Message-State: AOJu0YwDCz4E5iaJ5CEMUpq1Vrw6GBhmsSH1kAD7pAoTpawvlPpTzSuf
	mpA5CNm50KLVJ1yux5SQm5KpR34yiqHEaslE5mLMBMJ0I6zIU4oLZ1QtEkQszrNGyz4=
X-Gm-Gg: AeBDiesX5Xe2JNVYfddcpwtVhWtK6moHMLTMZwkoIxsV20ptJwXCRkRVI1iM5cjSuyP
	1zYVaspu4C3vM3sKd/EMXms2LjHZ59ONg9+8cf0WS3x76thZ3Knbrn7ufb2epMvc5WlbX10q8Ow
	gBy2DkxfSuOa7TseqvL9VRGzDs8K3/BP/GdAlC4Cc5dFmXEc6TbSPzcif7/lmWcMm68rMSxHHtF
	8Hu2KInZbY31OD57doyQFTwY7VTK2GmvR4VC6fC1T2MA0XHWVeC3E9iRT1oKiESeARbqOIpqfrO
	WJoOR+6IVBA4rVK0FQF1w/7gmcjLRNuvEW9IK+i2HHCUNRjM21pnyoKhohfKktPtmrkvKr7x1QB
	4qgJ8YdpPpmB3HbaLR6Iz6MxqOIvUTwElC22sdg3sh9NsSa5GBAq47UhrT4+qucucHeX4tBjd7y
	Xrh4cdvGeaR2nSsncytQoI/cPxTT83QWHD/WuO6RbWaByyXJ57vzAo2a5HHw==
X-Received: by 2002:a05:600c:c4a5:b0:489:1c5f:3a9e with SMTP id 5b1f17b1804b1-48a77aea521mr100717885e9.13.1777450723891;
        Wed, 29 Apr 2026 01:18:43 -0700 (PDT)
Received: from localhost (109-81-86-177.rct.o2.cz. [109.81.86.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c2f2eb8sm20657925e9.6.2026.04.29.01.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 01:18:43 -0700 (PDT)
Date: Wed, 29 Apr 2026 10:18:42 +0200
From: Michal Hocko <mhocko@suse.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, brauner@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, timmurray@google.com
Subject: Re: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for
 exclusive file folios
Message-ID: <afG-4hq7Hr62Uu6J@tiehlicka>
References: <20260421230239.172582-3-minchan@kernel.org>
 <aesg-sj6_VmXyqxb@tiehlicka>
 <7c7da8ae-cd39-4edf-b94f-c79ab85df456@kernel.org>
 <aevBRh08X4UTMUj9@google.com>
 <ae8NT0tLt7eBmH6j@tiehlicka>
 <CAJuCfpHQdA7C50V2WjNrdYcp7feV5ukgxJf+vMNEcp0P1SGEow@mail.gmail.com>
 <ae-Zu-VAzAA7SdLa@tiehlicka>
 <ae_roPR64e6sY_fN@google.com>
 <afBaJLLFigkdszov@tiehlicka>
 <afFco71vwmpQy3pk@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afFco71vwmpQy3pk@google.com>

On Tue 28-04-26 18:19:31, Minchan Kim wrote:
> On Tue, Apr 28, 2026 at 08:56:36AM +0200, Michal Hocko wrote:
[...]
> >         DESCRIPTION
> >           The process_mrelease() system call is used to free the memory of
> >           an exiting process.
> 
> "Free the memory of an exiting process" implies all memory, not just
> anonymous. User cannot know it will free only anonymous, and I am trying to
> make it work as intended by completing a symmetric reclamation path.

Page cache doesn't belong to any process.

[...]

> >From cf292f8f8ead8df9161aad342c36633ffa90257f Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Tue, 28 Apr 2026 16:39:06 -0700
> Subject: [PATCH] mm: process_mrelease: skip LRU movement and expedite clean
>  file folio reclaim

I will let others to discuss this. I maintain my position that this is a
hack for a very particular use case and you still seem to not explain
non-Android users of the syscall. Anyway, I will not repeat myself here.

-- 
Michal Hocko
SUSE Labs
