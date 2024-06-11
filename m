Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267D63CB;
	Tue, 11 Jun 2024 03:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718075843; cv=none; b=cmPgt/8t5tecvDZx5qAZnHnV89aH0hG+Nw4a/gyD41+S1Lh0B7DInG3PkilwPTrdAi3uMv4PA5MAywrOoBGOmg8xFcd438xQ5OevION7a8wfUk2wLlnuf7117CqsymzzUJ+uw1RDCjhLbooiqpYcH2OzB+Q4XTRwuNZP5BzgpwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718075843; c=relaxed/simple;
	bh=/60qOc7roiLWpgrlHYTsf+6kSPuXUzcO/tFIko6/+qw=;
	h=Message-ID:Date:From:To:Cc:Subject; b=SAxQutrCVsWmoxMrl6jv05QL3wcxc1E8q7GM4SMFTN2Srd4NFE32R+DrrzKO4Fw04d5TUAaGUoVIUaNZzKNUYuKv2w0b1nIu4hcLk19jXcG0dv05MccLFgv16kE4/whPKsT/12odw54uyXGBZfIwSheXaExFWsOXjoU18cq4E3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A354C4AF1A;
	Tue, 11 Jun 2024 03:17:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sGs0v-00000001JgD-3KfX;
	Mon, 10 Jun 2024 23:17:37 -0400
Message-ID: <20240611030934.162955582@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 10 Jun 2024 23:09:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org,
 loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Guo Ren <guoren@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 0/2] function_graph: ftrace_graph_ret_addr(); there can be only one!
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>


I noticed a slight bug in ftrace_graph_ret_addr() for when
HAVE_FUNCTION_GRAPH_RET_ADDR_PTR was defined and fixed it up.
I then noticed it was buggy when not defined. Looking for an
architecture that did not have it defined, I couldn't find any.
So I removed it.

Steven Rostedt (Google) (2):
      function_graph: Fix up ftrace_graph_ret_addr()
      function_graph: Everyone uses HAVE_FUNCTION_GRAPH_RET_ADDR_PTR, remove it

----
 Documentation/trace/ftrace-design.rst | 12 -------
 arch/arm64/include/asm/ftrace.h       | 11 -------
 arch/csky/include/asm/ftrace.h        |  2 --
 arch/loongarch/include/asm/ftrace.h   |  1 -
 arch/powerpc/include/asm/ftrace.h     |  2 --
 arch/riscv/include/asm/ftrace.h       |  1 -
 arch/s390/include/asm/ftrace.h        |  1 -
 arch/x86/include/asm/ftrace.h         |  2 --
 include/linux/ftrace.h                |  2 --
 kernel/trace/fgraph.c                 | 61 ++++++++++++-----------------------
 10 files changed, 20 insertions(+), 75 deletions(-)
