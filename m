Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5CA3CF209;
	Fri, 28 Aug 2026 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918536; cv=none; b=rj0gG4x0ZF9sJ1dmocUnLbLPuFlEuBK160lFoaWbRLGFOUSBMUf8aD6BCwzVIj+Ze90oVgG6KAMS4gjFYE17uN1TIE3WshRydVgCLG7q59rIWDN4TM30mUkB1iIivG4xOZnaZ2E+wce7UtneMsd8PwLtFviYL/EUsT+OH+uGcVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918536; c=relaxed/simple;
	bh=0MKHMwm6HfuNj/wkwhQN9XPAPhME2EBUj6hhH+LjL4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZpSKKDWFq8ZvuLVuGHOsffjGtZT81qJ5kJoVcggTuudTc98ORCTKgkZTx7YTrAnuuJTbKZeaL7TbfzTbJgQgRTC/jbeFiYC37FyCjYGAgDwOVW4J0nyK4oWF0QWXrTGMFAOBwmu8X3fHICzix9bC9sonzFnr/5WEgffoZVKVcaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4HUyS6v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4HUyS6v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082811F000E9;
	Fri, 28 Aug 2026 12:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787918528;
	bh=0MKHMwm6HfuNj/wkwhQN9XPAPhME2EBUj6hhH+LjL4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J4HUyS6v3lp6pmdbXy1jlLACK4YXYnSp0NIZAJ/SrIJ7N2lv+PbW3awTKD+IHy0ae
	 yvdKsYjbxYs9EABJMB0y0GOsnf32XOpOIbhLNGvB/fxSt+W5e7WIYr8nipgtir/EB7
	 SlYrRA5nruCfwSUaQ+83q2oGDwI2qxh9Se/HIAYe46l502Y1amt6mqtiHiW12djers
	 ySFJwDV4Uk8uwHmflHMoH+qf+Kfip7xKOQxdsdg7dR7uyiH79hEX0of/Do0392YKsw
	 cbcQHMROCIG7GFu2O6CMh4NCvjWpw9HiBM1nWdvQW9aHbh+IssskQVM52S8wmArtn1
	 /I/4Ix7LFzT9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/8] KVM: s390: Fix compile warning for
 kvm_s390_update_cmma_dirty()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260828115439.145885-3-imbrenda@linux.ibm.com>
References: <20260828115439.145885-1-imbrenda@linux.ibm.com>
 <20260828115439.145885-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 12:02:07 +0000
Message-Id: <20260828120208.082811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The parameter "old" should be marked as const, to prevent compile-time
> warnings.
>=20
> Fixes: d487a24041c2 ("KVM: s390: Prepare gmap for a second KVM implementa=
tion")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828115439.1458=
85-1-imbrenda@linux.ibm.com?part=3D2

