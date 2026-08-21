Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FD92877DE;
	Fri, 21 Aug 2026 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342620; cv=none; b=LgiZ6/7AGynhfKTdM71Kg2BHElupcB6N8ookiF4GxDnYcDQqwmsYE6/f7fwvkV7AGYh3dhrOTRBqw91LBPGnESFdAtclRfoyx1NvsQ3ZgeSp23Mye7Wk4vIy8onVwGwS8FJCEwlOmBBRoVx5z8cvFY8DhlqaifHJ7qoltK1bUUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342620; c=relaxed/simple;
	bh=Mh8t0IJDTt2QD6YqGm07omieEw6BhMh5dSbgea4ogoc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KvxVORBxmeoA+WSSYIR99U999pT7/RWTCv6iBhTiwGCsQIZ36LEtXLbYZLYpDyHM7nwS/tXJIWsC/XAJ918WEX1xc39MNTwfJ05AjfewrPZTe9k1GwjFG5eTwdwJ4MDSCjwo35bTAty+G10q8HsoM3loTs1xEGzdUWXhjLm2t6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHQ6ZZqR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHQ6ZZqR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AA91F000E9;
	Fri, 21 Aug 2026 20:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787342619;
	bh=Wuu+DIMINXOptVDWSSqZzvaWBvUXAWDD9QqFtvqXdKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HHQ6ZZqRLh/Byu1c1bGvdgtHmr5TtrHaUTim5tVC9Z51Oug5hAg1nSih0A47c9JIU
	 Zrc9NmJzrly91+HPBqsqFO44zvqtJBLIxyvSaiDPsPL0lnc5E6ub9ny9pYuxmIa2Hz
	 eNvzGh1DyK11QMm2cNyv3xlDgR8V9EWWQE6u/rTIH5n0aAf8tE6XBinbkKRNBg7II0
	 3m0ykFyilI/+GIek9dQAqSOA5KF1XBGaCOhfm1ESxBqO+Je/7Vo/J9Q/h6o0czpe8n
	 nPY3inGwZEN6r46KYk+a8GpPwbKY0rNGP8F/qXz/yMYP8XR0hA1eC6I12y3GFV7Uyi
	 ncKxYDy3lvHFA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 05/24] unwind_user: Flexible CFA recovery rules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-trace-kernel@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260821195259.2688377-6-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-6-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:03:38 +0000
Message-Id: <20260821200338.B0AA91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> To enable support for SFrame V3 flexible FDEs with a subsequent patch,
> add support for the following flexible Canonical Frame Address (CFA)
> recovery rules:
>=20
>   CFA =3D SP + offset
>   CFA =3D *(SP + offset)
>   CFA =3D FP + offset
>   CFA =3D *(FP + offset)
>   CFA =3D register + offset
>   CFA =3D *(register + offset)
>=20
> Note that CFA recovery rules that use arbitrary register contents are
> only valid when in the topmost frame, as their contents are otherwise
> unknown.
>=20
> Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D5

