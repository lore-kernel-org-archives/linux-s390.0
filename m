Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872F74A5EBC
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851262; cv=none; b=Hwjrn3U6Qa7ko8RgZT8ScTybIQMNghL3w5h1vlRjorRI/Wf9913KRqHYyI8ZaUWPz/9oF1Twna7gkckGvbSfDi6BTFHc7qACRaoeZcuP6oSVYlKZ+caSJYEQl8Sj6D/buJtbPtAmvuOmqs/Ot9wfOmzmoxmNRls3wqmwZb+wHmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851262; c=relaxed/simple;
	bh=0LtCtta/bg/Fjkr3QcKzYSAYAfKx46oXSxOIvpC4OeM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ui1Q5FZ/+hPhiA1kHAA3yOWAzO3lXHysjk7QQjovnUntqV9SByfXx2w9bJthHHBXGz/KNVv3WbhQPTjnVmqks0tjFHyRJuckTf8x4Jati67GijtrVIc05kagDx8ryGeY5O6LahlBEb7ZKRyTkS8ZctE41ggK1/3Kq3AScP7Ykc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fnrq2sOT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fnrq2sOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC201F000FF;
	Thu,  1 Oct 2026 10:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851245;
	bh=0LtCtta/bg/Fjkr3QcKzYSAYAfKx46oXSxOIvpC4OeM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fnrq2sOTfVvgjyCdaMnGSYziEEK2BvDktjvLxy9OIkeKwIozzrFAzpr2F5++rielR
	 ag9rsfmcz08eZ03jBb5rlw6brvcGjaak6DVUzOZYujKHd3Z4X2c4OFkPS4EbRAJTiZ
	 S2w6Gx6VA0OKvXJdt8w3AB6+YChb1yBQSLhFacrAD+P7yuYo0SnOJOLh04bJ8ZmrZj
	 1sB5hOzgW8YTxtYzJodVKXGKcg6zGqZlhVfX7x1lSTQLpH7gTwOytsgHQ0h5k3241o
	 vLz1R3RUm+dhunQ5+QpEChUADZasVfuWOEzes6Nc3yHufKKPNa/37IFo+xO0Bpx9Sx
	 Q7SozLRqMxWxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/32] s390/ap: Convert inline assembly to EX_TABLE_INSN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-21-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-21-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:40:44 +0000
Message-Id: <20261001104045.0CC201F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert all ap exception table entries to use EX_TABLE_INSN.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D20

