Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3FC3D7D67;
	Thu, 17 Sep 2026 23:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789688787; cv=none; b=pBKP8tav47B+iHGuRmvVcJWH++NKnPqU/L9Ua3ArdntINJGbNN0BnRv5zqgcae4iQmVygW7735t9NJMV2q2LqNFVdQTvNgcHvTIx3RJ2cb7YgJPQ72U5CavdHKrFukR/cdYrkWCf4vFoGI7wc1IpslanF4DrDJIh4CPXlCkMlYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789688787; c=relaxed/simple;
	bh=voYeUFRGxJF51AdGg0Ie0IWOP6zIt8JXqOyKZWKsO3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L4kzJrmZJoYrfVIuprRw4S1R7bOpC01qecj5N1jE/41lefZvDNsiBTcwvp2VE90hdxQb5nh8lRRof6sVapggJi6aMn/csMEeQY65Cnz9+EF2KZk2b3EmJUX5WLGXY+rMYwmn3EfRD2MU773CnfJjJYBTk/vwvv3dPJYvlJqVkyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=mOExCMnL; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mOExCMnL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=1Mqf8IivruERMP6fZwT8V4CKtJjvaF7LKzl37WPzoRE=; b=mOExCMnLTSkGvTyRiMXOatBBID
	K20rA0fJ+RktEBh2RY/p4i3ZZFxSCk4K6B2GAu/uxcPp1mupcsvpC8nIfsUW8a6gs0xivk8kv4xHB
	XrH5FKh/9pgaj4pHdoWK6RmH3APuNRH3kqWVp/Ze7jko/NwXwQxfV1RxHsyCoJPMC+WUKYmzXmkLW
	qaMmJGSNvcyppesurdnMZCPyEwsogWTNL5RpPOzpMKt3MEQzEzAvEh1ko+ULz8j43VYdsgpSdpioe
	vu4a3O18+Jfq6l19eN5uCo8DlIQqF88sEc0f1LsDMksulIDUhdZWOvhVsGjnZCCQawZfXn+dzr8vd
	SCaQHUIQ==;
Received: from [177.172.123.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x7Lo4-003hU7-TS; Fri, 18 Sep 2026 01:46:20 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 17 Sep 2026 20:46:04 -0300
Subject: [PATCH v7 01/13] syscalls: Make --abis parsing more robust
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260917-tonyk-syscall_table-v7-1-f4cd8f8e3265@igalia.com>
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
In-Reply-To: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
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

