Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416A530DD10;
	Tue, 18 Aug 2026 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064965; cv=none; b=lVk2gsI7Z5PeqpYVXeRN0clPbbwy7UPl/cOvN1eJK0jkqLZWNepGTa5NlD2YmZMIA4Ca7gSHjgx2h4MRMaPOmZdBCbHIYLTMUiysBG6i6KFzBXMKKv4uwCtVXeKkfqLUvg9m2FWvNYiyamAOHwWQKOfXz6pg8lToLjFRfZhpfCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064965; c=relaxed/simple;
	bh=E0sFdXo24GTpAB1i3xhks4N+0jobgKUpwWsEZEyElFs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=itT+armouJ2tTKrISn1HBlDOiZTBL00ksd0mMWjlViDDDwAYlSqlbgtp/oPisk+bDbT/mgY4Xr3AuxJVZcx7d0ViidLYKB0JHky+ICYy17eKkmLrHE/R29Ln0Zq9HJyvbuIkmubcWvTK4MwESiQ07tD8bWW3Ffx/sDDLm5LGWkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0ZpNKfD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0ZpNKfD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2EB1F000E9;
	Tue, 18 Aug 2026 14:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787064964;
	bh=E0sFdXo24GTpAB1i3xhks4N+0jobgKUpwWsEZEyElFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o0ZpNKfDrzB1DCef/UPAA6EoNHU/r8f6YEIKJJqQj+WTvofqhYz3eA0mDzgJUmn4m
	 Kc5qoW+CzmChNXV4wNC5XnslhfnT42aN+/oETpnYwK6R8GU1sefaXQcM6RIblHyF4G
	 HTuGxiatnZB5C0O1/Aqu4wao+HBefdIF9B5/Spy+/UuTW7jCNqOYXfekMRwBeha6lX
	 4ZSSt9i54j0B19o+sa5nbiB6S6Uvu2gBMZmThSjtFJDbJEkLK3UvmZg/7r4QnRTRcW
	 tzIwN9qSzmxkWEs2pqApmwI6R8hhaFUn7RwKQ3wlUiEfxfEQE9ON2pioX2lBmtfZ2H
	 HAg+qWd5bTu4A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 02/25] unwind_user: Stop when reaching an
 outermost frame
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260818144954.2320378-3-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-3-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 14:56:03 +0000
Message-Id: <20260818145603.AB2EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add an indication for an outermost frame to the unwind user frame
> structure and stop unwinding when reaching an outermost frame.
>=20
> This will be used by unwind user sframe, as SFrame may represent an
> undefined return address as indication for an outermost frame.
>=20
> Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D2

