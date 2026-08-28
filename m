Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DE8392836
	for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 23:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787959667; cv=none; b=Ueu2fOXbQ62s3RVlZh2Jxgr9vclJv7zhDlat+A+bDa+lOpq0SJVhFaPdBSxZd9SCbdT73zEqjTxQGH6uHubYcLeHSfHGxQDdfcixgzRt9WKH6Aposk+8ZNLYP+wM/NVTzo+qsS/g6PtEm/h82CoYVwGZUprIkzyPkzQM5oU5jWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787959667; c=relaxed/simple;
	bh=ZCP5+SaCBLwziEzJrgKFFm3Diqe48PtWKmldgHa6In0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EYsl8VaE0emQwI1iKg8btCg8OleK/B4kz4UfmOmcJBxdz/TaWRJern+StyF8i+JGp9iwIViOiHNJ06F7VLDkQVZqmbDi850Syw0Zm+RuLYnlUzJCrtWx5qTjK4IIiuG6sf6PQvIVRSiyJ8fGounyxkM2AIEjQMb1EpzMzUD+1mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6969YpR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6969YpR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F401F000E9;
	Fri, 28 Aug 2026 23:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787959665;
	bh=ZCP5+SaCBLwziEzJrgKFFm3Diqe48PtWKmldgHa6In0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n6969YpRumVegEZphTxYzxEtCoEOC5heQVRC7ZihRTkS3iHZQtBv4g9m8bY5/0oEO
	 JctaDOf1PnmCEPWSs3SDzcLqDHeaeGjgu+J5GzenG2mY2fsjT2YKf75kBWIKfFruos
	 O1ASQBeIS2azQ10qHScYSDkVEfr90QNsTQC7aP/PdyuAsPgWfgwUsXjkQhEtMUp7yC
	 9mpEsEEm2m3nW3D2JVYlY/pBsIxv9SATAQYf3dEYwL4vxYwVHdk2qyo2hEArir27ky
	 p6Qnem5wjUm/DYKlvSrm+lcKRoAf/SpAVqss+q3CMTeRLF7WEPgNTjAtP5nyfuHNWO
	 k7ot0qvu/MQjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/13] s390: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260828-tonyk-syscall_table-v6-5-fdd358456cf1@igalia.com>
References: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
 <20260828-tonyk-syscall_table-v6-5-fdd358456cf1@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 23:27:45 +0000
Message-Id: <20260828232745.74F401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Remove some of the duplicated code by using the common syscall number
> table.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-tonyk-sysc=
all_table-v6-0-fdd358456cf1@igalia.com?part=3D5

