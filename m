Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1B13A4523
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851591; cv=none; b=KvcLogxeDKaDcnIP20upQCYqfdqFF2r+4CVLsb2V4kEaZf/jJvzWYgYSHX63IeybTmCCF1jw3nvrBTE3edtfrNi9EQ8EpIBNHkzH/WEBmYy9wj3fDl8BenrzTEntbbJHDrW7sS6QN8v5mzaQ9YYXo4bq0Lw9MZOdRGU+19gXDwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851591; c=relaxed/simple;
	bh=uqlYNvw8MQYl3YRZHmWK/T8LHjO1rEi1jeTvyegBNv0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VryKaBU1wwmyOTXwS7kRd4rToC0EJjvMLNME3dOyA7CH4xxFAkdt/d9ypurWs5U03AHwvI7p/T11c/W1d8VUV24BTmjLGsd2F3musdiC5haTMy8+lP9pVuZv8c3ZvZl/UBA9c+jNS1q7Lrooe9zKQIX/gnqZ5yhrb9gjtzNWCuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WncqsXpI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WncqsXpI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB3A1F00898;
	Thu,  1 Oct 2026 10:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851590;
	bh=uqlYNvw8MQYl3YRZHmWK/T8LHjO1rEi1jeTvyegBNv0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WncqsXpIGn4QP7fdXPJs01Fx9k/Z1uU8gFsQF4XSr9xbQb0CV3lneNs5QR5Ik+NFZ
	 3uX7A6RmJNemvIbNAexFLmvOxOJ9AQtW1j3uK0UDzOof+ZmrflirY/fS41euUYF+Z0
	 egi+2wbBg/7Pny8UCmH736+iGoSLSdlyatcUd8X51zMR3ouJP75OxEEtYxxQ4gyqh+
	 ckjlQPnay/AJ+J01xTNHl+hckl1ev3335EjuE2tL3JUj053/0BIkcdTFH7D/j2D9Z9
	 PJgtBrjCsCKKCXqGuq8Fmcayf4JQA0IAzZoI7dX8vq0JGIFmRwH71MhbRCyGKhpxI8
	 C7ZgmD3A1/7rA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 27/32] s390/cio: Convert inline assembly to
 EX_TABLE_INSN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-28-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-28-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:46:29 +0000
Message-Id: <20261001104629.ADB3A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert all cio exception table entries to use EX_TABLE_INSN.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D27

