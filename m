Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03C941DE1B
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578003; cv=none; b=RoY9GZM18HCp+QmvmdG8drRBlZUfWsq2N4O2me5nT+uhyVBLfy745equrHDa9Wpi9kGRGcm0hmYCuHOtsZIBQq0V5rjsepdGoXgluMBx2LsHnf5vuoRoahb7OpPzgWPMjkQ9tkIPcmYwFDXW5nbwalCghH6fFZwK+8Nps9MS+zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578003; c=relaxed/simple;
	bh=ieUGCkoqMVlzh0gnb0KsWabDx9j3/gnMjBb5umFPOhM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b2SnnxJ8Wg7vKVn2w2uPeiZBGhBQ7dntZhJsit8mHs1LKFEkHniZCjNLXLVpc2uU069wOQSeqH5G2JsExqUhIkNrW8gIy7lY0pkBgd3bCS1YOp0XwDCIYVWupSrvpcRLTTsIbjXAIe1wXPRpkVmedNHQB3dBfH1zEazizOjjglg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvmsNLDL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvmsNLDL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F3D1F000E9;
	Mon, 24 Aug 2026 13:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787578002;
	bh=ieUGCkoqMVlzh0gnb0KsWabDx9j3/gnMjBb5umFPOhM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZvmsNLDLBA1pjWgWlsYqxHEmwqfTRi3ep/aulIjiXukkWy1eL+090wT5uTnlbR43r
	 lwigDejeOBKsFVPEIRf31ZEk2PJ5aNCo7Bb2Lr0gHKSxGV5LpSNMp0fUoNYmf32nKI
	 haigSgdUK2LWOTdreE9GJ4SrFASOPka+A5AG7ChejNaIOD9TCgwGOzWJA2+xe982TH
	 IszGjpzRBeCqt9ahKg5yjmIcnsxrI4uys/6F47i1kcxr9OAk/DZ9kwYlf5+QC3Gdd1
	 va5b6FIZGMjCrz2J2diG67rn2slra1/TfrUWYeKGBnwJ2344ibh7CbAlMMCHUXrHX+
	 mmGXSDEv2MZTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] s390/pai: Use PAI PMU index as parameter replacing
 event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260824131751.179275-2-tmricht@linux.ibm.com>
References: <20260824131751.179275-1-tmricht@linux.ibm.com>
 <20260824131751.179275-2-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:26:41 +0000
Message-Id: <20260824132642.21F3D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Use PAI PMU index value as function argument instead of pointer
> to struct perf_event. Only that index value is used inside
> functions pai_alloc_cpu() and pai_event_destroy_cpu().
> No functional change.
>=20
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824131751.1792=
75-1-tmricht@linux.ibm.com?part=3D1

