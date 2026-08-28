Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E7D38AC88;
	Fri, 28 Aug 2026 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787959195; cv=none; b=S7nFRsBGApKq5STnLSrkXSclCew+F59mYplVlAYtn6V5QazPjsUxxW7qzN5e06a2F00jphJIzrqDxvi4yvgEcwPKmjVYUaBijIeiBtC0Pz+BJciM0OmDBgD92o+zbvUZieOMSUBkqcu1imYE2o3Bmvyh/lS87qw0Dvhly/mhYjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787959195; c=relaxed/simple;
	bh=voYeUFRGxJF51AdGg0Ie0IWOP6zIt8JXqOyKZWKsO3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U1OIxiv69q2Y9lcp1eMnuAWTNWcnor39z6mly4bCq7/aO/sSm2vl2NbW28bEf9BugOfSrE6U2kUxfRxckzG7wB0BWCinL9DxSXpT6ZkkeSt54xNoNY6oMWmzGKI9G65GWm3zuaxdva/4o0OqqC3t8TGbfh+3ji7HIhImg0uGFIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kApnQbtQ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kApnQbtQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=1Mqf8IivruERMP6fZwT8V4CKtJjvaF7LKzl37WPzoRE=; b=kApnQbtQ+Dg617qrBmTZu5xy5f
	Lbnimg8N/l8V7rNCeFVbJcEP8p7rAPDFM6+FLM1MLpk3/R2s/wGdqxGk+JMY2Cbq1i732NZEEEeAi
	fFw07E+np24+TEJZCvkt3IqkU9W6gSieQ7X19bnMSFcmZxaqrNSv6aVoN9q081NBZK+pQDxhyv/KF
	PWWNev7hAPz9ckok7XW+BdFezFHo5Yzo4s5EuYxVB0UXOUCcG1bhVP69cxpgCtD/BbrSrsj24TjyS
	C6T1hVi66MJhPhLp79eAkl5A7zvOexdz/lccuiuAKAAz+dOHdfSUm3/OugLnUjolODZdMyQMM31Tq
	RkhkZoZw==;
Received: from [187.57.78.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x05rM-00B3sF-2z; Sat, 29 Aug 2026 01:19:44 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 28 Aug 2026 20:19:28 -0300
Subject: [PATCH v6 01/13] syscalls: Make --abis parsing more robust
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-tonyk-syscall_table-v6-1-fdd358456cf1@igalia.com>
References: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
In-Reply-To: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2

Some archs Makefile have something like this as the rule for making the
syscall files:

  cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis common,$* $< $@

The $* symbol is evaluated to the variable found at $(uapi)/unistd-%.h,
where % is 32 or 64, resulting in e.g. `--abis common,32`. Sometimes the
rule for the file won't have a %, resulting in a trailing comma e.g.
`--abis common,`.

Currently this input is transformed into (common|). This is problematic
because grep will then match any ABI because of the trailing `|`. Make the
syscalls scripts more robust by removing any trailing comma.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 scripts/syscallhdr.sh | 2 +-
 scripts/syscalltbl.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/syscallhdr.sh b/scripts/syscallhdr.sh
index 22e34cd46b9b..bad1ab606a0f 100755
--- a/scripts/syscallhdr.sh
+++ b/scripts/syscallhdr.sh
@@ -39,7 +39,7 @@ while [ $# -gt 0 ]
 do
 	case $1 in
 	--abis)
-		abis=$(echo "($2)" | tr ',' '|')
+		abis="($(echo "${2%,}" | tr ',' '|'))"
 		shift 2;;
 	--emit-nr)
 		emit_nr=1
diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
index 6a903b87a7c2..c4b1f85c2dd6 100755
--- a/scripts/syscalltbl.sh
+++ b/scripts/syscalltbl.sh
@@ -33,7 +33,7 @@ while [ $# -gt 0 ]
 do
 	case $1 in
 	--abis)
-		abis=$(echo "($2)" | tr ',' '|')
+		abis="($(echo "${2%,}" | tr ',' '|'))"
 		shift 2;;
 	-*)
 		echo "$1: unknown option" >&2

-- 
2.55.0

