Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF0D3B8BA4;
	Thu,  6 Aug 2026 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029281; cv=none; b=lZzxUUR+RyPCL8Jiz75sP02nGkMIyS+NlMDjMFb+LXH7sIhsqnviNGSpx+mZnYIzWMuqS2De0LZHJ/pN6+YVvwgyDSepKZVacU+QOO9//g6+cyNrE0h0OQZjFSG0lwAp0tZSQdUb8i3C8l7DsavnKr2d9vd2YX/OrdL4I9eRDD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029281; c=relaxed/simple;
	bh=rCehbKUFRSk0Q9nUc+hozNY7MFUqpsX0ZvHH+jbVcE4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qtu5yg/rcbnRNMSQEVEHUCLixAfpqX7/vqWmCEV8vOsv4kO8bHNORXZfBf2xGD3cabmMx4U15FhPCwYLGRtLYwH3iGFDEZHgZYW3QELtCjTffaDbiHOtcRAlSWvlWnaYVuzxst7k5CzOrn5R8IOTO6mR10Y2zWlRRI/RDkP+UCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbeep/8D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbeep/8D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006641F000E9;
	Thu,  6 Aug 2026 15:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786029277;
	bh=Ar1IST0PtWQuGZxid8G4FIVWUrUqeFcREljH3aczeq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mbeep/8DjlXHrTv6uZgMSRVsrnZ1SFAiSlu14YqnAL0ebtm/jrth2xnaBZcvCGSZ6
	 VRePT8hNZESIw59C4jJNRAf6+RLTFEmWyoVw/W5quhk7WNIPFXGWNeNj2V7hBWlQTj
	 u4QOFNBHnp4X9LNG8sC6wXG23o+b78E3l1tH8nrN4rgGEw0sWG3rZ34Fp5ZdprIq4a
	 Cc+lOp2qejT4/Cc0AVOsoE8GcRrlEaHMw007cPiHbnZ3qAd6UYA+NNf48m0Y9uiEuN
	 lMOZzDpj+w0O0IDHi2XsczKbbWb0uvia7Q/UQA+82cUiZbqpMy8FEs6VhBxIh+SWw4
	 3hkrvsKfaPSyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: s390: Fix memory corruption by not reinjecting
 CK machine checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260806145835.31818-1-borntraeger@linux.ibm.com>
References: <20260806145835.31818-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 15:14:36 +0000
Message-Id: <20260806151437.006641F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806145835.3181=
8-1-borntraeger@linux.ibm.com?part=3D1

