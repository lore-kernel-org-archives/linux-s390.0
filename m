Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441338;
	b=Q8PDZGF0zarp4zZ6DFoRprhoXklGqquDsNrYASl8Y6EPW12oTpt2wHahF6ckZrjkSyum
	 OeJSnAn+VRJe6BekL2t53sRJMfUmopedoYWml4H5WKSIp9MfRNfwlzGke3nFA9to0VEI2
	 Tsgjiq3rwl9CppIK8Px81BLFnM+zWvIJEm/b3pgh5+7rY+SC6fbJ1tUxSgB06MrLKgxzU
	 4B/YvwAR7dve26pwqxq0q9ElhPKbygXui+qlH+iaY//IL+EAKyymwU3DQ1CL1hIzF03vt
	 li2VMSWGYy5ZOb5WnDMDs1aGi2jxhXZwk2OhdBPI3wX/WGXlRZPluWOQiH1SgelQtBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441338;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=83/Zj4rSwKrIFC007gjSByz1iWMyXBkv4E+KUOKksZQ=;
	b=25H+cOf//WaHUGT/09GrJEKn6wazEXY3S/rr6xIGWWwH2TCdAnYk0H526OZRyPgR/Fml
	 bYMiX92yX4wo3tpAp+PvdpKWIOWwLehrHZV+Jk/1JOqwaehlf4a6BSIC3m+z0rGjqkCsQ
	 ZE+yLsnuEJ85gB8LYdPK6OIGSu4O4ssm6UIqJhdsbVk0mBIvGPYtD6eGmGF6o2O/Wl9Qj
	 598pjtsBjdwmii1fs524qaClqWR4MIlpjSeVIKqYCStR5uL2ZUc9BjfoPNQkQmbkykujc
	 z/A4pApfDUQYJh9aWk2OBURsR0ut1M+IxAEOA8h/oq0711qc4ot+gd6GrH3dis3UmTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnuSQpfP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8FB75606A6B5;
	Mon, 23 Nov 2026 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnuSQpfP
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 36CFB1F000D1;
	Mon, 23 Nov 2026 13:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795441337;
	bh=83/Zj4rSwKrIFC007gjSByz1iWMyXBkv4E+KUOKksZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gnuSQpfPyD2Zq6kgZIh18+mfM3Gs60TqAdD4NsnVgAcoPuvJVVs1wECECxIouJRJY
	 JOp1T9oTUvzpMUSR7uvWnyFhIGjvEugvRyx61LD25T6XlnkrCLDyAYtzQTt1X8k8PL
	 K80wixAxhGU0RgLCzwO+6ojOrMdRoztADpzvCLeAS/oM9EJu03ko8FbXTs2XqphV+k
	 v/D9dWW5MjlW6V4AIyMHWvtyvqxtRSz4lOhKD7Wu5f5HcLqIT0vtaGU9nljoD89NIv
	 SLL6I6pXZUeJM7lgPTbl5Zx0t3aIpQSHxdXwtdyiw8rcPUz1AZzMy1bHuOkDHu1rX1
	 y7FV225aISvfQ==
Date: Mon, 23 Nov 2026 15:42:13 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Anastasia Eskova <anastasia.eskova@ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/2] s390/cert_store: Allocate keyring with link
 restriction
Message-ID: <awRCtUt7_hHclKpe@kernel.org>
References: <20261123102324.483917-1-hca@linux.ibm.com>
 <20261123102324.483917-2-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123102324.483917-2-hca@linux.ibm.com>

On Mon, Nov 23, 2026 at 11:23:23AM +0100, Heiko Carstens wrote:
> From: Anastasia Eskova <anastasia.eskova@ibm.com>
> 
> The keyring is linked into the user session keyring on allocation, but
> keyring_restrict() is only called after all certificates were added.
> Until then a possessor of the keyring can link arbitrary keys into it.
> If keyring_restrict() fails, the error is only logged and the keyring
> stays writable.
> 
> Allocate the keyring with a restriction which rejects all links, create
> the certificate keys with KEY_ALLOC_BYPASS_RESTRICTION and drop the late
> keyring_restrict() call.
> 
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Anastasia Eskova <anastasia.eskova@ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

I think it is best for overall good that earliest possible release
for my intersecting changes is v4.7. I think that it is good to
do that architectural change but since it is a problem solved
there's no need to rush it in.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
