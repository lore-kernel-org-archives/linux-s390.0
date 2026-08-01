Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964302931F4
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785607561; cv=none; b=jwt/Rt+2ISkGuxT4cpRVcFrpN0d2VTl9IA1EKyqMbZPKIpkGsz4kyUIdVLKmAfuQ+4eaubP5MkJobxZul5vrpdj3uDaJ1OTIZp9TkuTzZ+eBVX32bXkWCILvLSso0g7b/61tjZf97PrB9XzsT84IwzAuHSywgSg+OvNdm/0Zg3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785607561; c=relaxed/simple;
	bh=sRXpdDLVGNdqL7rCx/jI0V79bz4l8HJA79ktiCLcbZg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ph+XTErTN8tNryLiheuisOIfKJkRXJRKw8fF7vtTFuJ+BVUiMk34eibaOlsdTBi5W4Yx4sYrhoJ+a4MXO+UcJZ3B0pJRGeXiCF6nZoRXlWXEMgHsHTaoIyzh8dMio1kUs2ql4mb75Vb2Hx4WVnpu+Q/fA/yT+3wSHOs8+Bb2Mo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQslyfXW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQslyfXW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94F81F00AC4;
	Sat,  1 Aug 2026 18:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785607560;
	bh=sRXpdDLVGNdqL7rCx/jI0V79bz4l8HJA79ktiCLcbZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fQslyfXWOvOZoFWhHqedgw6G7FJ+skXv5hLLfKfoPTuaMNdz3nj4SwQW2mUDgdE1Y
	 4PtX8z7WvkR1t1Odaji4ZueLmcXzsaKFG2rBlHvj7W5wXiIReY3Iop6Qu89Q78NYQ7
	 axkrJmWUR6XQZsPcBC8uHbso7CbvTp5qJ/cgSz3xMXa8zJr43PVQ3vMYrxQgrhJLJB
	 xPot4wqPpb31PqVTHw5kIwVkyGdHGb9YmmZdbXUmcybM6P/cM619hi1Hm5lLGxANmi
	 l+oE0kgDpTCwX2oiCuMX1242k+Sd/JXRnHVqgxP2igLz89lrz2OZCGvsKSI+/2VR1c
	 Et9+t18CBpoBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/19] s390/dasd: Optimize max blocks per request for
 track alignment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260801180033.3679412-6-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
 <20260801180033.3679412-6-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:05:59 +0000
Message-Id: <20260801180559.E94F81F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> With 4096-byte blocks a full ECKD track holds exactly 12 records. Lower
> DASD_ECKD_MAX_BLOCKS from 190 to 180 so requests align to track
> boundaries (15 full tracks); full-track I/O is more efficient than
> partial-track writes, and 190 had no alignment significance and could
> let a request cross a track boundary.
>=20
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801180033.3679=
412-1-sth@linux.ibm.com?part=3D5

