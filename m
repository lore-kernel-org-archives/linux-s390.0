Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664322080CE;
	Tue, 18 Feb 2025 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910419; cv=none; b=bjT2Y44eyl+Whn+eWKyXH8u4UhlXtzGu/aEyNcIfsvdf35jBPO9Q0Sysx/D5coLbKt7HzIoPNtABACe+AM3qQqNnGFW2DQ5IxCKnI5vzfy9ttf+DtOgWMAyazeKamfL13Jj8z5hj+79+NaV32kEHT8kdol6wCbuMoYXTLQb7O6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910419; c=relaxed/simple;
	bh=+BpSywo2RlI8BW6DOlE1otMjRAQJkJig6+pDphhevfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SWWwhHfILBb5H0xx1oQvbXGiYDl7i3cu2VQZweT0ue1zMGSaizJQQRZd8JeJb5fSGRT+F1CKuqIhiM7x+IOn1DBVhwQPqhF6PDe7BUUMsuqXMEXk/3fvwiiasJQzVEivFfqUXnBAX1TLMfuiBbv2hH/+2OyoS64iZ+cXEoryBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hvep/sNG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hvep/sNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38514C4CEEC;
	Tue, 18 Feb 2025 20:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910419;
	bh=+BpSywo2RlI8BW6DOlE1otMjRAQJkJig6+pDphhevfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hvep/sNGRESIUqOcBxcaw4Yf42g8NewRR7QPA0ZxtkcGbgkFq3DlEgqy8e1i6cPw4
	 bvowu75A7pWKuCeHWJQvhzHdrtBTHUbIULMvI8C5HnL+xv/54nxiVnzfIMfxzcqLGb
	 G9btS+iV31gMkZJhoW2/DUxtc3vj4UHl0tP714AtadATJ1x7FiAQI6ql/WrqPw7iJk
	 y5yoVAgjYXGbv6lE4Jldd3B7Mf+TXelh2dNsBQ53P8LDvuGMrl9BK+iDp0vrSPEeKc
	 PzyJa2L1S3duvVh2Ks/M93+JdQSSP7AHffSH3zeyGb33vzD9K266r4noCBytIwua2X
	 J1vobllgcTYrw==
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
Subject: [PATCH AUTOSEL 6.12 19/31] s390/cio: Fix CHPID "configure" attribute caching
Date: Tue, 18 Feb 2025 15:26:05 -0500
Message-Id: <20250218202619.3592630-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202619.3592630-1-sashal@kernel.org>
References: <20250218202619.3592630-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.15
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
index a07bbecba61cd..0c5bda060249e 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -682,7 +682,8 @@ static int info_update(void)
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

