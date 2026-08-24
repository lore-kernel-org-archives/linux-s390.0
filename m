Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDDE411680
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574749; cv=none; b=o8QCKnP0Jd37KxLcfugWKhTxXASRPl3HS+duN1iIHroGih4Jsmvk3wqu1XdsuMPM+ZBbx513rpdkOXa7O2THockFl5QJLrcVqhE80m9sMoRgLmkfFCCdPfiJOCUtXq1eDF+X1d9m3bZhPhcIbQlwVQsg7zUw9c1JS3wXlCWevpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574749; c=relaxed/simple;
	bh=mTfLaI5BfNNSUV4AovMnZkkQadBbALMv/ABoL49xCvY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R+QMebbi6QI0jOBi7xxCdwEk6Y24qxut5bSRkGOuYMJhhwMrepMpilBTu75SGwKZKNGsISwdQSvEdNFQkU8RZd3dck/p+DVpEplA8ltZsA3Krc5E++OrCoj/eLX63zWTmtdUgd2SCyljFVVDtVqoqf3P5Q/LD8c/dW5CKUFJzWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3CubvCa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3CubvCa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9953C1F000E9;
	Mon, 24 Aug 2026 12:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787574748;
	bh=mTfLaI5BfNNSUV4AovMnZkkQadBbALMv/ABoL49xCvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K3CubvCa/fKglEIStUw/CBp0p0GTwb1KalKBki6GNSmykqeHdfWIwop47hYxBTof+
	 jsWuNs+tPuXzjYeaj5RnDWY1Pi9vwVuozhqwhbJUkIpPZLCVtREFpiYQhfu5BZMjjf
	 aoqcRvvb11Cbd4hErF4Cg+lwyH9VCtx4mUobRS6zJdiC5BME7RwYaKNWlCLRrdX/o1
	 xXFoJ5DwSYb3r3F54vGb6T8ph74OWBqN+gWpY0YFegJk/Be8h0dVeEyBUljxSYFn6j
	 xeXtlk5Gu86K+qobLCeZHteSf+pSWXxM/AJodO4ZSFewxiKpyCEGbsS8/qLy/kzYda
	 PPjnUXyLbIXWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] s390/pai: Use PAI PMU index as parameter replacing
 event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260824122307.86133-2-tmricht@linux.ibm.com>
References: <20260824122307.86133-1-tmricht@linux.ibm.com>
 <20260824122307.86133-2-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 12:32:27 +0000
Message-Id: <20260824123227.9953C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Use PAI PMU index value as function argument instead of pointer
> to struct perf_event. Only that index value is used inside
> functions pai_alloc_cpu() and pai_event_destroy_cpu().
> No functional change.
>=20
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824122307.8613=
3-1-tmricht@linux.ibm.com?part=3D1

