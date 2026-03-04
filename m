Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24F43A453E;
	Wed,  4 Mar 2026 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634206; cv=none; b=iWHvHB1DGMJnCUBgyxWKqRh1PYUNd6An4+TwYwoJqVfvUW7ddwwjm64Y/Ad0jy4Vepn9Mz+02Uc3LNjAoB1Kx8GdzkyHb+XcUD7pwdOgOWpuqSiYtwkwHz+ts4O9kpnEf34lhIayFdyH4PMlkXxwpvfLWRFLtc+WfThoJn6LFGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634206; c=relaxed/simple;
	bh=uG3fuB1GwbFZ+UKsfHoEbxhjz5+rI3V5/vSouyWMVRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+YnLjTCbZMYen0tCmscaD3v15H3iO8BUnFbKkSjblrOllUy5x7qztYV8qK5tVaE0XvBKMqEgImaraWfeHz5Jtt8jTRCY909s4glxdzPUIf3tNW85HcTFuyGj0x7ZrkVo7OX2Fk3xmQoO9kd3pq24q9Plb2E1kGwJF6Yy6+zc4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyC5r2c7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyC5r2c7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BCAC19423;
	Wed,  4 Mar 2026 14:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772634206;
	bh=uG3fuB1GwbFZ+UKsfHoEbxhjz5+rI3V5/vSouyWMVRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UyC5r2c7eGnP5hVGA6hWVnCyP7LWD8h8YEzGs1p22lnC6DowGMrTiq+h6AT0reXIc
	 GCyLXKUiasXew0Ysvz0RTDuJk+z1G0eb9EQsnP2Plb/rfPOGb8iv++AAjgr8RUaphX
	 bkI0WlthliB8DfQu2UTOASt4dcdj+54fVfsAyJOVCsxhYAeKU/45ikgKWWhrkn9ObE
	 YopVId7PeE8xCcML1931chj+EYaH9Zxh6HPgnNjYycInQG3Yuv0xXbGykoP1fyDUVQ
	 c7NO4QaU6lLr0ut7k7knEfVy/mThoVUc/ycpvAKjUbaVmeQ4M0u1NeI+4Eg2Kb0Zvu
	 Dw4lZZ9BRg/qw==
Date: Wed, 4 Mar 2026 15:23:23 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/9] s390/vtime: Fix virtual timer forwarding
Message-ID: <aahAWwMByLKmEvTu@localhost.localdomain>
References: <20260218142012.863464-1-hca@linux.ibm.com>
 <20260218142012.863464-3-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260218142012.863464-3-hca@linux.ibm.com>

Le Wed, Feb 18, 2026 at 03:20:05PM +0100, Heiko Carstens a écrit :
> Since delayed accounting of system time [1] the virtual timer is
> forwarded by do_account_vtime() but also vtime_account_kernel(),
> vtime_account_softirq(), and vtime_account_hardirq(). This leads
> to double accounting of system, guest, softirq, and hardirq time.
> 
> Remove accounting from the vtime_account*() family to restore old behavior.
> 
> There is only one user of the vtimer interface, which might explain
> why nobody noticed this so far.
> 
> Fixes: b7394a5f4ce9 ("sched/cputime, s390: Implement delayed accounting of system time") [1]
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
