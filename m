Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504D9199BC;
	Thu, 10 Jul 2025 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752168458; cv=none; b=F9as3LXMKT4SOBBEgNgjiDFKD2RVmcnmU/16i0rhMUDLCsm7B1M28dXwfCVu/xCJw97D7DFLxc9/mVs5jIVJHATWvkmqy6rF0QduOYe9xIAWDruZexFbLITU8J+38tMgOIUq0+QFdr2cNg6Sofnmwvnj+q24fEdIj2U+J4n1M+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752168458; c=relaxed/simple;
	bh=Ki0dO+ZHrOXQSdg82yLFgWjl+hbvkKi5tN2LS0Hq8Kg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UNmZjypx6q+tw97Go9N92KN1KLBVGXNdw0vPP8bTAZqXA/XJGYIyB5InQ7OLX9V/1CBWhJJr6k6oUkWI5p3QDE5u4wJ+HHhxhfYZAVWsDDW9BUzYnv5/1Ur84r2RGZFaM9y4A5LK2TMru/pG8XhAKCCIPXXy4757LyN/bYDDhoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2+bfG1V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2+bfG1V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E98C4CEE3;
	Thu, 10 Jul 2025 17:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752168455;
	bh=Ki0dO+ZHrOXQSdg82yLFgWjl+hbvkKi5tN2LS0Hq8Kg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=n2+bfG1VM+GeESruDToH2rAPXmg7nFFxVy9aJ0ozCYIz3lpCzDE378ZAb/e2KIQES
	 u+r+nVu7J+KW9NNBOP35dVowYn1xS0fmvKjTc3I/1pNoJY80ha9mQDLtJowksRC5hX
	 Ej+h5hj8YDvXoAPIpul3KwKiFaITY80hHqgtpJN7s3kq62l7seFTbyZp++rJoZOyeY
	 lOCcXzp6aOn0glElgxtVW6xYSPqZqxf4EssP6TpU3o5b30DceqotT2Rdsircoq1d04
	 zCRfq5FJhRLS7LhOyUnlG347YWKPeICiWO6/Mr8nAVvqUVLTxXDwa0MscfucKU/EEd
	 7fREVy7eBB1Cg==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, acme@kernel.org, 
 Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
 hca@linux.ibm.com, japo@linux.ibm.com, 
 Ingo Franzki <ifranzki@linux.ibm.com>
In-Reply-To: <20250709072452.1595257-1-tmricht@linux.ibm.com>
References: <20250709072452.1595257-1-tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf list: Remove trailing A in PAI crypto event 4210
Message-Id: <175216845541.481342.17562031483386057762.b4-ty@kernel.org>
Date: Thu, 10 Jul 2025 10:27:35 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 09 Jul 2025 09:24:52 +0200, Thomas Richter wrote:
> According to the z16 and z17 Principle of Operation documents
> SA22-7832-13 and SA22-7832-14 the event 4210 is named
>    PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_256
> without a trailing 'A'. Adjust the json definition files
> for this event and remove the trailing 'A' character.
>    PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_256A
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


