Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57ED2D0622
	for <linux-s390@vger.kernel.org>; Sat, 16 May 2026 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778949085; cv=none; b=tKW88/KJFIWTijnCdOHUh4bMMHYNNLZz6e7IoBG/1DoLi+giheqEgC0c5snqusnIc127eMz/wlCrsEd3uqwrP4xR5WItf8WR+g0QGEMoTo5+DskVYirhco0yHz1/KeeKpnGuAWNlkpcS5BvdhyqCyLoLv56GML1YGyjblt3HimQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778949085; c=relaxed/simple;
	bh=pKSRT8Qd4R26AqrDEKG6q+Kp2l19YJ95HqS9pRLgqC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaAq8T/zHDqAj2KlHnA2m2gaQ90t+OloMh69TapqRewwVVdF8eCXwEqbWw6S0zMilprbf2kIZKwa+FjZ9GYaiUmqIzTLa/PT+lKELXrrDHcYivIjoPJQbcdsLN/dEZNwgeYxo3DAQJvjxLC8BZDkUzmSOXHiKzK2ZZb50o2VOaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cc3s4CtZ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cc3s4CtZ"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6802f9c5debso2527145a12.3
        for <linux-s390@vger.kernel.org>; Sat, 16 May 2026 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1778949082; x=1779553882; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MFHt3WS7pPHky8hdFM5dT7wdhV8XvIh/WfyCtsbWs3s=;
        b=cc3s4CtZwD/Mxc5guoO2gXjKx7GolTLC2uoa0o4eET1g4XNp4drnbp0JxUjSw4sHdK
         OC+CtBWjAtGzhwVRyTLKaKTaIkp4RIveEEEg54Tvl+hA1q8lCAKJMG1ExPDgo132ZQUr
         w4avfs+aRToaw9O7vpu7bsfgk7To26ApCkjvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778949082; x=1779553882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFHt3WS7pPHky8hdFM5dT7wdhV8XvIh/WfyCtsbWs3s=;
        b=Aom1QtMwwNNEszF7KwhdtMuxkAK1AeL94LFJCGA4PprXoZEgRiFp1drUOcjkiQ+dcW
         gqv2Xfu0mgsGMwCKrG+53Ds2qQkSlCPqnuZ+lVZcbwbGhFayLesxNSJMcDUBn1mLuDWx
         itlWnYTM0A3rxjtvEZdOV+nVoeviqrSP1bZ9Q2VqeK38Db4hhxmHQMMUIODiVJxOYnEA
         vRgyFDNkaMkIxko+A96dab+Q2qVNZM6+LJ4PnAGvBZSOr50G1cXCrZPYzR9F+kCgqGhC
         4bZohayMTZtBO6eawnRHdkdSiEtbHeSYXXgsX4gqIIeCXQtov4hHgtN9ENO4LRVyA2HO
         YSNA==
X-Forwarded-Encrypted: i=1; AFNElJ815saCcBi+2Qe76zGdwu98K5VqGeP5b7piWxA8FdqgncQr0qC289mMLTaPEcXWw8X7wglZsXKqVPRj@vger.kernel.org
X-Gm-Message-State: AOJu0YwKABkicoOs4HJlCF1avjsnGp05O1IH5BHzesW3RH5EH/kXTKMR
	crDjMRulkScb5Pd7oplxu/Cs0j0LR6dkMLm+mbHiXo+kM58leaWoc/J9RJ/VcntsZr0YbEAOCYg
	2WL4O1yM=
X-Gm-Gg: Acq92OG4WhlcgttCPSb/r6DxPksOhcnoM012ybjv8qb9yjg1b6BJ+8ckQXOKh+2BVgd
	/zFoEysh6WM8CeB9M5oOU9krBTSNy+DA5vBMuOdNqnA451zRCJQIblXON+RZormLLFtmCo8lyCR
	/KaHtGNHGb9wkwxzWjfJj/+yz/stPsGyr5ObITMdOg8ewVQptF+KlEXCGleXKAOKosEyrE7KWDU
	DDzaggVVbLYa+eDN4QeSjZVOU3h/bd4YKI/+l0QwMOqxrEbVQefTi6+Jn2Lr0oQsRa29glW9RDo
	irzV1XaOoz54SXy1KgBo1hthLUFDCSCx32oVvnSsIOFKzxgCyc/wL2jyras+zXBwPl0TwTaOd/B
	p/jeSqenXuerJlKIDl98rR7I3771sOySoIPOHENZqejLO3HwW2F9bZNPmTg4sJQPzPRXzpNSeBc
	ojHTHwf2A1OP83PwRAnIe0QNpAz+EWV2rJX1KK8F/ZjiteTzPSjQkIYIfU4UwUJ1IoNtV1WSD+O
	IpYAt0208o=
X-Received: by 2002:a17:907:c8c5:b0:bd1:1391:c326 with SMTP id a640c23a62f3a-bd517813aecmr495485366b.15.1778949081674;
        Sat, 16 May 2026 09:31:21 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4e21235sm360364966b.43.2026.05.16.09.31.20
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 09:31:21 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67da63ae541so2253455a12.0
        for <linux-s390@vger.kernel.org>; Sat, 16 May 2026 09:31:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8ZKbCFHREhsuoJeehH68l19BTl1AWMi92RsE7wU4SaXF2v9XuAdRS8jzexHV3fWbM08W6Veuw4guLW@vger.kernel.org
X-Received: by 2002:a05:6402:4515:b0:683:f485:c63c with SMTP id
 4fb4d7f45d1cf-683f485c93fmr3646745a12.1.1778949080207; Sat, 16 May 2026
 09:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511214226.937793-1-minchan@kernel.org> <20260515-nachdenken-umbenannt-a90006a46e14@brauner>
 <agd--WZpeTq2iKFW@redhat.com> <agefLhQeWpvil14M@google.com>
 <CAHk-=wiHfzbufXD2nuc9BhOVp-pYEmnVUYeThKmfZRXLU0kJ7w@mail.gmail.com> <aggE2haQ7yGeHPeF@google.com>
In-Reply-To: <aggE2haQ7yGeHPeF@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 16 May 2026 09:31:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg08=sZb=hVa22KjN2pD3aNk-diGmKQnizCgmoMMfrvwQ@mail.gmail.com>
X-Gm-Features: AVHnY4KZeaxgoWY4xTggm78AB2OXkk6KHZZ0t4P5460-SnjHdn5OCruGq4QgY7M
Message-ID: <CAHk-=wg08=sZb=hVa22KjN2pD3aNk-diGmKQnizCgmoMMfrvwQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm: process_mrelease: introduce PROCESS_MRELEASE_REAP_KILL
 flag
To: Minchan Kim <minchan@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, 
	akpm@linux-foundation.org, hca@linux.ibm.com, linux-s390@vger.kernel.org, 
	david@kernel.org, mhocko@suse.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, surenb@google.com, timmurray@google.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 May 2026 at 22:47, Minchan Kim <minchan@kernel.org> wrote:
>
> Regarding proc_mem_open(), it actually operates very close to what you suggested.
> It acquires a reference to the mm_struct itself via mmgrab() but immediately
> unpins the address space memory via mmput(). Thus, no long-term mm_users
> reference is held across the open file descriptor.

Ahh, and we've actually done that since 2012. How time flies..

> The latency issue occurs during seqfile iteration (m_start/m_stop) in
> smaps/maps, or during get_cmdline() and ptrace_access_vm(), where the reader
> temporarily acquires mm_users via mmget_not_zero() or get_task_mm().

Ok, so it's that much smaller region.

How about a completely different approach then - make exit_mmap() just
take the mmap_write_lock() properly, and allow walking the vma's
without ever grabbing mm_users at all?

IOW, just a mm_count ref would be sufficient to hold the mm_struct
around, and then the read-lock protects against exit_mm() actually
tearing the list down when the last "real" user goes away.

[ exit_mm() is currently a bit odd - it does take the mmap_write lock,
but it *starts* with the read-lock.

   I'm not sure why it does that - it used to do the write lock over
the whole sequence, but that was changed in commit bf3980c85212 ("mm:
drop oom code from exit_mmap").

  Sure, read-lock allows more concurrency, but that would seem to be a
complete non-issue for exit_mmap(), and switching locking seems to
just complicate things.

  But that's a separate issue that I just happened to notice while
looking at this ]

I may be missing something else again.

Also, I do really hate the smap code. People have optimized it because
it's so piggy, but that code is still just silly. The "rollup" case in
particular knows how bad it is, and does that whole "unlock and relock
under contention" because it knows it's a horrible latency pig.

Oh well. But it really feels like we *could* do this all without mm_users. No?

                  Linus
