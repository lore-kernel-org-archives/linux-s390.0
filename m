Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F2A502571;
	Fri, 18 Sep 2026 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745156; cv=none; b=rmRKEkVl1QcXF4HZCmvA/7ZJ/C9OF/y2A9PRNwURBlLQzOrOb9eWJcyJwyHpJRhG4QWZu815CxgmcBVt3zUGcxu8WWHrfKP4VB2YYD+PRfgBX1MQZ6zvH2fMNfdz9dtKUp+U+pmw3+zNhOjptYnXo8o+43rO3eryS3w05U/cdkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745156; c=relaxed/simple;
	bh=EAZ6zvjGCfITYSQ+lHL1WQKP0e/vfrscSWwbTvCkcC0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ndy0OQBVr8itFjuuwewiAAjFC7/r2TY/OSxjrl0FhBSdciKjXADICWRx4VlzZ4gxD3vCJXm9pID5yFot8gGx5KPFI1XYzrOercbNbE+BIUbS3B7s1+d7E+mvaWuhzz58Bx5VZJl/3ZMNsV4N+AdnfHD4L0O44TSBEsmQ82V1uUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwhZn5gO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwhZn5gO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05B21F000FF;
	Fri, 18 Sep 2026 15:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789745154;
	bh=EAZ6zvjGCfITYSQ+lHL1WQKP0e/vfrscSWwbTvCkcC0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TwhZn5gOjbX7i3kcXbCiHJZHAizGFGpRtPlfjUcg6TcRQFlYp79HHYbgusUtzBq56
	 2cneAoxlE5Ndlx1Vq6Q+z0ouSBL2d+yiNG1bk8SjD5Z/5T4Rd4gcIN46et/wMfmt0Y
	 DSaKflim8sRG/vSlfMPf4+VETXYBsD66kn4907dtdzqBkr2tqlaRn/aJSOYEVI6gVg
	 yaiRSSLDiDOkPIrYzboFzIJpCKl+WTOzRAw+1Y+8Ne4LS1tiQ1/B8eDUqaRgdI04/B
	 UslATfPh2E1+IegElNhFJTFR4MPqOQPx8LZ6Cvz37p4RMCMNYadT7mi6hnlF+DMier
	 dje6563NZYsIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/21] KVM: s390: vsie: Add helper reset_vsie_page()
 and unshadow_intercept()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260918-vsie-sigpi-v7-11-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-11-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:25:53 +0000
Message-Id: <20260918152553.D05B21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Extract helper method from existing code to reuse in new code.
>=20
> reset_vsie_page() clears and releases gmap related to vsie_page.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-vsie-sigpi=
-v7-0-f39806eaae37@linux.ibm.com?part=3D11

