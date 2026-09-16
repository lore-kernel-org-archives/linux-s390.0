Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B174A206A;
	Wed, 16 Sep 2026 21:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594989; cv=none; b=hJ+FO68pIG+TrP2iF3FKwwm0N2L2nSe3QljUnOoY8AJA/r+gPlRCs0e/V2HsuNiB+E6Qy5D+iyfcOueOhTLwAzvz0ZYLXIrybK5jOkPg23PPq64J4+ylGNd08DPicVomFKpZpcy226C3yv4PIRdNcalY6oDgitUT1TStzslQ2fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594989; c=relaxed/simple;
	bh=Oqce4SRhKmhkrAfseNI1uRPbq8ZPXHuHglKx1WGEbwY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=stMVjcBmcdHJSqIcvkyFp7TeEerWbuN+569ytuJpSMdtImlLKHUItdk+NxlYICaJ5HY0J07r8D8idIMGgDEpP0+CWb4ws8baNJQ0xGX4qEnkwuvTV+njZtu8wo0oQSnwhxIrAoBCnq6OISDHQfzTgWF69Ttw0vQdhhR5Ol3bGHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGFFk+tj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGFFk+tj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9E61F00893;
	Wed, 16 Sep 2026 21:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789594974;
	bh=Oqce4SRhKmhkrAfseNI1uRPbq8ZPXHuHglKx1WGEbwY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DGFFk+tjEmPKvMUopvhBrFtvP0u51Ac1/LlVl5qvYSqffvyAwwi3CCoay4U3/G8UJ
	 h1SmwU5hJmZhccGWSviU9ZLoV+a72tR0iwOpKR6I7x4VUFkGMl2DMVczhoEIO2FfGc
	 kJka6Pux67izv+6D5timS+uEPyf7XGTV+CI1zP7QUoS9ls6Z6Bt9N8G0YVj9h6GExH
	 XgqkbKA7x6S8n9fbXWiUfbUiR2RNRsPfzHCy06vvTapuxRdKBmmggl9SauM0T1jtB+
	 tG25V86oDKqLwH9L1FKsRreB3fXjqovKrqJ/1y01+FDAC4SQNBpvYZA91iStFuJeMU
	 o8bmhwcnS04sA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/4] vfio-pci/zdev: Add VFIO FMB device features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260916213222.233-5-oelghoul@linux.ibm.com>
References: <20260916213222.233-1-oelghoul@linux.ibm.com>
 <20260916213222.233-5-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:42:53 +0000
Message-Id: <20260916214254.5E9E61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce new VFIO features for zPCI devices to provide FMB passthrough to
> userspace.
>=20
> Allow the user to enable or disable the FMB using the SET-only feature
> VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE. Likewise allow the user to read the
> latest FMB using the GET-only feature VFIO_DEVICE_FEATURE_ZPCI_FMB_READ
> in the case when the FMB is enabled.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916213222.233-=
1-oelghoul@linux.ibm.com?part=3D4

