Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u17OW6FU"
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EB5CF
	for <linux-s390@vger.kernel.org>; Mon, 11 Dec 2023 03:51:04 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-67ab16c38caso29122566d6.1
        for <linux-s390@vger.kernel.org>; Mon, 11 Dec 2023 03:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702295463; x=1702900263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFlOaOKOFTUGeU3hihhI0E9Jv6p6CgBMgpCcvHMWbLI=;
        b=u17OW6FU+I47r/XfAcb5vP+2Le80pD6d5wdDVFKE2j5qnRsm+J0UIuKmqaMMryr1M+
         CjsaO3aTGMFOawVCEqypHSyz6TV6RHpCuu4Fxi9ZTvs5umRG801QflWNLjzkR4OEYt3Z
         4M9YKCjq3rygkxRn4mxKpPYVQsnXYwy2zxJ+8xtCTzArc4HSlyh5z1Yu7qkV3KLrapuV
         30AzzCqO5sh4QRiWlJ5xW2C/dNKvDpkVSkC49ezfICTW5OpDSdk7mPmL4esqg+xsEdb8
         zRezW5po+CbeFBVl6pOlTzs6HdwBER4EZPEAGvxtsISuAbxBJ5UBfI0crUGleB2ViKRy
         J5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702295463; x=1702900263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFlOaOKOFTUGeU3hihhI0E9Jv6p6CgBMgpCcvHMWbLI=;
        b=m+s+faq1OIzcN3ktu5YuLvcvMWuJ2Bjvt8Dzvu9kUKU6IIM6IneBWgG49o/Sn5ZzL4
         Qxc43znegwd2y9JF7PZo0Ijfyc2c+kMsozr2mVLf/EkZ0viZ6dgWnFaA9TbPCoRCkx7/
         amLl3JEvC+yZvnBn47GO9eA3k6HiW5+UJEnRkeVCIYmBbbksacMnwFfOTHmd1avKMKuX
         wdoI0k8mitn6c/uAHh3vr8kTH55Gx/iOGPfmnYdcsGVfpqt3T8c6XtagpofiejHywluG
         fqpana9Zs7uqxp/e9GO590zgPxYlT8+BRVizHDEt1FUFjvcWW5AnlCoD+pLDPqtqLRuL
         YLAA==
X-Gm-Message-State: AOJu0YxlQygAuKH+FN9EMeEjU1a8ztgVBpKUAR8PJoZrmqqT06RAa6ub
	r5qEkZroalLaD5Cr8coPWA10U8AcY3XsLXD5b7AEog==
X-Google-Smtp-Source: AGHT+IESpOk1+13dVI9Xc1VuCWEKnD2SuIEKb3OpBVqsUwAw0LqpvmwqlMYZQkeY3oFDarm5X4BCzXvYf66ohaO4eV0=
X-Received: by 2002:a05:6214:2626:b0:67a:b923:6ae2 with SMTP id
 gv6-20020a056214262600b0067ab9236ae2mr6255559qvb.23.1702295463057; Mon, 11
 Dec 2023 03:51:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-13-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-13-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 11 Dec 2023 12:50:22 +0100
Message-ID: <CAG_fn=VaJtMogdmehJoYmZRNrs5AXYs+ZwBTu3TQQVaSkFNzcw@mail.gmail.com>
Subject: Re: [PATCH v2 12/33] kmsan: Allow disabling KMSAN checks for the
 current task
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

On Tue, Nov 21, 2023 at 11:06=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> Like for KASAN, it's useful to temporarily disable KMSAN checks around,
> e.g., redzone accesses. Introduce kmsan_disable_current() and
> kmsan_enable_current(), which are similar to their KASAN counterparts.

Initially we used to have this disablement counter in KMSAN, but
adding it uncontrollably can result in KMSAN not functioning properly.
E.g. forgetting to call kmsan_disable_current() or underflowing the
counter will break reporting.
We'd better put this API in include/linux/kmsan.h to indicate it
should be discouraged.

> Even though it's not strictly necessary, make them reentrant, in order
> to match the KASAN behavior.

Until this becomes strictly necessary, I think we'd better
KMSAN_WARN_ON if the counter is re-entered.
