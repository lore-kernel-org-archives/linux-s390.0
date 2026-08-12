Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D5A472F63;
	Wed, 12 Aug 2026 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556370; cv=none; b=Ic4sKedHdr2uahY7B0O6DvmmwQvX61Svi0iGmDZPJHf4aikvekSL9BkTpGJeAbPh3rqYlHUqLmMNweHRhhDGV/ygq/BgyA27KHC9P+VmCvDuCpkNrJ5OxD230gMHjjF38aw91s7XGail2KGobhyam/z5W6pMEL6apiAK3kqUkF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556370; c=relaxed/simple;
	bh=7n4/mNhffi4PiabtnFY6nZirbsxb6pE2KF4dlxOp9Pw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=STwppHsGDA6sdHWpba+5jPnnGvLzUb3kK/3jWw067aryYjZSzt5ykIrFdFAvn4llQ6lRAxl+0mqB2Nx0Onjpu0mZfqvCNaR+EbAJei5VA2mTPG6mlSskt1UcpXS8g6/v/YPqOgNdLD4lYFDK2p1vxK/rp+FhFaeg1hqIJO1hpdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DabKBFQv; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DabKBFQv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=aHTfC3dF5n8o6o+Bek6YSTz5h62pHg3QZ+1t4sbI8bM=; b=DabKBFQvHbBV8v7/BxnV+pAklb
	AkZMZQjWY+akPZsvrb/lJ2ijV57ALF3EtFx6r0HVepGP99+TuuRmsv4fCBFqoPhIJtkTRjVijjpYm
	jD1bT5Iooigr86aeK3E61uystExJFI5qV19U0dyPFSJkZnjVHZWw7kkGY0042lMixezt9zghE7f+g
	k3PHs2D4NXPew4zyTpyemQqYaxznOI/n8f2lcvUipgENjF/XgQpr7AKOhY3axYFXviKcXAUt7g3xp
	X1ZfTYelI1dG1WtaUhj0CPJ5ev8loOIir8qCe2vt+ILScPqAREoVwPiG6sZNPESEdlqWawmRzYek1
	wJAE5nCA==;
Received: from [177.139.22.20] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wuCvF-000FR2-2u; Wed, 12 Aug 2026 19:39:25 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 12 Aug 2026 14:38:41 -0300
Subject: [PATCH v5 10/13] syscalls: Add an option for offsetting the common
 table
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260812-tonyk-syscall_table-v5-10-3d383927c609@igalia.com>
References: <20260812-tonyk-syscall_table-v5-0-3d383927c609@igalia.com>
In-Reply-To: <20260812-tonyk-syscall_table-v5-0-3d383927c609@igalia.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 kernel-dev@igalia.com, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 linux-mips@vger.kernel.org, parclinux@vger.kernel.org, 
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
 scripts/syscallhdr.sh | 27 +++++++++++++++++++--------
 scripts/syscalltbl.sh | 24 +++++++++++++++++++-----
 2 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/scripts/syscallhdr.sh b/scripts/syscallhdr.sh
index 54e09d3e686c..ce6819111c27 100755
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
@@ -98,18 +103,24 @@ emit_end_guard() {
 }
 
 max=0
-# gen_hdr(infile)
+# gen_hdr(infile, offset_nr)
 gen_hdr() {
 	input=$1
+	offset_nr=$2
 
 	while read nr abi name native compat; do
 
 		max=$nr
 
+		if [ -n "$offset_nr" ]; then
+			nr=$((nr + offset_nr))
+		fi
+
 		if [ -n "$offset" ]; then
 			nr="($offset + $nr)"
 		fi
 
+
 		echo "#define __NR_$prefix$name $nr"
 
 	done < <(grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$input")
@@ -120,7 +131,7 @@ emit_start_guard > $outfile
 gen_hdr $infile >> $outfile
 
 if [ -n "$common_tbl" ]; then
-	gen_hdr $common_tbl_path  >> "$outfile"
+	gen_hdr $common_tbl_path $common_offset >> "$outfile"
 fi
 
 if [ -n "$emit_nr" ]; then
diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
index 91c135143b22..aea00834dd5a 100755
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
@@ -59,12 +64,21 @@ outfile="$2"
 
 nxt=0
 
-# gen_tbl(infile)
+# gen_tbl(infile, offset_nr)
 gen_tbl() {
 	input=$1
+	offset_nr=$2
 
 	while read nr abi name native compat noreturn; do
 
+                if [ -n "$offset_nr" ]; then
+                        nr=$((nr + offset_nr))
+                fi
+
+		if [ -n "$offset" ]; then
+			nr="($offset + $nr)"
+		fi
+
 		if [ $nxt -gt $nr ]; then
 			echo "error: $input: syscall table is not sorted or duplicates the same syscall number" >&2
 			exit 1
@@ -105,5 +119,5 @@ gen_tbl() {
 gen_tbl $infile  > "$outfile"
 
 if [ -n "$common_tbl" ]; then
-	gen_tbl $common_tbl_path >> "$outfile"
+	gen_tbl $common_tbl_path $common_offset >> "$outfile"
 fi

-- 
2.55.0

