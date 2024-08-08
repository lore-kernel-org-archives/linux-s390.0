Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83882156C5E;
	Thu,  8 Aug 2024 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142667; cv=none; b=nQSs/BcAdgHKfwaK6C2HoZuG3+lvj3ZWCnAs7rygv76vYOrIDfbf9wkWfIQJIL2rsl4ZjaKb9jfYO2k6bpyQJQqkDAbPxFfwZpF3hUCTmMOLA1+iDgZZZA39/tcGiAOGKxX/XkqPlZvIrBkTlQTelWN2ZS5pMNo9m5NihVq4WKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142667; c=relaxed/simple;
	bh=yBncEqq2sXHui7DWw9Ittf1PXvuGN/iNU/JonnHljMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Joy5v4T6P6jUkvxCG/7zjtK7MHdSHvLBXVWTnu7aro4hFQ7MThrienLJ8UhKhrWyb/TafLycJXRvbz9WWmx9stFBw+WfiP1V4y/9Zav0oBskXQun0sG32PXHbUpvzEtpRBSxfaRpagrZfuMUckbQxBOOl67Z2nvga+1ls4tBT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noIGMSXT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noIGMSXT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B939C32782;
	Thu,  8 Aug 2024 18:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723142667;
	bh=yBncEqq2sXHui7DWw9Ittf1PXvuGN/iNU/JonnHljMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=noIGMSXT7Cvt5hAE7vaVJP0P1JaaPtBDQ+rGBNcM16SDg3OK3291zy0SG8KV8mw+t
	 Acb3eIoVrJ1pshi2YtoOMIquTa6bARoB/vKi+1LNa+8OdcpY2I+zKFLt9VG21U0mqa
	 tAYi0OQcKlcKbQyAQ9GoqPsov+PsJ4e0fKGCQ2Z4KItPyAtu6O8gj049NzMJFmwOhW
	 EEYbZIOpaMmRy+9x7oz0fNdjiNtR9KL7LWoet3JWYXV4sjTlHSAE/tCKqqTQfoiND2
	 TLXIzC4sfB8w1bW11sWeURtvmDu+daDOVDcr5fHsarjZ4pMF92CdZ0FqRneLIhfHO2
	 eblAmXk0gRORA==
Date: Thu, 8 Aug 2024 11:44:24 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@arm.com>,
	James Clark <james.clark@linaro.org>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-s390@vger.kernel.org
Subject: Re: [PATCHSET 00/10] perf tools: Sync tools and kernel headers for
 v6.11
Message-ID: <ZrUSCFLWDg9iJ_23@google.com>
References: <20240806225013.126130-1-namhyung@kernel.org>
 <ZrO5HR9x2xyPKttx@google.com>
 <F3C6DE61-8E10-4814-A6C0-C7569B3FD613@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F3C6DE61-8E10-4814-A6C0-C7569B3FD613@linux.vnet.ibm.com>

Hello,

On Thu, Aug 08, 2024 at 12:14:12PM +0530, Athira Rajeev wrote:
> 
> 
> > On 7 Aug 2024, at 11:42 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> > 
> > Hello folks,
> > 
> > On Tue, Aug 06, 2024 at 03:50:03PM -0700, Namhyung Kim wrote:
> >> Hello,
> >> 
> >> This is the usual sync up in header files we keep in tools directory.
> >> I put a file to give the reason of this work and not to repeat it in
> >> every commit message.  The changes will be carried in the perf-tools
> >> tree.
> > 
> > Could you please double check what's in the tmp.perf-tools branch at the
> > perf-tools tree so I don't break build and perf trace for arm64, powerpc
> > and s390?  It has this patchset + arm64 unistd header revert (according
> > to the discussion on patch 6/10) on top of v6.11-rc2.
> > 
> > Thanks,
> > Namhyung
> Hi Namhyung,
> 
> Can you please point to the tree. I checked in https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git as well as https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git , but didn’t find the changes. May be I am missing something. I am trying to check the build in powerpc.

Oh, sorry about that.  It's in:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git

(no -next at the end)

Thanks,
Namhyung

