Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A76526F44A;
	Tue, 18 Feb 2025 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910518; cv=none; b=O+AeZT8pW53qpX97AQqbMLl8b1ROiYFE94eKapTrTycSPmN1+brhy0jnxj1EmMRmUbAtbsF/qL0eMkZEK3sH4ulR4iIFpXekH46XGns06cpYspNx8l6Pf0H1x3sqIjGZFc0t0PNgySua3T40nWCLf/Vxj6P9HxA5n1sJ4aI21r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910518; c=relaxed/simple;
	bh=vLGBBLNBJAfS7lENU56qjJ2IG9aknMIMjqvsAu9hhlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FHueNyAkJlDOfKx56oak84m2j3v2YM+Ryx6b3KwfYLjKvLbRsqLilKv2DXN1GWwKkXozNda+IkkXLOl4AShlZV9EKbHPIuEeHuJEEgSsJVb4o77l04ARss6trEdSjkw7yDG6jNoUBaumVcJcfN1x9j6O5w31Ur7HAqWyoCwdMsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6Dkar7G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6Dkar7G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3364C4CEE2;
	Tue, 18 Feb 2025 20:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910518;
	bh=vLGBBLNBJAfS7lENU56qjJ2IG9aknMIMjqvsAu9hhlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6Dkar7G2FAm4HRxH8nez/R+7AGV3p/w56H3RQP8OkMq/VNHUjK38S4rGGUvxgF2+
	 X3F1v/UaI5AWCd2260pHqjsWoCMRoU9vL73ju72gp6aiuFZsuQ4aTcnJONBtAZwMur
	 clxkTtsBjRBPkUeZkVmQC8tRR0s8XsK63b2vPYpq//GwFAFVwDZFR5JrVkQ3z2ibrr
	 VhXu+yxM1i2751iLVgmB9g0oqsf8Y6l+kD14dmECq8h0FD+5wyisk5fDpVN8wOaIsC
	 GE32w0YaJ4o+44nvAlXa2FKgkg5h7Lw0ZxguXjyWuOyZH3weaui4oMXh8fut2lCq9S
	 PSdVy5JmZLd6g==
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
Subject: [PATCH AUTOSEL 6.1 09/13] s390/cio: Fix CHPID "configure" attribute caching
Date: Tue, 18 Feb 2025 15:28:13 -0500
Message-Id: <20250218202819.3593598-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202819.3593598-1-sashal@kernel.org>
References: <20250218202819.3593598-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.128
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
index 5440f285f3494..7e00c061538db 100644
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

