Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE1547279D;
	Thu, 30 Apr 2026 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566864; cv=none; b=RRlaN3Dzytlf+O8yQeihwSF0+EhWFBBJuaku32tkrGW0ZJTqgXmmnCYtWGCWqs5x87109RCmAkqgDS+DcwCpMzrOIXDdlqU1AtJcUiO6+vY6GaGg4qUIEOaAgsD+NuX2m3UNbluuW9yFAUtaQAumJmPpWdqsHvgr/C1kXVooVng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566864; c=relaxed/simple;
	bh=VeeQit/WflYUE/oUXMVUBbywDewNNl1r0QHqPo9WK2M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LO2QVMNu8gZFqeoKtZT+LpzYsbWQ2jYP6p/ArF5NBWrq0gz5kX0ZvD7pw36uvqC8tsbrRCxTpLCkUV6Ma4LaKXMUwdLoWa+TlT6ROvpKwImxMlbDCt5TTQlKWhHQB8XbS4Jig6tOKCEKkkj4Qp1LSyYeyoQL/pd5B+KQ5baCDcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vH95IIdH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vH95IIdH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94A7C2BCB3;
	Thu, 30 Apr 2026 16:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777566864;
	bh=VeeQit/WflYUE/oUXMVUBbywDewNNl1r0QHqPo9WK2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vH95IIdH1a1hS7FTFrWes5ZDLADqVcRGqzS1IFnydyeFkwzEcZarrCiRD8xYQXusg
	 eMBHA7BTXap7elW+bD+pNwlYp8GIJzhHm1LFS+dkv7vBns40c6OI+8u1kujR36WQYs
	 kQ0Fl1vaSNds5gK5BSBR2gZh4YS2BBpeZCVd3KE0=
Date: Thu, 30 Apr 2026 09:34:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>, hca@linux.ibm.com,
 linux-s390@vger.kernel.org, david@kernel.org, brauner@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
 timmurray@google.com
Subject: Re: [PATCH v2] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-Id: <20260430093423.3118ff0f295a9719cdadd91a@linux-foundation.org>
In-Reply-To: <afN2GBAjBSGlTgvA@tiehlicka>
References: <20260429211359.3829683-1-minchan@kernel.org>
	<20260430074305.9d3389ed71af040acfe222de@linux-foundation.org>
	<afN2GBAjBSGlTgvA@tiehlicka>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Apr 2026 17:32:40 +0200 Michal Hocko <mhocko@suse.com> wrote:

> On Thu 30-04-26 07:43:05, Andrew Morton wrote:
> > On Wed, 29 Apr 2026 14:13:59 -0700 Minchan Kim <minchan@kernel.org> wrote:
> > 
> > > Currently, process_mrelease() requires userspace to send a SIGKILL signal
> > > prior to invocation. This separation introduces a scheduling race window
> > > where the victim task may receive the signal and enter the exit path
> > > before the reaper can invoke process_mrelease().
> > 
> > Does process_mrelease() have a manpage?  My googling was a fail.
> 
> It does. Very well hidden in 884a7e5964e06


Well, that didn't appear to make it into the manpages project and it
doesn't describe the expected usage: need to kill the process first. 
But I guess all the needed info is in
tools/testing/selftests/mm/mrelease_test.c.

https://lwn.net/Articles/864184/ is useful.
