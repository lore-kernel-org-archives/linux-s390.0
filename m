Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5373002AB;
	Thu,  6 Aug 2026 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022212; cv=none; b=fbv+ARO104RgqSSJmADeyIlNm7fFpi4vQ8d7LHdZDAHKEYhya4Ph0hzCDywA0pZYWkCDy8RhzKFWCGVZNQgOgOlr6pBTp7GWbj7kr+qsg30czE0T7kNIRnJdOn8gpJ9MXTIH6VhNUizJg9IyjOr7LwhqRzXMh5KEkOaFUamoWYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022212; c=relaxed/simple;
	bh=iCSyTHOggqJr6+kRcVGvKupafhGlS7S8KhkKtIVxzyc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j1BDIe47d+lAiBJZNSLnXG8BO8sy+lYItAnvGhtitnMStanTnQFtS06PsUGd/lZ8NshXPTrGn9waEpo/MuEW9QtbpdRPftCt09rEnq7BYcyKeAKqIcW8HNzjZ6CDlvPg9t+IjDQeeWwYzMA6aX9LEld6e/95jtlB4V5LdU6ZTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhrnUk43; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhrnUk43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74DE1F00A3E;
	Thu,  6 Aug 2026 13:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786022208;
	bh=Sy8MKEOn4ulC3jQTQ7PddLxW8jobLEBOUkx0cLvdAiM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lhrnUk43MsNZSmqPiftHJliOXZatInAo0dmpX1DMH+HMdxzxb8E+WBtlpWSeXwxa0
	 30WYXgqFS7/07IMuJgydSAsXnzTY2QgMXbrDlaPFORrq44bGOZFN2J8gTNbBTPLbcv
	 s9qYRWt46aUPxJh0dOG5f0mb+Xa5XBkFul80cIqW7N9hs2A05OTp+VK4OMmtEH+zmt
	 dQolITBqM8Uc0hXlEBAlbU64ir8fPlkHoc8eyn5IE930HRwFr93JhRjCGSAn/54vKp
	 6wlUlUJ/t8TjhSyTW3Ohd1RUykXzpTfps80Bu+Xmi033Oaq+5/NFY1KKJymae1g//c
	 q+ezvyghaV14g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH on master] KVM: s390: Fix memory corruption by not
 reinjecting CK machine checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260806130410.14254-1-borntraeger@linux.ibm.com>
References: <20260806125241.210170-1-borntraeger@linux.ibm.com>
 <20260806130410.14254-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:16:47 +0000
Message-Id: <20260806131647.C74DE1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Channel-subsystem damage machine checks are for the host channel
> subsystem. The guest channel subsystem is emulated in the userspace VMM.
> There is no point in forwarding such machine checks into the guest.
>=20
> This also simplifies the machine check reinjection and avoids kfree of a
> stack variable as reported by sashiko.  There might be still machine
> checks that have the ck bit set with another bit (like instruction
> damage), mask out the CK bit in s390_backup_mcck_info(), like the CP and
> ED bits already are.
>=20
> Fixes: 4d62fcc0b692 ("KVM: s390: Inject machine check into the guest")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806130410.1425=
4-1-borntraeger@linux.ibm.com?part=3D1

