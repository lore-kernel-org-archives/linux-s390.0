Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909178;
	b=zC7qBSHEPJdXb7rVwv4tuDA4RbuLzQCeRh7iK2mpmFBKXgLEWtdUVh1QLnGVblGoQAmv
	 wNWxFmeB53q4v+bP1QfQFZoNrQotjiJ2HmwydXkP961J32uiZ4MccUkBvwBJGCxMYZXn9
	 a2tdhzC7kHEc7zov7Rwi223bvgX3UcFoMdGIZzFHPcaJL/1DpAzNuDaBJtq4U6e6Uf+/k
	 YP2qK1JWXn4tjgI0B9MFIokbKwCod5g6F1zaZPvVO5sNsl3wLhTYjBbcDr+qEor+EFQip
	 yxxwJ8XTtDWk0e1aufvCrjPNtT9ocWZDN0+Z9ilT+xbJmrbI7ZkZDlcvF51lVpSA1vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909178;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=ghv/kVh+DDT/S1vdhxWYjrzdDtHKz7Fz5jBxCLbdbeY=;
	b=UvDslghUG0c7niCLS+lBREwTKh87JiASdjRy4fvpUue45e/38e+47hLBPE9GjaVqnplJ
	 P/JJH/i2omsyl0mPV33zJBX2DT+6kh29qegxqH69UhnbNgHuSFi1+wA3/fI2hvEeiq49h
	 19Co32w998+6xAViAH8kTNpV47lNEVAb9v9IsM9aK0FyYE8JWpX6aPwlng6ebqJlORF6l
	 Q9dYxzXEQ8PWWJQGe/6z3PESjK74d4z5Qnb9M+o0pMCSgrhSxhoqSmBfjIRg/HEx8WhZX
	 w8LshWUBd4Lc+CapqBPWrSNVlmp1ra62ndiRw3f+rhhqq9VpjeE66V4nvBSPOCzBuLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=NIxMsvxo;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E03606A328;
	Thu,  5 Nov 2026 20:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61E03606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=NIxMsvxo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=ghv/kVh+DDT/S1vdhxWYjrzdDtHKz7Fz5jBxCLbdbeY=; t=1793909176; x=2109269176; 
	b=NIxMsvxodj7h76uDgJYS3gBvliFG8bTAzj58/a9HSR7qbIzvUZ+ekO875uPljc6uVEHISzFoyH6
	65KaA2F+qGq3CfQwYEzKm7odFY2I79ZLqfqT3UvSJMil2cU+IoGQdtLL1lZTr77mpBEcWXRVLqzgL
	ihD85lqYVPgAZ64+u/MvZrNjCiaB6tyKjJZXuQvnsd86Rr181CUAc5WWyYzq92P8jA3FVaP9BG/mt
	qGpQcFBPIcOy+7dl/8FCyuxQivnIxbleEGb2NpcUnx9ZTSgoyumR60P3FlNNamRL1w40qwaMGlpzT
	u+z7ZZor7decrIYNhz/E6LwkseEyLoxT9jHg==;
Received: from [177.172.122.137] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xP3iq-003hS1-MV; Thu, 05 Nov 2026 21:06:08 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 05 Nov 2026 17:05:36 -0300
Subject: [PATCH v9 01/15] syscalls: Make --abis parsing more robust
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261105-tonyk-syscall_table-v9-1-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
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
2.56.0

