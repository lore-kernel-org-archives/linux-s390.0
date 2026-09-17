Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650E73B7751
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628968; cv=none; b=EDkSldN8y46R5oNsSMD5BFvSoZ3OZ3G8G/usygvoTgzNjIiLkHj5rC+K9ONuli1B9k32DR3Sp8sAbVmWBaXbyxXVZmTZJ3tNAPDHKxU/3oSgMxtfNRiIaUylY+u4n6hVuC5QOSlzG+cvFcFjqaDtzNgUrWWTNh3P7XL4JPdH20c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628968; c=relaxed/simple;
	bh=Y2x+6rNogkQEnF8RzNc5/f6HiAPI6DOk65q3yHK2n9c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KUb6x3GZXkWvTRrnafHCLqV3lNU3dSTrWH2qLqSkBjHgGCKq1CUVejKoqJ2oZEqk08czsSZKPsT8nd1kB5/2uN0D5lKRk+gereA0X5Q5ZQ+xCLqxp3x75k6zV6YljhWKwogYrDuQD6cZl/YuCVNKvSDJGsy+zP5CRu07pYO3gW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+I7kDAx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+I7kDAx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77EC1F000FF;
	Thu, 17 Sep 2026 07:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789628967;
	bh=Y2x+6rNogkQEnF8RzNc5/f6HiAPI6DOk65q3yHK2n9c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X+I7kDAxm5MATojKRAr1klh0FMj+pQ9H03phoiYKAOpcooVScnX+QU4e1o5PsGuMN
	 hSGuZk/FQEYKCoxCvt5u0mZH6J8theVDTps3OdbtqL1IyOT5VncOIzyZr+nrXDPNBN
	 aCiWh0EpE+pszta4H5E/2Mcb5ATmi43tWabCB5xJ35cs80305tk/JwjvxmOP2HRZ2n
	 Y3S56AUCdeBcyk7z7qLdIIJGY5gtOP5k0FXriqtF7FIQZGjidBssilGcp86hksz6t3
	 wSUXqzmUKivjwyEOWKSYPx3VDYryDSgoScwNhXMHL5HjBcCt5auGSA9Mj0PSRjN8V+
	 V/sO86OfpyfrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] s390/sclp_ocf: Fix computation of length of GDS
 values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Egorenkov" <egorenar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260917065824.2858737-4-egorenar@linux.ibm.com>
References: <20260917065824.2858737-1-egorenar@linux.ibm.com>
 <20260917065824.2858737-4-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 07:09:26 +0000
Message-Id: <20260917070926.A77EC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> There is a potential invalid read memory access while extracting
> the HMC network and the CPC name from event buffers sent by OCF.
>=20
> Both, the HMC network and the CPC name, are sent as a GDS subvector.
> A value stored in the length field of the header of a GDS (sub)vector
> includes not only the size of a GDS value but also the size of the GDS
> header. Therefore, to obtain the size of the GDS value only, the size of
> the GDS header must be first subtracted from the total GDS (sub)vector
> length.
>=20
> If the length of the HMC network or the CPC name is less than 6,
> then the total length of the GDS subvector carrying it will be less than 8
> (length of value plus 2 bytes for GDS subvector header). In that case
> the memcpy() call in sclp_ocf_handler() will read extra 2 bytes following
> the GDS subvector.
>=20
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917065824.2858=
737-1-egorenar@linux.ibm.com?part=3D3

