Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4169368958;
	Fri, 21 Aug 2026 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342405; cv=none; b=ufe17EE7ynHwOEhyre774yhG+o1HH8Ft9kflJTiOT/anIgswNzCOtg8PWvXcoVGcauEEIErYyK9aLTpKaiP6QVDH8n253JKhWt9+K2I1jq88DcvwiGZAHDz40BKrSjIhyWrwFm12G8zZ3szbRjVMlDtwHcWBj9oR3eGrNKBDlCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342405; c=relaxed/simple;
	bh=IHzJAeiyPtYvHhMkqhC54G1GyvLsghJVx3CkLLCFecY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hknPhO8Br31mhGociZZw8sg7Kbmsv8GES/BG2HBayj6agtveB7fxDEqX/E28zS6J+M7DJWzE7doDGuA7aTJI98ICr+LViH8bZRDPxdOzIh0DDUYIqWew+y6Bk4BawYwAPqleYFaynf67taeuTcxmrFtbvtwxpvijfvZh9LvcFyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONJTBy0J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONJTBy0J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CC41F000E9;
	Fri, 21 Aug 2026 20:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787342404;
	bh=IHzJAeiyPtYvHhMkqhC54G1GyvLsghJVx3CkLLCFecY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ONJTBy0Jkgk6sC72d/od43LVxccBZlStB8soA6i8WX6ZWub8qzmRaRPV2Q59xzecU
	 vJI7bSiRBxjKHDcBRzUQvrqPUMHY0SvYtYuYdq91EahiUGgbkvwvd1DLv7z1mFV7jl
	 cTkp0qEXq4s1cg+Xib9YEKSaf4mGVB2A9Wif1Oh3d67Dq8+xhwuMlHbbtcKMWF6Q98
	 YEBQPMGueWhtnVBgTSRR5QVdJNUeapmzwP0DLqi4rC/II/8zHT6OE2eihiWSqoVdML
	 hIk4Bruw9UjrOmBxalmvQF6cZS5hZgG47Sdn3G4PSyngVqeQbEhu6F53kcczttfgVo
	 xyWhpm9JTh6Pw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 02/24] unwind_user: Stop when reaching an
 outermost frame
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260821195259.2688377-3-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-3-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:00:03 +0000
Message-Id: <20260821200003.F0CC41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add an indication for an outermost frame to the unwind user frame
> structure and stop unwinding when reaching an outermost frame.
>=20
> This will be used by unwind user sframe, as SFrame may represent an
> undefined return address as indication for an outermost frame.
>=20
> Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D2

