Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A038E51477A;
	Tue, 29 Sep 2026 12:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684855; cv=none; b=mM5zrKTtu/241boehQXWqD6I7TagaKHx7kRHqXzQ5twQPX8BU8cTVjsitHSLiPJImiLHzlw4eVUxt+TtO7UadbHo/FaQ6FsxtsOSJLZnL3si8asBzVG/Dk804TvINd4zVdj3yTwu2Uenqj+hsm2i/VGzazMp2uRz2+V0ZP8Uyis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684855; c=relaxed/simple;
	bh=0Icw2G/posV0O+108KT+jqWD2lzCM+PvhD5tni05zAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=czk/0ZHCaeYwR0SFwSq/3Uzp2yvm2faFfImZMTt0U9qH/vsY5Gpsx73+wxMceVCa9ITlL6VCMOWt8jda9DaFmUF74I4UVKPEzXN8iGDaQpzW/KRk1ddEmrhKtWN54vT7wqnLtqH7RUodAlhi7QJfRTM+O44yk9YhJJqriDhFbBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnhsW+AI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnhsW+AI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CE71F000FF;
	Tue, 29 Sep 2026 12:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790684853;
	bh=0Icw2G/posV0O+108KT+jqWD2lzCM+PvhD5tni05zAw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fnhsW+AISiKPnIDKPTS0ENxTOr/5ma4fHD0/o0Dc7BHNzOqMoyj9+tzOCKejGgNWM
	 sLfmCKn+29pPQGcyDh946X53vRzL8dgruieSyCXblXe/i1Ax3JiUb+6U9XUZ0u1DB7
	 g1j3yOQlIn0lSky7fw9Ld4XdBdckwm4/EsltDW6g3L8Xz9K9Nd6+D5i6iLPXYYUfWq
	 biyKLF/foVlxj1kYvuLlfCHqNIYYreRfZ2MDK/2eZtZAKa3aCZv8vx+1uUP//8bBDa
	 iSMYahZZfV8kwLWIDEVrEdokMv5fx9Cf8gisr048bPHu3GDoOfRN+KfnXj6uHMgrKQ
	 zGWcDSY4NykWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/6] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap
 size in vfio_ap_mdev_cfg_add()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260929121837.2715710-5-akrowiak@linux.ibm.com>
References: <20260929121837.2715710-1-akrowiak@linux.ibm.com>
 <20260929121837.2715710-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 12:27:32 +0000
Message-Id: <20260929122732.97CE71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Domain and control domain bitmaps are sized by the AP_DOMAINS
> constant, not AP_DEVICES. The two constants are both 256 today
> so there is no functional impact, but using the wrong constant
> is inconsistent with every other operation on aqm/adm bitmaps
> in the driver.
>=20
> Use AP_DOMAINS wherever domain and control domain bitmaps are
> sized to keep the code consistent and correct in case the two
> constants ever diverge.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929121837.2715=
710-1-akrowiak@linux.ibm.com?part=3D4

