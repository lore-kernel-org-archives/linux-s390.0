Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D41B3921DC
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673366; cv=none; b=edZ0bE5zg8rGqQSx/obtoLmO8uTmXXrBWEesGJZlZEQz3Yrr7N7nb5N11bv4bYhZoG+G1Obpf25ybVaHKcxRchSREx1KSPeH6g9Kb5ly/P7wC2w7AIV8y7aV8/kMpQUaiQSpJodIo7d+CGiWVwFWRO/iu96i2jtR4xKPvfdpo2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673366; c=relaxed/simple;
	bh=f9vo+6zrBSeFKmE/S1s0avjUHVNRgCTszv6JTDqZwIA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gwGgleM9tR4SuyBsmLO+oXZz8sRcBOOjav9YEKLfYEeH85xXwi4RaMbGPIXlcv+H2pMoRwpnHrmzm+VZUavgxrbiGepw/GRKp4XaTAxfufrQVdAetnDF7fDIMFfSf8sfayePXuD4pbRI2eMRUVacEFHpFHVsVex1+oRQbLlSLZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f04eQxUl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f04eQxUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DD81F000FF;
	Thu, 17 Sep 2026 19:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789673365;
	bh=f9vo+6zrBSeFKmE/S1s0avjUHVNRgCTszv6JTDqZwIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f04eQxUlGERKc8fsmRtFxhsMyOgOZ3bOp3MSSKqmcFWingE0zlBpK0OWy5dTVwFZc
	 hl45a3/d3m+1SkRxFIiumHhbv8HYoyzaYYrKFaYiy5vGNJ0Ma0X+jZ2xhu8qEUjiyP
	 1WkMO+9c3UNrGlaEa2YtMCdylcLtN3ltqfzzOq2kB7SRr5/DnH5tXG7xjqyHdfVy++
	 I4rdUvQDv1F2h4u9/pgIOKrUdVmLPhy3ajYUXxR1nVwNAnpFOzXHEaNsLSWPF72Bbp
	 b9RpCHNC80Nsyl7p8UzKfiNfA+08MYJvGz9W01R7j5hTUu86RV4JVGCxyprn4F+V71
	 EpsWbZT+2HbSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/12] s390/percpu: Use percpu code section for
 this_cpu_cmpxchg128()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260917192237.638324-9-hca@linux.ibm.com>
References: <20260917192237.638324-1-hca@linux.ibm.com>
 <20260917192237.638324-9-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 19:29:24 +0000
Message-Id: <20260917192924.95DD81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert this_cpu_cmpxchg128() to make use of percpu code section
> functionality. This is just for the sake of completeness, since
> currently there is no in-kernel user of this_cpu_cmpxchg128().
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917192237.6383=
24-1-hca@linux.ibm.com?part=3D8

