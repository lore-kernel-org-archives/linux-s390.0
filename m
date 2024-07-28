Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2129A79DC5;
	Sun, 28 Jul 2024 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181746; cv=none; b=KtqbK7gkLp7b0bNsg/SlDawEBkbCyE+x8iEFvCzV6ytsdpmnlVa+lbzHB+ZLkHFHZ2jqR6kF6jW6Czf8v5qo02PZAK0sSe42R4gmTGwYUxWFmlK7P8KHxw5IQ59v21DRn+MJYdjUxdW58nCTA1bhBb+rmqkwuUKG6OCdI2q2SOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181746; c=relaxed/simple;
	bh=fu9IFAHAFSVZXRrNmnKacWWm82vIqE+AmfedSfWIhuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndlnrdkhCAacEX9831MPzEQD+LdWv+hgrum0GNDkYfWv9PqSGqtNTfWIxok5RVNKwvR9+vClI6XdPrR0x2M27BcQbotXjiaZn6BqLbJ5TFL4b3XPJOQd+7DQyXauXsmvpn5UUUeexQEqhEaXfN2co82oWiCYm3y3l1GB19P3s2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2sUt5wX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2sUt5wX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD13C116B1;
	Sun, 28 Jul 2024 15:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181745;
	bh=fu9IFAHAFSVZXRrNmnKacWWm82vIqE+AmfedSfWIhuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i2sUt5wX4EgiZq8+rNdmJh0Vgdl9dWal/pve8WQn4zQgO2LqmhDbSiCQTqFM9z3pC
	 coGC2xylqH0NRAZARJpP2AkN8ZxVrfl1T+5KEBInVk+T83gbxKbn2dqzZio4jB0nHL
	 0vCxRKm/Lz2F+67BnRBgR/mz4PXgst8np8yL8JlwOXH9EJSs4HBfZSzMJjuFPim+dg
	 AYGGI5ZGqiJOLU/j6cIcDUgiVF4kyts6l2Qsc3uBqfjXwaayms5H8FvKepacaVaFaC
	 PURyknU4D6BoD1bxVHrA9F/bXG+gTl0RHB7cZ2M4Nxlb4A1e5n9LM1uJRtWSKgm/W4
	 2sjULA6QjI+Vw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	gor@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 16/17] s390/sclp: Prevent release of buffer in I/O
Date: Sun, 28 Jul 2024 11:47:26 -0400
Message-ID: <20240728154805.2049226-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154805.2049226-1-sashal@kernel.org>
References: <20240728154805.2049226-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Peter Oberparleiter <oberpar@linux.ibm.com>

[ Upstream commit bf365071ea92b9579d5a272679b74052a5643e35 ]

When a task waiting for completion of a Store Data operation is
interrupted, an attempt is made to halt this operation. If this attempt
fails due to a hardware or firmware problem, there is a chance that the
SCLP facility might store data into buffers referenced by the original
operation at a later time.

Handle this situation by not releasing the referenced data buffers if
the halt attempt fails. For current use cases, this might result in a
leak of few pages of memory in case of a rare hardware/firmware
malfunction.

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/char/sclp_sd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_sd.c b/drivers/s390/char/sclp_sd.c
index f9e164be7568f..944e75beb160c 100644
--- a/drivers/s390/char/sclp_sd.c
+++ b/drivers/s390/char/sclp_sd.c
@@ -320,8 +320,14 @@ static int sclp_sd_store_data(struct sclp_sd_data *result, u8 di)
 			  &esize);
 	if (rc) {
 		/* Cancel running request if interrupted */
-		if (rc == -ERESTARTSYS)
-			sclp_sd_sync(page, SD_EQ_HALT, di, 0, 0, NULL, NULL);
+		if (rc == -ERESTARTSYS) {
+			if (sclp_sd_sync(page, SD_EQ_HALT, di, 0, 0, NULL, NULL)) {
+				pr_warn("Could not stop Store Data request - leaking at least %zu bytes\n",
+					(size_t)dsize * PAGE_SIZE);
+				data = NULL;
+				asce = 0;
+			}
+		}
 		vfree(data);
 		goto out;
 	}
-- 
2.43.0

