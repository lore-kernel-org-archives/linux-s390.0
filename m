Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2C3344DB0;
	Wed,  4 Mar 2026 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636861; cv=none; b=g85UAmnEn5WLu+Rtyv+wHHVJeHHug1fcS6Kd8urpH4MBN3IxbQCnoR79gR6uja0cWrfbWYeOprsLph1NyfMrpON5XSLQ2T2DoZMhnQiN8RwKHyXd1AWNonyYhydrQApDNOVkGvfjUOiAvOsVujGdsA23ZXSyN/8o0bT0ZzNuwwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636861; c=relaxed/simple;
	bh=ztKTt2d8oyhp7VXVhzxskCg4q6wLBMD7QwJKGcJW+3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYdmbgfSjCPzwCRgC0nFmnbxUganes1/eeWhO+FSGb/ASMs6Hg7ho+RgYC6tJxjEmZnQS+LVT6W5n9Bz0wu62wo6E9vu8seQCDn0FjUtW71WbLfB+Lm0+stpDY0Ic//+iGjXQUyC0xEBmshMTgM81Q3rr7uDvgjkOzawfE8oMHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aACN1Gak; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aACN1Gak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC0CC4CEF7;
	Wed,  4 Mar 2026 15:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772636861;
	bh=ztKTt2d8oyhp7VXVhzxskCg4q6wLBMD7QwJKGcJW+3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aACN1GakVchRRFJA5sTAs6ySfgdS3D8h+s9LcV48OmIf302pml/+2gppp2chiAqwn
	 Xh4GqByVVfN22Lrg+KWtimQ63DHPtEVgq9L9EveStdftwsvZqDkseGQ5sSqUX/vYN0
	 MluMCB/k6C7W4WYlgOHoHgPKfK+MbQIbdQevP5YPiEF9xUzdNwOOXDej8X3zAwpQNM
	 wb8n3SWnBQgvPc2AlBGg8/31dZLHhAdsQvDJwhiFNPoe4NIXpgMz9Myree7jwPBZry
	 UeL7LvYlQ2iLlkv2Wjs+wbZLj8rlxVhUgpX+sF7t0N03b9yVzASmi1evxWbqJOneaB
	 JcpvONyyoP6Dw==
Date: Wed, 4 Mar 2026 16:07:38 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 5/9] s390/idle: Inline update_timer_idle()
Message-ID: <aahKuhrNX4gQRNFC@localhost.localdomain>
References: <20260218142012.863464-1-hca@linux.ibm.com>
 <20260218142012.863464-6-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260218142012.863464-6-hca@linux.ibm.com>

Le Wed, Feb 18, 2026 at 03:20:08PM +0100, Heiko Carstens a écrit :
> Inline update_timer_idle() again to avoid an extra function call. This
> way the generated code is close to old assembler version again.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
