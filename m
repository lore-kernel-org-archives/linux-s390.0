Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932618;
	b=aCq9Ijf/muE6hobVY0c7kZBRVCV33St2AFCK5R6+Xf4GoFVeLLvdAQ2CPE3IdxYZGXkh
	 L7jXZTGC7LMIGSHcrAxobPx7jzLqPOX8pMRU0c8mpI6jVwFGXeT3apQqPcoi+fzjDyh3s
	 s6cxoWsCGebnrA+o8XU3C91G5/nbJ+8mEcOj7G+yL2lT4F/yEZkx4vf1l57J8CZW3jd4V
	 RgtVIpFzLWFGrRwMOt2WCG+YJmJM9nfOHaLZRRP36zaLKlWMiVVo7enftaMaKwp0JDXEz
	 PaoYOrEGh51xntoq2rT7TI+eAymlLQ0kzrZE39cX+5u1C0yEx5715xRg31+HTgViFBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932618;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=9bKC9y5sYZUFVKo3cJF968X4JmNJ/KKgeW9i3uCsAQ4=;
	b=A+ukAeFaYfPQ0bk2ctaJgbEjmYpPac0VMpFW/Z/InNCj2cXWAUvBNIE++0KK/hd9TRPB
	 IP/YdKz61PA7cCMudYQjryf7+3BoeImjNWOnalYzHuhXy5Bynji+BCWQzrjnDvD1YWdNj
	 VUOjLNUEz0Ql/qJ7nOn2UBc18RkDMXVxH8JmqmJzcDx1JQPpExFY4qpUpMWHaiPNz9v4Z
	 sDytmpE2gpKehJNfi3DdeeVusBI1yy2E9h0Hn9KzqmT5QTADOjTpWj0FeXhnBkokxTyQY
	 dzsqrpl3W01k9rLZp0UzY4bmwpCuIXbpgp55fPEBBP8tbMwROiQ/m5b8vXGt7QbbinA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CabdkIqe;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884CC606A333
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 16:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 884CC606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CabdkIqe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794932616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bKC9y5sYZUFVKo3cJF968X4JmNJ/KKgeW9i3uCsAQ4=;
	b=CabdkIqelw7y3LuuSNZmZZWIrcLfGGA4pGkOQ1mcywVJUecBHr6tmfUpHJSrWKbCPUuK7z
	RQY7PJdKAvG/Tzwskc+Rd4wUn998F5GMdWqTEJKujlftWcF0lucjAybh9yigs/wvwlfXq0
	h5z9e+09fNQohC1UroHEHBPz0JIaPZs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-XavX1kWgOCO_-y1dC__RfQ-1; Tue,
 17 Nov 2026 11:23:30 -0500
X-MC-Unique: XavX1kWgOCO_-y1dC__RfQ-1
X-Mimecast-MFC-AGG-ID: XavX1kWgOCO_-y1dC__RfQ_1794932608
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D234E19560B5;
	Tue, 17 Nov 2026 16:23:26 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C0C371956054;
	Tue, 17 Nov 2026 16:23:20 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Tue, 17 Nov 2026 17:23:26 +0100 (CET)
Date: Tue, 17 Nov 2026 17:23:19 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: linux-kernel@vger.kernel.org,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Thomas Gleixner <tglx@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, "Dmitry V . Levin" <ldv@strace.io>,
	Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Davide Berardi <berardi.dav@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org, strace-devel@lists.strace.io
Subject: Re: [PATCH v11 2/3] ptrace: add PTRACE_SET_SYSCALL_INFO syscall
 skipping support
Message-ID: <avx_d9SSnpwhSyqU@redhat.com>
References: <20261114181923.370930-1-renzo@cs.unibo.it>
 <20261114181923.370930-3-renzo@cs.unibo.it>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114181923.370930-3-renzo@cs.unibo.it>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11/14, Renzo Davoli wrote:
>
> Extend PTRACE_SET_SYSCALL_INFO to support skipping a system call
> triggered via seccomp.

...

> Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
> [v8: skip via seccomp_ptrace_skip_syscall() instead of syscall_set_nr(-1),
>  separate ptrace_set_syscall_info_seccomp_skip(), reject later
>  PTRACE_SYSCALL_INFO_SECCOMP updates during the same stop]
> [v11: report the stop as PTRACE_SYSCALL_INFO_EXIT once the syscall is
>  skipped, instead of rejecting PTRACE_SYSCALL_INFO_SECCOMP explicitly]
> Assisted-by: claude-opus-5-5
> ---
>  kernel/ptrace.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 2 deletions(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>



Sashiko has some concerns
https://sashiko.dev/#/patchset/20261114181923.370930-1-renzo%40cs.unibo.it
but IIUC this is the "pre-existing" problem fixed by

	[PATCH v3 0/2] powerpc/syscall: Fix the return value of skipped syscalls
	https://lore.kernel.org/lkml/20261030084926.1068384-1-renzo@cs.unibo.it/

so this change do not need to depend on the powerpc-specific fix above.

Right? Just to be sure...

Oleg.

