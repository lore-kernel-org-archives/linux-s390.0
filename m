Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5304E4A012B;
	Tue, 22 Sep 2026 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107182; cv=none; b=LQP2iXOXdLOhG/sB7KFtYfb/B+xKRqHfmDYHGxuc7hkJ/X5As/ovUYw1AzdHwI7Pe63r8GSJyg3DDgISHrDBEcs3PF5AgYjKEnwa8L8qFKpFNRQyeK0eIhnm+kLk2HnK8S5wQ6DLYNQcUQknorCPNYtRhb/HjGsuWmG/DpiB0sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107182; c=relaxed/simple;
	bh=YTPhlQNkq1T9bsvrhvGjB2tNMScpIQ0CHGb7rwV2cng=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d9ttrIeBdF4lFU8EyRXtB/0X4KPVtdAhChfpqkz7qHdg4wDMdMcbYIc5Q0gxFCkYlTWW7F+0qh/bYm/TYUFpBlYDPntyWHaAoC1Psor95JtWQUjhxG00t+hBmt9VHClDVosrazzqrYXF9HmkNqvoKOrm/spKzPzgD/m9uEbPYAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvAUi3Vc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvAUi3Vc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FA11F000FF;
	Tue, 22 Sep 2026 19:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790107173;
	bh=YTPhlQNkq1T9bsvrhvGjB2tNMScpIQ0CHGb7rwV2cng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FvAUi3Vc2c0W79aKEGDQF0t8XBGu0bFGgs/6d+plY/h7vab7Ur9IiVKx1l0F8J4Pn
	 TP/vkZyxGXd9XjqKYSc2Z0zNkTD7pYfIbYaPc/bWZmpy+YDYWHGSVcNyqUY867FmJ8
	 7m4x6TPMhLZiahqhtqYDbP8QJEaQqAFOkPd49ifsuzSp9eln3BFDTTEHHEPQKZzfWG
	 Jw8bXV33TcMvZJiyqmAzmzEX6YruHO9aPIen6o8+ew2JvVfC6nhEPBNkFCDR/rXSAY
	 sn13N1ByPvqwMpkozpKyrDLu22hBOel9IuJZFAKAZycMg7Ylllz3folsMEqyxcw7Oc
	 6cHRzvV3c9jYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/4] vfio-pci/zdev: Add VFIO FMB device features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260922195141.94548-5-oelghoul@linux.ibm.com>
References: <20260922195141.94548-1-oelghoul@linux.ibm.com>
 <20260922195141.94548-5-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 19:59:33 +0000
Message-Id: <20260922195933.70FA11F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922195141.9454=
8-1-oelghoul@linux.ibm.com?part=3D4

