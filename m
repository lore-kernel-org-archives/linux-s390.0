Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB74B0E42
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721788; cv=none; b=JvQPwvXSvUqod6U5RJG/q/o3zT1IxYbLqiziUYQiZQ4c59m6XOK7k2b1JbzSKJSA5zm7p0xSrNcfmfXdV26ZgwExsITtHZmZIMmk7ziE0BN6bQhHpTJtfA8CgiUcyTwc7QWXsi6hrixQB4ojvvymnEOWdjPeP/WN588TGGsuoe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721788; c=relaxed/simple;
	bh=i2DUI4o8d64acIJjYWTvBGIl0uhwgRA5jOQ17S/P7e0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OT1VOK6Xterifp0oESTn5PP9ThAEqMa9AkifPrcX63kSu8k6ieI9eM3pmJfgRA4pm65nSCS/fVnY5rHo4f4PeHLabITaKygmb48g1mEh3mxMj2yXc/3GVcJctHByeuiPkI4RoEORsXMQdnLBe6lmvCGa1hMgnJ0pTG16o5lYSU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPHmqPVY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPHmqPVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11DE1F00893;
	Fri, 18 Sep 2026 08:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789721785;
	bh=i2DUI4o8d64acIJjYWTvBGIl0uhwgRA5jOQ17S/P7e0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UPHmqPVY3P5qMkxumpiD9lRzwOduKd8mIwb5BLdCNQG3VyV+PLuT5KEBcOlNJbOsP
	 sHKqdEKor4AFG8H6bj9S83c/svJ0mWsbLDB09i68ML1I8EaxUeb7GdFRuQXUW/L5X7
	 OS9e8W4FZtm8zUHwTwu2KfqotADtaZ6BNVjSy6YTerKjxrMhuIIpvGQOAD/Z41+qo8
	 g1XtehFZxnSbV7a/zITjI1P7WXPcjiaf+AwJ1SLsfxsECXJA45/uj28zJErwEauWYp
	 H3Mxt/j0XwihaXxk7nRvnsNzNuBV5PaSWTJP2rxk3YvUugXDrZTizUO/NO+VCidWnE
	 S99ByyLwX/rug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/12] s390/percpu: Use percpu code section for
 this_cpu_cmpxchg128()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260918084842.2333237-9-hca@linux.ibm.com>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
 <20260918084842.2333237-9-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:56:24 +0000
Message-Id: <20260918085624.A11DE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert this_cpu_cmpxchg128() to make use of percpu code section
> functionality. This is just for the sake of completeness, since
> currently there is no in-kernel user of this_cpu_cmpxchg128().
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918084842.2333=
237-1-hca@linux.ibm.com?part=3D8

