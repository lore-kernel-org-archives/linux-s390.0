Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DD53368B1;
	Sat, 19 Sep 2026 00:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777921; cv=none; b=sgd5NFw9Hy54OxWis5m694rUef+NWqcfxwqsydC+DGvHW9vB1cU2TafsjosSw9RsL2qZ1pYBGqMpFQvUfQN3xpr9D4VD2ohhpsklSrXADr4fEYh0fca064gQoxxQZ49qKct5C85H6V67DBuibvW24DpURScaSKW3IW48i4tiayQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777921; c=relaxed/simple;
	bh=GMNQyeBlusY+4H0i8eVLGqHXOhBuv/CyzKuQjh/1xtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bJh66bbZLE59wdaqhA4jbuAnThNJcYyZI0rrMqKfWUpbMjcNYoungrlfCDcUgEuXY/KGnsR/MFGNKewhJlON/n1XknyUHGcN9mkbVpd5mVKQf6krEGezs7TTjn45m45hq9QXDpFV3ZquuYCpYkQ55ZD1x6ywzL01dDrzdGK90JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lxxiVmvX; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lxxiVmvX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=Wqb5iKIn7pHSmtRgWS6wBCsYSpV0OZZFytPa5NWq4PM=; b=lxxiVmvXNlTmgJYVe3XlD45lJY
	KtpTiohfjJsklMhxdA8pCDtcmb1AKapB/45ku7f0iw1NSnYybir1sHKzAycWPPafZ3ohdr8YTDLii
	BL1qcClo+CJ9M5VdFSh8nu5sQCtH/RuyjGRZG2mwnFFIbpK0oPW5/IRcXpyN6Dk2NvLqPpU6c9a2W
	cfi+kOIisaI/IyuE0CyWbt/O7TlixWSJxFajg9+ZlmeRMPw4U4uNUv9zg0oN4tAcXfjrJZol2PfIl
	7tGisjWyZLoaz+vFCibu+MRmpYIwxKFFgGb1ZOjahtzsJ/jBGPay+7t7R8BKoC3+TSxwV0z071s3b
	eoNquWFQ==;
Received: from [177.172.123.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x7izX-004Bwz-5l; Sat, 19 Sep 2026 02:31:43 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 18 Sep 2026 21:31:16 -0300
Subject: [PATCH v8 09/12] syscalls: Add an option for offsetting the common
 table
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260918-tonyk-syscall_table-v8-9-0e2d60cad13e@igalia.com>
References: <20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com>
In-Reply-To: <20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2

To better support architectures that doesn't share the same syscall
numbers, but have them in the same sequence, add an new option to offset
the common syscall table numbers by a value. This make it possible to reuse
the common syscall table for alpha.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v4:
 - I was reusing the logic from --offset to apply the --common-offset, but
 the logic is different: --offset does a string concat, and --common-offset
 does a addition to the number
---
 scripts/syscallhdr.sh | 26 ++++++++++++++++++--------
 scripts/syscalltbl.sh | 20 +++++++++++++++-----
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/scripts/syscallhdr.sh b/scripts/syscallhdr.sh
index 8f7dfcf19a4c..cf6bba3019b1 100755
--- a/scripts/syscallhdr.sh
+++ b/scripts/syscallhdr.sh
@@ -16,17 +16,18 @@
 set -e
 
 usage() {
-	echo >&2 "usage: $0 [--abis ABIS] [--emit-nr] [--offset OFFSET] [--prefix PREFIX] [--common-tbl PATH] INFILE OUTFILE" >&2
+	echo >&2 "usage: $0 [--abis ABIS] [--emit-nr] [--offset OFFSET] [--prefix PREFIX] [--common-tbl PATH] [--common-offset NR] INFILE OUTFILE" >&2
 	echo >&2
 	echo >&2 "  INFILE    input syscall table"
 	echo >&2 "  OUTFILE   output header file"
 	echo >&2
 	echo >&2 "options:"
-	echo >&2 "  --abis ABIS        ABI(s) to handle (By default, all lines are handled)"
-	echo >&2 "  --emit-nr          Emit the macro of the number of syscalls (__NR_syscalls)"
-	echo >&2 "  --offset OFFSET    The offset of syscall numbers"
-	echo >&2 "  --prefix PREFIX    The prefix to the macro like __NR_<PREFIX><NAME>"
-	echo >&2 "  --common-tbl PATH  Use the common number table"
+	echo >&2 "  --abis ABIS             ABI(s) to handle (By default, all lines are handled)"
+	echo >&2 "  --emit-nr               Emit the macro of the number of syscalls (__NR_syscalls)"
+	echo >&2 "  --offset OFFSET         The offset of syscall numbers"
+	echo >&2 "  --prefix PREFIX         The prefix to the macro like __NR_<PREFIX><NAME>"
+	echo >&2 "  --common-tbl PATH       Use the common number table"
+	echo >&2 "  --common-offset NR      Add an offset for the numbers of the common table"
 	exit 1
 }
 
@@ -34,6 +35,7 @@ usage() {
 abis=
 emit_nr=
 offset=
+common_offset=
 prefix=
 common_tbl=
 common_tbl_path=
@@ -57,6 +59,9 @@ do
 		common_tbl=1
 		common_tbl_path=$2
 		shift 2;;
+	--common-offset)
+		common_offset=$2
+		shift 2;;
 	-*)
 		echo "$1: unknown option" >&2
 		usage;;
@@ -98,14 +103,19 @@ emit_end_guard() {
 }
 
 max=0
-# gen_hdr(infile)
+# gen_hdr(infile, offset_nr)
 gen_hdr() {
 	input=$1
 	tmpfile=$(mktemp)
+	offset_nr=$2
 
 	grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$input" > $tmpfile
 	while read nr abi name native compat; do
 
+		if [ -n "$offset_nr" ]; then
+			nr=$((nr + offset_nr))
+		fi
+
 		max=$nr
 
 		if [ -n "$offset" ]; then
@@ -123,7 +133,7 @@ emit_start_guard > $outfile
 gen_hdr $infile >> $outfile
 
 if [ -n "$common_tbl" ]; then
-	gen_hdr $common_tbl_path  >> "$outfile"
+	gen_hdr $common_tbl_path $common_offset >> "$outfile"
 fi
 
 if [ -n "$emit_nr" ]; then
diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
index 70da0039ab22..1e9cac32c02d 100755
--- a/scripts/syscalltbl.sh
+++ b/scripts/syscalltbl.sh
@@ -16,14 +16,15 @@
 set -e
 
 usage() {
-	echo >&2 "usage: $0 [--abis ABIS] [--common-tbl PATH] INFILE OUTFILE" >&2
+	echo >&2 "usage: $0 [--abis ABIS] [--common-tbl PATH] [--common-offset NR] INFILE OUTFILE" >&2
 	echo >&2
 	echo >&2 "  INFILE    input syscall table"
 	echo >&2 "  OUTFILE   output header file"
 	echo >&2
 	echo >&2 "options:"
-	echo >&2 "  --abis ABIS        ABI(s) to handle (By default, all lines are handled)"
-	echo >&2 "  --common-tbl PATH  Use the common syscall number table"
+	echo >&2 "  --abis ABIS             ABI(s) to handle (By default, all lines are handled)"
+	echo >&2 "  --common-tbl PATH       Use the common syscall number table"
+	echo >&2 "  --common-offset OFFSET  Add an offset for the numbers of the common table"
 	exit 1
 }
 
@@ -31,6 +32,7 @@ usage() {
 abis=
 common_tbl=
 common_tbl_path=
+common_offset=
 
 while [ $# -gt 0 ]
 do
@@ -42,6 +44,9 @@ do
 		common_tbl=1
 		common_tbl_path=$2
 		shift 2;;
+	--common-offset)
+		common_offset=$2
+		shift 2;;
 	-*)
 		echo "$1: unknown option" >&2
 		usage;;
@@ -59,14 +64,19 @@ outfile="$2"
 
 nxt=0
 
-# gen_tbl(infile)
+# gen_tbl(infile, offset_nr)
 gen_tbl() {
 	input=$1
 	tmpfile=$(mktemp)
+	offset_nr=$2
 
 	grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$input" > $tmpfile
 	while read nr abi name native compat noreturn; do
 
+                if [ -n "$offset_nr" ]; then
+                        nr=$((nr + offset_nr))
+                fi
+
 		if [ $nxt -gt $nr ]; then
 			echo "error: $input: syscall table is not sorted or duplicates the same syscall number" >&2
 			exit 1
@@ -108,5 +118,5 @@ gen_tbl() {
 gen_tbl $infile  > "$outfile"
 
 if [ -n "$common_tbl" ]; then
-	gen_tbl $common_tbl_path >> "$outfile"
+	gen_tbl $common_tbl_path $common_offset >> "$outfile"
 fi

-- 
2.55.0

