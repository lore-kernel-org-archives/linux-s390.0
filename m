Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF6B4766BC
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253968; cv=none; b=sYR5x09otVGlqr8nn6CZGcgtMw/57axH6l12rS2S7V5LM+IX+I0Cicbaim3p99gO6AmvtbvPMouQ6VljFYm0wpxwpqOS9uTdpEue7NCR1em0JRFwe6YCQTWP8iHxPHtZhkT4eRGUC0IVsuMcwfqe2L7jOglKhCRdiFHzko6aTVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253968; c=relaxed/simple;
	bh=rg1T89jWVSDBmZp/WdgBKamEpyhRMfTVsfjObvh+Uw4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q/Jvkf/psoT8oFXnjjP920oNyZK/S9r/4Yds2+AWbgih0WQxakduXCBppjy5x11bcyUDM4nREzZWVizD8SjfFYEdOBC36D5xXHtUn3dYMrZLSEHIxJS4NOoUnbpRlFg9crQVDiIYJN9byiVDUhc1XuFMUGP1e7/YyrIlI8r3wvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7H9+S3d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7H9+S3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F711F000E9;
	Tue,  1 Sep 2026 09:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788253965;
	bh=rg1T89jWVSDBmZp/WdgBKamEpyhRMfTVsfjObvh+Uw4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i7H9+S3d1aAPVcFN3+XoEU7uiVvoNwXLthVxi+F+PFT5FxxzNGSkA2DELNHRwsWKb
	 UJM6XHctwlMDKP2gSABBbA1DepMO9DN7XB3iD3uorBHAY6R3hF0WuA3pahHuRffEsd
	 I2bgpoeo7ILisW+XcfHjNrQYGKfBcQYmhAAz/47tGa4vFZ70ikMnc5sAN9Sgn0LPDv
	 hT8u1gflNpkf3HmBvpHhOQgY/Fca1KXGD8pRyL91yb8uUTEr+I0a7SG3OoyN3wmi2g
	 /8y4GS65Cx3B4L3aoL3aFAbsi91NRlp2oXFfHSLne77ph9O7KBgwOIfjS48E4JR7cl
	 zYpOqMcO6vPnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3 v8] s390/pai: Move locking to event init and delete
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260901085448.2260658-3-tmricht@linux.ibm.com>
References: <20260901085448.2260658-1-tmricht@linux.ibm.com>
 <20260901085448.2260658-3-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:12:45 +0000
Message-Id: <20260901091245.81F711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move mutex locking from per CPU allocation to event allocation.
> No functional change.
>=20
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901085448.2260=
658-1-tmricht@linux.ibm.com?part=3D2

