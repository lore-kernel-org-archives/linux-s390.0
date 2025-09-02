Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A212332F742;
	Tue,  2 Sep 2025 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803251; cv=none; b=tlgsyT+caP8ae52prGOmXn5j42IQMzH7gpzj9OQmc84d0SPJHDx2k/8W9wqJzJsLlLHFLwp2sjNUZA0wB9R7vRSYVNq6XP8mAVb9Rjgbmhx56kUjUErdrx2Wt+luRsalLcCYD9S8iUfJ+J1Pp/kLPuI0iIYlRv9m1DaEBg683/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803251; c=relaxed/simple;
	bh=FziVTH2VN3ZRnluTxp/ZzsuOdZbzicHgKfj6YYYahgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiqmHA407vjMi4rcgf/7592iEkvQNaKuyyRcteSRoEkFGlKGLI258zMGQMeyBuTjEJTrLp1t7w4L0GlBUj23bbp2Uq6sb8s2r4zfMXMPPqw7LO4eU5AJ8I4qrwmQNJtEtr7JpFhM41em5vpup7a2rmsQtMCCwOs3NcGPDZUMQTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FejfoOm3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FejfoOm3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEF0C4CEED;
	Tue,  2 Sep 2025 08:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756803251;
	bh=FziVTH2VN3ZRnluTxp/ZzsuOdZbzicHgKfj6YYYahgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FejfoOm3QPz1/3Ys2BvcizB3bDuCQtFqMlQ9kqQJHUtSxkcLuSYJra7C7DUmDnokM
	 fWPSjxx0AoHkDNmcq/V12jrYBUsKqMdMSJ1M/kwSTEuN8hycbwYLWTXJa9KZGjiwup
	 KNPSDqYRzTAAvhXqfWs6F0+FiQFA3ycvtv8jFpBBViilERH7uCTXzg3FCn5F8OroBa
	 PwQCTcAzrwC04b3PILQoiL4CrbAU8+YpXRqcDfCmtKh0nkX71+yLFCzyYu3pHRF6Wt
	 6sMHqXrKUWgfZ+x8hqmYR8+euK+blA+cJZr2+d4/czUPqVb+fKbrHn7LGTAyJCthua
	 +t+OjLQaJgazQ==
Date: Tue, 2 Sep 2025 09:54:04 +0100
From: Simon Horman <horms@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Aswin Karuvally <aswin@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH net-next 1/2] s390/ism: Log module load/unload
Message-ID: <20250902085404.GS15473@horms.kernel.org>
References: <20250901145842.1718373-1-wintera@linux.ibm.com>
 <20250901145842.1718373-2-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901145842.1718373-2-wintera@linux.ibm.com>

On Mon, Sep 01, 2025 at 04:58:41PM +0200, Alexandra Winter wrote:
> Add log messages to visualize timeline of module loads and unloads.
> 
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>
