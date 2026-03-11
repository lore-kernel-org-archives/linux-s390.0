Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87FB3DCD9E;
	Wed, 11 Mar 2026 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773242058; cv=none; b=hSidmGn8oyx7/8GSqosXM1AjiN2tqO45uKwxIrdpXoAt4O4iKMabCn1oRiBF2oGrWKumhIFuL0I7MDT+eHUrEP1i3s/V2kIJ88pQMWc3j9m1fECMwJdYzHc06BgE78MsZxUhtyqUTsTw/IMWXg2wbNszrMdzxkECSHnVgZBe7r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773242058; c=relaxed/simple;
	bh=oEDe90P5Ir+YQbqU0wnRzG8pXaAGWduEfkOYkikvjhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvCWUGpBPTs03HEZiC00vvIGMry2LXfLevCVh6JBKUwJ4sauKzmpsdL9V8/g1KM3i9f0Sml4NE2oTe5SjD6lYGGb3U76wfHlEwM4E1WrFhXcFjcm4HxKEAgxVvDpAuIAZYGAuoCK8NX8C037/fpdeMwJjB0iCwk9XH4y18Nnvc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaSfZ0VV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaSfZ0VV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18358C2BC9E;
	Wed, 11 Mar 2026 15:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773242058;
	bh=oEDe90P5Ir+YQbqU0wnRzG8pXaAGWduEfkOYkikvjhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DaSfZ0VVDlzFdOUHLZ9l7YltCusO+jhw/KnR3TcCKLPvsX+9f0YQyE/ePAiBCo/YY
	 08pcku3aiHY0wac/byRlEs2O9F9CwIpXkdYW15ihjD4lO97mNIZsOjuBMFC4IacyYU
	 VEfcAm6QjylVLoSts2HDAjNkk6tIHJR9HEnin2EHP1T5Ih612ayU53hHMQBb1rTD9z
	 dukLDLdB9w57RXGePDnQVy3UQYoBJ2Ku1zMZMJ0fOU3MjvQQQNDPUcNFb0dbWgPXdB
	 ahWsG18EHRAtYiAHNt41iUpJHsvi5m/HtM6pn7U4ed8GwGgaGFG+ioCo8O//X1CoIN
	 p/XHc9Hy3CPRg==
Date: Wed, 11 Mar 2026 16:14:15 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] fixup! s390/time: Prepare to stop elapsing in
 dynticks-idle
Message-ID: <abGGx-t7pGISKorw@localhost.localdomain>
References: <20260225145146.1031705-1-hca@linux.ibm.com>
 <20260225145146.1031705-2-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225145146.1031705-2-hca@linux.ibm.com>

Le Wed, Feb 25, 2026 at 03:51:44PM +0100, Heiko Carstens a écrit :
> This should be merged with "s390/time: Prepare to stop elapsing in
> dynticks-idle".
> 
> It makes sure that idle->clock_idle_enter is always set when loading the
> idle psw. Otherwise the idle_time calculation in account_idle_time_irq()
> would be incorrect.
> 
> Also "revert" some not needed code movements and whitespace changes to keep
> the diff minimal.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Thank you, I'm folding this to the patch.

-- 
Frederic Weisbecker
SUSE Labs
