Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27215013C4;
	Fri, 18 Sep 2026 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744492; cv=none; b=QlU7l0z2FrQ1kINhnIEcuJYX7h/qDA6E10B5MnJZZfNEq6gMJZ2V5QkQIiAYcPGAhh7Qeph3A2YY602RoTlQQCYfqJJx0G0Cs43y5AaaTL9PG/7Zu6QAEnJnHn34b3IRFCdBv97Y6F6aZAnIydFFxaz9jgXNfL9e1gSCiy0Rmu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744492; c=relaxed/simple;
	bh=xOd1yXp2nVLBxMTqXxq1NSsF4TI88Vnes7OUzn8jV70=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XROx+52y/6c37owCcRt+svbgBTt1YW/4BJVuyRZL9IuF6JTclJZRY7TSstk2HD9WXHhslVRtxxLwhdvRKp9Zu/vKvWI8TvCxIse0+MRgqgpNiPJaD3SJXoSpVWs8DBa9Q8ZKZjLvkgF3TuQnuP3WEC7yM7TotQdlYNiuKU8kuxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDQZGbXx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDQZGbXx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E861F000FF;
	Fri, 18 Sep 2026 15:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744490;
	bh=xOd1yXp2nVLBxMTqXxq1NSsF4TI88Vnes7OUzn8jV70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LDQZGbXx9WVjjTm9CjTuNWlH6tlribh2Wqc7CgDMDzbikotrAvG5IclKPDVj0RLAd
	 TQ7FlVSacgalITwwqaQbHipMXc+AiTNY6jwgRV7fMJm64BZKEuAaxfE7mDPEDNKRmH
	 ZZGuDG9pzQUvfWjpgoB+pkc+ce9/96A9dStB2uTnhMHT/0VMyudllw6dvK/mClmLnS
	 g3qcb+EGMJhrJgnjE5mhtIOv4QQLw3AB/QJJfhj9PCNA4lZi0nexNXc/Hd36Ch8odC
	 aL2HMerGzfeKJtKBRyBWlULAudvsT2hbww0/tflhMrR7sH0vKH4jshlVnVS6LYkZeJ
	 /StmwYoEClj0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/21] KVM: s390: vsie: Add SCAO read and write
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260918-vsie-sigpi-v7-1-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-1-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:14:49 +0000
Message-Id: <20260918151450.22E861F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce some small helper functions to get and set the system control
> area origin address from the SIE control block.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-vsie-sigpi=
-v7-0-f39806eaae37@linux.ibm.com?part=3D1

