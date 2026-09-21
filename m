Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430AD48F015
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007598; cv=none; b=bz3iHWh5RGSNmNVjQmTJZ4NEFUWf54bOSTWbqQrSTEiXMfaBAFWd/dT+hpcyqX+BA+D1JRul2oB2WzGwRas88/QG8OI/VLDG/9Nai8okungzgT/9J1/2BobRR84QxqABWfI6Eaeu5dU/GotiM9GNpiZoNa3jEik0RWOwJcdSWvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007598; c=relaxed/simple;
	bh=msJhQ8bUTmB04OzqewDMItQ9Jdj5/2Kqce/JNI1/i9k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fZ6FYDj0Ua6zbsBn5/43sOUyQeW1/2qT3zw8ahhQpDqpHCI/aVZRuWAwDZUqiTyEdvHUdxeaWIT/1a0tIP9QS4aOCnXjQI54JByYYtltQHHvg1IZZGL7vTi9BGga4JCMBqJR5xAvlnHQZgHtXdfwEDxua/MEreU7LJHjxq5YX8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4WQ+RL8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4WQ+RL8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8CC1F000FF;
	Mon, 21 Sep 2026 16:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790007595;
	bh=msJhQ8bUTmB04OzqewDMItQ9Jdj5/2Kqce/JNI1/i9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i4WQ+RL8YngmKm1F4f0cKU6BF++PlBOyUhmUzjuSJBW8G66OHVOHpGR7U3GPkHt2K
	 QMlFJTStt8NRg9uIWjjuotV4qoMgD6Spb75Dytnn3T6ERQgz6pTmGY1zF6ZD0W1uJx
	 xIHgiAkCd3QNARQQtncHtngjOzD4/RoC8h3Ngxnp8qCdfIlN9QU7hXQNtwztOJ5JS6
	 RrKP0h82kN9FySsTq5Y2+VMAVkMVpykQfuu69VtpIeUoBl2rIeRzl+NhVHpVO3DhFY
	 WcIp0LbT3gFhwJN4pXckoVrHrgO405auGRqf6bPVeNaCsG8HVlO1LpcpC7m1RX4zEl
	 i/2Ag8aGmcVeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/11] s390/percpu: Rename inline assembly symbolic
 names
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260921155806.2447506-7-hca@linux.ibm.com>
References: <20260921155806.2447506-1-hca@linux.ibm.com>
 <20260921155806.2447506-7-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:19:54 +0000
Message-Id: <20260921161954.9E8CC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Rename percpu inline assembly symbolic names so they match (more) what is
> specified with input operands. A trivial change which is supposed to make
> the code a bit more readable.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921155806.2447=
506-1-hca@linux.ibm.com?part=3D6

