Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3953F34027B
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251449; cv=none; b=LsfseRLMBmLhGO2DcQ6tJQOJuj8h0swqj3sEAQIB7zbGuAIHkmuTMKThER53GppNPp6Ue7aMmcXMf45XFugEooDPJKxfg7KQLYwy1KQdab2o2apYeFopWjtPWOMtv2ONGxAJfGwXe/SeVE16FcWPXdhQdu+qCo/YAFcmmJHbqhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251449; c=relaxed/simple;
	bh=L4uILBV3B8lUJFJh2+N01gWVZuZcQ+oAiXx1jmwwBlw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vB8xgOELc8O3xZXTKylVmcFPTmZ9AMZxKM7FACRTwp5TX+VNBcTSbFdTLDn5P4ll0mJgLA8amox1gRWhVloy8lk8AKLT19iOkYwsB7SxsljkB1DKfrNNF2rC+IM2OJ2ftEpdYvMCqyknaSipKtIoonBU1lR5n9JSA5tJ+hkRzFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5cxfZo/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5cxfZo/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6231F000FF;
	Thu, 24 Sep 2026 12:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790251447;
	bh=L4uILBV3B8lUJFJh2+N01gWVZuZcQ+oAiXx1jmwwBlw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T5cxfZo/oSeqbgH9bKqzrpmkLxG8KByDynkOqPaQexwBK8bzfXX11bI/ypGiwsFoH
	 193mCwb3Tf1C6/p72QhKjOQSTu+O0Zb8n0rOmff76Wjv/V5gPX/kN2/H1kWoRTnZYF
	 UrM37g0CJ7qNWff3moVXEXCo1DlBearQHBOztZQZjxsm244kun5N7hCSglR+s5VVFT
	 CjnDq+d4K7v/4q9R8OVeYOgpfNUuQMfgKh2NHIuRTxfz141aMkNIIr8zVE8JtWkvmT
	 NKOU5vSj8ZO/AY0eFedOMK/ZPcRT5bJH8iKOGQY6jHv0tv1ellgTimPqZiSHcj6Uvl
	 3T+EPG1rkl7ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/kprobes: Prevent kprobes on instructions with
 exception table entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260924115725.1108581-1-hca@linux.ibm.com>
References: <20260924115725.1108581-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 12:04:06 +0000
Message-Id: <20260924120406.DF6231F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The mvcos exception handler ex_handler_ua_mvcos() decodes the faulting
> instruction, assuming it is an mvcos instruction. In case the instruction
> is kprobed the decoded instruction is a breakpoint instruction instead,
> which leads to incorrect instruction decoding and potential register
> corruption.
>=20
> Fix this by simply preventing to set a kprobe on such instructions,
> similar like arm64 is doing it.
>=20
> Fixes: c488f5187a24 ("s390/uaccess: Shorten raw_copy_from_user() / raw_co=
py_to_user() inline assemblies")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924115725.1108=
581-1-hca@linux.ibm.com?part=3D1

