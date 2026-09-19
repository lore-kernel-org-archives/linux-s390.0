Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E530D405
	for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2026 00:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779018; cv=none; b=oCad6SjCRwotrxNVH9hmHuJAJ5e1Ipt/FvrtpBDDWSyu/VOf6uiAQsNQF6gEhXjFpZzDvbLTB3ackVQ3h7MhDwBcudSrUxzrmpHSBt3IJ9uoXaN/oaKCGzK4W0HliaEc3mdT9bLsxrK4qoDGhLxev+WtQ3HclqBbOgnt42rX/xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779018; c=relaxed/simple;
	bh=TxaaszzNlMJRoMRBE3bG8sGNPjfEV9mwWj1K7UtXepA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E+asnmivlu9/GShHP7hMs84RK1xSdi02KOTwo45YDHaMZ3GVvnh9JZnjnsMOuHzxHAxvA9CjICUiUo75T5tFv2KZ6VvWZ8G8C8yukcDRaahvgDGGT2SaB2ahGII1jgbECOEMfoAIo0HY4gddfyt5GQml0RXerfjPN3TLl8Oj2oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5rU7XoL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5rU7XoL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27531F000FF;
	Sat, 19 Sep 2026 00:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789779007;
	bh=TxaaszzNlMJRoMRBE3bG8sGNPjfEV9mwWj1K7UtXepA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I5rU7XoLnbyidBAUx5bENkg2TSnCzdObyazN6feoeMYNLI0DWzvigcdjXSHGcRZEM
	 ldngOu/29gawlVtO6jnXWsF4vffjTNKrWJ/oAfpzESs4WiQB6JkI0nUGycq9WibkJN
	 5w/h6IPLCimv2RliryjdKQ7JZMmJscO2zuCYeBn5VVOJn2W+BWxevPSo+9Z0lTBh+5
	 IcymNwdJjcguJjNjWAcNWhFS0ClLW9XOPp7lUaVYlEMoyYvoI++j5V3RaYYkY2Tzkd
	 3DLB3WNYAjnvzlWFsEguZOoAQfZs4zA4xXdnOEK0o5kUSay2ttiJAfOmnw9GJXSfI1
	 vE1yitKTUIxmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/12] s390: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260918-tonyk-syscall_table-v8-4-0e2d60cad13e@igalia.com>
References: <20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com>
 <20260918-tonyk-syscall_table-v8-4-0e2d60cad13e@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 00:50:06 +0000
Message-Id: <20260919005006.E27531F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-tonyk-sysc=
all_table-v8-0-0e2d60cad13e@igalia.com?part=3D4

