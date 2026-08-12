Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47C42236F7;
	Wed, 12 Aug 2026 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532005; cv=none; b=gd7nWH60xCT+5twv5JIR3CgwvzPPCtjRYFsz3BZNc7vjkdjG/XAB15ZgVhpwNRxe6W+zmx5vxncPZvByFcIs8tekSvb5uBpCYQUnNLn59gzgEoBnd+XaWu45tECSJMeYiLuOO7TH66dLYrs4/DBw1nwW/wpmQ/xnEFHduMQlzz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532005; c=relaxed/simple;
	bh=d6PMnO7ITs+trMD354cK+xcJEM8mk1kGDat+XUrdqrA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qDVhBKhne7cWnCP+phuMLR/XOOWpXTmkXpPmqfZ/vqfVzBZNBb/cXCupIYqZxNyjtQt1+dM8vcAJNg1qQOHxY2tT+RqWL4pYn09y2Ll0+Cve4J6yNO/tj/2gocuMA2AMyZc0TK11kn6w0LgiT7qBZw1tjpgm0jnPRlfTJOvH5SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggWIJeQb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggWIJeQb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED52D1F00A3A;
	Wed, 12 Aug 2026 10:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786532003;
	bh=d6PMnO7ITs+trMD354cK+xcJEM8mk1kGDat+XUrdqrA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ggWIJeQbzW5sCk2x8ziGYX8SrBV5MLvgQYuxoEeaotvs69p7ycVRffFVM7vOw7VBe
	 XZ6XPMg7pif6iQih4U6TBOcakyzrumaWC4sd4/Ln3OIV4Q0TykU+/YzB1Qfi3mrTkc
	 OmroUFEanaMQhLUV4bmTV7wzJbNHk0pCQNcX8nB5cmEr5hmB6iL3fkXzTurQffK3ew
	 BLbJ+92QEENOl28aah2ZPNQNWPPXsCLno0vXHNBQBr8uB0nI1iKswtJUcKi781bzqC
	 GugXKuxvE/U/W8vQPpLIoZi7+93zrwjKZhcjj6b86GxXIF0THyihQmDByqzJaj2uJU
	 gWdELwGaLnYpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/9] KVM: s390: Fix potential tiny kernel stack leak
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, linux-s390@vger.kernel.org
In-Reply-To: <20260812104436.109741-9-imbrenda@linux.ibm.com>
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
 <20260812104436.109741-9-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 10:53:22 +0000
Message-Id: <20260812105322.ED52D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> In some circumstances, one bit of kernel stack could have been leaked
> from dat_cond_set_storage_key().
>=20
> Fix by clearing prev before use.
>=20
> Fixes: 8e03e8316eb2 ("KVM: s390: KVM page table management functions: sto=
rage keys")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812104436.1097=
41-1-imbrenda@linux.ibm.com?part=3D8

