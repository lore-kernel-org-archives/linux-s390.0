Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40413AAF6C;
	Tue, 18 Aug 2026 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065226; cv=none; b=NsmwGGAtlI1uZxs1MlbIeusC8/SxqEFwAedHsSyyDTpUUh9IQRe3J7BatT4JDmSE/xS732vg0lCdFSPbWgjPoUGPJv0nyEYvzje30hU2VCyWZmQx5Mu2jnxTm9Cmg7Y5kv0HIbbS0U6ja5Tw3IlHVBxD/Kz8HMZBUDMbKf7Csjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065226; c=relaxed/simple;
	bh=kW2NapbBU6W6PVXNx8ESAZ/LZxBFhWjgoZlb/rrmxcg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dwYln/+WVYp4up3B55TD+9gCHdVaZwPwSwCV+GRJR8sqxu+Af02nVE1kzzriQNqiYOgiDLbP0AfUov9WxUr3OBtpEEFmskTRSuROtuGF030QneNCbj11n5XZYL3GSk+hSbvKqDxESoq/2VKM70uFPTliwcBMqA171D4pb7t6+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBlKfzd1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBlKfzd1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319A31F000E9;
	Tue, 18 Aug 2026 15:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065224;
	bh=XHB2GTE/WtsSIFLYaWSOHAJ4gVW3a0sRdjh1Ad81CKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cBlKfzd1jSo3YnK6z/wsvf9D5N9AhWRkugKoWWdpxQpWBYHP+zStoDfGlUNEGql17
	 rBdU34LkEvYhsFfLYdoYvqDL7rvkUxMt47ffZ8fx7kQqAn37rxwpDkwdfQNEhGQ+3o
	 OZehC7QlWO/em4YpOd91KSZC5J12z12JziBdtWXO++3OTyaKhPDvEIB1rFICtYkq0/
	 iOWuAijS9JNWNMdBy5J+w6GdesCRNlxvVnX8FVYrDZLkRImiJQSjCs36mOHm0/mqhD
	 cJ3UCjRom77dodQ1ZjLOtt6ewbRfJnO9XxBXvMtvlag7k6caM62oKwdXSJiYOAqtwV
	 wchQs1DmFaOeQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 13/25] unwind_user/eh_frame: Show file name in
 debug output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260818144954.2320378-14-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-14-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:00:23 +0000
Message-Id: <20260818150024.319A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When debugging eh_frame issues, the error messages aren't all that helpful
> without knowing what file a corresponding .eh_frame[_hdr] section belongs
> to.  Prefix debug output strings with the file name.
>=20
> Based on Josh Poimboeuf's, Steven Rostedt's, and my unwind user sframe
> implementation.
>=20
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D13

