Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FBC153BED;
	Thu, 23 Oct 2025 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761248233; cv=none; b=PLaVLXXWJHc1d3oTJ9IVoK923g+mHw88H7j1CYaSF/lWGNVmubTn6hDA5jYxu+08FYw9SZRalVYx3AgmpjB1uzbPYwqZ25LWVvrGOeagAVl/+iE278kN62cUYcI0Pw/nu5q3aGD4QTKDR8RxcXD//wgDPTRM9FI/zb/RJwgbLEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761248233; c=relaxed/simple;
	bh=YzEWGZmOR1ZzkAVa9qNqrBy8pUhjP1sUUnmuUwaRu/Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rHg5PebXvw1Ri900pTRNAPy9KtNZobZVOVi4K9E7kmQNVMTgX982Vbb030aE+YFluJ6AlVp/c/1GiHaTs37b8ci22cFM/uJkxboUeUzQvEz109WmViB56roLWvenVfw1sThjbI3l8wqjbofRUmkiRMw+OMf2wpLufYkK7Ob95R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dLsp0uLP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dLsp0uLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB76C4CEE7;
	Thu, 23 Oct 2025 19:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761248231;
	bh=YzEWGZmOR1ZzkAVa9qNqrBy8pUhjP1sUUnmuUwaRu/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dLsp0uLPWekxHARRJY9I56LQT7EjVK7YH9xOAP30+gDKj9B52ln3XAUP4ELZ39mZY
	 K+A62aiunMFG0gdYxj2rTUoxhFnAPr6De3/xzxkUJr5hONiXH9HwXTquyxjlQYr5xJ
	 stKyHK6HmSZFHc5OKgjczVyvfDWzbxH+/sDEOFkA=
Date: Thu, 23 Oct 2025 12:37:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Andrew Chant <achant@google.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens
 <hca@linux.ibm.com>, "Paul E . McKenney" <paulmck@kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Brian Gerst <brgerst@gmail.com>,
 Christian Brauner <brauner@kernel.org>, Francesco Valla
 <francesco@valla.it>, Guo Weikang <guoweikang.kernel@gmail.com>, Huacai
 Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jan Hendrik
 Farr <kernel@jfarr.cc>, Jeff Xu <jeffxu@chromium.org>, Kees Cook
 <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Michal
 =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, Miguel Ojeda
 <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] init/main.c: Wrap long kernel cmdline when printing
 to logs
Message-Id: <20251023123709.e6517087325a3a53221029d9@linux-foundation.org>
In-Reply-To: <20251023113257.v3.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
References: <20251023113257.v3.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 11:33:05 -0700 Douglas Anderson <dianders@chromium.org> wrote:

>
> Add wrapping to the printout of the kernel command line.
>

Spose so.

>
>
>  init/Kconfig | 18 ++++++++++
>  init/main.c  | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 113 insertions(+), 1 deletion(-)

It seems like a lot of fuss for a small problem.  But this:

--- a/init/main.c~init-mainc-wrap-long-kernel-cmdline-when-printing-to-logs-fix
+++ a/init/main.c
@@ -944,7 +944,7 @@ static void __init early_numa_node_init(
  *   Kernel command line: jumps over the \
  *   Kernel command line: lazy dog."
  */
-static void print_kernel_cmdline(const char *cmdline)
+static void __init print_kernel_cmdline(const char *cmdline)
 {
 	size_t len;
 
_

will make it a whole lot more palatable, no?
