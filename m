Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2FD48551A;
	Thu, 27 Aug 2026 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846980; cv=none; b=DE7JCuUmtYwHw+QL8iC9UUkKcGkcaa91s8thBLK8GugzfJZHQCqwMhZein7DUHDhtXmIlXsfhJaWjPx2Od5RIy2qzxdRePU6thOm5HI2kBhM4YQqgBI7lP90/fOoUWTE0UXp93Ri+iJPB6tJm3CaaPWW1QdNOEBCQvgB4K+1oJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846980; c=relaxed/simple;
	bh=tGNt6g+q5i0SQra6K/Bfve0kGnFLFmJcXo5Z6SC+a+A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KQ7j5bmTuL75wVdT0NUNhaIpHRFweT2gWN46UbqPvkLSM/Fgm5gcxop3lI4LLTDHkZV5ly9LiUNx6BPmlFhI/1YG73OqRrUed7ERb7mUWZxCalJy7S/gp2PNthhtDITVgLkTLm1pulZh/ILQBet92iNfLCQZy4j+ELQB/Rmfmak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6bIQ9wM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6bIQ9wM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D80C1F000E9;
	Thu, 27 Aug 2026 16:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787846979;
	bh=tGNt6g+q5i0SQra6K/Bfve0kGnFLFmJcXo5Z6SC+a+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D6bIQ9wMcrlVb6/oby/o3Fjhe5orpUdJn6N2KbmETAcxdLuEYfEylrGPPACYEvKHi
	 hkamqBWm/986Xm1Iz9lqsSXQvn0ERqdqoJD0jGNXIeBJmEtfgVCSN6wfuX6VWwd4bj
	 FNQTyy1X36blO3CE/MiIG42zswLdYBYfzfHaaQjUg8BFcURpboB5+ILmdqUieGAZLD
	 EjyLTf3SvkhTxymlrZveXSD4Q1tH5uCc2dUPQjHyjTLIcWobxQp2qCMKfy//CJVYeu
	 51XrjV4xPM7py9008zAQTKQyNqGHZS5/XpKMpnAxjno9TuKDvsWYCzrRRuMzE3bdbY
	 mZ46uORjRl4zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/21] KVM: s390: vsie: Refactor
 kvm_s390_vsie_destroy and extract reusable methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-10-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
 <20260827-vsie-sigpi-v6-10-8020bb53be52@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 16:09:38 +0000
Message-Id: <20260827160939.1D80C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Create a helper method release_gmap_shadow_safe() to simplify releasing
> the gmap shadow of a vsie_page and a method kvm_s390_vsie_destroy_page()
> reduce nesting.
> Both methods will be called from multiple places in upcoming patches.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-vsie-sigpi=
-v6-0-8020bb53be52@linux.ibm.com?part=3D10

