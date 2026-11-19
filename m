Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119766;
	b=r3ie9LknFQ8w5NyY+mnTQuDI3M+O3uGM6q7pGqT6dLyvSDQc+q0YC4u+njVIHh3Ez/Fj
	 ju5DIUog6bQEvsH5LPL9Xf98awUQwZGiLkIcTbZHe9IvtmVDj+JRKr0yZoK8PqoIy5yIj
	 5HPt2E+vEUyK1RNrBXAVBQMtTzRaQ1PDyaO8oCRVwZelXgMZuvLSRrjQAzY/ySjBM81R6
	 a3EKvuAgiiUSORfRKD7hU3BU2nMvI1GBQHq7lPCx46V9Xd8p+DHkBhv4/7BU2/1/OXTLp
	 bUsfDgGBy5WL/JEbkMdPAUtOugDHwG1SHV5Z3RWG2eR0OuEolbahbJrU9RycsZVT9Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119766;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=yNMTjhhXsIL4Mb+Flz3xYNDv20KzML1PcGmUq1IJ2BU=;
	b=j2GEUaYtUKXkjWeWq3pxmtaLXlj6+YeLYdqc9arODnVK+JkN8HRfL5UnkK0+1DK5rf/c
	 9/fi0jkEKHqrTZHsqndxhGa5HNIb1ry7dzU/ERWVb98utNtTNdYfXfldblyCFjOja+7No
	 P5Bc4AyEKPfH3u/6/EBvAJgMaSrZzj7iWNwIImXNu55oDaxdHYcoVT5MyTP43+nf9CHZ5
	 c6aXpY+vgHpmA+qAGUk2XvlEpV7+ncZbPbQ0wTn+1IRh3ROoL6mtBrbF5jFkfmZk0byCD
	 ajx+E2udqTDcAEsOExzXNI3GzDE2egR8kiIsV9AK4kZIPHKJKLNeU1l0fZG/hDgjBew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Zy2LVbbN;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DE9606E4DF;
	Thu, 19 Nov 2026 20:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24DE9606E4DF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Zy2LVbbN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=yNMTjhhXsIL4Mb+Flz3xYNDv20KzML1PcGmUq1IJ2BU=; t=1795119765; x=2110479765; 
	b=Zy2LVbbNaHM+iSQX8XGgB+kLXgNKLgBqqWaHZmWcodt8SNRGMfPwH5oc3CGNcqo+//fxySuETwc
	DKvocWU35Yes2lOQ/ijZVEB2+pV7bCJInoi5ls4Fe4aVqWWv679OFV+Ogi2Qw0bPQwREawWMADBiQ
	8+2MMVY1ffZD/JRqdRgHUhbYb+SbpWJDcCo3eP/wSwPt3ILXGgfSVHETxyxRtuWPSrl0XEjD446Sj
	yLzVCiqnRWgew6R/QFkAqhZ7Oj3aNk0Jjk2NB/vHgiVaf21R0NfX4jQMGC0HEkLCNCwsVn43hFk/Z
	lPxVFZ28/TwLl530dMTi3tTBmBf4cA4B6tlw==;
Received: from [177.172.124.218] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xU8ea-00000001cIK-0L1Y;
	Thu, 19 Nov 2026 21:22:44 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 19 Nov 2026 17:22:02 -0300
Subject: [PATCH v10 12/16] syscalls: Avoid matching substrings in the ABI
 parsing
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
Message-Id: <20261119-tonyk-syscall_table-v10-12-a7c9ebd900f6@igalia.com>
References: <20261119-tonyk-syscall_table-v10-0-a7c9ebd900f6@igalia.com>
In-Reply-To: <20261119-tonyk-syscall_table-v10-0-a7c9ebd900f6@igalia.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
 Magnus Lindholm <linmag7@gmail.com>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2

Currently, the abi parsing for grep will match substrings. For instance, an
ABI called `abc` will match also the ABI called `abcde`. Use the space
limiter to match a complete word and avoid matching substrings.

While here, add a true command in the end of grep command to avoid the
script exiting earlier and being able to do the cleanup.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 scripts/syscallhdr.sh | 2 +-
 scripts/syscalltbl.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/syscallhdr.sh b/scripts/syscallhdr.sh
index f2d670f45ec8..6372dbb1cb71 100755
--- a/scripts/syscallhdr.sh
+++ b/scripts/syscallhdr.sh
@@ -109,7 +109,7 @@ gen_hdr() {
 	tmpfile=$(mktemp)
 	offset_nr=$2
 
-	grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$input" > $tmpfile
+	grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis+[[:space:]]" "$input" > $tmpfile || true
 	while read nr abi name native compat; do
 
 		if [ -n "$offset_nr" ]; then
diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
index 1e9cac32c02d..403a604e7c76 100755
--- a/scripts/syscalltbl.sh
+++ b/scripts/syscalltbl.sh
@@ -70,7 +70,7 @@ gen_tbl() {
 	tmpfile=$(mktemp)
 	offset_nr=$2
 
-	grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$input" > $tmpfile
+	grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis+[[:space:]]" "$input" > $tmpfile || true
 	while read nr abi name native compat noreturn; do
 
                 if [ -n "$offset_nr" ]; then

-- 
2.56.1

