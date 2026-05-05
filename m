Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC920346E40;
	Tue,  5 May 2026 05:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957501; cv=none; b=SGCVqtiLw0Q1B9AwsElRcGCPVpL8kw31rSxvMm6xXqz20Zg6YeTGWE3kXqAY3UTih1SRCyhK+khZmCnUmPjuVx+/36zJvCJTh1z8YXBkW/TaxID74UJaU6v72rj003+6V/YyQ9a6WZOGhZm8l+uedse2DvYhl9JtJIFzTHXdSM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957501; c=relaxed/simple;
	bh=ulYwfhIrZiiyOA+ej0SzTrh2d/+ULM4vkEf6B8JaKfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trKJCylEwulMHTxsE0Kqasj7K0gDR6943ey3mav8dkBdg/lHhIWYlskrOR/yVafjRpRmWVofinLmb39mLc3Mi1EEYnn3/vxJCbUS6P/LJTt3hsjJx0D99RA8/vt+0mUVaIXkTimaPY71bOorC3/T1qUHRUMH33r6mziGlOgKbPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQdIe8ip; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQdIe8ip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED059C2BCB4;
	Tue,  5 May 2026 05:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777957501;
	bh=ulYwfhIrZiiyOA+ej0SzTrh2d/+ULM4vkEf6B8JaKfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YQdIe8ipp3zoPQt/M1IT100RhJkC1LW7HKyjFJV5+jOWmbpwh82QuzbAQDo5jHwcH
	 zXZ1pTxLQu3i0metigYKkT9eK/TSWmxLHxaSnrXUlvjZVlh5yHVJAHUfUHsYJArZjg
	 qnzp/NMRdY+bXEj0RqUZJ1/sGsTnM3Wxbu0y/KABvw/LSoGO2CC26cYIjJssFtu0eZ
	 gJMgVE/nHI9ss534NzOBzovG17IXtAPTv9e9xXKHvg6kuAFYAZWYmuVQsDFPz+PFo7
	 h1b+OOmlAr9lI5p8WhktdQhvYSz+abjWJ8Aj896wtbG2xwjbvpoJKzTUfzeo6f+8Ep
	 3I4JbmUkM80Yg==
Date: Mon, 4 May 2026 22:04:59 -0700
From: Minchan Kim <minchan@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Christian Brauner <brauner@kernel.org>, akpm@linux-foundation.org,
	hca@linux.ibm.com, linux-s390@vger.kernel.org, david@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v2] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <afl6e__ljPCkVX6j@google.com>
References: <20260429211359.3829683-1-minchan@kernel.org>
 <afMnKrYT0xG_a-b3@tiehlicka>
 <afUYfpwWsUQoB9hz@google.com>
 <afhQB0CWEcflXpOi@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afhQB0CWEcflXpOi@tiehlicka>

On Mon, May 04, 2026 at 09:51:35AM +0200, Michal Hocko wrote:
> On Fri 01-05-26 14:17:50, Minchan Kim wrote:
> > On Thu, Apr 30, 2026 at 11:55:54AM +0200, Michal Hocko wrote:
> > > On Wed 29-04-26 14:13:59, Minchan Kim wrote:
> > > > This policy differs from the global OOM killer, which kills all processes
> > > > sharing the same mm to guarantee memory reclamation at all costs (preventing
> > > > system hangs).
> > > 
> > > Incorrect, we do the same for memcg OOM killer as well. This is not
> > > about preventing system hands. But rather to 
> > > 
> > > > However, process_mrelease() is invoked by userspace policy.
> > > > If it fails due to sharing, userspace can simply adapt and select another
> > > > victim process (such as another background app in Android case) to release
> > > > memory. We do not need to force success or affect processes that were not
> > > > targeted.
> > > 
> > > This is a wrong justification for the proposed semantic. You seem to be
> > > assuming this is just fine rather than this would be problematic for
> > > reasons a), b) and c). If there are no strong reasons _against_
> > > following the global policy then we should stick with it. There are very
> > > good reasons why we are doing that on the global level.
> > > 
> > > If for no other reasons then the proposed semantic severly criples the
> > > shared MM case. You are left with a racy kill and call process_mrelease
> > > approach. You certainly do not want to allow a simple way for tasks to
> > > evade your LMK, do you? So just choose something else is a very bad
> > > approach.
> > > 
> > > So unless you are aware of a specific reason(s) where collective kill is a
> > > clearly an incorrect behavior then I believe the proper way is to kill
> > > all processes sharing the mm (unless you are crossing any security
> > > boundary when doing that).
> > 
> > I agree that in the case of a global or memcg OOM, the kernel deals with an
> > emergency, system-wide crisis where killing all sibling processes sharing
> > the same mm is an absolute necessity for system survival, bypassing
> > user-space privilege screening.
> 
> You are misinterpreting or missing my point. I am not suggesting to
> cross privilege boundaries. The syscall should fail if the mm is shared
> with tasks the caller cannot kill (same as it does now).
> 
> > However, process_mrelease() is an explicit user-space initiated system call,
> > and I am still hesitant to place that same raw, destructive policy blindly
> > at the UAPI syscall level even though I don't know of any known security
> > issues right now.
> 
> This is very wrong argument to introduce a potentially crippled syscall
> semantic.
>  
> > If we really want to go that way for the collective kill, at least, we should
> > evaluate signal authorization (kill permission) against *every single*
> > sibling process beforehand instead of only the target task of
> > process_mrelease. Do you agree?
> 
> This is what I've proposed already.

Sounds good.

One thing to note is that this approach is still not perfect, as some sibling
processes sharing the mm might not be killed due to different UID or SELinux
policies while others are. In such cases, the actual memory reaping via
process_mrelease() will still fail anyway.

If we are okay with this limitation - meaning it acts as a best-effort
approach where we might end up killing some processes without successfully
releasing the memory — then I can proceed with this design.

> 
> > Also, I wonder what the signal/process maintainer thinks about this approach.
> > Christian Brauner <brauner@kernel.org>?
> 
> Yes, this makes sense. There might be a very good reason why we might
> not want to introduce a way to kill cross thread groups when they share
> mm from userspace. I do not see any as long as you keep the proper
> permissions for all affected tasks. Maybe we cannot do that sanely now.
> But these reasons have to be properly documented. You whole argument
> that this is different from in-kernel oom killing is just not valid.

Okay, let's wait for any valid reasons or concerns they might raise.

Thanks.
