Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3444AB6B;
	Wed, 12 Aug 2026 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543141; cv=none; b=hUI5U3+y2jABvddMNbQK+zmjfet13rUlYyYOVQDPEVHGoi935lLIo+TPK9dx7dXR8WnD2phO4W0mCYuU/sH1J/zxvIcmsQOF136UkwALhRraPMlem9NXay+hL/wjK+KxbHFB/gabZBCvcSTtt/YmwxlX1aCAqGFOb5HwPBkC5DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543141; c=relaxed/simple;
	bh=uxDHT8LkQpukH6gH16waWrNjJULoeKPk8VIW3OBvuBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qfhPCqDHWAzDnPxpGCCvT7b14RKbx7ySeG4T5OQIXu96Aut0XlXY4/hAwgUW+5qGn34zYa9YSMCvxzZkCppRuTITlDQQmwdkqREe3GG9M6lSV6MpL6Ct0JfJNzfVr1yEhmoT8QNWVFgYKAO2BFc1YdbCroHECOEr8S1zSfDVzGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwzvTNJU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwzvTNJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC5E1F000E9;
	Wed, 12 Aug 2026 13:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786543139;
	bh=uxDHT8LkQpukH6gH16waWrNjJULoeKPk8VIW3OBvuBM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FwzvTNJUNg6wyvNu+YpdYv1fosxLpzGp/L77Bv44jIVUDlwMkm/ToelIjYX/r7KSy
	 iBCRrfKBjLKKFVYiajncEpTqB1jdQX2bPebrKXocCDVD4HlXxady3Xre7bnowCG15V
	 otImoPXiERUga/taDcMAHhA7xhIWokkRYqvG0GemtoGJU5oTQBtPXcggkq02HdsvHu
	 0HEpFIDQebj5cafosMWcb3BUypMxwg5qaRM/ngEuOWDQiBNsgl+eLTtaJlDBSfaUSY
	 uHl/BQiuQe3bmuHSg4mkTUBRQ7p29zD1S11/YweDd0x2LJKQ0JWb5Dk4MLALmrh06A
	 X1LjqNVMMOroQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/20] KVM: s390: vsie: Add vsie_interp_extf
 detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org
In-Reply-To: <20260812-vsie-sigpi-v4-3-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
 <20260812-vsie-sigpi-v4-3-f19e49666315@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 13:58:58 +0000
Message-Id: <20260812135859.4AC5E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add sensing of the VSIE Interpretation Extension Facility as
> vsie_interp_extf from SCLP. This facility is introduced with IBM Z
> gen17.
> Along with the new facility add a KVM struct member use_ssca that we
> enable when the vsie_interp_extf is available.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-vsie-sigpi=
-v4-0-f19e49666315@linux.ibm.com?part=3D3

