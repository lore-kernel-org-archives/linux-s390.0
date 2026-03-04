Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECE93B9607;
	Wed,  4 Mar 2026 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633805; cv=none; b=mzeeCI2WAXT/n8pM6GEtakIXmcnGt5LXw4CL6Ab89II3KGOoSetwIg9Khre9ZoCQtwbwN0+dcKmNDc05et5NBwjLxIey2Wsort7y9jL4gfAbS4hWkrOTEsCgQis5lwR1ntQOBUTKf7D1Zt/bMhsAyDRj4ywfeoATuSp7jAwOKMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633805; c=relaxed/simple;
	bh=QgRllSl/vhdOKbED3p7Re4eZdGFyPMUkURgTM0169qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phjO+yLVbh0cqj1UqJSQZs8VdriiTY7hDo5OWFavsvCDSDWPrC7QS33Wj4GPpnPy1YWChSc85Y8qTs5tHhBvulSu5YqS/zzz2oC4kf8ktv2xK5wBPotr4sCjZesas/onwrCSnlpDTEZsctzjcSN3B1fr7VfaCZ6uE08dKNPsaqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVfxKShW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVfxKShW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96C7C4CEF7;
	Wed,  4 Mar 2026 14:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772633805;
	bh=QgRllSl/vhdOKbED3p7Re4eZdGFyPMUkURgTM0169qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZVfxKShWjLwhoIX1l9qEPogFHwRgsK3fpMTESkFVb3Wh4NeWVUT9U+eKGYqlxGMfp
	 8A72kjAeq37tnqN+QlK7R24p7GoNtNbrDwmJ1r/R5fssa4NwNts5wrQ0BULf4JZDA8
	 vM6zMibnLvitT9VsPUCY0kbMDxl1THGvl+WPRKLM6cNnBv27h5HrO3Iwbt7gy2A1AQ
	 p/9TGaGmrms7+Cl9o5R8vpXJ1MW+Q+zFRaZH4DVO73W/zBfn7Dc2Ajn4DaBj3wzMyZ
	 Qh54pwyvGno/9vD/W4wCpXiwzJr50McOV7IyKJYuKkKpqb0JaUazT0OqkioVdSLKsD
	 4BW60SVXdaCZg==
Date: Wed, 4 Mar 2026 15:16:42 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/9] s390/idle: Fix cpu idle exit cpu time accounting
Message-ID: <aag-ypLmdyQk0Zxl@localhost.localdomain>
References: <20260218142012.863464-1-hca@linux.ibm.com>
 <20260218142012.863464-2-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260218142012.863464-2-hca@linux.ibm.com>

Le Wed, Feb 18, 2026 at 03:20:04PM +0100, Heiko Carstens a écrit :
> With the conversion to generic entry [1] cpu idle exit cpu time accounting
> was converted from assembly to C. This introduced an reversed order of cpu
> time accounting.
> 
> On cpu idle exit the current accounting happens with the following call
> chain:
> 
> -> do_io_irq()/do_ext_irq()
>  -> irq_enter_rcu()
>   -> account_hardirq_enter()
>    -> vtime_account_irq()
>     -> vtime_account_kernel()
> 
> vtime_account_kernel() accounts the passed cpu time since last_update_timer
> as system time, and updates last_update_timer to the current cpu timer
> value.
> 
> However the subsequent call of
> 
>  -> account_idle_time_irq()
> 
> will incorrectly subtract passed cpu time from timer_idle_enter to the
> updated last_update_timer value from system_timer. Then last_update_timer
> is updated to a sys_enter_timer, which means that last_update_timer goes
> back in time.
> 
> Subsequently account_hardirq_exit() will account too much cpu time as
> hardirq time. The sum of all accounted cpu times is still correct, however
> some cpu time which was previously accounted as system time is now
> accounted as hardirq time, plus there is the oddity that last_update_timer
> goes back in time.
> 
> Restore previous behavior by extracting cpu time accounting code from
> account_idle_time_irq() into a new update_timer_idle() function and call it
> before irq_enter_rcu().
> 
> Fixes: 56e62a737028 ("s390: convert to generic entry") [1]
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
