Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C9835D7AD;
	Mon,  5 May 2025 22:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485905; cv=none; b=GA5cg1KAmF8QRyw7znUhjDdwDWfphZ3RloXJzo1Iqr3Tn92lk0S67cf8TXy/NoKQlxuXhkfIQ23A9KngmIbz324dg/XZOGl72N6O1qSHCcXb6f5VWZvVqUquvXq8jCwkEcIIqBC4xler2QIYt4AE9byCnjGvDbb29jF1ATgLXD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485905; c=relaxed/simple;
	bh=vYBIDgjPuAT1pjrXhbJXLQ/c65u0Xv16gt1tFOp2Wa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YZuvP2MuNd5loomnpKNL7/6I7sfU3+n9gWLANLsxGt91NL7jXqFVP1RZ+b7lL3wJT0WaNW34waeXPERBxqYGqt7UEf9e5XMSop/BD6opkTBgo8YqaGy88cIjCllGrcWkkzijz/2PvkYOC1xOwGkmPu7DaEj2z1bav9+4Qdy74VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REIwiB/Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REIwiB/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BACC4CEEE;
	Mon,  5 May 2025 22:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485904;
	bh=vYBIDgjPuAT1pjrXhbJXLQ/c65u0Xv16gt1tFOp2Wa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=REIwiB/ZBAAHuLuKsz3Fu7cBarLd3qIEhBMNnWPnV7hkwaMSupZTKIqSpZetIdrsJ
	 KCUD86nnlgg+o6VBKdCmUPd3HEWimq++frUblEbDt/RinkLr0TO5CgKgYwrUo6Z/tH
	 PLSSkFUI7kMKP6TLgLmRPktNYk+IKANTOe4V0ogp1ZyhrAlUnZB/36h7BMzE5hWMHL
	 CUL9OF6tQOYJya+jJ6U9wjN0lV/82UclwcrF7WXUmDPyTApjrbytRnpg0RlbAv8V/B
	 xSUtSK/k/A75AveQK+XRLdVyTmAvwfCXGVeX2syy++aYdAaF4dox49/KFsjMzqMi4b
	 86IHMVuq1MObA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 057/294] hypfs_create_cpu_files(): add missing check for hypfs_mkdir() failure
Date: Mon,  5 May 2025 18:52:37 -0400
Message-Id: <20250505225634.2688578-57-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 00cdfdcfa0806202aea56b02cedbf87ef1e75df8 ]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/hypfs/hypfs_diag_fs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/hypfs/hypfs_diag_fs.c b/arch/s390/hypfs/hypfs_diag_fs.c
index 00a6d370a2803..280266a74f378 100644
--- a/arch/s390/hypfs/hypfs_diag_fs.c
+++ b/arch/s390/hypfs/hypfs_diag_fs.c
@@ -208,6 +208,8 @@ static int hypfs_create_cpu_files(struct dentry *cpus_dir, void *cpu_info)
 	snprintf(buffer, TMP_SIZE, "%d", cpu_info__cpu_addr(diag204_get_info_type(),
 							    cpu_info));
 	cpu_dir = hypfs_mkdir(cpus_dir, buffer);
+	if (IS_ERR(cpu_dir))
+		return PTR_ERR(cpu_dir);
 	rc = hypfs_create_u64(cpu_dir, "mgmtime",
 			      cpu_info__acc_time(diag204_get_info_type(), cpu_info) -
 			      cpu_info__lp_time(diag204_get_info_type(), cpu_info));
-- 
2.39.5

