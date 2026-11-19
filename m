Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119779;
	b=mQY2NM4SI98GI+5qk/03NPcgCsBwZBouQLiaK7Hfefi5hjzXeGE6bU2CGWKBzkprBPW+
	 jk5FeasBDv+mUxofJaUzRyMTjz9ybJB3HiG7Wrrs0Ph43VqhtmiBrCXtwe41mS29+BEmV
	 Wz3Bjrm3Q/TuseKZahPFWyZ5Tf4i39Y+fxDgy/u+mQiNWHKe34b3K/J5BN9V1pqel076C
	 5JJ2QdaIYDhPNBy6OBPX8uNNX5lXUTWiSB3cUzMPbSEdZNqk6fvwLewGZeyfL0xj3Bv9M
	 s5KHYp9xJzsIZYuCxbt6EF7Ie1IwpDMlUyDy23YV65HEdYRtCRLKot81IdWgTmZ9Vvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119779;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=Sb5ECHJq075NdZLr/aOmkhX0xJSaoLaGufS+947cOIU=;
	b=rFdJVGPjF4sBtlB7tofdmWDl6tlK7QUvcqkKrjwlKYmrWlAGXUqU7tH+Vt2t8P83NSuk
	 2geTX33FEI2AD02LR1ZJ+FiIIN5rfNTs5peHFWjOFYtyk8DDmRAxUJeK5QxqMuwZ0X2D4
	 X89/m1J+0ZnuffGwCE0AmXep3tR/MlkIvA9LVGdNwPa3FqcMfsMzOerxS1+hucjmDJfI0
	 WEyzDEI/cjZ882NqzSW9gzEo6QP9Ml/0/zqYhAFZuaW1Behw1vle5P3Vc33t2nJRfGsaq
	 iQi5nwpUYuaf5ob6ovc+AM8o1nlVqoIvNeexkz1aSzJ5dnF1rZTIj1tSdw5W+Qp/fuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=FpG9Fz6P;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0E2606E4EC;
	Thu, 19 Nov 2026 20:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F0E2606E4EC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=FpG9Fz6P
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=Sb5ECHJq075NdZLr/aOmkhX0xJSaoLaGufS+947cOIU=; t=1795119778; x=2110479778; 
	b=FpG9Fz6P/RuiSCWmVv8fnDyxc47TP3tFEeRmTudGHAV4u8G4FCUN2yvBeHk9E7EdDjgcmqoMjYP
	4Rul3thy1Tar4739oTSvagWqZBAIGUc1w9Jf1WZ0xW7OAlAaE1wC/wEW6B2SKS1KD7Brkkwk86VXA
	44kysKX9v8IFtKQ+N0mCpv95FCKNz0yaHD4/+dTm+CEABgGxjCqzkgjxYtc0LI4Gfyozd2OITN1xy
	fH0tPkz7vzcIsgWwrBAgZGv4goPrnedFhKyNXQt9SXqV9ehVwG9Lz0XHEF/Yi+q0/537lEep+7qPh
	VgpibggwbCyLy21z0HYil20yaRHMrHQgNZHg==;
Received: from [177.172.124.218] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xU8em-00000001cIK-1kER;
	Thu, 19 Nov 2026 21:22:56 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 19 Nov 2026 17:22:05 -0300
Subject: [PATCH v10 15/16] perf: Add an option for common table for
 build_tables()
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
Message-Id: <20261119-tonyk-syscall_table-v10-15-a7c9ebd900f6@igalia.com>
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

build_tables() parses the syscall table files for perf. Add an argument for
concating a common table to the local arch table. This is useful for
architectures that have moved to the new common syscall table.

While here, add an extra +[[:space:]] for the ABIs parsing to ensure that
it doesn't match substrings.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 tools/perf/trace/beauty/syscalltbl.sh | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/syscalltbl.sh b/tools/perf/trace/beauty/syscalltbl.sh
index e70a8c79e019..adc29af6e891 100755
--- a/tools/perf/trace/beauty/syscalltbl.sh
+++ b/tools/perf/trace/beauty/syscalltbl.sh
@@ -36,14 +36,24 @@ build_tables() {
 	outfile="$2"
 	abis=$(echo "($3)" | tr ',' '|')
 	e_machine="$4"
+	common_tbl="$5"
 
 	if [ ! -f "$infile" ]
 	then
 		echo "Missing file $infile"
 		exit 1
 	fi
+
+	# if there's a common syscall table, join to the arch table
+	if [ -f "$common_tbl" ]
+	then
+		aux_file=$(mktemp /tmp/syscalltbl.XXXXXX)
+		cat "$common_tbl" "$infile" > "$aux_file"
+		infile="$aux_file"
+	fi
+
 	sorted_table=$(mktemp /tmp/syscalltbl.XXXXXX)
-	grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | sort -n > "$sorted_table"
+	grep -E "^[0-9]+[[:space:]]+$abis+[[:space:]]" "$infile" | sort -n > "$sorted_table"
 
 	echo "static const char *const syscall_num_to_name_${e_machine}[] = {" >> "$outfile"
 	# the params are: nr abi name entry compat
@@ -60,13 +70,15 @@ build_tables() {
 	# those without. This default behavior of sort differs from that of
 	# strcmp used at runtime. Use sed to strip the trailing 0s suffix
 	# afterwards.
-	grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | awk '{printf $3; for (i = length($3); i < 20; i++) { printf "0"; }; print " " $1}'| sort | sed 's/\([a-zA-Z1-9]\+\)0\+ \([0-9]\+\)/\1 \2/' > "$sorted_table"
+	grep -E "^[0-9]+[[:space:]]+$abis+[[:space:]]" "$infile" | awk '{printf $3; for (i = length($3); i < 20; i++) { printf "0"; }; print " " $1}'| sort | sed 's/\([a-zA-Z1-9]\+\)0\+ \([0-9]\+\)/\1 \2/' > "$sorted_table"
 	while read -r name nr; do
 		echo "	$nr,	/* $name */" >> "$outfile"
 	done < "$sorted_table"
 	echo "};" >> "$outfile"
 
 	rm -f "$sorted_table"
+
+	rm -f "$aux_file"
 }
 
 rm -f "$outfile"

-- 
2.56.1

