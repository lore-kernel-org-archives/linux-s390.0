Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654D1484222;
	Thu, 27 Aug 2026 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846525; cv=none; b=kvKtAURcxnGHdv8oOQKJYZhzJfLb1cdfWosjeIJdaPG5Xm1YAdqaspymFsSIWSlB0c7PNMgRHmecYLOktfyOIYJdE3vxRkwKvDDak/msvTvBUUA6wgA0pGWK9ZKu1lFvZZjp/oSiTG1qvfZRgRyF4uMF0hYqzd7tgbNQH+RHKtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846525; c=relaxed/simple;
	bh=RwLasunStm/NgEmIMdOZInVd67jWFtgsLOMkvsvvRjg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ewQCvxvjsXkkVSl//YikTU/M7cKJTQH7xNFGJH81knNO2Ua0yjtrCzEcIJo1uBJ9ZY6pdPg26ejWT9lv2GDotF/VIMSieDXGTatZrcXoc1C5EDp4nIxQiWbyw725HEkrnlviAUXdjs4FTgD5d7MOWdPAKqgO9Hb4zBmAJ0UqZz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgslQE63; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgslQE63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE39E1F000E9;
	Thu, 27 Aug 2026 16:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787846524;
	bh=RwLasunStm/NgEmIMdOZInVd67jWFtgsLOMkvsvvRjg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OgslQE63U8FK/PdwO/ZMKx0d1aMMIMAuWE9VCthDhnDDhJ6HnwcAHNnGQQNXQuCHb
	 Pi1Ibc7ZfUsPBmCxc7eIuITv6tBVg1WF3XoiaVt4zhGjyCBbgxAid8plpL/hEb7DHB
	 GvgsNyNdm267J0hnhsFgzFKcnsRCHrxMtSB4FugfYCxkyqSlHaWWi+qvdym99L1TNv
	 ndewrKp8h09dQjlHBeEw8mxP+tvqKWe+cO57sAxWDAvukhwncvzGlCCBLF989KcB/w
	 Y65B0KvVts1rpf0QD1w+SjXRR4nTxR0cg3RC3qze2Ea/10zGswEHHhn/7xvL4ADTmx
	 hgrmrma8sLlMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/21] KVM: s390: vsie: Move pin/unpin guest page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-5-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
 <20260827-vsie-sigpi-v6-5-8020bb53be52@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 16:02:03 +0000
Message-Id: <20260827160203.CE39E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move {,un}pin_guest_page() up in preparation for the next patch.
> No change intended.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-vsie-sigpi=
-v6-0-8020bb53be52@linux.ibm.com?part=3D5

