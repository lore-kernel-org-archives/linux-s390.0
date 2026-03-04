Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE153A874C;
	Wed,  4 Mar 2026 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772635785; cv=none; b=TvJYtm7SGygh13xKXs1AChxHu0VhOM2FP9qlPNcuYyZJ8rH8GufJbA0G3ooeyofh0Z7BLw+OeS+EElGsU3Qk428HeBXn6I3zNWGFJGv28mIokT804dEq6rG4JAsseChMho22SnFOOqri/JfO+kb7v4WNlEgpdDU7iaREFhZRaCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772635785; c=relaxed/simple;
	bh=HLxaqdF0WBZTKqWlVkCPHzZoSpFDeDKiWnbjxx9FLgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ud+eoizCTsBefJIR+Rntt7XdlOY7Rj3XgD5PV8+957l+5X2OgRMTlydCKstnSzMr7QUmyihLmjFeYT872FTvIAMAxdamqGVXIbDe0B5Nr7WqjM/Qq/lrl2bUC6MnDFkoZui9+tg5NhI+CNqAnpt0EogM32LSEtgIxoxXIHLam0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZ7UXzUP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZ7UXzUP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92978C4CEF7;
	Wed,  4 Mar 2026 14:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772635784;
	bh=HLxaqdF0WBZTKqWlVkCPHzZoSpFDeDKiWnbjxx9FLgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZ7UXzUPhlXeqBwbPlYjJrSVrmnKJk2Ee4847TlMRTSHckk6ZhtXgyrqBL5u2ImZB
	 zVJ4HWOCVCu+WxZx1xx24bq2l7blExS2yzDn75OA6Phkb9T7/uHwShh5O4f4XBR1wH
	 AMd1V7xr9RIKA68ksm8hD1Lk/MG+7RVtuDxsBiJHjHF2HsifByihUe6MxKU0U9y/5C
	 CJcouh2dmWofFSTUZaey9fIGSp/dQUxmedb3aDDfNhjOyeJqkB0UaxDlpCkNAn3WsT
	 gYEY9zlWA6UxIbA02J65G9lxCU1iqe/6hZJU1zbTNgXzOYdtq0yVBYStJkN/xr/HPC
	 jyBTbCGSlw3ow==
Date: Wed, 4 Mar 2026 15:49:42 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 7/9] s390/vtime: Use __this_cpu_read() / get rid of
 READ_ONCE()
Message-ID: <aahGhuJcDDJqSX_P@localhost.localdomain>
References: <20260218142012.863464-1-hca@linux.ibm.com>
 <20260218142012.863464-8-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260218142012.863464-8-hca@linux.ibm.com>

Le Wed, Feb 18, 2026 at 03:20:10PM +0100, Heiko Carstens a écrit :
> do_account_vtime() runs always with interrupts disabled, therefore use
> __this_cpu_read() instead of this_cpu_read() to get rid of a pointless
> preempt_disable() / preempt_enable() pair.
> 
> Also there are no concurrent writers to the cpu time accounting fields
> in lowcore. Therefore get rid of READ_ONCE() usages.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
