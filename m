Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BAC1509BF
	for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2024 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721550; cv=none; b=O6sFMoy2yM5Os4E1+jvz9gqCJsLczoFEAB2Thv0fZRCQIz6VIagwrghkIO7a//EdTLn3fcYV5NxIwyEHXynGa2ejtq6u4S/nzkZf6GDix00oRP4JS812wI8cC2DjTlwd8wZHLVElKiRjZlm9r6pyBEF5rk202v34h4WEMWqTSYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721550; c=relaxed/simple;
	bh=dBK+Ndw0Vot1wf/eS0eqhW75oHUr4im8qRpkAfEJRNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sx9TE9NJCCUg2IUGfPLAGjJBmBwQd+jyD61RArczc1aP/guSXhPMsyWG/TAqRahnek/H4GOcnvk97rqAXKc2FpXg5ksvlsY/4s2sWHso2X6He693Dnck+LJPCq7g/0iiF6fofRohzkfufR5GsLQ1SlyHO933ArPW2DtJbefFcXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YjLEw97L; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YjLEw97L"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6fc36865561so1476571a34.3
        for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2024 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718721548; x=1719326348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBK+Ndw0Vot1wf/eS0eqhW75oHUr4im8qRpkAfEJRNo=;
        b=YjLEw97LcDvrYFVevvaMmoIBRMpHrSATUHvBtdgvCWP5EJ8d9tCMM0iH+dxskBFebH
         OGuNMF/mCr/iI2AEO+QmNGi3Zq10CJ2RNCG1nZUohstMfZuTq6mLxNK0wveBOKMiCcXZ
         VXzkVtPS28uXylXJI4GWSrVXtzxGG/pxP9h6sA9ySwcqEBXkQfsNBdk76x4y18s3BVPS
         UktNu9Mt+4W4PsfN2nFsaunMdYXGvC/b43JEHg1bhaErNfc+zReY6OcgxOPIk9TvBdYB
         e1MJXER3Yhz1ka0wYxMwD4SzILpq8wKl5u5S0nB1bP4Er6G4kkQVGo1vNfvUIBT/DOcx
         IA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718721548; x=1719326348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBK+Ndw0Vot1wf/eS0eqhW75oHUr4im8qRpkAfEJRNo=;
        b=UOXRdSHPn7CRHKhkj1C9jfICuBWd/j8pvUChHywjlPwxkL1dZPg1Az6dXCWI+R0Zx7
         9BX0iJQVMl/bXagIi7L6xPhpnHxE5KbbiO4u3F2NFVncEB6k054xHD0JYBESStiS96RI
         D9GRX+MAKxOEVWi3DSVVImMBCn0MCxihFTAECqlOjS7/skxSmMW+MRa25W3sas3EGzim
         1vrLzB3omQ5At9Hb9Ls7kq0fq5rZDVVj3yLwrqQdoi6hlczYOmGVwY9TrbH5VfB2udRp
         D+rNHW0m7iPjOy3L82uSmqP7yWNP9Zmtk1Z+vOFVFH2fv34i9mNtx3f3p3yDp7EgzLp4
         75Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVVdEzqkRdRqXeTLALUTZWndmoni9+5JtRsuJI0o2i69LeD/+YmIIE4fr98gQO/WtpPS0gQgEDt1XcY5VEEphVLl8UMa/SuhB9SQg==
X-Gm-Message-State: AOJu0YzczQRV4Hz+FvDnUTRR1qWlR1JF7hyzJ8h82NrtvM1diN1jMaJL
	uBP/AmtG66QEIn0YSEqWS+U+Zumx9pHs6qowEOuJR6fgk3tfXrcYsRp68vWcEqiaj9HeFKFVlhE
	00RCPfMV01IBjMyFMSbZkIxvVT4TPEykQhGi6
X-Google-Smtp-Source: AGHT+IHvmtXD/5jdcU/F3gCaBUEdfvS5SdhkcxvX24T00XkUY5xtucdhFcs/3zm/3mx3Jnt7TCz3MWavkll+mwgIPtY=
X-Received: by 2002:a05:6830:1d8f:b0:6f9:6e0d:dfaf with SMTP id
 46e09a7af769-6fb93b08befmr13854300a34.26.1718721548293; Tue, 18 Jun 2024
 07:39:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613153924.961511-1-iii@linux.ibm.com> <20240613153924.961511-17-iii@linux.ibm.com>
In-Reply-To: <20240613153924.961511-17-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 18 Jun 2024 16:38:31 +0200
Message-ID: <CAG_fn=Uyx7ijj-igC2hgSpdzmChM0FVy46HTRXyKzNAA0OFK7A@mail.gmail.com>
Subject: Re: [PATCH v4 16/35] mm: slub: Unpoison the memchr_inv() return value
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

On Thu, Jun 13, 2024 at 5:39=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Even though the KMSAN warnings generated by memchr_inv() are suppressed
> by metadata_access_enable(), its return value may still be poisoned.
>
> The reason is that the last iteration of memchr_inv() returns
> `*start !=3D value ? start : NULL`, where *start is poisoned. Because of
> this, somewhat counterintuitively, the shadow value computed by
> visitSelectInst() is equal to `(uintptr_t)start`.
>
> The intention behind guarding memchr_inv() behind
> metadata_access_enable() is to touch poisoned metadata without
> triggering KMSAN, so unpoison its return value.

What do you think about applying __no_kmsan_checks to these functions inste=
ad?
