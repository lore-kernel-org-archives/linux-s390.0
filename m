Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C72455184;
	Thu, 27 Aug 2026 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846473; cv=none; b=drAZMAftrWr7up2qwfFYlCupnQBtlaz5uttqm2xRXVlCiWgp+np11Yj83j8jNwg4VjgX+fsAalNrj5NAjEVwPu3f4TyA3OVbF1GuFPKOOv9yK+jN+T8LJxHSFLZVvGlyQCGM6w4iIDaMs//J90D3HH5Mz7pmaU66riKMtb3Rfzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846473; c=relaxed/simple;
	bh=dkhvmaAoSxH5MSofIX0Hi8IXHeeKYehqBtB7kMK/Kds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N6dphLjEs1q3VEbUUwWSNcgCowhG+xFlMamsbP62wRx1TbSmetac+GWQpKVBJwZ/mnJBP7SPfPnfDfZXz2ozVilj0hjsxu7QlsOlmeDUIcFq6B1FlL8UZRtw7UoyPhGhOwJWTEYSDbQUZ2tiEiy4hmv5R/1Xc3M4o/VA3ynkIOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjycpZLT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjycpZLT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70D71F000E9;
	Thu, 27 Aug 2026 16:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787846472;
	bh=dkhvmaAoSxH5MSofIX0Hi8IXHeeKYehqBtB7kMK/Kds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QjycpZLTfe2BRH1R6urwxia9FcAaj4WkTdW31HWM2cXY2iR5PLtCJ8Kdw6wIlKeBB
	 UEoOGBav/Jn0ow0L873i504XP2bAlp3g0TctuJGAYqSmL9tmhqHQGYqVzoK6vwqBrg
	 F63mLV63CBYn/wJGDHZwpnuK6/FOuulGzR9hwWed95h914MUUgxqKnfRAA+ZvBynlQ
	 avvJwqYjHiRRhO3j/wTI26rZSuqwk81qEHujroRvrR/0y8fjXi0nAaSUpSNLRYLWa/
	 OyFOZ/5qBnlQZ7bdA8tzcB4BbG+m3aNkFZITMGJ8G4N1ESRfYcDKxRoM89Xj/VuAMU
	 RGB6ZSymbwLtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/21] KVM: s390: vsie: Replace radix_tree with
 xarray addr_to_page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260827-vsie-sigpi-v6-9-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
 <20260827-vsie-sigpi-v6-9-8020bb53be52@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 16:01:11 +0000
Message-Id: <20260827160111.D70D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The underlying implementation of radix_tree is xarray since v4.20.
> Changing to the xarray API directly relaxes some of the locking
> obligations and provides more symmetry with the next vsie changes in
> the series.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-vsie-sigpi=
-v6-0-8020bb53be52@linux.ibm.com?part=3D9

