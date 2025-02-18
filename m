Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2C123472A;
	Tue, 18 Feb 2025 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910551; cv=none; b=agO8a7VwzMc2FlFYIcD7VOHaMOqU7dndqlSl0Kh3mjqv9RdMQB14TkHMkHDfo6e6zg5UlwYueN6RBjZt4Uk60qTJaymLKZy7+RcNiNSYydA5S9LSIdMqj8dGNE2F3vnCHlsbWSAsft2EcKr4vZbzRzRv4vv6XIP2TfBBU1/7n2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910551; c=relaxed/simple;
	bh=U7qPuXalWb4LIeb8BXR0SZjS2Oh1QwM0RdKEnSuLcpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WhjxlXrPCZ9XGaBgXq7ER3RJR1IBYXtIIjRbEJwmfev4evz3XhelD5ActRk5qjaCq2tqaYOVZ+R84zhccmqm52QiwSEDuM7WMkD4w7I0shFxAFSG7alqV67WmqzG5/lpGpgS4Xo3gGhOmpmqKGAYyLSPkc2eaDWUCe/3VshUBgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1N3QyCI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1N3QyCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC2CC4CEE2;
	Tue, 18 Feb 2025 20:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910551;
	bh=U7qPuXalWb4LIeb8BXR0SZjS2Oh1QwM0RdKEnSuLcpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I1N3QyCI7nA97tBjzv2bAHHiRTYFQK7FRfSn195ZdroJ77Mrtvnbd/sRHrnMZMV1/
	 JXY341LCROdiBY6mtSOOqH1hOokSybsW/o8MRnixHHFr1nMtdHR7psBat6Z91MYRCG
	 vw7CcLnr7/e4G9vqk5+o0//+lCQgtq6Yzq33lBlm9hbR+xsPXHcob4hXpHB52woro1
	 wHmOUzvFwMYwiIV8c3IO+FvbTE+pdb0wnawI7lDEi7CFpSZgS8F1V8bCX9oy2ZIjRx
	 bmSslZTwZY8oa3OEwVmMB23zMlj8LHFwx2RbDO/tqBq+9AJY0yPK/Ab7MsskZfdhEZ
	 4TnB2i3RSvB7A==
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
Subject: [PATCH AUTOSEL 5.10 3/4] s390/cio: Fix CHPID "configure" attribute caching
Date: Tue, 18 Feb 2025 15:29:01 -0500
Message-Id: <20250218202903.3593960-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202903.3593960-1-sashal@kernel.org>
References: <20250218202903.3593960-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
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
index 93e22785a0e09..0b84ced33b3ca 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -646,7 +646,8 @@ static int info_update(void)
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

