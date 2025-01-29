Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768E3155C8C
	for <linux-s390@vger.kernel.org>; Wed, 29 Jan 2025 00:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738111021; cv=none; b=vBl4rYVOMLmBItPkJ6aFyAJSsQ4thvr/Hivg4nwVHCmbo3zbZe/xVsFKKODsoBVsNQFV5rJixgYpiACXu3Y8xHanwPmLhrxakNQ6V9MMHNHlg5M02rWmorWly8AZXEjlvrSf/sFYOG62rnf8MLqYJNA44jXztmrnjvFc+pPGm50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738111021; c=relaxed/simple;
	bh=BvflY9ZJgLT8GK71Vf3t40ymigycEOgSdWxbDIEo/50=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=K2rXL5oeCE0ysM4U0hB2kGGyAv0dWMbXMRzM1waiJKIioHHq9naRG0ZyqSwEsyyrdEAReLFHb0ojbG8DRbZuO7+vKDOWi7p7JRJ5D7JYPVIGBty25X2W2JuSzZDX6uMU3vo1IKQMqqpw2K8f1POjf+3dm5LyJlZRrK0QGd+1Duw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vo2MhWIu; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vo2MhWIu"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738111002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BvflY9ZJgLT8GK71Vf3t40ymigycEOgSdWxbDIEo/50=;
	b=vo2MhWIucuDx9N3eK1xznV69rHhfzzkionjso/3kiteA5auCtc9Kjrn0FyX7EeK/voMmVj
	FqNEMNUyzIziwwm95VZ2L39fvp5mbdCpsDw6AJm8ox8g1kZXaIrms27DLax4PLw9YXZH8m
	memF63g0wyrwDAabSacanUbEkoeIOe4=
Date: Wed, 29 Jan 2025 00:36:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <36780a0c327fe6fe0fee1c05ba04368e46d30a37@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 1/2] s390: fgraph: Fix to remove
 ftrace_test_recursion_trylock()
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Sven
 Schnelle" <svens@linux.ibm.com>
Cc: "Jiri Olsa" <olsajiri@gmail.com>, "Masami Hiramatsu"
 <mhiramat@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev"
 <agordeev@linux.ibm.com>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, "Andrii Nakryiko"
 <andrii.nakryiko@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-s390@vger.kernel.org, "bpf"
 <bpf@vger.kernel.org>
In-Reply-To: <173807817692.1854334.2985776940754607459.stgit@devnote2>
References: <173807816551.1854334.146350914633413330.stgit@devnote2>
 <173807817692.1854334.2985776940754607459.stgit@devnote2>
X-Migadu-Flow: FLOW_OUT

January 28, 2025 at 7:29 AM, "Masami Hiramatsu (Google)" <mhiramat@kernel=
.org> wrote:



>=20
>=20From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
>=20Fix to remove ftrace_test_recursion_trylock() from ftrace_graph_func(=
)
>=20
>=20because commit d576aec24df9 ("fgraph: Get ftrace recursion lock in
>=20
>=20function_graph_enter") has been moved it to function_graph_enter_regs=
()
>=20
>=20already.
>=20
>=20Reported-by: Jiri Olsa <olsajiri@gmail.com>
>=20
>=20Closes: https://lore.kernel.org/all/Z5O0shrdgeExZ2kF@krava/
>=20
>=20Fixes: d576aec24df9 ("fgraph: Get ftrace recursion lock in function_g=
raph_enter")
>=20
>=20Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
>=20Tested-by: Jiri Olsa <jolsa@kernel.org>
>=20
>=20[...]

Hi Masami,

Can confirm this patch fixes missed/kprobe_recursion BPF selftests on s39=
0x:
https://github.com/kernel-patches/vmtest/actions/runs/13021621468/job/363=
24248903

Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Thanks!
