Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333071F427C;
	Fri,  4 Sep 2026 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515219; cv=none; b=CHhcVQ+qntVSij2ZQkUGsQbnDD8wqw51TN7FcpTd+V+4RB4u3K7r36Kd7DFWU03W0Ai5ciEWAxjrQHlX/GGas5gXwQC6wnt+gxOkiWv98iDHRGMi+lwS6qfalvGb6JZX/M6Tvi9ViWQF6GS8ywTBGpl6OFRWmbLQH1+O2GFVOF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515219; c=relaxed/simple;
	bh=gsAvaXf1b7lCyVOWlZa+y3wboQzpQjT6PJ6XmoCdE7E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fU8J9KQSvnUU8jbZtgM+2WiiLH06WyvxwQB2XAuOJ7BCcmwzNZJhNQQnl/gWDO3goY2KMV9RsCgfFOiP6idgmiL8ZTgC4GhVKtzhSP53r8qb7qzNHkio7WnVv5sS1BQM6Y4T/DxgV57gnq3UNjYVjyRuqp1MAyNTT8mcxA8czug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGTKf7Z1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGTKf7Z1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7128F1F00A3D;
	Fri,  4 Sep 2026 09:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788515217;
	bh=gsAvaXf1b7lCyVOWlZa+y3wboQzpQjT6PJ6XmoCdE7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hGTKf7Z1QxvxRnWUor7/rYi+uwL/RbKZc8iKteH8fOWUdgMX7bJNYq1cx0AavwVrW
	 LVlhQe5iqvbwLmj3FxnbzaQMvr/zKysRcKk1hW42jx+pvBFGYQCXw/hsypFSNALMuI
	 5+LVPv0kuSVDOa0vpwlWsbL5uz3BYDBtRv1IaCiJgrBZCUR9M+XJzX8OrcvwWiXjBY
	 mrj/JASP2VE+LR/OQQoZDwD6ll2JW40DRkIkPWAN0wzY+AmIfd9rGF4/9Rb+NN/ckp
	 E61B+Z45wz+JmuGHYe/NrDjMfqjNf/R1Qt0cV/7i1SYYnPiFpFwe0Kt0uOBTiEiT4l
	 w09NiKUIxlU6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/5] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap
 size in vfio_ap_mdev_cfg_add()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260904093435.1161402-5-akrowiak@linux.ibm.com>
References: <20260904093435.1161402-1-akrowiak@linux.ibm.com>
 <20260904093435.1161402-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 09:46:56 +0000
Message-Id: <20260904094657.7128F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Domain and control domain bitmaps are sized by the AP_DOMAINS constant, n=
ot
> AP_DEVICES. The two constants are both 256 today so there is no functional
> impact, but using the wrong constant is inconsistent with every operation
> on aqm/adm bitmaps.
>=20
> Use AP_DOMAINS to keep the code consistent and correct in case
> the two constants ever diverge.
>=20
> Note:
> This patch was submitted in response to a sashiko review comment pointing
> out there are other functions besides vfio_ap_mdev_cfg_add(), so there are
> fixes included here for those also. The subject line was kept the same
> since this is in v2 of this patch.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904093435.1161=
402-1-akrowiak@linux.ibm.com?part=3D4

