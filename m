Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27223472A;
	Tue, 18 Feb 2025 20:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910563; cv=none; b=jBU6uvkl29ikNwRYW7YL/ozxBZ1BfiZzQXRxbRLmKz5I5RwQ1BjKU0NsEDrjyWXHzt7ZOG1IJdM2oGdkcJsXEZgoyUXQFe7FZWQ0g+DBxF93cl8TKYivuCoB2Zr0/GiTXzBWaBFGvwOUH3HujPti0Ezl61z7/AK/I+Zu7ibeV3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910563; c=relaxed/simple;
	bh=dmPRugDYWLomWeFIK7sg+U6WYeBFqFFsqpCpSW2sVdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SgMEBbyw3NHJViRlde+/oD6x8lqRJ1nrmeaa0axCszuF50ORJ2SbQVNWln3B/kBEZcf/ACrnfE/GUJuxSQe4o7AiYYinos4GrmBgkjoU1xignvrM42z3BJMSjcgBE01hWkIvqUvXJTihWbFj2z+5lEU8x+jeM361Tj2JDP6znrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cka1kJs1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cka1kJs1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668A8C4CEE4;
	Tue, 18 Feb 2025 20:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910562;
	bh=dmPRugDYWLomWeFIK7sg+U6WYeBFqFFsqpCpSW2sVdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cka1kJs1BZblNpbZwt1sK9VkMWY7N86Cm7yshD7KEnsB4KAdirb+2IdZYbcJSLln0
	 JOIxXvklBaOQ8LagwKoYhjjc8CZNiI5ETpCEI5bmhPfET8pcYJ2YSIjOTY5l/EgrJN
	 y15vf0iNkGSftlLpIgw8L6sPz7Vuio73L2gpIJre3vixZjALE0uabtSce21/kShHpn
	 6S7+InCjOv+tS46kier2GdyWZDt06PosPWz46lmNViXjC9f1d3a6KwR+r3DT3jh6dy
	 IAyD19BawKzRW68czJ8iO2q6jnH6nYjkZFGBEFiDtKDFrCTfquCmiIvYus2UBo9vvY
	 2HjIHv2I3oC6w==
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
Subject: [PATCH AUTOSEL 5.4 3/3] s390/cio: Fix CHPID "configure" attribute caching
Date: Tue, 18 Feb 2025 15:29:13 -0500
Message-Id: <20250218202914.3594039-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202914.3594039-1-sashal@kernel.org>
References: <20250218202914.3594039-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.290
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
index 1fd982b4d64bd..18b2fc50463ba 100644
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

