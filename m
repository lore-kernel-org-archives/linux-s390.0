Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B863F4854;
	Fri,  7 Aug 2026 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096776; cv=none; b=qk+MwtYOMpJTt3roORFnBr6APN9uMyZEMLlZ+J7SW7NW3To44rcbg0gjYEhryhq36+uEUtVoCpLGC+8zhQvK7IJAm+m1PKp6x7BTNfU9aYjNlizezXsaLQ19VTlajuHLZyUlxEjN06n+jooY6Bz/nFXeP3+2ZpejTlMTz6meqtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096776; c=relaxed/simple;
	bh=if2g1DxOsP67aQk0Oum63Ah8jVaeEHNohNfPsCSInSg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mIEXSu8xU7hsXUgTY3s0ePh6xp0DvRfijK4HQyHZxSu0fd1LKbzhi/X+u7O373NH19Jwyw1cpOg6rOFNaxufFKV7CclBoqh0LlvCJNSuCu92T1xTlZgbtQrwTHN8jNma4qUdkvVkEdNQMuEPQHzKiAdvRR8ZK3u/G8iYR38Cd74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6fgFDXU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6fgFDXU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434851F000E9;
	Fri,  7 Aug 2026 09:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786096772;
	bh=if2g1DxOsP67aQk0Oum63Ah8jVaeEHNohNfPsCSInSg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I6fgFDXUwUHT201yzbtoEvV04Z0biK5hWJzvf9Qd9UeexTG5H3juL850uABbOHOml
	 dtRYY3plohlCycd9sLTUbtlt9T+M34ZXyTZM86kgGRJNJYEckJjJSfLGQHrLEEr1KT
	 3Jxj3dg+Cx+eaEAX7HknxQ1XmIva1VY7QA+OF9mnJ4p6LttWHELr5rXTNGH2Kha/UG
	 WARpm5tn3BsSak60XuD1py3jYwhV3yrW/fBcOk0RyhTDN2UwOtSEPlp9UNxrtYPjdY
	 Nemp6w2MO+EPMdjefzW+nHt1HHak9G6TrzrmMS8tJJbuQaRqvLal/n2yUhAdFWgMfQ
	 ZctOz18EXynBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] KVM: s390: vsie: Remove duplicate assertion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260807-vsie-cleanup-202607-v1-2-b18659b55e3d@linux.ibm.com>
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
 <20260807-vsie-cleanup-202607-v1-2-b18659b55e3d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 09:59:31 +0000
Message-Id: <20260807095932.434851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> This is covered by a static_assert at the struct vsie_page definition.
>=20
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-vsie-clean=
up-202607-v1-0-b18659b55e3d@linux.ibm.com?part=3D2

