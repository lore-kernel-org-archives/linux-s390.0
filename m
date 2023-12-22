Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0C21773E
	for <linux-s390@vger.kernel.org>; Fri, 22 Dec 2023 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sEtBWDud"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-67f33cf014cso10557486d6.0
        for <linux-s390@vger.kernel.org>; Fri, 22 Dec 2023 03:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703244510; x=1703849310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1p7KqUeaWemOFaHH+JSolT+/fQ/fl1zP2/9KT4NrzQs=;
        b=sEtBWDude6HWs19lafdbEKl2ITBZWLxnvBlNmD1wXKZRmQ5Fw700bLGgf1AgDjWYZI
         p90Mot4L/KBL+CRZVWTkC7Q73Pnwq9Fn8mrQ+2z2D1IKCz+monFQE3vXKu8LSaWONASH
         DUdNuMayUvwttB4B1a3DbD4x0tvatna2N2PIgbD6L7KfntPLk6REcVazi5nOKmgbiMLr
         Kzca5tZZ+skU6Gs8xc2wuKmNZrghaZuxG8ATJNGohgNcRDovDQl+6Iw5N/hSByDjtGbr
         s3RmOugWDoBjZtttca7+aCFdMHerhCO9QUQyYRSlb7gG6A+YmDM7uqoWayUyvAFq24wi
         fODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703244510; x=1703849310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1p7KqUeaWemOFaHH+JSolT+/fQ/fl1zP2/9KT4NrzQs=;
        b=Qmp4FT8HSRS1ajuBZjs2ZKwabRkdTL5wFb9XDjaZz9BGfZg/SstSj2g1yCzXTyO5Vw
         n2yG7iA+CwlXt63tuSe6tv8eNOFyqBVEBjMHaDY++ME5spGlkhFzYKTZEJcG7rcqTaqU
         9+Yd9B19CUHWzc25sBLtJGGm6pZaI7FPYL5a86YyQUkHCVRpXR1fiLqejQHiQTjR2vCu
         NTymI/6J2lgV4yS2aBhxbdvLA63JQ2oYhdbDitO/++lsbYGIL+s7gK3IgEjOiG7WM0wN
         pd+GDKnWqDBYSCeSDMNiP0i6VkcWym+67mtGf4hcUiQ+6D2WzlJNL5cAjHK6VAEvleFj
         9ihA==
X-Gm-Message-State: AOJu0YzLAEvyprHNaj3W3KEky983GatKqjCKGjVxvZ7LoM4ghVukLbCB
	r66JZgkPC26B6OCa0xpB5wwatejHyVMHtqAfqqgZckcNj06N
X-Google-Smtp-Source: AGHT+IHPji95ha6HR/0zNsyc4lcIIhIIZ0QuPDK3fEve1mQsC16ko8lq10eB/oWPfvvIAqy7RvyLZOYcE5PauCz3ktA=
X-Received: by 2002:a05:6214:62a:b0:67f:9eb:f1ec with SMTP id
 a10-20020a056214062a00b0067f09ebf1ecmr1541233qvx.56.1703244510192; Fri, 22
 Dec 2023 03:28:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213233605.661251-1-iii@linux.ibm.com> <20231213233605.661251-28-iii@linux.ibm.com>
In-Reply-To: <20231213233605.661251-28-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 22 Dec 2023 12:27:50 +0100
Message-ID: <CAG_fn=VfYNpMynQtXiKemoDy3LjH5Hn8N-VpzH6AGVZ3jDHPUQ@mail.gmail.com>
Subject: Re: [PATCH v3 27/34] s390/irqflags: Do not instrument
 arch_local_irq_*() with KMSAN
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 12:36=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> KMSAN generates the following false positives on s390x:
>
> [    6.063666] DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
> [         ...]
> [    6.577050] Call Trace:
> [    6.619637]  [<000000000690d2de>] check_flags+0x1fe/0x210
> [    6.665411] ([<000000000690d2da>] check_flags+0x1fa/0x210)
> [    6.707478]  [<00000000006cec1a>] lock_acquire+0x2ca/0xce0
> [    6.749959]  [<00000000069820ea>] _raw_spin_lock_irqsave+0xea/0x190
> [    6.794912]  [<00000000041fc988>] __stack_depot_save+0x218/0x5b0
> [    6.838420]  [<000000000197affe>] __msan_poison_alloca+0xfe/0x1a0
> [    6.882985]  [<0000000007c5827c>] start_kernel+0x70c/0xd50
> [    6.927454]  [<0000000000100036>] startup_continue+0x36/0x40
>
> Between trace_hardirqs_on() and `stosm __mask, 3` lockdep thinks that
> interrupts are on, but on the CPU they are still off. KMSAN
> instrumentation takes spinlocks, giving lockdep a chance to see and
> complain about this discrepancy.
>
> KMSAN instrumentation is inserted in order to poison the __mask
> variable. Disable instrumentation in the respective functions. They are
> very small and it's easy to see that no important metadata updates are
> lost because of this.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
