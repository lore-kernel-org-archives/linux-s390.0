Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4225F3A6EFB;
	Wed,  4 Mar 2026 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772635105; cv=none; b=fIM5v+2Ft7N7ep8kC3wRIJUofPajFPqNwfeQqAygsfyojvg9nuPqf8glJ7qK9ZhcV/3jiuwa9ZuJ8FMZIzL1AIrgM0XY/IZ6imThAgk13JINYCcbpUuc/dKbJ3cpzONbAZ5Djuk4tVe8BX6aIUGzYBWEcWwuu2VhiygATukr7WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772635105; c=relaxed/simple;
	bh=04tgK67VQfSCDdfIg+sxFG4n0hzJTQoX9bRddb/f0z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guLW8eRdtbPGysZOIRJcw6SVphwq0dhxo/EF7o/A8+Kk43Uvek44085DLMDGsJvzs3u9MmCKfjbWCHLZYJ79J83gdrNQ4fQvWICdANtIdzSEPbxJhurR3qujigSP0q1DT/eOzH/ybOHhFU9DJHCOptea+dOoV6PYa41zoIzPjIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvojiLcr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvojiLcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89212C2BC9E;
	Wed,  4 Mar 2026 14:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772635104;
	bh=04tgK67VQfSCDdfIg+sxFG4n0hzJTQoX9bRddb/f0z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvojiLcrJAirG2FA6Fk322XxFyqmIsJsJ8vmwI8DeNAkCplNHkAyWRRcjGqspW1j4
	 XZ90BYGRVobTNjsc/CnpSEiqV5PK0gzCCjST583Yo2iSEC0rijLVnpMP/KMsAyJ+s9
	 PO4qDPjVB7bBSdsBQCcWDDF3nhJeyPcUPjREwugXjIml5wJmkePnbIE+Dmia0pKt9g
	 Gy21TjXULenzNfCgQH0rho67Ub4yLf+3icNncOI6dBenKeZ+OwUxInp00fjBSBI9s2
	 tLLnjbXKcp8bNwc01JPsikwnW1IyZJjoOEJmbaIgxwVCxCS1t07Q8Pc61Q/+rfyycR
	 Ttxu7WRwq5NcQ==
Date: Wed, 4 Mar 2026 15:38:22 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/9] s390/idle: Add comment for non obvious code
Message-ID: <aahD3rvBCSl6xjbx@localhost.localdomain>
References: <20260218142012.863464-1-hca@linux.ibm.com>
 <20260218142012.863464-4-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260218142012.863464-4-hca@linux.ibm.com>

Le Wed, Feb 18, 2026 at 03:20:06PM +0100, Heiko Carstens a écrit :
> Add a comment to update_timer_idle() which describes why wall time (not
> steal time) is added to steal_timer. This is not obvious and was reported
> by Frederic Weisbecker.
> 
> Reported-by: Frederic Weisbecker <frederic@kernel.org>
> Closes: https://lore.kernel.org/all/aXEVM-04lj0lntMr@localhost.localdomain/
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
