Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/VfjS1S"
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F6F171E
	for <linux-s390@vger.kernel.org>; Fri,  8 Dec 2023 04:54:24 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5d7346442d4so19794847b3.2
        for <linux-s390@vger.kernel.org>; Fri, 08 Dec 2023 04:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702040064; x=1702644864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByI2BmM76fDl6CBfV37McPabf7tQNlC2zWfp5P+Us7w=;
        b=c/VfjS1SUuwPa0ud1rF722pXq7krjTYGiyAE8nZHfGfjZDzA3ClrvBBuQ6yUccZEi6
         /bZoXwdzaqzTm+CoxnSe2Cabmorok2OW1nZ7TOZKAG1E/fUC+sfpYpw1eynWF5d3pJo8
         sC3wBfO2dKliegsZpEq/ZgpjepQHKUATQPJWV267UIYH+T6XWMO6DS7DtYpyXyPoCZkF
         mHTGgLAiLNnMGGejmdOT+zTHHjOoBf0u3kUbJ44QN1it0+cms9+IPimtcqpICtrTfzaC
         h5I9+liC5GdvGp2HvVPgmddd/Hn9iHVyQmSD3rQt4iw2tS2509s5Bqf7eXqb34M3k1GC
         h1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702040064; x=1702644864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByI2BmM76fDl6CBfV37McPabf7tQNlC2zWfp5P+Us7w=;
        b=Yff34jUNOh6d3PbaNwwFkmYYB1LabI42yZhJ3ha83lpVUB9w44uTQDBt9OnbsoqfMk
         t2oiWx/J2MUbFhvhcG95cx8LUGDfOBjlTtayt3mK4Yik1DAEotPBIdTbLBlZKJAjpp4w
         CSwDhvlaB/xfbawihxHO37dN1UgFFLwK6eDgkgPMjaTR2AbNnmVFKIl0IpOR3gujmF2v
         VdfIf7FO4n9p1NG2hFro14khdhFrzHDA/FunjDIYZTl79ZvSYMAlC/4pOkXagjPKVDSd
         rwbWi5BalSVmcDxJJMBB6oKm/lF3Byf+xxI8GGN8dgBYADIbQ1T6Ylpi4LR63cBTZh9k
         qMBg==
X-Gm-Message-State: AOJu0YyNsXOlNH3/YsSBeRNFWJsRd9LM17usoCaCL7WripBHtlDpPc0T
	7fha8LEUhXWFTVhfuL/eaewZpFqqf7DmCREWMU2fKw==
X-Google-Smtp-Source: AGHT+IF5iZ4loNbrkDEVIKN0ZuOOKoVeFsgMMcs4UNMekY672SG41YIpWxGAUfSzwyEW89VxsHniMNAuYOLaquPgO8c=
X-Received: by 2002:a25:2395:0:b0:db7:dad0:76dd with SMTP id
 j143-20020a252395000000b00db7dad076ddmr3075741ybj.121.1702040063846; Fri, 08
 Dec 2023 04:54:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-18-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-18-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 8 Dec 2023 13:53:41 +0100
Message-ID: <CAG_fn=Ug6MFyoj=J_yabfd-V+3vGYNS3-CS+fhW9Tsc847xMtw@mail.gmail.com>
Subject: Re: [PATCH v2 17/33] mm: kfence: Disable KMSAN when checking the canary
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

On Tue, Nov 21, 2023 at 11:02=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> KMSAN warns about check_canary() accessing the canary.
>
> The reason is that, even though set_canary() is properly instrumented
> and sets shadow, slub explicitly poisons the canary's address range
> afterwards.
>
> Unpoisoning the canary is not the right thing to do: only
> check_canary() is supposed to ever touch it. Instead, disable KMSAN
> checks around canary read accesses.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
