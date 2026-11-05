Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909198;
	b=HQn1DZBEIjcNN/2a28szHIqiZebSOAEnDnss82iIEtC4asHHkScP46IpSDE4D7At6949
	 e/2/F/TudARvpJd8r4i0bYws+CJTICH6sF4l+ox+uzmteugUC2oWp2Wa96JMDyyTyvRqy
	 s8HjJ453iY+Lqz4I0Zb1I10A6EnEAnQMzGUcFXi+S+vQQTzzFJqV+KkaNAzjCfLDzL1W4
	 L82ll2LLz7giUj6AbgjkYMKE9MF5UFEXCf/EwmLjwLEAOExiCUJcZ48cPKQ1gw97Jkcu7
	 6YhkQwbrbRGKWNNhSjG3NfoVzK50ipTOxl0koUytEs5XxcXt5yFTXkoP7wYqSgJaZ+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909198;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=XBoDNkj8Cq94G4H4wOo3RFCe630bVSgYY6+2WlgI/M4=;
	b=dGG7xmWFXjC7DB1TxOF4Z7jpvmM6BrJ6IUdQo2ifRSZI8Zxfr7FSmw/Qpa2UpxpZhnFH
	 T/hDYejx2yidP4k3uEzOHf7s7cetbuhCx6aurU1kNYI3BbNpp+/Y91vTAkINVDmVKMYMk
	 ZVvHAaDAnr8XlMUJrioJL3MczeGnsYH/WX8mYQg4jeNtDU073uRoabnOm7iXySSSpSRAZ
	 RNclymE16RsXHFzgpp7OsUexyK/NxQwRIwpQ/1CTVT2epKLxNU3/t3dK+uBKuod53wd5M
	 jRK+3GzQddlOrizPvtICz+SO0w6QuUtEV74K8Oe8tIfsvAXd7fCiYFLBx5VMGYcZRZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=cpFGq1vP;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA1E606A31B;
	Thu,  5 Nov 2026 20:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BA1E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=cpFGq1vP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=XBoDNkj8Cq94G4H4wOo3RFCe630bVSgYY6+2WlgI/M4=; t=1793909197; x=2109269197; 
	b=cpFGq1vPG00mC/C5LufDxQKrvulJxpd+d/tN7XRN9qrYv2GPrnyoxoON1VjXN/fdUM91kmY2wpH
	8IP+r2MCJf0yzh/ssumuyrs7XlyMohsGrxVqhsEew/2KqPxClzz/6y8dr5YnFbIIiN+a8+q1S2+So
	bMcwfBWrGaERYELO76zit97VbfyMF7HzMHrI+T7BzrmS1lrx9krY98Bv7hQ3mVamyPD3m2s3PKePc
	hcv81eGuR+FSVLEexV2pgsvqR6JNSeJVmmbMyCIGWnR7l1QkpXjwb1BSq/kDK2EUeKGSiJHUeISqD
	zeR/WOrHfAz0OZxWKrQdRXljlU//hnc3LkFg==;
Received: from [177.172.122.137] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xP3jH-003hS1-Ki; Thu, 05 Nov 2026 21:06:35 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 05 Nov 2026 17:05:44 -0300
Subject: [PATCH v9 09/15] syscalls: Add an option for offsetting the common
 table
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
Message-Id: <20261105-tonyk-syscall_table-v9-9-8d1275885d9c@igalia.com>
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
2.56.0

