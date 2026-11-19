Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119720;
	b=RvZAFQwXd2HFB/kJaUg0F/lwCPTcYGPBrLt9zMy+8hkMtKod6g/P340AJGBtopxVAdBU
	 e73CX+icWRiyGDqiRt43D28Z+Nsi0i6s/c66nYBatj4KjT94FM67IPvYy55P3rMQJtBPr
	 Si12U0Uy7sye2nmgfBkhpctz+7ryx40f5pstHvUnBcSxXzydF3oNZ+v3xLKBr/qAzvCv5
	 rABlz2rqd3JVcaTuP1oORlFu0uCjwTBm887JytaLg/u0HsgCdoXZaEhrzEcbDOt/I0GSd
	 meEViysp8K0jhe2OiZUgqv92q0MOYoCG8qtMPPRM+r7TXngLR9UUaJKGGj8R2mEJW0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119720;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=A3uG7/gpB0iY92Gq+oLwrC+DGDmsjpq9q8rzd1WGlUw=;
	b=lMS/jhuGcoEVIzmy1foDvMjSf0gsazWhRCuZvgkeG3xsXPBObKi0C6vPMbbsIThsdKj/
	 BMp61MTaSSICUyznM8KOhbEAAqbvRJlhSjKhbVxJMNGxlt0VvBfVm8MLQHPEvyB/sNXE1
	 m2eR4JOs+Da0rQ96k0D3qGiXefIa3xhRKu8hmL56JBIpf4n/K5pkRFUYynrR+4jtE4iIU
	 dU3YjwGIY3Te1vveb0VDnt487GeQLmwR86I6meDNcyeEtT04ls4dXQyhQcvSvzM9LG9Wg
	 XL8hGC+x3t6TWVAKrns+rDruW4A8Hzzqrs4+rXcnDnXs+je75VEgGlm1BQCBv+WyaAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=kV4zTTtH;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDA1606A325;
	Thu, 19 Nov 2026 20:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FDA1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=kV4zTTtH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=A3uG7/gpB0iY92Gq+oLwrC+DGDmsjpq9q8rzd1WGlUw=; t=1795119720; x=2110479720; 
	b=kV4zTTtHHKrHVrkhdCi5i07vJSe7d/IcV/b/eyTjt5jJr7O2kON8ncijRKo2zTWsPpnTJjXundq
	rEZMd1Z9C4giVNIwRs889senYbSBcNk0u+bYb8lO8pS7wQsWIQSDEFXmA7A5AufDaONQtgAZANkic
	GAOa2yyUFEcCROcax7JwEDHj44vpMrnE6k+DgpHcbeuJRyY7LKnZ1sKYLaUwxxpN0xOfOkk77KTlE
	fGx/usnhrxvcmX78dEJrILjqHDrsC+CvTja+TRErRj/7IcmNf9Zlz4oQyrl6GsPsknTWBmR2KBGA/
	nc/EBORJstNhYmXLooRVSi2Gjcr9ngb65h+A==;
Received: from [177.172.124.218] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xU8dq-00000001cIK-1ufW;
	Thu, 19 Nov 2026 21:21:58 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 19 Nov 2026 17:21:51 -0300
Subject: [PATCH v10 01/16] syscalls: Make --abis parsing more robust
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
Message-Id: <20261119-tonyk-syscall_table-v10-1-a7c9ebd900f6@igalia.com>
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

Acked-by: Arnd Bergmann <arnd@arndb.de>
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
2.56.1

