Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HWYga+h6"
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD845171F
	for <linux-s390@vger.kernel.org>; Fri,  8 Dec 2023 05:32:55 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-59063f8455eso1026004eaf.3
        for <linux-s390@vger.kernel.org>; Fri, 08 Dec 2023 05:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702042375; x=1702647175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL1EkEt0qsAoRDwtVA7bs3ZuCI4ZBobSjrqprT3lLqo=;
        b=HWYga+h6Y/OrNxvsQNQKV44owCXJEFQh8Oo+zcKO/Yz5Z2g7+WWdW2pLwpzJBChGNf
         aRo5/KZ22AwHqxKwlgV44Di8H8U8JXRVulqYZoZJeLb0lZ13UIk8fw8EQsbSyuK/nSZR
         m2gOwrhezjVrbOpMIz9OxWmW+N7pwmY833k3k5AnJPVGCe4X6HRPppqO5UZc7nmtm71D
         zvpFAKhlm555YrRxvSLJvmUk5u30knz9WYSMI2Udxzs56aun/AjF1H14Z8epTobcOArf
         odKTPT2UVsIjInvxPytFfJqhzzbUWkP0bYmOCAZUH+5K3ZatN3aOr1w+UQ+eU72SoI22
         QZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702042375; x=1702647175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pL1EkEt0qsAoRDwtVA7bs3ZuCI4ZBobSjrqprT3lLqo=;
        b=xUQtYAh1XFHZ3OO6bFOVf1nzfjocAosU4W2hl5EFPTT84KxoGrKSa3wbKG3uvANr7t
         mz1zBnZvS/P41tsIY3pkW/IPcaFm33CPFSIA848mAQlrpyBTVjkjcwtcjqso1szNDl9q
         ZU0nNXwa/MCUpzTQ4w5+6OvZTA2zp/BIe+5Sib1PkMp+QvSiRr4HUWosugocuFYz7+cX
         nmchOBuOePQWImmV9EXHfSSSUmBHDaOvQd8Y4R1K5vWmy2+NauoC3OCAHM2XOlivVNqH
         KunLkeSWRG+xLQRF/objzmkGGkA2KG5rARGat6bWb1Fjv83PlYgrm5iezTEE4FiUqcL7
         DfUA==
X-Gm-Message-State: AOJu0Yw0aQt9EvoqCaczoe4wEs4+LizMhUGYNcQNY4Tk22BPJdqRLgMX
	EzOYJuokmgzhrGNiBVP1DjFnyufoDpMe2PO1Itivrg==
X-Google-Smtp-Source: AGHT+IGRSBnBoc2BG0FsV541PbbYtbMc1RoW0fnIT845DKwurdtswNYXWxoNJcxnqfNgHmHrHSrHprdH/0NINlfzFLY=
X-Received: by 2002:a05:6359:6196:b0:170:22f1:d0a2 with SMTP id
 sb22-20020a056359619600b0017022f1d0a2mr3474879rwb.56.1702042374871; Fri, 08
 Dec 2023 05:32:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-20-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-20-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 8 Dec 2023 14:32:15 +0100
Message-ID: <CAG_fn=WiT7C2QMCwq_nBg9FXZrJ2-mSyJuM1uVz_3Mag8xBHJg@mail.gmail.com>
Subject: Re: [PATCH v2 19/33] lib/zlib: Unpoison DFLTCC output buffers
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

On Tue, Nov 21, 2023 at 11:07=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> The constraints of the DFLTCC inline assembly are not precise: they
> do not communicate the size of the output buffers to the compiler, so
> it cannot automatically instrument it.

KMSAN usually does a poor job instrumenting inline assembly.
Wouldn't be it better to switch to pure C ZLIB implementation, making
ZLIB_DFLTCC depend on !KMSAN?
