Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1C541A922;
	Fri, 31 Jul 2026 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504486; cv=none; b=WDAzYVO7lSOCFSY/g/doDUtODfG/d42JOxu/L9DUefhpNmC1/0lCH9aBOd6EuanG0WbqFFqE/5W0lrvFvU/1QcwoOjIIZ7kuBGZTvZS1BoF/fke9YDVkyrhJS5US/96APT3HJRuYfoSS9E7sdRCD3iaCa+a9pDzKA9pdnPOtjtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504486; c=relaxed/simple;
	bh=lnrX6C3FrIqXBzRWL5HyDV2Q7w6HC/Zu6pcAlmsEZDA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t8FemnPJOsHqK8nicaHCG2R2jN3ngM3GciWQS9oh6JzepiiZ3rq5bNw7I+tIH+vQoHMpIyq0Ma6aUsmepIzSt5RHpCOEY0PBiru3IDlrBvvkkXpJjsHDQOhcZAKCGoNFtat07wVvRuvSKenFmLn4Tg2RKfbhTPpIgvey6Zn8q7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHgWCjSO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHgWCjSO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836E01F00A3A;
	Fri, 31 Jul 2026 13:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504485;
	bh=lnrX6C3FrIqXBzRWL5HyDV2Q7w6HC/Zu6pcAlmsEZDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iHgWCjSOGOfJQ3umRaM2FpE3zKW3SGPEhZesrLx1LI+MJgLsrMaV7bTASkU+pRZXA
	 BOfGX0ZVZES3JDLf/RsIMq7Soz8jER85v0Tzki71mzHcHj7umcSNuQP4jR7v5SzcNo
	 GHIkraMwqWh/1vU1PaUAd7q3+C0OyoVj2HRYvLEmGmePR1oVjsM0M1VKsi5JFw8wFL
	 MzdAFUA2NHGEyH8gI+qsgVSruOw86QLzvjzhuN70NAfb85UbqaCwNnkXysu9u5J533
	 qvm8BueYh/+FR6uybTXI9+eEAg6gJR+6t/LCol6VHtJpv95EKC5LudzinTcqNReydz
	 8i4aaAKc0fEgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/31] KVM: Allow KVM implementations to switch off
 MMIO independent of Kconfig
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, linux-s390@vger.kernel.org, "Marc Zyngier" <maz@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260731130902.654679-4-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-4-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:28:04 +0000
Message-Id: <20260731132804.836E01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Only defining KVM_MMIO is not flexible enough for multi-KVM systems
> where one KVM implements MMIO but others do not. Solve this by
> additionally testing for the non-existence of KVM_NO_MMIO before
> including MMIO code to KVM.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D3

