Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C1974E09;
	Sun, 28 Jul 2024 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181858; cv=none; b=lnr0UbI66UTpmuKRu2Xf3IQwoAgWNc9m9vv3Mb1//zO5LPxkLgguHlB3oav0pbG0nR/9V/pDguB0kuvjCN+wZCQvF3kGqN5nyAoY9wtZLN05xbXa/5GTBMKMQ1H3jeSkZD8ZIjptfgOyp2bJuZmKmUd5Bd+aQmy007fzuQFqKs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181858; c=relaxed/simple;
	bh=MCl2thOrMpSD7UbCXdQ7fzx+9mC48PAXCPYzgWxy9SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laMGqLslOILIO7Bi7uQxPPsq4yT1ZOUNDmyxYtLogHtC3MNHVkpTEPdBDMoT0Tk2Ibd4UnJQd+wbWskjUpPL3EjpzeVp4+s1NHGWyq6kg/aZghEgd1sBWD2Xs/55Kpvk38nooOVe+rjl6XKIm4EZjOgyrdfsjazBFvEopGIs+3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGrH9FiZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGrH9FiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA11C116B1;
	Sun, 28 Jul 2024 15:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181857;
	bh=MCl2thOrMpSD7UbCXdQ7fzx+9mC48PAXCPYzgWxy9SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FGrH9FiZo2MTXc9hI0IXSdFF1rfV1bZ3DmBFV4Uq64GgQj/+BHqEgYu7QxBATOcEl
	 xGyKH1ABv55554BePbzH+YLTSaovZA6n2GOyPy6kLiG5bDSCJY0oTtdUL91QaIsLHV
	 u9wKZvYNIwBZIIIXYD2k+DJDMhDXbv1v9RlmuJjoCKQj5f1HuxMCvIVXwbFdhlEQ7t
	 d7Ky/8L6QM5gWl8svzmv1/8KafCcYe55jgFFdBpH8r4p84PKaPcokM9pVb7/o5n8hW
	 kvmDK5ZW/zCmWsvbrMhBAuykElPpbrKmLrPhWt00acNQ/eSFiScDADxyEonCKYDLpf
	 YkOMmnbndF/Bg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	gor@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 5/6] s390/sclp: Prevent release of buffer in I/O
Date: Sun, 28 Jul 2024 11:50:37 -0400
Message-ID: <20240728155045.2050587-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728155045.2050587-1-sashal@kernel.org>
References: <20240728155045.2050587-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
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
index 1e244f78f1929..64581433c3349 100644
--- a/drivers/s390/char/sclp_sd.c
+++ b/drivers/s390/char/sclp_sd.c
@@ -319,8 +319,14 @@ static int sclp_sd_store_data(struct sclp_sd_data *result, u8 di)
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

