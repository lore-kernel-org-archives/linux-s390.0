Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0361E2931F4
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785607555; cv=none; b=SsVsJLgBaPTRc8xQPi4JoWdLuC8Jl2RlO4GJA4R2zvBt18utOV8eixfkCCLhE+79XHRlKo3ZB/Tyx8TEJ55CUfV0BtE2Xr/ZHcNNJDVTFJPDY1IorQTxEdcoictpgzQxFKtmEM7Uf3fxFMftxXYthYCKlUFQV+8DGZ5acsqcNjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785607555; c=relaxed/simple;
	bh=b5zjadp7I1a9nTmvsckyjcMQ1ysqPan54WcC9IerX40=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GuPdyo97sldS6/gWIoTFvPNd/tI83RZRpy0XQW5uVuyi+mnSiRqDjMEW6HkqDVBiGqCjvuIY4ECQXqI3RZEFfIeM3LNNeul6/XGtg5CuTdsWmqsluUPmka4HCkgBsyg7zxonmx09Am2KzIoZgXVLZzXdzu8OAylsqaicaSpm508=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+u+fH/B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+u+fH/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538A41F00AC4;
	Sat,  1 Aug 2026 18:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785607553;
	bh=b5zjadp7I1a9nTmvsckyjcMQ1ysqPan54WcC9IerX40=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W+u+fH/BbNJvJ2l/vxlpW9Y9UPdVIzjsgj9rtkRWdWXTl1fNbp+95Jnfc0YJ6QABx
	 Irpt9Soi+wCunHtw5p9CH7TCP9NBxQ5wtJF0ZD1AYa7p3u1jmGsiUFBoYBPnnaMWCN
	 Y8Z5h/WnOBxLah5iz+DBTzwH/k4krSM+vh+WndJePAz22Sn2ERnh2soL8Qgaq6NqpB
	 6ktDKoJZhTbVXBhFz/qsqGCvqN9HobGwknb7X6VlmGw/abLqH93bIlbbBGuNJVMSG/
	 RJnaDqLilBjmGImtsH5Ttt4M3Ar8G/VgLc66nTyFa9BYD7h9TnXd9JXCHFvDhD42+8
	 snDpC7m2CAcEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/19] s390/dasd: Add defines for the Extended
 Address Volume track address
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260801180033.3679412-8-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
 <20260801180033.3679412-8-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:05:52 +0000
Message-Id: <20260801180553.538A41F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The track address of an Extended Address Volume (more than 65520
> cylinders) carries the high cylinder bits that do not fit the 16-bit cyl
> field in the upper part of the head field. set_ch_t() open-codes the
> corresponding shifts; name them so the encoding is explicit and can be
> reused.
>=20
> No functional change.
>=20
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801180033.3679=
412-1-sth@linux.ibm.com?part=3D7

