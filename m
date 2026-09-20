Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAEE3B8D79;
	Sun, 20 Sep 2026 02:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871535; cv=none; b=RB5t8ephCOg5W5sDcLfxJRuVTwoiY+f96YhW2TzRcBOENPlRgNKM8iI/1BOn4hwXG9w1bBANryTEh26bId/BZu+7xzdvtmIE4yBmztqYAfZx8wiEEYifl7ikm8A4LksTdEwGnFtykqWcjPyO5F47COyCCslXUD3UewcFDN1ATPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871535; c=relaxed/simple;
	bh=3ocmWo8zpdGIWol/VbDwvzxFNOXmRUzR9qJMPJPKDPY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hvYn7jqwcEAs+GNqk4S8sksAFS7kkGwCmcShGdCux9mj+JtFhjWKn4vKahIkKSU4dsNVfGl9Sls8DJuaMTvvPwp61qElwApBWoPflSz7vwmZsFfEcyr5DbNw9HK6Vrf0vy1+ETDzZJUdiZ/p4n7g5oZnvYpnD44u8bhyQFIxOT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GN8Fh3oc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GN8Fh3oc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08731F000FF;
	Sun, 20 Sep 2026 02:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789871529;
	bh=3ocmWo8zpdGIWol/VbDwvzxFNOXmRUzR9qJMPJPKDPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GN8Fh3ocjc+V8UFJbOhMpsQ+b0CfHxAvHq6LI/XtbdLRFvNbG/SeFhW0HuGDZEsJC
	 1TMR/M1ZLVhye9lnwxLgUTq0WMj3/0mwDX4x+gFbS7Pvseqhau9y7RAbHu4PpQeT4A
	 KHS43FFIj8qe+VSeEiPYm7TTQx0ADbbhgt4yX3ivW5eedrtreQx9LZGcid0P3mvFZr
	 67mOJE9FweMAPHNorkTfNo4Qrse+F1W6g3fKSmbMUBbFGr01M5mjGvKCB6ZmBy+QfC
	 DCp90i1s4BLF7DXMSCwKsVGCaXB3HrP+JkNaEi3FKqefVPmI6BbT8gJ7PCClAZgBV6
	 za1hlrcLIzPWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: s390: gmap: use assign_bit() where applicable
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UGVuZyBGYW4gKE9TUyk=?= <peng.fan@oss.nxp.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260920022642.3145674-1-peng.fan@oss.nxp.com>
References: <20260920022642.3145674-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 02:32:08 +0000
Message-Id: <20260920023208.E08731F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Peng Fan <peng.fan@nxp.com>
>=20
> Convert open-coded if/else with set_bit/clear_bit to the assign_bit API.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920022642.3145=
674-1-peng.fan@oss.nxp.com?part=3D1

