Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702D14B44A3
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673355; cv=none; b=cXzq7zcDmn+T1cb1ZJl0QKijxVtLdc7dKZAFD7TyvRIARdNJXbdhVjchfXOW+mliV1j9bOa/AzFJ0UqiFBQAk67YkZtRUsCdWzgLEPx1//RtlF5XdRd3ZYlQFlI9jBy+yEMqUmMW2sa7oWalYZCI6YjpGG7+yg44ylc87PKQ8Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673355; c=relaxed/simple;
	bh=0u3tK5P7F5oD1TM8veR/GTPRHHFqFQUWc5uehTW5XcA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LnOg742EM/3MpvJKteeGS8kPfuUO26WrGA2dhyu5DeePRgoS6g8vESgYG5179AdReEMgfbfZIh037CMCnBJL6U4BuQ6nUACvUEh4LEtrYexKqGJjDoj1mwW67DETiq5MJ7UpEp1dZaCbnCozy+YcvHBQUS+VwOiF49nXuAb7QYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxPH8C75; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxPH8C75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEA21F000FF;
	Thu, 17 Sep 2026 19:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789673354;
	bh=0u3tK5P7F5oD1TM8veR/GTPRHHFqFQUWc5uehTW5XcA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oxPH8C75Cf0zu+YY/FOeZKAgCAcFE897OkdK3i8117SuEr10vlPkIPXcZSGzBsYpZ
	 v8hhziMJ/DE6WYXIAR46vgHVt7Zrb9O4aiaWGOdOrnKx6YNnlYg7w3fQ/k972rcDmx
	 F/0vdBU9mUzbC4WCElPPZzhfL0/YUm2s307ksAFLqNLqMpkX90RayddvgRmvmGe1Bi
	 pqB4NfyH7DqigSUfLlDTmkHUj8NV/zFZ1lrvh6rTHVMHYfH6FdeT+cfqzsLxqDJJS5
	 S2gDoMqyot4nOkQln7CWPN/WNyuzn5sWP/C4yB4h3rApUeVGR6qf/9yJLsQusIISzc
	 ye8/+ITWLtK3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] s390/percpu: Let MVIY_PERCPU() calculate
 alternative displacement
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260917192237.638324-5-hca@linux.ibm.com>
References: <20260917192237.638324-1-hca@linux.ibm.com>
 <20260917192237.638324-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 19:29:13 +0000
Message-Id: <20260917192913.9EEA21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Let MVIY_PERCPU() calculate the alternative lowcore displacement instead
> of passing the same value(s) again and again in all percpu inline
> assemblies.
>=20
> This shortens the inline assemblies and makes them a bit more readable.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917192237.6383=
24-1-hca@linux.ibm.com?part=3D4

