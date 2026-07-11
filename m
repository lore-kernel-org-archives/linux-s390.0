Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE263C3BF4
	for <linux-s390@vger.kernel.org>; Sat, 11 Jul 2026 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783772968; cv=pass; b=UilpnHqawMlqfZz7YvIW9OKA0pJr4UMFmZUU+dGNfHE6XUta1BGbQyKYAcfNzv8tS8b3MeCzrF5NOyQhxcvSbqmPac9f4KjQOoxoUZhdPw4OGWXIq4LVJ79j4WLp0L7FrvzTjs+xTpIhPSzV84Ov6rj4s9rUC85xZ5GRKx15hFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783772968; c=relaxed/simple;
	bh=lgplXt8OmmYK0O5s0vGlPCfavq5E5GB8C7ljQ3QichI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfjSMY4/cKeMDZ44GcXdaCdKqUAu2L6XiLewWQJHJhwGvRDmr39z7eqSc69sE6YIXOL/jO9SZrQAt7HaOM1zkKR8WxPBY/jzaSI3VZAydZvYvdkj6pXMSvN3JIu1zliH/M/wV6ViNxmLM/5/Y4tTzbbeWX+tKB1waXVnfzf1vyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhVAsJnP; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhVAsJnP"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-698a9f11776so2817329a12.1
        for <linux-s390@vger.kernel.org>; Sat, 11 Jul 2026 05:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783772964; cv=none;
        d=google.com; s=arc-20260327;
        b=ffwPJoc1+blIjiZUHXALfWreW5KhxZEq2Z3lDzSDywKQrTcGtOPpg4gPBMiaapS9RO
         RGyr4OwPMMBu7OP0jFc+m7Je7Rr+AkkQ1lghn9KD0m2cgxKy+x1PzZLV26InLVMv9thS
         bVKEsyG5znK0/RcMMAxqXjgXXaaXqrP32ZGQkfzrTNldICxppTn1bu3neCXRy2WASNz1
         9QP6xqolmYZH9jOv7msP7IbJjKC5c+41meW3ufGI+8DNvbIMOwQN4WU5CASGMevQW19/
         teZe2ReIvQ/RpSeP8DuPOtmjnpiD1TU6+QUFQ6QsXnaUcEGFIv0iVYzkhhls+yeiK7yy
         oPXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        fh=/ohxn80zQThjZe5NwSdkZbM6J2UqSXImzjn4Ny36v4I=;
        b=rbnlxfi3ZmPTU3ffTcPLwP+EenQr16UWpD9751IhjMSZEnk0Qv/EbEa5/Kk4y9/exF
         9AFrcVDEdO4ksA6C47mFxOsjcGzZCFa4yIZVsRg6whtoUzBKQoLTGBGqflnitnCuEedD
         TA+JYyH9lqlElodigxBlqzBbdlsPueYSwytvU80xt2f/FWzJdGe94Xf7I5sER4LrT2BX
         4lYvjQp8fjfybtsu3anPjlmZuieFGC0YX0Ulp7YsgN9RXA3pCRFea6e+dnu0xgXQz9Of
         QWlUH9cr5aqRTldgOvKi+KPDvL0UoDdOQaqrjgj5Y7PCDWnqI67pJ26xeysgoyXeiOk3
         7vKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783772964; x=1784377764; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        b=KhVAsJnPccLQtlT6BW0pZOI6M33Kq5peNIi+brKc9mXt9N7FYBNxZiwumx0gXF4fIo
         sAO6rzobNlVEoIHs9Nr5Ud7Pqw06Wde6xz1P1K2kPK3YZyfFF/QcLy13zXrkpb8v6zCE
         wa1FryKea8CiALQ/FW+b66R5gxrKvaJKvQ5Z1BuPJv6JghHzUORCw6XB09TKL/k9s/1r
         i0N8avEwa/AHjCgBU1q0AZKoEW1/H84E5Jz1kEDp/nKMXzLRh+UDioLCoc7tRKEjgsZq
         3/2AvXjdSUp8fEKFVNQm320lqiCV3PxeKpLmb2suZXyxqugmSpsqzHjcuuYpicZfDTox
         leNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783772964; x=1784377764;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        b=KYV8XxQmFLw+uGJsxDsWQzykpD1JJ0mn9m2/XD3VYy4Y33arWdGl2qHX1NwFBVPDtY
         Fs/jIX83Du36e+2XQh66MjCnA1zEZNuDSNNsRfF/EpWbohmzABXMYHGCWVPCANG9rUa1
         J7I1CB7hMktWdJHLtc8pO6waSRMjRcSLAQFEL9XUl6gex2XUbOnanQvGIEPbRCYHc80G
         9rmxHj0mgTcVfUZ+k3h/u2rPs9a//qaXFBKf7+KDI6xJORzVtj9WNFeISnaA+H+Q7Yg0
         wbxMQaBkO8JEpWmBAits0KM4yT617QHzHRAmGV5ZMg+Tk50dwAYlkNbAXGf7QmfFT4Qj
         o6RQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr5YK0hkgMkL9mPoJzIqReYB488D9FVNCNYFo1k5nA2gWxy4RIMyFaKKCXmg88bWmk44Ca/IC8T8SBv@vger.kernel.org
X-Gm-Message-State: AOJu0YweJygM0fMxojOkn7qk4YK3OGLf7DiDwT4o/eD+ei7HvrdOnDo4
	EhaCkNBm2Aq5x76dCtO5G9IwRMYwOxvxg2k58ZhO8V1sgmvRvv2m0cTU0p/NTK+e99w23Hh/eI6
	/ISgi5mtjbvcPHSomGr+vKX6DEwJEXrA=
X-Gm-Gg: AfdE7cnrlr45NsGugu/0vC/9WMDVkpDz1tfKIfZVG3i3+CFFLw69P12c5FqlsU0NI4o
	jxvOk7/ajbi8Tqf6lP734t0idpXqEsjyyDzUGI+fyWEcJOPiRD4OgEQCfdVeNN3Q4trwcJC+sHo
	KnzDAUT7Lficr/CZEtjtBY38TyicieO50/fAdf5xMMOSbaeuGRj/2DBzfTzPtYL+MQ6K/Sk9oYA
	fPFAG1dI6bqrGrtkuYKEIkSOSxJDkCN/xBkzo578xeaE3rvJ9hl8UL/w+2LcydewgCMd2D2P9//
	DC85yYqYOXJk3pt9/IbZFZ/terziQS+Tc/e87/uB9L8y5ybGVqq/qndq4yYp/eQ=
X-Received: by 2002:a05:6402:3512:b0:699:728e:48b9 with SMTP id
 4fb4d7f45d1cf-69c5edb9cb3mr1210325a12.0.1783772963919; Sat, 11 Jul 2026
 05:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org>
In-Reply-To: <20260707181957.433213175@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 11 Jul 2026 14:29:12 +0200
X-Gm-Features: AUfX_mzOlRB8ana7x7qPQc4frMU9J060tNH0Z2GPCNvL1LYqDKQBjM-XzHbrvno
Message-ID: <CA+=Fv5RpgQ-UeGAT+VcLufte2gAp0H=J5GqZEFR_SuQsmnzy=A@mail.gmail.com>
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry handling
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org, 
	linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> With that all architectures using the generic syscall entry code follow the
> same scheme, apply stack randomization at the correct and earliest possible
> place and skip syscall processing depending on the boolean return value of
> syscall_enter_from_user_mode[_work]().
>
> There should be no functional changes, at least there are none intended.
>
> The resulting text size for the syscall entry code on x8664 is slightly
> smaller than before these changes.
>
> Testing syscall heavy workloads and micro benchmarks shows a small
> performance gain for the general rework, but the last patch, which changes
> the logic to be more understandable has no measurable impact in either
> direction.
>
> The series applies on Linus tree and is also available from git:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-rework-v1
>


Hi Thomas,

Thanks for the series.

I have an Alpha GENERIC_ENTRY series posted and planned for the next
merge window:

https://lore.kernel.org/linux-alpha/20260706170019.2941459-1-linmag7@gmail.com/T/#t

Only its final patch intersects with this work.

That patch removes Alpha's architecture-specific syscall_trace_enter()
and syscall_trace_leave() implementations, so the Alpha changes in
patches 11 and 12 will disappear once the GENERIC_ENTRY conversion is
applied.

It also currently uses syscall_enter_from_user_mode(), so I will need to
rebase it onto the new entry interface introduced by this series. I
expect the integration to be confined to the final GENERIC_ENTRY patch.

The Alpha-specific changes in patches 11 and 12 look correct to me.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
