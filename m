Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D742772D
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 04:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787026716; cv=none; b=h1S2O+KRRVsIvEeYlHUCZYzxmb/Fet/kjVZpHFxay2g8vCrvwRMHS9Ks68oYBgIFtipKCVOlS1ytrrESlACXDUfsxQxk/DXFhVAPsBVzJ1IvdnYj1AiZXVEi3rA+a2QifaXfIN79oWsSUu2psOP3tDdO7Ikk3Amp2WKo67GxYIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787026716; c=relaxed/simple;
	bh=S6N90REF7ihznx/dxYEuadBHnjzTZ6xtV690r4uqlfc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pw0S8ynZAL3Lh4ObXfosubq94epSIM1mnFNeOoTMcXHsPyYRHDTH/7SJOqDnlprIu1G1kwynLV12xXDfL4dIgPE59Jbb6P9FGBs1x1BfM4lErKbTEncv1lqVUr/KWiYj/vhE7eAyBggRKDK1QPhEn55Hpi+VLgLV/k6AscmN8wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GocPsLUl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GocPsLUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EAA1F000E9;
	Tue, 18 Aug 2026 04:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787026715;
	bh=S6N90REF7ihznx/dxYEuadBHnjzTZ6xtV690r4uqlfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GocPsLUlUtfwVi7+Iqon52GsgfRhKdbIxj8dGdSwyTjENsCZWi3yoq64CryuLap7L
	 ev3dcLxUMt+nlf0Pfm9673gMbY6KFZ2fSQWR9p7E/L+QPGa3NztSJgGVNBg5V3jSbj
	 zvvbrI9fEojsKsqbstOWb6MQIlqy/4TOG8Jht02eOJo/Fh0rFBPWbI8BO6fbGrjCWm
	 x2m99LKxtqfo7Zm1P7ILeY3JMR+FwBmTF+jZbboXyis6MItf2wUVrz3iXwi0KCHIXd
	 ZMDnWPHq92BvMzLkZiBm7roQmpXuJmqxtTTDD/s4KVnguIB1RPR/L+TwbLjJnGMCHJ
	 c8gZT7S2tgS+A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC V3 6/8] sh/mm: Stop using [p4d|pud|pmd]_ERROR()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260818040041.1891769-7-anshuman.khandual@arm.com>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-7-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 04:18:34 +0000
Message-Id: <20260818041834.D0EAA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Stop using [p4d|pud|pmd]_ERROR() in __get_pte_phys() as the pgtable entri=
es
> are known to be NULL and hence could not really be accessed.
>=20
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818040041.1891=
769-1-anshuman.khandual@arm.com?part=3D6

