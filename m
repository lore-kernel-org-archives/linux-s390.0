Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5B447CC61
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790247341; cv=none; b=Jpr1Vm4SMmKbxap3ecdH/miwqDe/phihnB7HLAzxIUH28YTsBzBM04eT6Q4yvrpQG1dPNAgcupu5EsMApRj+kQvVQpAupYqfViAlediE/bSEuJHsFkMLlBNrXb4yfbDb1fQEF7uTsLUkCBsSqBvHiWwwSE8mtmfO2hZ4wsYk3XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790247341; c=relaxed/simple;
	bh=Y2JT9EMfQ05tV/yInkx1sSSlixpCM1aiQHTZ7htnNTY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aFSJqcnWLXAHui3JW5zpXXFJ5v3bE31Rn6e3Mcrc3FbT6zM73KdNt+ugtTiA7UNHZw6SxywD4zFAjHmZCDpCMk/Hvr5K580O5XhHX9Fh6r38lwDUCaBWKY/GA8kK/coVyumBAzUMs56u5SNSi613K/THptxhKknawS9bvp+gO+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKiqMt7z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKiqMt7z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4CE1F000FF;
	Thu, 24 Sep 2026 10:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790247332;
	bh=Y2JT9EMfQ05tV/yInkx1sSSlixpCM1aiQHTZ7htnNTY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WKiqMt7zyckKqVP4qpg4nQhcSC79WENE5zTnbjnnFFpxRDX7OFZI56iiyJ5LymwHF
	 o+AHnNiZDvocf2nGn3p4NkT/5HK31c+iM/JYUsDM11aNdxLTyhr7dRvjDKMZBn+WJw
	 KbFX62Z2hSeATo61D4JVNC4ks49yQiI5tBCOXZ4S32QvPRW01DM8117DkPhaumBcpt
	 vyvngdkpsuCGNVmnvgMsBGAzUUH+zkSb87lxODgl/w2UCIniSI2M7tnWGWG3ZovK0S
	 AX6oF0bPxq6XOHBXvo9+xsHIom2ycO4ZMHeNrmaSflCCgwHypTtyAMMF25M0L+ZVBt
	 P3AP3EOuzzUZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] s390/sclp: Introduce dedicated sclp-vt220 event
 buffer type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maximilian Immanuel Brandtner" <maxbr@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260924104732.1978942-2-maxbr@linux.ibm.com>
References: <20260924104732.1978942-1-maxbr@linux.ibm.com>
 <20260924104732.1978942-2-maxbr@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 10:55:31 +0000
Message-Id: <20260924105532.0D4CE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce sclp-vt220 event buffer type to replace the
> byte-manipulation behavior in the receiver function with well defined
> primitives.
>=20
> Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924104732.1978=
942-1-maxbr@linux.ibm.com?part=3D1

