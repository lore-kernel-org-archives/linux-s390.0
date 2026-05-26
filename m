Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508EE3E0C66;
	Tue, 26 May 2026 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795316; cv=none; b=uLZdQXA8t9L4ao0gQjh8CBEkQhJ0w2Ts569twWO70s7lHzww4zVxpi+cGHwFy12dr6qo1+39Wxr864hhKCEvVVSt4KRvEur/R8W9HelFTgv0WoCJ2hkmqQ3XNhhpomCy8BFvsHsNHxnFVa3CCxrAWmhiHpAMK2+CuviaBq/zMBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795316; c=relaxed/simple;
	bh=ZFEWDQVpgi2M+dqFkSK+iIFTP7OyecjxApY93rIvv8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvb46etghuiDNHkEFfFmCWzpxXQ/JEAJVZBy9n0+H/ceotcpd1T5lNMYwJmJnXskOKk+Mouj6DkNcZ+t5l90MdmZ/4EwyC7dRm0a50y6cmhslA1Gf+GzkzEX/aXx4ukP9/6xpYMRH+LVnet1AykN+c7CKx8UI6eDvzFn3sHNkMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emQ34TJu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emQ34TJu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59841F00A3D;
	Tue, 26 May 2026 11:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779795314;
	bh=Li26XPRm7/eoUa6Pz5Hdq/jrI3WVUijGkMu6MzHsS3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=emQ34TJuiu8uYpW4PVd1xzv8qQ5w2qXXovys85E0abTHLanqxmJVOl6hTWcgQsPm3
	 wWdgfaJR8/hwh53YS1QCKNMQ++kvVKR21Kf45EhsvJlCdB1fgKPtL7ziRg73Z5jc2m
	 LQgNulY7ll9DBgfzwiUj87hSCXhrcP1Pq/j6gi7qHj0ec2xP1TzFdN/k6gHSia78MC
	 klbz+eYjjLF5ueCgUtHvuXs3jv1OGleyTgKZ3yo/2HJRvlp24O0tcV+HsLFxpVdOKA
	 hwnLS93GV2R6dFSKARyqr3dEPpkO3vxhhlB71YSFkuDeTInHWDnc7FeV+fxCjh3NqO
	 enMzwdenk5Mgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Natanael Copa <ncopa@alpinelinux.org>
Cc: Sasha Levin <sashal@kernel.org>,
	regressions@lists.linux.dev,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vneethv@linux.ibm.com,
	oberpar@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com
Subject: Re: [REGRESSION] 6.6.141 s390x build failure in s390/cio due to missing driver_override infrastructure
Date: Tue, 26 May 2026 07:35:06 -0400
Message-ID: <20260525231000.agent5-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525101635.26090-1-ncopa@alpinelinux.org>
References: <20260525101635.26090-1-ncopa@alpinelinux.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> v6.6.141 fails to build on s390x with
>
>   drivers/s390/cio/css.c: error: implicit declaration of function
>     'device_match_driver_override'
>   drivers/s390/cio/css.c: error: 'struct bus_type' has no member named
>     'driver_override'
>
> The s390/cio change (c4295487124f, upstream ac4d8bb6e2e1) was queued
> without its driver-core prerequisite cb3d1049f4ea ("driver core:
> generalize driver_override in struct device").
>
> Could you backport cb3d1049f4ea to 6.6.y, or revert c4295487124f?

Thanks for the report and the analysis.

The driver-core prerequisite (cb3d1049f4ea) is already queued for
6.6.y - The companion bdddb54c533f ("driver core: platform: use generic
driver_override infrastructure") is queued too. Once 6.6.142 ships the build
error should resolve.

Newer LTS branches (6.12/6.18/7.0) already have the prerequisite as
an ancestor, so only 6.6.y was affected.

--
Thanks,
Sasha
