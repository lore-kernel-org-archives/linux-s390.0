Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B714ABBCB
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689092; cv=none; b=hn9pufwqVHehsTuyNymrZjpcWh73qYhQlLUqYDxmJLFFhbfPRx4WUUvXft1XxhBOHAv12vTgm/UjvlyeN1fGQK5BEIN3bMenhDg9iyDenXxOIuciBPNB9ORI2NwLJQ9E4k82ArSOqDbXXxF1I6UvD9mXzLEjTZnbqaT+kzawT/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689092; c=relaxed/simple;
	bh=feHWvxzs+HaVN3u6hejAkK8q0TpP8px5PK3ifd2Hfd0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d6unXanbECmOLvg21j2aHlNSz5nsiO05cqsCO7NLdHnK3Ub0swSdjAQJ0Bk0ojdTC3AW4hFzc7UJjQkuuJMfK9biePqPuqz/CA7g/jzoct30FWgEC9Ql/nrQXvYmjDCY68BX1eLmC5Ysl70o0ZgPM4VmFadN942TzpcqwImu+00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUUhZ7Ml; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUUhZ7Ml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1311F000FF;
	Thu, 17 Sep 2026 23:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789689091;
	bh=feHWvxzs+HaVN3u6hejAkK8q0TpP8px5PK3ifd2Hfd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kUUhZ7Ml10QDADjjcyXhaROAmXgUat4v05qAfulgS1HEF8R3+qNuQt4fXIHco0jyV
	 3YjbDoRz7n/a5eykoadj+1lyMxCCzo3onPrVXCM2H4AEmQr8m5xqLdihnLjh6qWxXD
	 0C22rUH1PdhkdnAZ+ZilYypYEAE40fvwrtbhRiehw+e7on+VXwnjtXS6xrCBKqJLNG
	 GPbVw98DycSLMNljl1lNR2bQ25IvCM1kUI5HtHpPcQzIi/2onJUQHbQXLMqjPCf10v
	 IB4PnTNQnPnrSU1FgyH6QaN8EV6CHaWv6KzdJpExC2GmFzW4mzTo6LUXuqNOkUT77n
	 acFtXgXSshj4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/13] mips: Remove duplicated syscallnr.sh
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260917-tonyk-syscall_table-v7-7-f4cd8f8e3265@igalia.com>
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
 <20260917-tonyk-syscall_table-v7-7-f4cd8f8e3265@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:51:30 +0000
Message-Id: <20260917235130.AB1311F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The common scripts/ already have a script for generating the numbers of
> syscalls file. Use it and drop the custom script.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-tonyk-sysc=
all_table-v7-0-f4cd8f8e3265@igalia.com?part=3D7

