Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E891E7080C
	for <linux-s390@vger.kernel.org>; Sat, 12 Jul 2025 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752351299; cv=none; b=FKmE7Ms7U90joF5PkJeynWZlsR4iKSRxJP6Zg8kWqp9cAJJnaHpZDh818vcOk0LkN7nfnpSRcgsezVnPROpsL3GBDpCFS/AtzKEJ70SzCypF5IaFb1NvzlbkUyK60r02nXjEm3ChddfePSQ6KytPewXzkge0SjfsbJYGn/SAAEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752351299; c=relaxed/simple;
	bh=Az09RGSg/CWES0TEpg5AmHj9cs8SpA23n3ISythda1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dGlSa0lE/PW/N94sq1xCzPlqDmFBuc6HBfgSUsEIeQMzeLkvJ0iN0+H8A56GCb8qxzMPGm+9DoiFmLbr0oOvYlzVFhXuXfHirQ+SeFjtTUMgLHp4R/ktz5eCvryII1VjpKb/hbReiMfzr7hlyOOflgBptj7XRGrFgm5q6NFXS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPMXff9W; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPMXff9W"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4e57d018cso553009f8f.1
        for <linux-s390@vger.kernel.org>; Sat, 12 Jul 2025 13:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752351296; x=1752956096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c2H/5n9iiow4hm4TqJZcD/kc8dTmrePwwyGHqrCmV0Q=;
        b=HPMXff9WKmCdNPkKYzPSq7xgjeqd/hkmI3UVNGS3JxsafNxmIeDBEAEGaHK4DH9zMW
         g9T5/FpYckWkb1Ou0d3Krv8ac++aDyH9TGwE0yPvubjohvVQ46fWYRRZO+pkRChHvqxA
         J/1lcbjKJeQtiTkqoPM9JC10IR0P8KHP/4wQizoP5gBp95bs4RjmgNcXnNvBszFLnvIZ
         SPg2dV63sextEOFYL3w/fs7cwn6tdpQ3SbUar24DTgn8UypX6ui74jxda9SCTO9AFbbd
         A+S48Aklg+WilSyDP8iTthIIDkxJrMkA1wce/7Wr35oKUAfI+1pCWB+2iBSS7YtXK8kS
         u97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752351296; x=1752956096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c2H/5n9iiow4hm4TqJZcD/kc8dTmrePwwyGHqrCmV0Q=;
        b=IQXdYk98af5X90UBNFzl36Ee4nA0EfqU8UjifAhrrcFv1D5GjbmAuGyisL8ynxYdnt
         cFuAP5F+JJd68peuYoLsYIP3AduMLUsWBZ1HDD27jiIUHjDDog8VwevYaDQEfcLdPcNX
         6+Ll2gtDVuD7NTfoj/lS0XBSV7OnOCwE+U7DRDJJIyseD23qOL2GM9d2sjiilM87c36W
         79A0SfzCKOMXj9+dyLcMWuxcNILX6fesH/+6ivZ2qX2iDCpeMTKlfacJ64XxH/z+DwWM
         odX5kZfsF5CqXsRBVTdvYjeTGQeUTakXO8qqQWDVuiZhljwfXxg+YJBI1SMpXrs9ogvu
         MvrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoanb5Nc4avC4CaVXn5QHRi8alEbzK3dDOl0orisA5U6chNc57WId2UTrEGyFuA+zJn1jKUlita+v1@vger.kernel.org
X-Gm-Message-State: AOJu0YyH8qbej3aIEU2p45cv8Tr50Br6e11RMDhHzHtKTmRVuOkhPMj6
	BKXdEHwaRlFLI//zvJ/HIVn2PhBqmE932qjcMCjPTdh5pGui7E3Diyg=
X-Gm-Gg: ASbGncu43Nh/khxrVvD8fUXhK9lnOxg7tCeQL2gGJz8qAt9sygf5UhK68Xf6avZO1ko
	CMon3YqVXpjrhQYHBO7Dyei2gOgc2VrwsbIr9WpewngOYgjiJdWzG2+RTRxAs4P9ldpnEJn4UYK
	cLyRUNbFnBCMkSNjooE8wD71q0LI1q/FcOQ83VxYcTF7mjStBf2lkBoV8DrhYAq0HgRgcj6kyUn
	CgO4EvUW052bWzdkRJMomMsiPVDJbgka28N8iK7TvZ5hS65WZKyiUa77HzBugeOL+4MnOMIRlmd
	KkzucYGcPWRNDElpic+O80cyehT5B63TdfZM/SCXx+jdYEI28vSi649lLTsJIIr2PNuk+LDayH+
	2sDQj6QwCs8IgEijd9A64aFCWmPC/jyUH4N3hxFEhDs3rj8/8BpyW62nNBXau/Q==
X-Google-Smtp-Source: AGHT+IHuIeAbzXw6/mJbD5MNQ/jWc3Nq/FoekJkkho10xMl4GNlABZqE63Wt9bw//KAWlR5mHOVVzA==
X-Received: by 2002:a5d:63c3:0:b0:3a4:e0ad:9aa5 with SMTP id ffacd0b85a97d-3b5f18e6cccmr2246206f8f.11.1752351295969;
        Sat, 12 Jul 2025 13:14:55 -0700 (PDT)
Received: from localhost (182.red-80-39-24.staticip.rima-tde.net. [80.39.24.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5032fc0sm121475465e9.2.2025.07.12.13.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 13:14:55 -0700 (PDT)
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
To: 
Cc: Xose Vazquez Perez <xose.vazquez@gmail.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Nigel Hislop <hislop_nigel@emc.com>,
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
Subject: [PATCH] multipath-tools: fix default blacklist of s390 devices
Date: Sat, 12 Jul 2025 22:14:53 +0200
Message-ID: <20250712201454.215404-1-xose.vazquez@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Each blacklist only their own devices.

Cc: Stefan Haberland <sth@linux.ibm.com>
Cc: Nigel Hislop <hislop_nigel@emc.com>
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
DASD devices been blacklisted twice, since:
https://github.com/opensvc/multipath-tools/commit/a6ff4f957c78bd15c49278ad359671a705eaf4b5
In the current code:
https://github.com/opensvc/multipath-tools/blob/de16cf82c5263fc148118be56ebf44c8f0ee60b8/libmultipath/blacklist.c#L233
---
 libmultipath/hwtable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libmultipath/hwtable.c b/libmultipath/hwtable.c
index 081d119c..4ca4245c 100644
--- a/libmultipath/hwtable.c
+++ b/libmultipath/hwtable.c
@@ -677,7 +677,7 @@ static struct hwentry default_hw[] = {
 		/* PAV DASD ECKD */
 		.vendor        = "IBM",
 		.product       = "S/390 DASD ECKD",
-		.bl_product    = "S/390",
+		.bl_product    = "S/390 DASD ECKD",
 		.uid_attribute = "ID_UID",
 		.no_path_retry = NO_PATH_RETRY_QUEUE,
 		.pgpolicy      = MULTIBUS,
@@ -687,7 +687,7 @@ static struct hwentry default_hw[] = {
 		/* PAV DASD FBA */
 		.vendor        = "IBM",
 		.product       = "S/390 DASD FBA",
-		.bl_product    = "S/390",
+		.bl_product    = "S/390 DASD FBA",
 		.uid_attribute = "ID_UID",
 		.no_path_retry = NO_PATH_RETRY_QUEUE,
 		.pgpolicy      = MULTIBUS,
-- 
2.50.1

