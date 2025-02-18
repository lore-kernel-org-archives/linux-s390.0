Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A96280A23;
	Tue, 18 Feb 2025 20:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910537; cv=none; b=WjQBGkQdK4Svd/wMYApLvI10AbpjY+hOKU9hvXJ2TQaZ68VmyLLCyyzaNNJiEz7UR4fhecFgd5bIaL1q226aPG0nw8b1f0SuuKEROt4iljcFUbb8P+GybL/ztu54sQdLXPi0ZnUH2Xs7CamthMTrpBVFDxr+WhqChBpyjLj8q+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910537; c=relaxed/simple;
	bh=eCFe3biFrcui9zB6tpRuPT6XU4Sxp6BBITULgziPVUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VpyrbmKW7UjZXDEL8UalS8p19JUqaZzsVpbTKPjManE7LMmcVCZ5WEKQJ/Vr9lldN2d3EYwOFTSEUe42Nti/d9kpb7/bpYkDF7zoCg19qQQ+f0WwOBIErm78LodiQJsEMULuCZlO+XIBMXfEPLf7YJJ86bYtLzETS2IwxLjNAis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U716OKs9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U716OKs9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64174C4CEF5;
	Tue, 18 Feb 2025 20:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910537;
	bh=eCFe3biFrcui9zB6tpRuPT6XU4Sxp6BBITULgziPVUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U716OKs9l3Mazonm30HNeB016p8s6SxsOl5jMEA84JXgUb9IrXfXaggJhFJjrN/+i
	 ru2G3IPuNbZ6H1HDGxtoP+vbmWgFz7JOcbCbbzcgAK7VyA9QMWQp4843y6wEM462Uv
	 qb+0HzZPztNYpWbb5/5c9ZIb0h7LP2wAyDWjjx2i34igg6a7Nq401m+DiOMVEQkCiI
	 2QPiW51uPrLxMLdq/++4kR9cSvPU6tb1sxbUAtaxlXcA4EzkkYgkBTOEM0zTJO6RWC
	 IXmCI1rbrCvLMhCtbcFsG2/H06/d+Ag6taU3p2gx9QsQ21232oS8vjnVq5el5FlV4c
	 AFBEe6o+QAx/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	hca@linux.ibm.com,
	agordeev@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 4/6] s390/cio: Fix CHPID "configure" attribute caching
Date: Tue, 18 Feb 2025 15:28:45 -0500
Message-Id: <20250218202848.3593863-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202848.3593863-1-sashal@kernel.org>
References: <20250218202848.3593863-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
Content-Transfer-Encoding: 8bit

From: Peter Oberparleiter <oberpar@linux.ibm.com>

[ Upstream commit 32ae4a2992529e2c7934e422035fad1d9b0f1fb5 ]

In some environments, the SCLP firmware interface used to query a
CHPID's configured state is not supported. On these environments,
rapidly reading the corresponding sysfs attribute produces inconsistent
results:

  $ cat /sys/devices/css0/chp0.00/configure
  cat: /sys/devices/css0/chp0.00/configure: Operation not supported
  $ cat /sys/devices/css0/chp0.00/configure
  3

This occurs for example when Linux is run as a KVM guest. The
inconsistency is a result of CIO using cached results for generating
the value of the "configure" attribute while failing to handle the
situation where no data was returned by SCLP.

Fix this by not updating the cache-expiration timestamp when SCLP
returns no data. With the fix applied, the system response is
consistent:

  $ cat /sys/devices/css0/chp0.00/configure
  cat: /sys/devices/css0/chp0.00/configure: Operation not supported
  $ cat /sys/devices/css0/chp0.00/configure
  cat: /sys/devices/css0/chp0.00/configure: Operation not supported

Reviewed-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Tested-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/chp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index 1097e76982a5d..6b0f1b8bf2790 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -661,7 +661,8 @@ static int info_update(void)
 	if (time_after(jiffies, chp_info_expires)) {
 		/* Data is too old, update. */
 		rc = sclp_chp_read_info(&chp_info);
-		chp_info_expires = jiffies + CHP_INFO_UPDATE_INTERVAL ;
+		if (!rc)
+			chp_info_expires = jiffies + CHP_INFO_UPDATE_INTERVAL;
 	}
 	mutex_unlock(&info_lock);
 
-- 
2.39.5

