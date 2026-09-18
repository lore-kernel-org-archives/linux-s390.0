Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEA93DB320;
	Fri, 18 Sep 2026 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745283; cv=none; b=KpgzZTKeMvdsLaLhwCumEtc5Y2rQ6kxFFjquuqTk/xiLHxfQ5FYF5X7XJF0pdIUdkdiDsi6cQmH1NOoTYhZi7IfM3II95z6T463aRtB+ZH3IOGzBhOhLqJqDDhPVl4z87OCK6nB18A38EP2oOMvh0Z7tSdSl6EWEweOaFiYB4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745283; c=relaxed/simple;
	bh=Y5O/xf/mFIcJDKbCeHsIsZUQCLhaZqE+IXeyz/TEH8Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gDxwOUL87kmXoEZDtTV9SHH5RDKcmTG6CicJ/yPvYhZhea0DY3oZz4w6YLRYmCKbEAvaPYK/qFLvUAbL2tKGW6SSE5NAd5oQem0OBjMnGfq7fUCJa9ahDXhvC2I/mRVKvCOGaX2ygdxqKpb+v5vBS+zaENyfo3JY1alFY9T4fSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7aN1nj5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7aN1nj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7A11F000FF;
	Fri, 18 Sep 2026 15:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789745278;
	bh=Y5O/xf/mFIcJDKbCeHsIsZUQCLhaZqE+IXeyz/TEH8Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j7aN1nj50pCUp+OABmhm6f/4UTG7A5UhnGS3AD174OmOFSf8irpcKeU2DD4Hzwwvw
	 jk5yFo4VSam59DhUGa1mH5BWKWQMhDSN/03mcfjYGrlg7FoKPzli0bfkcJ0fo3krzg
	 Wa3Uafk636+nbyhsH8nXawIYDRm40ukKNs+leFvLCfK+vSZl3jM8dKP/Vdvf0C0/CZ
	 ingvanVdmd/pNn2AqW2K5I50BH6we6yYEe7hzKRMD+ZkGRhDqUnnlGbfnltyw8j7JF
	 6QqUPShVmRtsu5d9J4JsmX8jPAF5/HUkEpgsH05EcRyFHTUTmEtLKZ2ZUgpUnDjsTP
	 ukYO1qzs2h8gA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/21] KVM: s390: vsie: Add helper
 unshadow_intercept()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260918-vsie-sigpi-v7-12-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-12-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:27:57 +0000
Message-Id: <20260918152757.EB7A11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Extract helper method from existing code to reuse in new code.
>=20
> unshadow_intercept() acts like unshadow_scb() but only copies intercept
> information. Used where the rest of the scb is not yet shadowed.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-vsie-sigpi=
-v7-0-f39806eaae37@linux.ibm.com?part=3D12

