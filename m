Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A061FA94F
	for <linux-s390@vger.kernel.org>; Sat, 19 Jul 2025 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752932784; cv=none; b=K+QxMH/sb/6+8WWy8kEYSGvzmLZiP2J2HhLz+wSB909P0P31jmUTmaxbblBG09Gts0Cq1I/NIQsdtRVlifaU/MUVPxzAg8Wpi56ipmDOTPiOL9o5wDu1pSCTD2Vhc18qQE3rNbMlt0eWUcg9ZhfGLUA2fZsEcYa2rast8owgKeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752932784; c=relaxed/simple;
	bh=DjzqGzUlo/sIT2JaiMrDdXX5dhs5Yx23SsPHmVKfofo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HQkK4Zjggn+r+LF/We7QDKJYXbne11MxiROhyK4wC0nOSDWpb09mvopGFJtSDkvwsY4ZdQKDgxP9HtdYWVLj2YzDym1rynz4DHgqg+bWxOOHBiTBSkGLBV1g7P97TZOvJHArcKvF2+tRRS96J+IP6Gkc/RH9/m5KuHVaeHvIhyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwRCWLDp; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwRCWLDp"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4e62619afso314098f8f.1
        for <linux-s390@vger.kernel.org>; Sat, 19 Jul 2025 06:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752932781; x=1753537581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mHg5YvItvmX572ShvjvkOAwdnvh5M+a6tgw6nkYQPfY=;
        b=ZwRCWLDpJgiSeduVXA6s0lZhX3BohO0KiuTHI84sK2qhHSHlBO6Kek84rBwh1DApk1
         xT7O7ga1PQxtkI+zkCaCvfeIdrIdd7iwFXE+6w//O1MC0yLMO4JVkW65FBjCpLxQCTdb
         Vur2cRmleUqQuu3H3iL8HJomZDpVhPGBE2MpGlCJxj1IzR5XcFDIL3oFc+oskmHxiQx9
         M2DCx8GZPekpZIM0hKes1t79rSl/v+Z3CA0LtX5Ydfas9vPXv+puzbwE41KvOc3bxge6
         8uFYCpfH9HyyJQXgsfm6NygjQV+b2yRRoC8zS/O6+FKqeVqxjFy9wA2NPI35RCGipwZY
         Lujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752932781; x=1753537581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHg5YvItvmX572ShvjvkOAwdnvh5M+a6tgw6nkYQPfY=;
        b=RpbwK65RiD3GvkfkPNF758sq8v0piTa+4eJrv622+CcnBbQ7dW/jycRPCWAZdBTD12
         tUCeJXUboNWOtve+n8cZi0d4RsNnzAIAiSCRk1fq8CNZuGCBHVC8t/2ustpmrek1835K
         R6/A803cCjzF/AZ3pnrdpjabcR8X+F/0No1KrVEyb+u8eP7P94DZ6JZ88fKe6EYxOlTS
         xKug57qnXLj0Oo2Gjy0Jjqh5lVzY1Eowia3bBnaC1feHeuuAfigFkT/Yad0Ed903ME4N
         OXw0egMk1MNxbjdPgyFfM876mhAQlUqZcQdBSjdu4yiG9u09gNtJ3kb3T1mZNaKNZGxU
         diBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd1E4xJ0/J5GT+PnZDVh9JfbJDOWhiBO9jhoeR1w3xnb2Hbf2KOk0fOH+IvhcrT0cupVOEzx/U4pV8@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc4/TmVi6yQCoJ4/RXc/O93+kG0+24aTQWhcB+hTyABHmlDlAA
	VQt4TcfmVtdpSZ6Mh/xG4lfRzJVty00jZCmew+eOJiC9mF4AIBQPl1Q=
X-Gm-Gg: ASbGncsLEUw4GMpWYDdml/b9VQnC2xbt4qWoY3NsljtW5yll2j0mbQClKrQv0FEGSKp
	VPyN7xsbpm8F39TW8bLfiqtHqo8Ui9NLT7/qeTpN7M7RmXhYedp97qY7DjTuGTE/URSXQpRdFjU
	2O2gPUwUpDiAAlaPR+ZvueMndLXNfHSV9q18cnwRVSET9zpBPS6/ye2Eo+3lPNLsnjAgR62nZ+x
	9yVCYGzf5jCLIDatvKsfZOpAahAc+5qsXLnG04eSZgxM0hJ+466haGjPNtK8NT+XKyec2W/8Trm
	4x1NCZdWv/h2uWVAoaBBTSDrhP7sX2rzb0IFbRA3fIF79RU7eIDhdwWCB8ez/UNMMh87iA6mvv1
	XvDyEz3LKJDgQX+QAo+8BOTS6I4n1Q4Uao2qnQclAcGOrbsH9Q3cBnlWudPRd6KZsUQ==
X-Google-Smtp-Source: AGHT+IHJqkICjwjj4UeIVLdGFt/DJFe0i2365dtr+EpU6Sfit/vU9mDnwJT2eThsTkixMejgmYenIA==
X-Received: by 2002:a05:6000:43c9:b0:3a4:dc42:a0c2 with SMTP id ffacd0b85a97d-3b60dd4da51mr3277301f8f.1.1752932780664;
        Sat, 19 Jul 2025 06:46:20 -0700 (PDT)
Received: from localhost (179.red-80-39-133.dynamicip.rima-tde.net. [80.39.133.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d807sm4853763f8f.73.2025.07.19.06.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 06:46:20 -0700 (PDT)
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
To: 
Cc: Xose Vazquez Perez <xose.vazquez@gmail.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Nigel Hislop <hislop_nigel@emc.com>,
	Nigel Hislop <hislop_nigel@dell.com>,
	Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Hannes Reinecke <hare@suse.de>,
	Martin Wilck <mwilck@suse.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Christophe Varoqui <christophe.varoqui@opensvc.com>,
	S390-ML <linux-s390@vger.kernel.org>,
	DM-DEVEL-ML <dm-devel@lists.linux.dev>
Subject: [PATCH v2] multipath-tools: add a comment about DASD arrays vendors
Date: Sat, 19 Jul 2025 15:46:18 +0200
Message-ID: <20250719134619.331400-1-xose.vazquez@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

vendorid for DASD devices is always identified as "IBM". But EMC, HDS (HITACHI),
or any other PAV (STK (StorageTek), AM1 (Amdahl) ???) array vendor, are also
supported.

v2 - remove list of vendors from the comment

Cc: Stefan Haberland <sth@linux.ibm.com>
Cc: Nigel Hislop <hislop_nigel@emc.com>
Cc: Nigel Hislop <hislop_nigel@dell.com>
Cc: Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Martin Wilck <mwilck@suse.com>
Cc: Benjamin Marzinski <bmarzins@redhat.com>
Cc: Christophe Varoqui <christophe.varoqui@opensvc.com>
Cc: S390-ML <linux-s390@vger.kernel.org>
Cc: DM-DEVEL-ML <dm-devel@lists.linux.dev>
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
---
 libmultipath/discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libmultipath/discovery.c b/libmultipath/discovery.c
index c4bc6df6..c78e8b33 100644
--- a/libmultipath/discovery.c
+++ b/libmultipath/discovery.c
@@ -1669,6 +1669,7 @@ ccw_sysfs_pathinfo (struct path *pp, const struct vector_s *hwtable)
 	if (!parent)
 		return PATHINFO_FAILED;
 
+	// Identified as IBM, but any other PAV array vendor is also supported
 	sprintf(pp->vendor_id, "IBM");
 
 	condlog(3, "%s: vendor = %s", pp->dev, pp->vendor_id);
-- 
2.50.1
