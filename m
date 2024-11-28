Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C81192D77;
	Thu, 28 Nov 2024 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803841; cv=none; b=kWSY6G4evjApKOAcQ63zWgrhJHqNa3sk/fh0nHDIsii4VPEBtk4+mP0+coLbcCi0eBECHqq4Ne5+4GDrxTkZQ1al0fAoTVu9PiBygyALCmrFDp015NbwXx0n/Csc+Q1MMP9qKEe5Q09Kinfgj08w+5sFz9ulo/Lg8DRygJHEnjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803841; c=relaxed/simple;
	bh=bJWFdRpr/uhNyP6FFJSMDdD4MjytXEOwetPif1DgR0Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nm/pZaQrLxAl0+48NHr3T5UeNnh43SVtg7MtK8u6/6FtKt/FsVfpYmbXhgmEe3CfCEqpqOuq4TMjsOxYcJnr9suDNP8auQelXhPnU8QOMSgKhOETQ+nkM7XuhsYW3dj3TFOd4U3YU3vPO9dSS4+DgL1tTjHA4x6W5JxGxvBmj4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 28 Nov
 2024 17:22:49 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 28 Nov
 2024 17:22:49 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>, <stable@vger.kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Harald Freudenberger
	<freude@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Holger
 Dengler" <dengler@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
	<linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 5.10/5.15 0/3] Backport fixes for CVE-2024-42155, CVE-2024-42156 and CVE-2024-42158
Date: Thu, 28 Nov 2024 06:22:42 -0800
Message-ID: <20241128142245.18136-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

This series addresses several s390 driver vulnerabilities related to
improper handling of sensitive keys-related material and its lack
of proper disposal in stable kernel branches. These issues have been
announced as CVE-2024-42155 [1], CVE-2024-42156 [2] and
CVE-2024-42158 [4] and fixed in upstream. Another problem named as
CVE-2024-42157 [3] has already been successfully backported.

All patches have been cherry-picked and are ready to be cleanly
applied to 5.10/5.15 stable branches. Same series adapted for 6.1 and
6.6 versions will follow separately.

[PATCH 5.10/5.15 1/3] s390/pkey: Use kfree_sensitive() to fix Coccinelle warnings
Use kfree_sensitive() instead of kfree() and memzero_explicit().
Fixes CVE-2024-42158.

[PATCH 5.10/5.15 2/3] s390/pkey: Wipe copies of clear-key structures on failure
Properly wipe sensitive key material from stack for IOCTLs that
deal with clear-key conversion.
Fixes CVE-2024-42156.

[PATCH 5.10/5.15 3/3] s390/pkey: Wipe copies of protected- and secure-keys
Properly wipe key copies from stack for affected IOCTLs.
Fixes CVE-2024-42155.

[1] https://nvd.nist.gov/vuln/detail/CVE-2024-42155
[2] https://nvd.nist.gov/vuln/detail/CVE-2024-42156
[3] https://nvd.nist.gov/vuln/detail/CVE-2024-42157
[4] https://nvd.nist.gov/vuln/detail/CVE-2024-42158


