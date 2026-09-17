Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7403DB62F
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673068; cv=none; b=qfKKO4gHyLGIZjvpCK21qdRE09zvDzL/4Sz1g371E/axttDI559k978sIeFNEboh7mWTX1DbuHthXT3TvwKlnz0UjEJ/QUwD+K8SlznXVBt0dBNewl7wH6QEykEgSjwPDMIk6DHvT8WfFjjXKvcmEHUJsFWL6x0DX0lqSxkU7Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673068; c=relaxed/simple;
	bh=d27P/B/m6t5qebuBeFWtNLukR6yIlylndJcC5whTWDc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d/Cqx7M+UarZYOVAiR6yAOrRpriRuUonlHj0bEnRhDaO4GMUDxOpJZJwHsE8PHPMWJ3a3xeOmtfVuVcdAeM/ZUTewJMKCfDmJ72ItFTSwsr2XV+SzDqKW2/LrgGgAp/jjQUgXm5sPSPLVj6gK9q3GnP1wQeII3z4WVSUT2v44cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOfn5IqJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOfn5IqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BCB1F000FF;
	Thu, 17 Sep 2026 19:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789673067;
	bh=d27P/B/m6t5qebuBeFWtNLukR6yIlylndJcC5whTWDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dOfn5IqJBVhJrHYC4Emzz7j60bWeUNAiX0N8ndrRIXwD5PSskAIsiP/2QL0xxXhQT
	 KKeYx/IQnqziNWSdixD4laEBYAzwHDsWc5HDETj/C9eHcR42LyfE/+8JzkXotC+Ao0
	 m2nFa8sNsxxAPgpVTLQsyTEzaD+TkOVaP8lbBhbuFBjPX5x4w8Ozf+hHTVLz/uxi9U
	 7YG4CbNg9/7DwxnaV+9asxCh248lIEeI2lcBfSPKCGuBw+XOKEpMH35TSxZ2N8h222
	 SqWeePScjAWC9Oaf0eMDERaTa38TkX7+EXrOLlE0geKi5HaljniEQUolW86EpuwOp3
	 XhBQKSLztcBYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/12] s390/percpu: Fix comment typo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260917192237.638324-2-hca@linux.ibm.com>
References: <20260917192237.638324-1-hca@linux.ibm.com>
 <20260917192237.638324-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 19:24:26 +0000
Message-Id: <20260917192426.A8BCB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> This is all preempt_disable() / preempt_enable() pairs and not
> preempt_disable() / preempt_disable() pairs.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917192237.6383=
24-1-hca@linux.ibm.com?part=3D1

