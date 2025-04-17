Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FD522A4E4;
	Thu, 17 Apr 2025 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884909; cv=none; b=ArPW+7s5SwAbgxW8nepX7k5eQtkxaJ9R81q9/5ukTPiRv6pm2SRXSkcjbj+oNKlfqFFqLvSqDi/ThaFGs58p7POH0bqX79Cvwg0FiECBfoOfKhH9Xnqo84CZgYdrXhELppr0+FwH7aNVD0EfibzMyjqO5ljMFsWbZU5SyPUiluY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884909; c=relaxed/simple;
	bh=66bS5QBb657eQ1sSvW2Mhv3kn1dXH4D7eKai0Rsd7nQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QSyztdcgOB+W33jYEDzlIA8Avt4bBgSP0FBiwElyLwJdtjaCrVLZc0kZyTcvNZyszjUHtXYFvQ+V4OpslM2i0c9YtSrglq0HZUHdh8S8KnnMTVGHGJxsR3DDyjAHLM5FlbhjixGgesakQs7lEU84Bz86NRd7CaSQR9UyfuqMyUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYiMCS5W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYiMCS5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D256C4CEEA;
	Thu, 17 Apr 2025 10:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744884908;
	bh=66bS5QBb657eQ1sSvW2Mhv3kn1dXH4D7eKai0Rsd7nQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eYiMCS5Wqd+8xqVUU0chnaunEb4vdj2yLtq7e4P0xYghCVR+26Q771ORhUaJB8u5s
	 QcarUgHjE+c9HtMLC9d2J8MXRSeXPvngyJVcLflseom4UeRpx8ZqWpnp0nK1hdpyfA
	 ipSELIc1YhjZ3IPd5V5nRJyy55dwfOXRHGlqHBCOwOv6eFk3xaZipyl1LOjBXq06fq
	 alllMYVhN7oFLges4Sv4gfz86VcG9A0T5K+Gj/W0vZFMuuEziPScaxR3TwJp5VjKSZ
	 TnefYWHFHu1o0p0u4gP2lTJejbPUhRkOfCf0jw4MFi68bxeftqKKeKJEzwQp32+Zaj
	 tJQDHeyGK+8FQ==
From: Simon Horman <horms@kernel.org>
Date: Thu, 17 Apr 2025 11:15:01 +0100
Subject: [PATCH net 1/2] MAINTAINERS: Add ism.h to S390 NETWORKING DRIVERS
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-ism-maint-v1-1-b001be8545ce@kernel.org>
References: <20250417-ism-maint-v1-0-b001be8545ce@kernel.org>
In-Reply-To: <20250417-ism-maint-v1-0-b001be8545ce@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Thorsten Winkler <twinkler@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
X-Mailer: b4 0.14.0

ism.h appears to be part of s390 networking drivers
so add it to the corresponding section in MAINTAINERS.

This aids developers, and tooling such as get_maintainer.pl
alike to CC patches to the appropriate people and mailing lists.
And is in keeping with an ongoing effort for NETWORKING entries
in MAINTAINERS to more accurately reflect the way code is maintained.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c409f504e94b..fecaf05fb2e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21260,6 +21260,7 @@ L:	linux-s390@vger.kernel.org
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/s390/net/
+F:	include/linux/ism.h
 
 S390 PCI SUBSYSTEM
 M:	Niklas Schnelle <schnelle@linux.ibm.com>

-- 
2.47.2

