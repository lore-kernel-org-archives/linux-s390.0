Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710901;
	b=y8SdoMMGwhYUFhwNmHNBlK4dtlG/Jo/d4dXLCnT2vKk9e2mr2BGZ5NEdE7km9GeQ7Qra
	 8Aeu9GjalAs3PmXvBTiNKnRl/Vd15IdqdfI9I3EuNe9YYt0y9MZeOZMxlqexkkLCWr1/k
	 1cRY20T57AmmzVgOnwzthLDG9VxW8LsRqLtDhOIsv3vCGPOr4adlVmIg/U99XgwOt9V3F
	 QVF+Yu3Mjp9UvrWn3ak5lhzRVYKt7QpPHQHG4CpL8Q1Gk3k/KIcDsI7FBVtMgIRpIswSG
	 aydYxS7Z4d06iq15q/sgE/e8cI/u/d5KDdU56LcDrwKn7cJdjLsUwT983PIZDYmlp9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710901;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UPqeQa/mVG220HWF0/V8KsFL/bCL1ZrWZ3it7yA/Cuk=;
	b=w1orpWZMWTkfrBVwQmFACGFxztSiG+vhq/H3asIC7HsnTRAQ7OdwEXrHTL2yiEyN7ylO
	 StR8zrAUOGfacqYFxeUc1Ct8SObluBgTAetlFSvjIORP5rAW72x26gmV8z6lFioCsEofx
	 KFYmenX/PUR+MaVLhkBWRk5mz+55nOgotLFJgMqqcpT3nQk711ERAMhG1mM3Cz7c+m7GN
	 sWqqHGBsLYSB9SqtUxQm691FkACjH23ZrGHWPl6v5k6gqjEU1KC0hLYfjf9RaMkzUASuN
	 XmLHulxZlM+LvPlstDdGPa1AbEYL8xijptBwa7Cancfr2gt4lIBumwjap47HsnwX77g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QiQrpYYn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FF7606A33E;
	Tue,  3 Nov 2026 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QiQrpYYn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17091F00A16;
	Tue,  3 Nov 2026 13:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793710900;
	bh=UPqeQa/mVG220HWF0/V8KsFL/bCL1ZrWZ3it7yA/Cuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QiQrpYYnbsdnlfY0Gs/3P1iZsdwWh3NlrOD491Hc7YD4K1CM+c+zQdOSiFEIq2Igx
	 wBJTwIUEKlDAaRvd4kpFNZKWt+Nu5WWC7AZha7kNOh2Yglwi4bMRG+E4/6tpkODHFH
	 31bE9B8SL07TsMy+q6Dipgibidj+HlM35Iuf6C3ZzdorjHB5vR3Hrno2PrhIrrSVw3
	 XOHcLhGJOCjR/mmWpg0pL5WdfzJskXTkZ6Fnnsy9Irg0+PJN1xavcNgwKGzW1nixMH
	 U/kCpydaUjWLTujtvlRj4d/D19X7fgGLRSg1rJWXgE3umtyKWhxyy6uGRcxwKa5e2Q
	 uqc/bcStLD0PQ==
From: Sasha Levin <sashal@kernel.org>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: drivers/s390x: select uvdevice tests using the target architecture
Date: Tue,  3 Nov 2026 08:01:26 -0500
Message-ID: <20261103130131.4069212-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014200149.1365017-1-sashal@kernel.org>
References: <20261014200149.1365017-1-sashal@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ping. Steffen reviewed this and it still applies on 7.4-rc1.

The uvdevice tests still never get built when s390 is cross compiled
(KernelCI builds on x86, so uname -m never says s390x). Could one of you
pick it up, or should it go through Shuah's tree?

-- 
Thanks,
Sasha
