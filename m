Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FAA428472;
	Fri, 31 Jul 2026 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504716; cv=none; b=cZ50cKbv/0A7yIqBVWSJI+3PRLOhO14HvHSxty3z4gMieRxCB5hE5lu6xt6cBdhk0oUxNd/8fzHatfAzlXDYSg7XR94LdFQ/+h3xQ1a6pv+svCoMUUiKvRGwIYjuzypGBrhdc0h2YbPRpo5/QdI1FQHKD3KdZNmR9izrVMQ1jXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504716; c=relaxed/simple;
	bh=wms5EFdmMIiWR5ZDHysNaw/Plc/9NZbDhiLIGeF+b9k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UN15/UZlK0p1MjICGruvAO1Bqvy2t8syC/OdLwewXpyw99yvnm7HGt9ujgZ0VyP+qcPoVXme3WKj5aRVdTt6+iwhE1IQZrY5o4W/MnGoMf9sfToQLGR3EpZcR5/fqSyKR2GWOxQTtzvoWc4rlLnN0+ThfVYYedqFrU3M1e/JcWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bO1mu0B+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bO1mu0B+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EBD1F000E9;
	Fri, 31 Jul 2026 13:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504715;
	bh=wms5EFdmMIiWR5ZDHysNaw/Plc/9NZbDhiLIGeF+b9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bO1mu0B+OrwsjpsjCQwXtBs47DyJ5nlJ7ID4Y8o2ERql9kvwpy2ks9TnOWOL7PpWS
	 tfXhyz5xrTGaZPBAhwqoe2gi6TfrhrwSdddbONyiz//3yJo6d/n9wNo69FhEU8DMRY
	 2h1yAVPgUwmM4Q4+oo0OnlJfVRX6KRR+Qi6tJLwEMacQ5GRrpZxvke6ccdivqtgjQW
	 0E9vK5RW/xtiqxUMVR2oS2RnQY8nzdJH/WvXVwpVwfMxW13BW39v2qip9ZGFG5KBGg
	 vqGJENtCJRAg4Fi34FI6Grc18UiNuz3JAXg7lQwXG1oU1MJyewxzraHD2t5uRAZI3y
	 Gc0/fQWNSyDiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/31] arm64: Prepare sharing arm64 headers with s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>
In-Reply-To: <20260731130902.654679-11-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-11-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:31:54 +0000
Message-Id: <20260731133155.16EBD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Prepare the sharing of arm64 headers with s390 by moving a few
> definitions inside headers to reduce the number of shared markers.
> Clean up some includes to further streamline the sharing of headers.
>=20
> No functional change.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D10

