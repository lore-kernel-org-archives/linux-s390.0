Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E673B189F43
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027866; cv=none; b=aotluannCW76Y4AglxwKyNJ6AwAXO1iOhKEDGdAitZWlTB9xv/0Hh7E3ZvCjRNRgiVJwmqvPLp3/4EbrslbZOehMMi9ZE0f9GwwmvARRKz+rUPMU39lY1S5YUx4cLxBtNS4LY2y3chZR4eXVcOfP9qxb6GwwQT1TVo7Byjja/bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027866; c=relaxed/simple;
	bh=kW3n9rT3KLxN1GW3QOqHqIDuvfsLkCXyxj+FFlPoYfI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J/tj5bh9AzlUfkwFemTdxUMvTpdMXXb6zYXr613kZ67zK92GWeRGy55YYfU7uuRRNvzV33ycp07jpIryrxiJeXCe0ozCYuECzMcssGyDZdy3o7C8y7Mgtt67v/YrXSkHIAaQ5FyD5ZVdEgK3zlAIy3T6zPkzzlZorPGMbe25fzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKgmTCNX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKgmTCNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A081F00A3A;
	Thu,  6 Aug 2026 14:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786027865;
	bh=kW3n9rT3KLxN1GW3QOqHqIDuvfsLkCXyxj+FFlPoYfI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gKgmTCNXBe6H+sEo6IxLx0I/PsBW8W0RW55aypn+BbyA36DpCSx6XI5kInsWGwu8j
	 OEh7a0WX7npz9eY/2j9cmJFMp+WkaeLdFyfLNSk70jZVrj/UHZ1smL60tT1m/aYQHb
	 qvjzSOvK8GS9xrPSuXpk33nqowxrELXpqzBY4aBk9BsVjsiOZWl02bCs3mW2Q84A0x
	 zFDBt+WlOCIdcgVv0rwr5czYDFCFH0uG3WlUG0Z/vOfmOJC1yHZ0JV9nl45wRTsCZS
	 1wLVTcmpBUWnq4mrfYro59H9J+Mq4j01N95LhHIdaz3kNgl8KJOLTA+pZnlg7Vc02D
	 O2TZhGpfdUtcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/2] drivers/s390/net: Enable CONTEXT_ANALYSIS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260805145032.1409325-3-hca@linux.ibm.com>
References: <20260805145032.1409325-1-hca@linux.ibm.com>
 <20260805145032.1409325-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 14:51:03 +0000
Message-Id: <20260806145104.E6A081F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> All drivers in drivers/s390/net pass clang's compile time context
> analysis. Therefore enable CONTEXT_ANALYSIS.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805145032.1409=
325-1-hca@linux.ibm.com?part=3D2

