Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2547141A919
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302520; cv=none; b=u21suJxPzqtuxme5F8mp7SOs/Uxq4c5TLhhriPakQunqaCBw4M/+nDuEt88wf7gHsrNb1I03VTDntuLTjkq++DFjaO7LchuXF+pTU08++cWHKD0IhJFeMM8wOo1Gs3V8LUCOdylhtlvFAD2BHCYwKy59UgBjT9yQuJTzTylq6bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302520; c=relaxed/simple;
	bh=1l+s8NhTJtSMGoWZ5+8d/OCfel/P098AzAfGeBbzTf8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gz8+ZqsNCXf1gy0cW4b/MaYYpv4PbjzdmET5/S+S5UYT8x1KsUHEzmx4MBGD/taZ7QvTVs3VUbtvi3lxoFYvZdcYk4KIjbDnk4LlgwsT8vybIjnEi5fuPFuB3wH3zP3St1IapjRnxdhE63+CrLjPQ/fb9Jy0bZtOKUrx+Dscnkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U79aKeyi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U79aKeyi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23001F00A3D;
	Fri, 21 Aug 2026 08:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787302519;
	bh=1l+s8NhTJtSMGoWZ5+8d/OCfel/P098AzAfGeBbzTf8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U79aKeyiji0Xi8b/2h26IRwX04JCJJPG8lFSBYXa6c4qmpDAIQaqNplRqHKciiZNg
	 fLdvOIU/4q2UPOM+notqljbamuzH3F6+YmEUFppwaIhlnZy0vnuaxQkjuW1BUd8g/q
	 JFI9p6fC0QxbVij0B1itNYiLDu+KhaKaJ10k+XIOlblyfm7vAL9bFVJMuPN0rcjLx6
	 fZh4kb0sC2Q8pQ8wr5lPc59IpyXKf3oCJQNzZclwQvAY89mfWk1yKmqQgJYINGeynD
	 y2DFs1jBHBgjmrL+yM+/5d8zYok0wvxLWj8s/re/i6yvUm6v75fs4zCplbEAzZUNkb
	 biOldTmLBHisg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 9/9] s390/crypto: Enable CONTEXT_ANALYSIS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260821084648.23222-10-freude@linux.ibm.com>
References: <20260821084648.23222-1-freude@linux.ibm.com>
 <20260821084648.23222-10-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 08:55:18 +0000
Message-Id: <20260821085518.A23001F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Heiko Carstens <hca@linux.ibm.com>
>=20
> Enable CONTEXT_ANALYSIS since s390's crypto code compiles now without
> warnings.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821084648.2322=
2-1-freude@linux.ibm.com?part=3D9

