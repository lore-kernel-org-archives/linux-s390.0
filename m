Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15701246BCD;
	Tue, 28 Jul 2026 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203395; cv=none; b=jiJQyFA6RVimpchjPSYpX3q6IcXKa12FhiUZpF7U6+ka/lvJzCfVnkjdY4l9plGVAmRVyw3CQSCObHR0xoQ8/c2OhoUNhqtH3L4cycZyvW7rFa8qdTFWzGsvkvhx8J43tLfi4pn7ZJtUyYPzjD+xWe/vghO3VCdw/W57L9nH/FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203395; c=relaxed/simple;
	bh=gulx7YkJzG4SfzJdarlE8sJyfd7eBs8vD0Lwl4KNxgs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BKOa3PVRTm7dSQGygx3jdB+SJS244WVk/vImRuOpGhN6KpV0aU0bWZQYpebQcNv219DmITVK7trdLTqgY0zSSHxuRj/+rIQcH/6E9zygD8dxFlVRINAzY0a6csLuwFg3fAPasGdcZbvGFduWB36LY9XW1kCqjGTAgi05LSgiFtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=it6JLgIQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="it6JLgIQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517491F000E9;
	Tue, 28 Jul 2026 01:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785203393;
	bh=gulx7YkJzG4SfzJdarlE8sJyfd7eBs8vD0Lwl4KNxgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=it6JLgIQBVh5pixpLQFJBIqwFNyRM1tI3v4NbJcMTu3UGnvA8MW99Qg36lK/5BW8c
	 IvH9Pi/ay+Rr1ZcdtondWAQxFh10tN2PUrqVmWO2N2dgcwsGEj09IIbJlePBZe28Ya
	 cW/ny/Ym2y1u/yBNly4QdZntviNG4L+5Ecov2Go7wP8J1RwG2h28v5tMsw4ifcp7ke
	 8AJtrS9QkIbOnPm9NSEGr05OvS3Wdi2nL+yUQU/cIkGQXfVotjqX9TaoFNS3S6xrfH
	 a+lWDBIRASieBjnU5x5bp8Bfys6h6BQALx81AUDKS7LeTz7J44W47M5BPpfAyAVsUF
	 fza+kOL23T/8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/10] s390/vfio_ccw: calculate idal length based on
 idaw type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260728013509.1551753-6-farman@linux.ibm.com>
References: <20260728013509.1551753-1-farman@linux.ibm.com>
 <20260728013509.1551753-6-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 01:49:52 +0000
Message-Id: <20260728014953.517491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Sashiko pointed out that get_guest_idal() unconditionally calculates
> the length of the IDAL presuming everything is a Format-2 IDAW.
>=20
> The output of vfio-ccw is always Format-2, but the input can be either
> Format-1 (31-bit addresses) or Format-2 (64-bit addresses). As a result,
> the size of the guest IDAL may be incorrect and should be trimmed down.
>=20
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/r/20260720203400.7328E1F000E9@smtp.kernel.o=
rg/
> Fixes: 1b676fe3d9d3 ("vfio/ccw: handle a guest Format-1 IDAL")
> Cc: stable@vger.kernel.org
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728013509.1551=
753-1-farman@linux.ibm.com?part=3D5

