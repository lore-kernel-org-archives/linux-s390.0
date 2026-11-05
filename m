Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909212;
	b=BwFkW10q1JhtQvbpWc1pdrwXB4AFoziMSqWcQXGR/s40XBpA5yqTGGw2D0nDeA+2+sm3
	 CTy2fsOF8POPS2CWK146srtJS0J7PUedhUMpwIRycEgqk0g6XFEUx1LObJjloyj3WWA2W
	 LcI9+aipSqEsqWwaiMhPmZnyGjXv+ibOujjxFbPXS0uBl+2/X7Vc/DmaII3UX393eAhVc
	 0jtc+4GiUxxkWv4Eu/WZKAPh+dd4NZFyrqGPtA39Ta75iFeGycVmnRFgxQfLhkSQL8pTs
	 b4ZoUGnh2c8XO4TUobWwL75rz/sJH9frz+DlJxtb2t2fkiVpnrWeAiPwjqw+5Evw1pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909212;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=Kenou/u5GC+cXRy8kELS4DyKmMoQ5qDZG4ixNftcQaY=;
	b=QGcghQQnxBSc9yxp9T21ellA46StCoBh1FSSR6ZJR4IBbmVevsCgdTwt1aDhvXYAq5kq
	 bRQ+p5SX77AAIbiLNwoY0x/cBz7IVB2yM+Edsh9tDqGHi90gBjW4hEUY+lYBF10fBNtO/
	 kfDJglhFnB2P0eqW1VCq/URVbCf+Oj9VH8ZXqj2Gm67xRXoawklUyF4UTrkp0qHREyfEV
	 tG3yOBcQhC3aJ5J+Tzubs4cmExMFSTLmy4DWX/nHGNPBRV2lt7+9dEHQQVTmc2SgRtbMP
	 2weqj4vVf9rzF+2dWfofFmx/7kRJAJ9iLX6Yfb8J/LGjgcXQZk+6jrYavHxo4LNmxvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=UBo1KoQe;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA79B608361A;
	Thu,  5 Nov 2026 20:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA79B608361A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=UBo1KoQe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=Kenou/u5GC+cXRy8kELS4DyKmMoQ5qDZG4ixNftcQaY=; t=1793909211; x=2109269211; 
	b=UBo1KoQeJ0LwYCMi78fphbnnqbjMXCTteeKcaPngqrOXKFB3dDdrt2PtQjJ8qG7QYJeMybM0TJ+
	1YsAzbN2zz3ggtToZoq5oQhIRmI63SBhHkIp1BoClPDiadBfEVpZa6HS1+YHcxdaV1cv/OlNUyooQ
	28LXHjuMORSeyBuG7J8L5MBv2z/np57yPfVFS3AxyvU2Rfe7Hs3lUripzeGa/PS3bef/OMEpJQl8d
	kmYiA3NoFQqLq+PzpFSw21CEwpcpqpG0yAd7jRhSpTQduNHpugx7gc4kl8EqOPV1acFSkniTN0duG
	NeBKPVMbKH/khsST1QEXZhylrN/0g3BpzhFQ==;
Received: from [177.172.122.137] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xP3jV-003hS1-Dn; Thu, 05 Nov 2026 21:06:49 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 05 Nov 2026 17:05:48 -0300
Subject: [PATCH v9 13/15] syscalls: Avoid matching substrings in the ABI
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
Message-Id: <20261105-tonyk-syscall_table-v9-13-8d1275885d9c@igalia.com>
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

Currently, the abi parsing for grep will match substrings. For instance, an
ABI called `abc` will match also the ABI called `abcde`. Use the space
limiter to match a complete word and avoid matching substrings.

While here, add a true command in the end of grep command to avoid the
script exiting earlier and being able to do the cleanup.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 scripts/syscallhdr.sh | 2 +-
 scripts/syscalltbl.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/syscallhdr.sh b/scripts/syscallhdr.sh
index cf6bba3019b1..cf35ff05b824 100755
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
2.56.0

