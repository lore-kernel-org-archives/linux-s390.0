Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7268926FDBF
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851456; cv=none; b=FEdsHOan8Z4u1fOyWjrFkROZ/mQBECbXcqdSbPbOPGpCKB65eoEF/xw98xoKtlc/SBRXcxvVVZP+zq3Kh36eYQZ1TH+VlUlH0vKPr1jw91DMEeSojaDGUyyRefvFL4dIQ03lMt5ScmqBUflKMcvwJgz7y1POIuoHI+vMsfM0haw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851456; c=relaxed/simple;
	bh=KQ+zcKCZZLzMx8FN1LjUeeErLIUBFOWxawJsHJib9aQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RZsTWEFYMXeUTKNglrwGPEEYKjWVrq+sQ1/ZtcxcXHTZ/I7a+TfiI1bplMyXtJIY49jaZ0Dmq4xijlJWgqrep8ZQJwLXW9YPV+uVXFWkcsC8Sap5cMywT09vaYe8l+AU1AQKagvP5aNRt5q72cnWEbQYjwuWuAwlLf4S6IllThI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGTd3xQ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGTd3xQ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F4C1F00898;
	Thu,  1 Oct 2026 10:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851455;
	bh=KQ+zcKCZZLzMx8FN1LjUeeErLIUBFOWxawJsHJib9aQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hGTd3xQ8G3VhlFr3c62ZPcazB61FDw4cgM2DjBtcwIdhfNBOj7KH3u6iLku+pOJ/2
	 bmc+MBMh8C2VCVP91ZmRHQuNxGHUR1YI/tWgPInkMj5VQ4/+n8cb+mmRDdQqrB4GGb
	 A85VB3Up/cDqVUQoFjhB/tCPRmaLiieFx0ssCAeUMRunR7Tj4mqT/9YtCvgHKfBtHP
	 JAH+aK9Zg6csGtc5XIKxXdfdxcniO9JZn1oyYI8kG/bZPYItebh0gVUgj06eY6HimK
	 b3uLmAynxzVs99iPU44KqP6uC5xNDvcALnJVUFLp+7tH20JcdnLCKoO5VVGHZQ2p1/
	 0hK5X/yoP8mOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/32] s390/kprobes: Prevent kprobes on instructions
 with exception table entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-2-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:44:14 +0000
Message-Id: <20261001104414.B6F4C1F00898@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D1

