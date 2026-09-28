Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC1E472540;
	Mon, 28 Sep 2026 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601227; cv=none; b=tGwM6t72S4w5c2RPz36RXn7890P0srOBFdwGmQN/OYD6ntVYjcP/lKZteQQcClAd2F6hH3OD5lxOLNJRY/m8f+lRChG9ROKclE8QZ21yUT2QIab51B0RxkookKB73cQ3VLMsLUpgaDmHw9v2Pon89Lkn47vtKOMc5XZ9CLFufyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601227; c=relaxed/simple;
	bh=qGmsHA0nEf27+XgSHz4UMlWJ0ncPhfBck/rqldr6HaQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kCMV56ch7vw+59E8mU4SKCeUsAV4Fwa8A6JLLQDklczcUOhIYnDgfO+HrwGLOnkct+TI8s/5qTPK63HBNKcUa7MOj8U9XFvA8H3PJSMsD8OL27+aKcgB5QMl/MqzHIJ/XIewNer6xAEjVuj+I2m/7l27Ds9BHcWYAPrPQlhmnNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOyrhP9B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOyrhP9B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADB41F000FF;
	Mon, 28 Sep 2026 13:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790601226;
	bh=qGmsHA0nEf27+XgSHz4UMlWJ0ncPhfBck/rqldr6HaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cOyrhP9Bi40qCDCBIAOZ3Md4u8XFtR5L9+wIl+exwcSafB8w+xegLlvKZHZGuajna
	 YkcRz3l7KRctFSW2wnGAiI08l27kbsMIWOQrn05Gyw6R8x7ZKJ2+AUB5a5DGxPSDHo
	 cW6M3XkhZhjtx5rIjliTrcx0ghqaa9CiAW7UrTJaZ5S6pOyuI47l9uRHbfHfcNRLpQ
	 hxIyh5tEiU9CvfE/FE0pPdkwlwz0dGp9lw5LAgOn8ygkTb4jj3L12c5qxNjlvzCpG1
	 gXoP0AFHYf8m3VnPUSkubVe+TbBoUTmPxKM8kFk3zUvNM5ugAQy+99psNI4yaAXLgx
	 ISk/XDM6zBm5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/6] KVM: x86: Use file_to_kvm_x86() in SEV
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260928-vfio-v4-3-e32e226d5932@linux.ibm.com>
References: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
 <20260928-vfio-v4-3-e32e226d5932@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 13:13:45 +0000
Message-Id: <20260928131345.8ADB41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Use the new arch-namespaced helper instead of open-coding the file check
> and private_data cast separately.
>=20
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-vfio-v4-0-=
e32e226d5932@linux.ibm.com?part=3D3

