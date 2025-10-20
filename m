Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE9423EA82;
	Mon, 20 Oct 2025 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953932; cv=none; b=IKel5aHEGY8nT1uiYHJcTYyX6Y2XomXotcPsSrBwVirPUzVqbAjJ6qumN8Ex/0lSte1qzRi34Uc3fyWsYn0qx1VdlKZpAMUcfdmpRX1KohYlCpfcuCVqVfcVopvNg2xqYL3eIpg0dcHxARIWZGkrnLslVwtn/9g61RKRdZpa+/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953932; c=relaxed/simple;
	bh=kQocwQBz5VeDpe2/0JKD0qlGr4zZiryI+bhHYrnpvjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaEzNzo6MzspgmakOS0gzaF8TjR3Eh4GWS5tr22fKcG8+0xiirBF3LMkdJETxB0lo/ABR3KwpeMZd0oqo+vG+f6fHRHStHttoLWeyNn3KldAjrzWOsF3DLb9NfRN2oXjo4iJzN5C+7scGUwTzLi6w6YXZ+8gaNylq50p6RDv2K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kd2ZXVDB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kd2ZXVDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D306C4CEF9;
	Mon, 20 Oct 2025 09:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760953932;
	bh=kQocwQBz5VeDpe2/0JKD0qlGr4zZiryI+bhHYrnpvjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kd2ZXVDBsMu3q7/fXKrB1ZSPODUYby7i+WvlAE2YRRGdjy7S/5EHNiYXuu0UMCZwg
	 8BJ6us3QEIcT33MG3dCtUi+E7b+YTFkL1sCNoSCThbmn1ZKM1xGqkH52hwyPIDyiSb
	 XQcEtZOL7j2aYckzOkT9fSWIyAanz4+E8wNG17jeNKwrk+AXS00ELrUhygbHBbAB+L
	 jIdQ+ZnAzfy5fkf5mFd1QegF1NhSc/9M7D6vXngd9zDwB2Pzl4WZpnqHkh6N17Bnz4
	 gtK7QIgmA1HZoL9odk4GZvpweVXJEafNkpT/N60x5MNaBltmNYvMtcHsoWGcJjLaGU
	 onl/NhhK++z9g==
Date: Mon, 20 Oct 2025 10:52:07 +0100
From: Simon Horman <horms@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aswin Karuvally <aswin@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH net-next] s390/iucv: Convert sprintf/snprintf to scnprintf
Message-ID: <aPYGR7V2nc1tqHI1@horms.kernel.org>
References: <20251017094954.1402684-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017094954.1402684-1-wintera@linux.ibm.com>

On Fri, Oct 17, 2025 at 11:49:54AM +0200, Alexandra Winter wrote:
> From: Aswin Karuvally <aswin@linux.ibm.com>
> 
> Convert sprintf/snprintf calls to scnprintf to better align with the
> kernel development community practices [1].
> 
> Link: https://lwn.net/Articles/69419 [1]
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Aswin Karuvally <aswin@linux.ibm.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

