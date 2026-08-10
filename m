Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E6E31DDBB
	for <linux-s390@vger.kernel.org>; Mon, 10 Aug 2026 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786362467; cv=none; b=XSQDLkcWI1CLuzG3u6KbYQuQ7WFUxrMBf4ELbjEWWlJ1kd7VpRh2weDaPaWiBQ6O15lHsUsqQ1bO/1O+Iwy7l3dhJg3w6DlYVoxRLSHMZQIAk1k+KbZEr0NDsHNCRFbZnZY9ahoGrYim+ciquTYldy1xxgxzi7zJw66DAR9n84c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786362467; c=relaxed/simple;
	bh=4+00l6aWh66J/hSdfMRejs09rWnjGLk1Jf/r330CzVo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gMAUPm0s7w/+uOgDAZLIxZwhEpgIqBtxHdQKhSmWXmAJVDEXZaMaFu8qZ137JQz/m4K9C89KpvgBfyuSiYlYa+qkjJu92qOsShRa2H1Kfwuuo11r51W/rXMcBXgASQmZSiZqxg3qsXZG9sDtxapqSTN9DOWmP99gQq/qNCAMJFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax5VsVps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax5VsVps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69081F000E9;
	Mon, 10 Aug 2026 11:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786362466;
	bh=4+00l6aWh66J/hSdfMRejs09rWnjGLk1Jf/r330CzVo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ax5VsVpsQozfgU21LFYxWzU7vFMJqEcU6a8odqwl7Hq3moFoQkuDYgswwHVzKmgVc
	 zc/0AvcOQupm5U7ptU7hJR6JCw17Z+3JGZ4r/VASnlUkemp5bP530OBh1inJ3YRcCQ
	 RpNi5LbHqVtdQ2ftI1IklRHFBtD9v0YWRVPeSj1TAacIFska2hkz152+040SukAcJJ
	 kRxIIcfNlYLyoJgiAuCqSxhFwwnNGebGODnV3Poi0r1e2KRR3U1Pm4HQgYYCVFqweR
	 uQug7uKLDTyPbp7SP9sl4SK9EafQtJ13aWgdWDuZFXSNd4uJY1u4Nvn7EZwY1JQYnw
	 iEiBbxZa6PeOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] sparc: Implement arch_do_panic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260810-arch_do_panic-v5-3-e86ae992c253@linux.ibm.com>
References: <20260810-arch_do_panic-v5-0-e86ae992c253@linux.ibm.com>
 <20260810-arch_do_panic-v5-3-e86ae992c253@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 11:47:45 +0000
Message-Id: <20260810114745.A69081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Implement sparc specific arch_do_panic() instead of using sparc specific
> ifdef sections in vpanic() code.
> Reorder arch specific panic handling, sparc's Stop-A messages are now
> printed after "end Kernel panic" marker.
>=20
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-arch_do_pa=
nic-v5-0-e86ae992c253@linux.ibm.com?part=3D3

