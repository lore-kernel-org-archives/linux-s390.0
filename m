Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3053E325701;
	Wed,  4 Mar 2026 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636960; cv=none; b=rEdvr7TiPWJvme30GXKlh0ws4E8gaRwKXkeVAK7YRTY8rlHCR+AmxhLZ7GxRCq9ARzuLPcmqNedP6QdpSze/Wd1Jie4atzfSj5GVaoTau1Ge+IY85jsw8W3RCh347YjxKH/alS1908HsFDvSCnv33wIh8pKod3LFUOENhO1b1sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636960; c=relaxed/simple;
	bh=Cd7cAtsPK2WqonzkKlX8P0Aqi4yrNk8trZtUchG1kic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyDo7a5REEBDmjStevFJ/CpSD2xZHfi+r2xMS/+r4t9SkkgKba3kPFSCrLsOCmRhSBG4rAbZ8E68MwqVeePzW3LljMTvyfaayv/YfGYCr3DZ2fXQQfWc3Rae1nME7/K+DKtfde/MmCV8HwzwfOgwhjVET/KF2x8WjMAd/uy+60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWi/Y32Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWi/Y32Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4A4C4CEF7;
	Wed,  4 Mar 2026 15:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772636959;
	bh=Cd7cAtsPK2WqonzkKlX8P0Aqi4yrNk8trZtUchG1kic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWi/Y32YUx5F1MgzIeNt0om/LgLOe8BVc2pHukuebkcWN4uj2XgxPEOXnVPdLZmDb
	 qeoTZcnmfpDciKeFJQ7tTJ/ipcV1TOHDUxUXkCaAMved0TRezWjzWZmX9l17PsnwbN
	 60FZrVBMexijqN4SXNchdV3yq6nyE2asiEI/zUim6E6ycACcKLGlpCEkZ7qG9u7dYa
	 QfgOZ4b5HTV3gG/R0ZyNAaZONXLGFM5K6oC2Sj3I66WKzej4wFiJdu30ZutkxtScuk
	 t5gZUcgw/UsXnQ3siFMNeA7o5my1Gn3rWJyKtHzT4CV/ebcp1lz21nQ3sQKvisvBUl
	 dpoYXxoP/5Zbg==
Date: Wed, 4 Mar 2026 16:09:17 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 9/9] s390/idle: Remove psw_idle() prototype
Message-ID: <aahLHZagR59cSpfu@localhost.localdomain>
References: <20260218142012.863464-1-hca@linux.ibm.com>
 <20260218142012.863464-10-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260218142012.863464-10-hca@linux.ibm.com>

Le Wed, Feb 18, 2026 at 03:20:12PM +0100, Heiko Carstens a écrit :
> psw_idle() does not exist anymore. Remove its prototype.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
