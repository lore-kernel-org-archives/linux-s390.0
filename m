Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD182820D5;
	Thu, 24 Apr 2025 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745517026; cv=none; b=spF7meWgrp+d/46ShlPxocaRR10MRfXYlgIn/6YA96e08WEtO4uIIahnRHxCUDDZSiWr2RJl1lnBjsJknG10sZd2knQyzF4toNcMzFajaAwY2ZuOSYnZdHh9keGdg2wwmOBw7LmLKem31Z3rghg/7I9RLrcPKLJQgLJLsTFSrqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745517026; c=relaxed/simple;
	bh=SNvH5nTYoHl5yKRvB6bgkzM8+nuVGJHUzDSVMgdb/Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSTZuTi3xAk4P2hQWj7y405ZV/Hqha2PvcOHZjB8UfVFNYVPXxexeMiZrF6zDkdn8H715DfWhHl8v9wtnvChJRTO/KyJ9nWIRu6D7ju05vYnE/pMyv2uMfP4y+hDTFzsJc+YO5FZLouJIE88K96GwXae0RNvjrPyQIk4/DKaEzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjoLASjF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjoLASjF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45667C4CEE3;
	Thu, 24 Apr 2025 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745517025;
	bh=SNvH5nTYoHl5yKRvB6bgkzM8+nuVGJHUzDSVMgdb/Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjoLASjFWlNNlV+s3AGc8xyiXZHKOPOSDUt2cwrbCBiKyaJYHwk1oUcraWtAcOZPx
	 Wn7k1DIulwZp+GTBSjgUFTwQ+7DnhEf95DfI3G9UBENaB38aUj8X44Xkc5O2dywcWf
	 GrYWeNBgV5ebDykpD3dUkVwAKLNbDni/9EL++suK53oN/pmZHjWpYai2Av7kzrAz5p
	 7Sac7r69VkvMnY61sHdWDSnStY2/HMrb2BCPjuNhLeXwP4Yje3s54VKr5KjztwmWY1
	 6ps2a4rsFzvP6KHyyqWjQF8RSH9OyH5poOE3nCrPvQlQ03wvOJqqIEfrd33aEvFiM0
	 KS/nZA2Qfx6nQ==
Date: Thu, 24 Apr 2025 14:50:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com
Subject: Re: [PATCH] perf/tests: Fix tests 84 and 86 Add --metric-only on s390
Message-ID: <aAp53m7fwmkOoSrz@x1>
References: <20250424133310.37452-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424133310.37452-1-tmricht@linux.ibm.com>

On Thu, Apr 24, 2025 at 03:33:10PM +0200, Thomas Richter wrote:
> Fixes: 45a86d017adf ("perf test: Add --metric-only to perf stat output tests")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next.

But please try to look at how patches are applied, specifically in how
commit log messages are rewritten, what is modified in the commit log
messages.

Specifically: When we do a 'git log --oneline' what we see should help
we find whatever we're trying to find. Twitter (not-X) style.

While I agree with Namhyung that whatever reduces the work a maintainer
should (have to) care about, and doing this is just some muscle memory
from sending patches to Ingo, I do think that trying to be consistent on
how we describe the problem, how the solution being proposed fixes the
problem, and then, when that is read, and the code is read, all matches,
bingo, patch accepted, tests pass, lets focus on the next issue.

This is not something aimed at you, but its something that takes time
when I'm processing patches, maybe I should just ignore this if the code
is good enough (I do this more than I want), but I think getting this
out of my mind is important.

Lowering the bar invites more people to contribute, but then it bites us
later.

- Arnaldo
