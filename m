Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F441F30BB
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512896; cv=none; b=PIVOsnGA6hkkE0RIiZdEJeiGXj5Uoe4XQutzL3LGIOQXcfsjzTwpZp0mucMc/b1tn0R/PG46MAWA4fym2HG5mL7bg0IG8bxslsjxsrBmgGd6b4Or4jEARclM3HpulDuNQn44XW6TtypRYNnhx5xOTCxneOfPpsOS+sz+GN9Peww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512896; c=relaxed/simple;
	bh=aQcoyPJehQJ1A3jrHtkVjBqqbrKAHkZKZmfXUzEYZXY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qyTFwhNcq1KJ5+K68SMYjDJ10w64HTpQ6Jtzot6pXXi4s+aN5fMXz9XB/65B5kr77Z4tma+WqBClTplfaDWZ0r0ISxA3vc2931m4Xl4b4QSYfdk+/itZ4s2HJ54KPmfAI6gWLbMHBHIbuinE0o0EEXb32KwbLk/e3eioxCRlBOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JW7jTWPU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JW7jTWPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC6D1F000E9;
	Fri, 31 Jul 2026 15:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785512895;
	bh=aQcoyPJehQJ1A3jrHtkVjBqqbrKAHkZKZmfXUzEYZXY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JW7jTWPUQuGlOwS0laYs6PPTadgg+XEZJZp0Ptxsg5R1vbVR13G67UqiA6cSFNQAU
	 SKl/BZd3YZN7DNrEy5utZ0NiGZQmNHmhm7SmFRklGb1Kwac4uiywGKuQ8NC4kCDcI7
	 YiD0dL/8cR8LSFpxxP3vp3P+cxq4+Zu0lbbK5azZd9Nl+U1N2Ts9oy0VzFuNoZ4y41
	 R68lTLydEb5LU6RJTq8a3mgB5PJraMm39E596bquXQQ9sdXImvxGy8QP9R2gcfSEhQ
	 q/GCVwDg+xCRcbKOAKHbeZQ+m0QgK2ApJLxgNMLR4t6xODaS/HqWlifOCbp1+RzLmn
	 IyrhyYLYti5DA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/17] s390/dasd: Add defines for the Extended
 Address Volume track address
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260731153842.1729627-6-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
 <20260731153842.1729627-6-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 15:48:14 +0000
Message-Id: <20260731154814.AFC6D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The track address of an Extended Address Volume (more than 65520
> cylinders) carries the high cylinder bits that do not fit the 16-bit cyl
> field in the upper part of the head field. set_ch_t() open-codes the
> corresponding shifts; name them so the encoding is explicit and can be
> reused.
>=20
> No functional change.
>=20
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731153842.1729=
627-1-sth@linux.ibm.com?part=3D5

