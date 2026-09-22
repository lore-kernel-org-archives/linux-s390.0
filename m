Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197954AC15A;
	Tue, 22 Sep 2026 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107348; cv=none; b=Aq4ZGL51eNjSAbYUyqBZM/Dwp//JhCkelp7r0tG7CTePMb4BjQD6F5Te83+Zum9Q+j76nACqNwIMth0eqTAgBBDq3lQOlafUyVDvrJdts+2Mzh1gIBpqx7W9m/9sH4u8eWg4Dhxp7+wMALiuYI4tc0oBxlWzycYJXyhEatVxMNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107348; c=relaxed/simple;
	bh=Ri6lEotMdJg/cBWl5GLqBVpYpWOapHeJLYeqI9PU+UQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h6aiMKtltqe2ut1j4s8dK4+1bslnVTIDX5DdgKgsqX/XklpOq3rMYaVDDWYxra0Ml3ZGl9s9B3uT/b0Q+0zjIkBaV53KpP6yN8R0yLTN6vDFxAjlbWhN3lASK4J7kOmUBpFGCASdn1/GVy70pfIVRZiBXgWdAQ/mU3IsLWYrn5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl3svsqQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl3svsqQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157BB1F000FF;
	Tue, 22 Sep 2026 20:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790107335;
	bh=Ri6lEotMdJg/cBWl5GLqBVpYpWOapHeJLYeqI9PU+UQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hl3svsqQQoalQTSYhBSiuGrLw0RVR/Ldm1vaimRd2s1qJCi9u7qpzTh7u1Af10oa/
	 MVwxbu4jNGWbrqwyCO2KDnJ5nF6Ge0NO8c5Myuaaye0ieHtH8pVbQsmivKX6QJ3apP
	 pgJDxGmEhQkoTT2HBBq756xuMEqYeRa32ORcDfZgqJONUplj8/B50C/Iewx1wPBu7K
	 3uYMtRbFbagOWjsbf46q2dTXQ4GPy43iQXjSRT6F1bEYTgXTTQzXlVwtzpgOdV5+wi
	 rS1+0iCIUWw4idNFXqoDqGxkWSfxEVsFjlgxR0q7p+Wtrx3QhvDgEOEkv4ntK+tqjV
	 8bqo0hyCYIiMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/4] s390/pci: Reuse FMB buffer and preserve state in
 device re-enablement
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260922195141.94548-3-oelghoul@linux.ibm.com>
References: <20260922195141.94548-1-oelghoul@linux.ibm.com>
 <20260922195141.94548-3-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 20:02:14 +0000
Message-Id: <20260922200215.157BB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce the function zpci_fmb_reenable_device() that checks the state
> of function measurement and ensures it is enabled. Reset the counters to
> zero, disable, and re-enable the FMB if it was already enabled. Call
> this function from zpci_reenable_device().
>=20
> Don't free the FMB buffer during disabling and reuse it when re-enabling
> measurement. Instead, free the buffer upon device teardown, allowing the
> same buffer to be reused in the enable path and add the bit fmb_enabled
> to struct zpci_dev. Audit the only consumer of zdev->fmb and update it
> to reflect the change in semantics.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922195141.9454=
8-1-oelghoul@linux.ibm.com?part=3D2

