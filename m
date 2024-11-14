Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D292B262A3;
	Thu, 14 Nov 2024 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605137; cv=none; b=VD81PQkaGhcSzu3zUgNfw5jdHhRs0KCWUZJVhCuaZUvrPr/JOdYJSynXCoOlQHOqN6kJL3yTIYayJL4QzkWpi64r5PSUB8u3wz1bNPbc1oiNbsA6Q64aGVu1nJeBO8GMNqPbE0rY/cdzaTLSaMdFNCNSGj+ZXQpgN+tTEQcg/dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605137; c=relaxed/simple;
	bh=tUCiJsMt1bFcsP1fASFoxInuAmtpzrNbhqqYPweoS/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=As/9nb3JyVXn2lkBwbcw/R1Y0j88u0gQtwQEM8fA62FdT2Zn50J/3Wbh2phuVmIl+P+aKkBZ5nY9UDuB5SeX/4q76gOrb3FZb7C4EuRVQDl3KaRc+hw9IwZcsCIaz2XNRDZZZpbFinOQg96GUxURZgeJLvDAwPtMCaPnj7O002U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkZGOoWi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkZGOoWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E237AC4CECD;
	Thu, 14 Nov 2024 17:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731605137;
	bh=tUCiJsMt1bFcsP1fASFoxInuAmtpzrNbhqqYPweoS/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkZGOoWiPqIXOoAjQuzGTGgZheqesXNLwkIWOGvcJH6VhfMo1vi/pTO4Qljj5ZYft
	 Zt0yJk1m37u2vnGrUy5qHJ+EFFURzq+Fgl5Kmor2gUYBxScz4QbNXIKrvoZ1YlCNty
	 Cvhgc2HKAaWVFVW927jLj9+KZE8dkS3B6pEBzAmAt4imeIiymRiv+syElvRByeewnh
	 RnAi0BRz4nuSweizXO6VoTq2lR1y0raVYnHCYBGIxk8zm2JMEKUExx/IF2Knj9oxPp
	 mW1pJV+PhaD4I98AMDKXyKbOGu9ltFunzSq5MVcwcQ0BJDfQ3NbksxzBw3HGTlz6Ay
	 ZLc8RC5iyebBA==
Date: Thu, 14 Nov 2024 10:25:35 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 1/2] scripts/min-tool-version.sh: Raise minimum clang
 version to 19.1.0 for s390
Message-ID: <20241114172535.GB1956005@thelio-3990X>
References: <20241113154013.961113-1-hca@linux.ibm.com>
 <20241113154013.961113-2-hca@linux.ibm.com>
 <20241113182109.GA3713382@thelio-3990X>
 <20241114170524.9691-B-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114170524.9691-B-hca@linux.ibm.com>

On Thu, Nov 14, 2024 at 06:05:24PM +0100, Heiko Carstens wrote:
> On Wed, Nov 13, 2024 at 11:21:09AM -0700, Nathan Chancellor wrote:
> > On Wed, Nov 13, 2024 at 04:40:12PM +0100, Heiko Carstens wrote:
> > > Raise minimum clang version to 19.1.0 for s390 so that various inline
> > > assembly format flags can be used. The missing format flags were
> > > implemented with llvm-project commit 9c75a981554d ("[SystemZ] Implement A,
> > > O and R inline assembly format flags (#80685)").
> > > 
> > > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > 
> > Oof, this is quite new but now that kernel.org has LLVM binaries
> > available, I do not think this is an unreasonable ask, especially if it
> > makes your life easier with code maintenance.
> 
> Thanks for your feedback! I read this as "is nearly unreasonable" :)

Yeah, that is probably a fair way to put it :)

> Even though you acked this, I guess I will drop this for now and
> maybe address this a few clang versions later.

Yes, I think waiting until that LLVM change has had some time to
actually make it into the hands of users would be good if it is not too
much of a burden. However, if you start writing new kernel code that depends on
these format flags, it may be reasonable to revisit this series at that
point for ease of maintenance on your end.

Cheers,
Nathan
