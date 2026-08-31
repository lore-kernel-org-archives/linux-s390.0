Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB7C3E0C66
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788171122; cv=none; b=A7pw3J4lhcI2gNVbGudzXzKKNYcLwgBhRk1JHDJqCsPP1jIX+d4PcDTF5972F0R2YIOHiNsMkQ1Qa96C1SQaFfqek67DX8Lr6R7PijxraIyJqjjCjAEtEOW5YdlY811gv70vyua3cI0/rAW6yIgf363VRSUycpqZbe8eQ/EhqCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788171122; c=relaxed/simple;
	bh=zM/0y6KNPrQs9bqZ1tJh45vHJVq7Pavb9dGiXMjS4zc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m65p7p+rx2EF7IFut549GiCiCnwQYBw7bzQ6/Aqb5r1+ityljt/HbwI259Ntvdv6KKwqLU7SBib+HIysAjVnbdHtH0GWg58S7EVv8051ct4nR+uc+LlVOLl1yZz3BFERp29d4R4woST7fGp3pfY3GwaMFMKlzZCSmiBcYPQ6QZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bljaeMVJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bljaeMVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582901F000E9;
	Mon, 31 Aug 2026 10:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788171120;
	bh=zM/0y6KNPrQs9bqZ1tJh45vHJVq7Pavb9dGiXMjS4zc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bljaeMVJOejmxHGT+d/aP3SjFB+dghjYdGF5ZCyIKSzRhNUiY03JoQLGzZUngBmCP
	 EYOcUwuq27iUtXOr+sNm9rFdY6o4Swb0Mvh8UQ8T7lPUtvdoBJl12+vhbToYYrHTA/
	 w5ADuI4N6j++PFUc1udtpit3LPdYA6SD9s54WeOZC4hYon68EnRQcodp0kzzIM/l/r
	 aJ02I+UR4I51C9852nGa+jyBUAXhPh9cBO/8YxmHfNkK7hRByM8s0jygOdrK3zxwh4
	 OuCefYUYawwkP/zaGu8/nAi7r/v3R45tt0hZm7GiDZ2p45NTXycToU+aATb/AD4Ane
	 3Ve4op5HVhMuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 9/9] s390/crypto: Enable CONTEXT_ANALYSIS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260831083838.3703-10-freude@linux.ibm.com>
References: <20260831083838.3703-1-freude@linux.ibm.com>
 <20260831083838.3703-10-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:11:59 +0000
Message-Id: <20260831101200.582901F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831083838.3703=
-1-freude@linux.ibm.com?part=3D9

