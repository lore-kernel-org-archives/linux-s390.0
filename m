Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C963EEAEB;
	Fri,  7 Aug 2026 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096951; cv=none; b=jmvfXiwixJBlkUlZuU4b7wTEK+GhOsWf8aqZF7aFmoJGau/3JSwiLQRFbhVY+j45OKzs2uXoIkEpGLkzGujXNesyA4kwUzAUhNggZ2eAM52kW2y36bx11hgXZJ1NWiOc4GrP9KQ7/QDco6JvMA+4XUnZuKOANsY3or+GgTtAgGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096951; c=relaxed/simple;
	bh=DQuIcsshKYo1K1w9Mq8B43Qf2RtyszDN6LdxwNw/ivU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hrggO0paMp9lwwC5pnya3/znV6nqzjzYmoiGQskL8wnwADV5Q27P3X5Jw1DZ82pGU4RZr1HOvQBF7kDU/eAQwL66c4GwycKzE9GLeA4LpZoWmsMGbY1473WZxt1eT9pw6ubx4NPUQ83hFoaaleX15qhlMMmGdNXEcy1kKXI14Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXCU9EhS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXCU9EhS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B9A1F000E9;
	Fri,  7 Aug 2026 10:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786096950;
	bh=DQuIcsshKYo1K1w9Mq8B43Qf2RtyszDN6LdxwNw/ivU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iXCU9EhS/vij6gV78LE8lv8PXVoN+wrvcmC4q/zLk4Cr0msoytyC91A8HLCgj04xY
	 Y5+LE6wKatcsJyTbp9sEQtNyl/q31DpmiTBbY6xU4Lohq40dGRuK3jyinZkjSJBgt9
	 m7T/fuUeRuRkvS5e0cyAL6mWcJOujkOTn4578/DOregRe26UmdpH8qryiE/cMyffzg
	 glzOVe2VR2zFur1pu8d3/H9L5w88u2elA/BymN8RzSnAVcQ9fl4uezLB/WXoc12V23
	 Q5lTdbwI1VGA20V0lCxYSO6eBxFfs2Xojlfrrfeo4thMcTF+ujvAYucuThNxWggofW
	 XgjOYmM0HNi6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] KVM: s390: vsie: Create constant
 SCB_ALIGNMENT_SHIFT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260807-vsie-cleanup-202607-v1-6-b18659b55e3d@linux.ibm.com>
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
 <20260807-vsie-cleanup-202607-v1-6-b18659b55e3d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 10:02:28 +0000
Message-Id: <20260807100229.A0B9A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Create a simple constant for the SCB alignment shift.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-vsie-clean=
up-202607-v1-0-b18659b55e3d@linux.ibm.com?part=3D6

