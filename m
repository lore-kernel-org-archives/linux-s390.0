Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71BD13A24B;
	Sun, 28 Jul 2024 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181512; cv=none; b=ld/Wzbhe+XevYkUk2WajPwUNnxysDttKacRAGbDqsM7x6SworBekgeMk3d5jun3ikNK+k++zr3bhbuZnT4kiXMJT3y6UgA2P7qr9Opq0YX8OQxLYfKYQDlibkVb2WNatXJUxYtAnH8eIHGIq/2I8dOEgP8sOYSBJ9zDluQGx7eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181512; c=relaxed/simple;
	bh=fu9IFAHAFSVZXRrNmnKacWWm82vIqE+AmfedSfWIhuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3PXquZ2USBnifiMP/3JzTWIVGAcM/z6Pp849B/ePlFsKOCLeXCBMgu4vkLgRuFih0qVtAi6Y0IzSyVFRXz1yfA+97gEfJaXwVdL3pv/fIfsPRi824HA+/+YIaUD2831dPa4V8B1yCJ791NEJ+wVinAc/udnCm8Ls3ilmfBdlig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emCip19s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emCip19s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF23C4AF0B;
	Sun, 28 Jul 2024 15:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181512;
	bh=fu9IFAHAFSVZXRrNmnKacWWm82vIqE+AmfedSfWIhuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=emCip19snW+SY2MZLlFYbvchg2Mmcyv16Vvg4dfPX+C1c41dL6sgFhMb4A20Q/u4u
	 /FIyrgLHsFMjsEgiXje9BAoTC6aTbfRnuEQVMb0NsFeV6YTP7AAAp+CscD9YUIycsz
	 nyopGgiROv4QJn1tLtCQf5BdKYXD9NiMQtc3DYcW/kQmGlsrzINeBUYS1V5xgIJP72
	 3mzgXy4ZW7R+lHxqsKnR19PiPdfCGLjUlL/P7vRSUWuatODgBAB8HNIoBO1suKYaQH
	 1pJHO1Y+3+36wDMHROllSJVI9DzTkDfmA+AVHK/pOUc58NctEw2HREU5ePyprPqbSo
	 hAiR3K5QIQspA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	gor@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 32/34] s390/sclp: Prevent release of buffer in I/O
Date: Sun, 28 Jul 2024 11:40:56 -0400
Message-ID: <20240728154230.2046786-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154230.2046786-1-sashal@kernel.org>
References: <20240728154230.2046786-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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

