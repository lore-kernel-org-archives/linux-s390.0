Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6933B4322FA;
	Thu, 24 Sep 2026 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240659; cv=none; b=iMifcbINODtJ3lgP3h4sYy3VVoA25gEmnqi9zlFpy0s8ChGBxBw+iTWdS52i1bkUGb4VBrxM+pTpFG59genbxom6NQw1iwUgHvP8BvT15kT+awup/8WPnJE3NAn2e/wPHmSHVMB5C2dJusQNiLngyqtE3abcOXz2MP1XlBUDE78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240659; c=relaxed/simple;
	bh=ZrFtOusX4/8Pb+VOa2Bl3uOq+z7d7D1tyKc0+8T73n4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bq5RlmYq2aSkezWfs0WQI6NIo16S0zhJkyLCto0JdBvIrYqNVticEdls+Cp+Nt+iq5RLsFrJV3/JQr+M6LUkCxedwmzZ1MKzAjEyfpyI0ROcsHCNOYgHZTKDhMHHpL5DKlVYxNYcelpe3W8ntKLq0wIHPzxPZeNkOSAB7vqWOvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btlKxx6h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btlKxx6h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BB21F000FF;
	Thu, 24 Sep 2026 09:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790240658;
	bh=eVkmWIfwqfxSSUBpjcYP5DxVwfaTPV/gRBEMoySj8G8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=btlKxx6he9I0seWRn+ojU41pkqbo1BTRy6k2qG+Jfa6/uS9PqezoxhwLzTmalrTfP
	 oDSVfnmZnxfjBich7727/3CadbR9tT626gwdeyTAzl/oF2TEmFIC0g2gAqp7zAOpvi
	 qZfnEDEE6v1jLKuLBpEW0SVs3FWd38uoKfj1RwSAXzcmoOEV8aBskJ/krgfHMcQKtx
	 yfAbFdUIkd+u3Hw3GE2N9Pxyuw5+X5eoipqS9AOhqHQyl3azG24UG4ZiCDjC8Ktz84
	 fxrhqDg4mJbjthXZcFonufKhM3G1kAT799Sw2cdHJzgtULR7ElZd940hhoCo1i9ObU
	 ECWbNdWnlugSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] KVM: x86: Use file_to_kvm_x86() in SEV
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260924-vfio-v3-3-4a294307797b@linux.ibm.com>
References: <20260924-vfio-v3-0-4a294307797b@linux.ibm.com>
 <20260924-vfio-v3-3-4a294307797b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 09:04:17 +0000
Message-Id: <20260924090417.97BB21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Use the new arch-namespaced helper  instead of open-coding the file
> check and private_data cast separately.
>=20
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-vfio-v3-0-=
4a294307797b@linux.ibm.com?part=3D3

