Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088B218DF86;
	Tue, 28 Jan 2025 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738078172; cv=none; b=QQs7LWZa/6aq5TTaKJe7bEIoLjDcD6bAWdrwDw/P0jphDzaJfdethMRWXG97zB8WADP+qHtvdyHOmeLKsOyJmsVHbrQTnAz4dhjvboGqwUWS0Ca5EbAFsTsh64xb4uDo4NMJUSnlveyHvkyt7/ePkm4u9OGJ8M/NyRlt0+zXK9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738078172; c=relaxed/simple;
	bh=RuuXxZPia6DuJ5umY2SNZ3YcyuvBPgcgxU8Pz9gvt1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VpGSaqxwixa+ROMZN+efEuLKzCef7X2WLyETumy9wQEbWZ6X1seGmwumxbAuQrAPtuJMmSsgjwSa/A4dr9fFKwnP8MU/n2mRvomBfQcxB2l2XY2Lvz5V5JGt8qU9r9pvjp4yY+nHVwUU2djfod47NMa5XWbCg8fqmWhRfYno8Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FO3FEFaM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FO3FEFaM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26ADDC4CEDF;
	Tue, 28 Jan 2025 15:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738078171;
	bh=RuuXxZPia6DuJ5umY2SNZ3YcyuvBPgcgxU8Pz9gvt1U=;
	h=From:To:Cc:Subject:Date:From;
	b=FO3FEFaMgTmoRzp1wy6uEloVFoA6mwYiE2tPztntkN2q9vGAqqJRcCY3C6HORR7MJ
	 KTlxvYNiLjyAkSQe9LHynbTwViUiyvfWRG4lDk8kWpIQ7W2hlZeYFxdsPGoIScOfUF
	 k9cygrpgRL7eA77FrdsOvK8lTMsB2mGfxLBGoTJCpjoYRSlKiiuaIpRQPlzX/DxBAg
	 nJ8JD0OZ+0VP5rF+z2xTs2S8c+P9AyxJyfUVLOK8kbv3zlK2Z/8+odn2MKWX/qyxqt
	 bZ1vQWIEHrMxckXUgOFQYBpNSU0p6Hii6axMJ7F3PdMkXl9L5zaioaJm16HU/a33ko
	 EDtKaOstkqMCA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: [PATCH 0/2] tracing: s390: Fix fprobes on s390
Date: Wed, 29 Jan 2025 00:29:25 +0900
Message-ID: <173807816551.1854334.146350914633413330.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here are fprobe and kprobe-multi fix patches for s390 which maybe broken
when we introduced fprobes on fgraph series.

Thank you,

---

Masami Hiramatsu (Google) (2):
      s390: fgraph: Fix to remove ftrace_test_recursion_trylock()
      s390: tracing: Define ftrace_get_symaddr() for s390


 arch/s390/include/asm/ftrace.h |    1 +
 arch/s390/kernel/ftrace.c      |    5 -----
 2 files changed, 1 insertion(+), 5 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
