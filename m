Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087C030F7FB
	for <linux-s390@vger.kernel.org>; Mon,  4 May 2026 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881100; cv=none; b=c7x8u/HSJQDR7fDUfUBPzQ55a73Y3NrAMtTdlh6SbSnYBLzMEurHnsq1hWjUWZCeTIZLgIxyH/zivi4RaGXtPN93u1DbVIW4KcC7AcLDRUN5AUDem7ijZjbVmZMv/lMRZ6xzMusj0YbYwH5VEb7cSNV0thQjDyMExuhmjKI6CI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881100; c=relaxed/simple;
	bh=P4QzuP/dgtbdGxn4Thu4H5J02aQLWEt94wPnLeAISLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow4xUJv0Lmv+T6ACeZ8IENtE0mdxoSXQ6TxXdq6BQBXKEmYl1BJgyRCnF8HyNTJdlVjNJ/Ann47xHdjtHLAuWbIDuOodxfXLO6GZyMSGddOM8W/i7uSe2Pdz1/9Ijnm2nsyDJnufkAj0OwNZIJiaVK6ZwhgWEvUAP6cYvHBcHAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YWTmCaPF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YWTmCaPF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso28919795e9.3
        for <linux-s390@vger.kernel.org>; Mon, 04 May 2026 00:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777881097; x=1778485897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bm3fGVRDJmvzKcGf6LzNIYgcMVEhDfTh7xuJQzaCqRs=;
        b=YWTmCaPF4KMg+wdf5B/15POxvtBFyiHXkQetKLhXzAVaHzE0p1UsD46JXIQRfu+XIJ
         98BZkOFvT78ozEdZhFXRdGiayFYtVDBzeLGm0zJG/H17LUee86Vy557X+jjJhxnopFm5
         V8BsOm+oWf/Km9hpS0PQhWKmbEkDpkg3APOafbYtQzYdgsNv0j2jIwPAUPmUJ6EZdYY4
         aMWlyuja82xOKYmQI8nDHAaxQwH9rlsbqt/S8G3J2UMGmDgSe8OgyCoPVEUPWn5JL5XA
         Zlha2pCsO5DW8vzEwZk+gFS6uF5HHlHjTALSrIxIO2qZj9fdOj51lVzxEGHMCu8Ijwj7
         CpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777881097; x=1778485897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bm3fGVRDJmvzKcGf6LzNIYgcMVEhDfTh7xuJQzaCqRs=;
        b=LSaBRdDk9Fevh74JAgoSRw31VzrLvBxxBBE8JSRrB7gftw4EBHqta0umbeif15KkVT
         ayLHRu1YjM7g299ZgAAGb4R0KHtewlrN1NmOpaaOGmeVuU9PaDrM0zUjubj7Q+KLg7CZ
         +2YdIa8DyJfTao8vaFT1oHfZX5tZVzrmfg3f4xznIE478ylokdSQmbPNsOplV8DM4eDu
         NE1fMTQBYrCXcUzk5cpjqijg0z+/YnEwsK5jJELuXpUF+NdfrnyTY3/U20YcoKjWjF66
         9y0F15JTPiL/hmqXBeQh65z2EjgEcdBc3fsie3hnsmvjH1v/FJkfqPy/CTT+Sv0v7/zY
         UV/A==
X-Forwarded-Encrypted: i=1; AFNElJ/gIB4ukFMFxAjDmbJv7PA27PNIvJVseGOjOZZwPUZgT/Gv3QxI2ZEXBDEIxbDNcYV8kicXudUKyI7e@vger.kernel.org
X-Gm-Message-State: AOJu0Yx//lkErF/n6uhW/9Qkob6c//UNjTLj63lH9m7qf4Ds40x+NOxb
	ZaVV4UcuAzCv6hJZyOO7+ae0IA5kKtI4PWGm6ZOK6sarZ9pk836ZyZhAEYDl66+J98o=
X-Gm-Gg: AeBDieugLIljrLsi1EOQGAc573rLm6dGvvX2ek8VQC5XwJzX47xUB1jDr3YGvvhvNEK
	azkBXhDLHRakNkAH5P7NVHhdG1pOXQwDB/Wr1ipiTUnybu4GiKX5g+BAvqPxMWe3QxICEb1pJsx
	N+HLnpNMp7udxYavs4A3C0NfhuNio+CQe4mSxu/CRwQZxWBk7VJ/utQ41qvNap10SctMNvrtvPE
	VEqFUZUaxlQFzmcJ34zNrwWovHFJb6Fy6wU8afk1fS0H9HVh8+PQOgOzPy59mqVCtvUhg2jFRNG
	2++2oQJs33yT8sfVJScBgS/DWV3zleQ+ifzRUSj/yD1ZCyeqx2Ne5PGwJPi0Cbo6LsCMda2Ytv9
	VBg9wLREiweu4KkkfOtYbTYtXxNdIpUKou2avYOL9r8paAwuA/e/kYi7eydlGETIYHQu4W2SVps
	PmwjrYwTKRVbbjDnedcKvdPeXE1W0x1s+CLnX2U2/+7z77eL4=
X-Received: by 2002:a05:600c:a302:b0:48a:568f:ae8a with SMTP id 5b1f17b1804b1-48a98638a65mr96686225e9.8.1777881097362;
        Mon, 04 May 2026 00:51:37 -0700 (PDT)
Received: from localhost (109-81-23-170.rct.o2.cz. [109.81.23.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb694fcsm271098285e9.3.2026.05.04.00.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 00:51:36 -0700 (PDT)
Date: Mon, 4 May 2026 09:51:35 +0200
From: Michal Hocko <mhocko@suse.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, akpm@linux-foundation.org,
	hca@linux.ibm.com, linux-s390@vger.kernel.org, david@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v2] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <afhQB0CWEcflXpOi@tiehlicka>
References: <20260429211359.3829683-1-minchan@kernel.org>
 <afMnKrYT0xG_a-b3@tiehlicka>
 <afUYfpwWsUQoB9hz@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afUYfpwWsUQoB9hz@google.com>

On Fri 01-05-26 14:17:50, Minchan Kim wrote:
> On Thu, Apr 30, 2026 at 11:55:54AM +0200, Michal Hocko wrote:
> > On Wed 29-04-26 14:13:59, Minchan Kim wrote:
> > > This policy differs from the global OOM killer, which kills all processes
> > > sharing the same mm to guarantee memory reclamation at all costs (preventing
> > > system hangs).
> > 
> > Incorrect, we do the same for memcg OOM killer as well. This is not
> > about preventing system hands. But rather to 
> > 
> > > However, process_mrelease() is invoked by userspace policy.
> > > If it fails due to sharing, userspace can simply adapt and select another
> > > victim process (such as another background app in Android case) to release
> > > memory. We do not need to force success or affect processes that were not
> > > targeted.
> > 
> > This is a wrong justification for the proposed semantic. You seem to be
> > assuming this is just fine rather than this would be problematic for
> > reasons a), b) and c). If there are no strong reasons _against_
> > following the global policy then we should stick with it. There are very
> > good reasons why we are doing that on the global level.
> > 
> > If for no other reasons then the proposed semantic severly criples the
> > shared MM case. You are left with a racy kill and call process_mrelease
> > approach. You certainly do not want to allow a simple way for tasks to
> > evade your LMK, do you? So just choose something else is a very bad
> > approach.
> > 
> > So unless you are aware of a specific reason(s) where collective kill is a
> > clearly an incorrect behavior then I believe the proper way is to kill
> > all processes sharing the mm (unless you are crossing any security
> > boundary when doing that).
> 
> I agree that in the case of a global or memcg OOM, the kernel deals with an
> emergency, system-wide crisis where killing all sibling processes sharing
> the same mm is an absolute necessity for system survival, bypassing
> user-space privilege screening.

You are misinterpreting or missing my point. I am not suggesting to
cross privilege boundaries. The syscall should fail if the mm is shared
with tasks the caller cannot kill (same as it does now).

> However, process_mrelease() is an explicit user-space initiated system call,
> and I am still hesitant to place that same raw, destructive policy blindly
> at the UAPI syscall level even though I don't know of any known security
> issues right now.

This is very wrong argument to introduce a potentially crippled syscall
semantic.
 
> If we really want to go that way for the collective kill, at least, we should
> evaluate signal authorization (kill permission) against *every single*
> sibling process beforehand instead of only the target task of
> process_mrelease. Do you agree?

This is what I've proposed already.

> Also, I wonder what the signal/process maintainer thinks about this approach.
> Christian Brauner <brauner@kernel.org>?

Yes, this makes sense. There might be a very good reason why we might
not want to introduce a way to kill cross thread groups when they share
mm from userspace. I do not see any as long as you keep the proper
permissions for all affected tasks. Maybe we cannot do that sanely now.
But these reasons have to be properly documented. You whole argument
that this is different from in-kernel oom killing is just not valid.
-- 
Michal Hocko
SUSE Labs
