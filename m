Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7262F823CB;
	Sun, 28 Jul 2024 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181643; cv=none; b=mVUAMlCh6C065o1JflddoMTsw9J7esEvBaLeECFfS1y51ysY+WqB2GQNzRwTTGcmG8h0LV46xf7kUlkxgHtxsBxMDGRNhLEyEUmeGSUbbdVxVLRLiUDspXKBGEaYXj4t0F60K9LF1jFCAG0VFJ/Mgtk3r0auzjVbkkJNW+o2V48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181643; c=relaxed/simple;
	bh=fu9IFAHAFSVZXRrNmnKacWWm82vIqE+AmfedSfWIhuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMfeeL7oar2JPNg7FjOgLnoPdi/Tmto/ozdMv3E+yHhUa/6lnDYPYvRL9tjcU3HVItxWqQgPSwo61TtRtfAyAz2GDrPQDTTHgDfe8PIZZLak8IDccrkqwsOCVWskQsBZpS+AWXMici1h7zp5h6+IDXNsVi6VbRxsnfZBeLhvFx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjNYT85P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjNYT85P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B75BC116B1;
	Sun, 28 Jul 2024 15:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181643;
	bh=fu9IFAHAFSVZXRrNmnKacWWm82vIqE+AmfedSfWIhuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IjNYT85PEEaMERS9RJLWmsgyM6MX2HYG4t4Ip2VYkA7isxH1cCOggDHufMt9RhvZC
	 hqpCU/MtB2kcv8YNwvUr+VQBnNF7M76Qr1iR4ju9D3YTYmiAFSryisCcyHEHNL95Vl
	 7Bg1unJ1P/3/eyV+NK0vLdqcBopD1b0pzFBlkC9Ew5kRmxGb08Gd4mLmTYlZcn5s5N
	 wUnwUnbPbWUMhCY0M3fCuobar0HTIZKS4PcVx/4SNSQ5c1L04/1QnBWLggmx8X4w7g
	 dG1flmyOHKsuOh4ZY3aqsPwPkduERKlRiOvHaVmAjgCvSDO+1T8h0UYUUVFjq9G+ph
	 R5ZhIgfWwyDvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	gor@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 19/20] s390/sclp: Prevent release of buffer in I/O
Date: Sun, 28 Jul 2024 11:45:17 -0400
Message-ID: <20240728154605.2048490-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154605.2048490-1-sashal@kernel.org>
References: <20240728154605.2048490-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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

