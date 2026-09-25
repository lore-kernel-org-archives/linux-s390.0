Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FCD497B81
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336324; cv=none; b=VbxiVE8/CPllWzdHMpXKN8JLmuIUG0MvzPbXUrJ18MR+LgwsNgLIR/Z/A1uSIFyVVdMR/fIA2i6Vw83am3yLRgmoi0BT5DJDlYRp54kge2SRU3CPPDxddRMRwpucLAVmP5irQ5kWwZM4hneJvkcWJrO+fruidvFgMFE/kPUaItA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336324; c=relaxed/simple;
	bh=44LxoppmJVy3IBMb28evSBsrBpci1ywsTcsBEzrUVDE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fuTX1oCTQWdepbDYfb2sgMeR17Wk5hUewafVBfi7en6mCMTnzm5yYfw0u5cjOCx4CSw740Bmht/N8ZIe42HdpYyLQW98RZI8hNz3Y+lsmgbaoJzC623Cbo1wiuBnekccHt3V+Li48Atn5wQj7QN4/RmJ3VqRcvIqkh45VN0eMYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TP6cH4cx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TP6cH4cx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AA71F000FF;
	Fri, 25 Sep 2026 11:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790336323;
	bh=44LxoppmJVy3IBMb28evSBsrBpci1ywsTcsBEzrUVDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TP6cH4cxjEL8uDTnFwAZx5gapV0oPXfY1P39q4DT+wnyLIcNRrv/xrV//1tnYKCO4
	 xYRyIvBv1bawyUYydtOgjmk2nEs/U/gG7Rg82W8aHpNYLQCo7WF1XMX0/JdKe/FnBL
	 8Ol5E9n4Mr/+ZTqXVTjfCfrtIaz6lijC1bRbnlKMwx11RIwS35dV/oQbBX+9V8RxYz
	 8MyRnAm27vg9Xbrp/8NPXX7WnpCTQLG12azZK7w+XuuS6SOZZaRUbT/JHbYsq1z8tc
	 ag+kEMlV2gA7TUBmb3TtNqq54o3Q4W9cKr+5KWtvpo1CuyBuyzPJ9SXDNvmmnaqAFY
	 IcsCkUZsLVI2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/9] lib/lz4: import upstream LZ4 sources verbatim
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260925-lz4-vendor-upstream-v1-1-1c7ffbe21c4b@samsung.com>
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113452eucas1p170bfdb34dfbf670a14a6f8f0c2f5094a@eucas1p1.samsung.com>
 <20260925-lz4-vendor-upstream-v1-1-1c7ffbe21c4b@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 11:38:42 +0000
Message-Id: <20260925113842.D5AA71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add the four upstream files under lib/lz4/upstream/ without modification.
> Nothing builds them yet; a later patch adds the build environment.
>=20
> Copied without modification from the v1.10.0 release tag of
> https://github.com/lz4/lz4, tagged 2024-07-21.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-lz4-vendor=
-upstream-v1-0-1c7ffbe21c4b@samsung.com?part=3D1

