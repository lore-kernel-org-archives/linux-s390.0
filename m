Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F11C210E9
	for <linux-s390@vger.kernel.org>; Wed, 20 Dec 2023 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZLsOLMp6"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-77f8308616eso461157085a.2
        for <linux-s390@vger.kernel.org>; Wed, 20 Dec 2023 03:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703070308; x=1703675108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRuOb3thPKxS5ftTwWuPZVBwpG9dfs4GXpoJ1hD7vC0=;
        b=ZLsOLMp6hN5xMThNv+as6Ms91ht4Hg8idXzILP4u9tIFPo+5rHRXxllusclBYIXajE
         Taub7AAXqVnoQI3f+fLXz1Gp0AxFveNNF0bNkr8eTL/zMqrVufk8w5ZNjCo+t1tZ8qv8
         t8z5nthKMJW+gMkBUyv+fkxw3IDtvvaXbfvz6qO0TtjPZ/NLkiMZzcomXP3VmwV5CiRQ
         UTKG35J2uNwTtYgyXGpycBAz1Ubbiix2cIl1KNmNuETV61LRgb3U//dbRzVATravzLY2
         7cwjvRQh5zkoshl6AuNy4Yj/qGDO3V1Z+x9I8CvRuIbJouB2zBFCjxFaSRojVcxHE5UK
         ufRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703070308; x=1703675108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRuOb3thPKxS5ftTwWuPZVBwpG9dfs4GXpoJ1hD7vC0=;
        b=cXZh+BW/PV14MWSMlllKjaccI09oEsu+I/2mIIfhCqIvNBrZLCSe3rUagX4VgyPpaW
         vh0p9YDYZYfHKF1zsyWNz1lQTxN+A74vl1+q6tqHZJdTYbMYSt6HnROGJMk/Gax7Pmq2
         IEBqcE6SsAD52ESLJEUnb4vDlg4DuEE9OV/7LTbIP+78sVv5ylt0R0R2430Lgkiwn7L1
         8R740c//kQeM/is/ZvtatvC5mzztEbJxHl4qx7R4ZujeN2wS8uR/jrAMIuCl40fCLbMB
         BATPFiZdMldvRCnvMGFiqm94V+Cva31bigwq22UKZvZTsEZS6wDf6zbuv1ceTTx2E/mL
         GNCA==
X-Gm-Message-State: AOJu0YzrJ3NABVs4TXkSBd4hVOIGg70AACHMGU8uzljWo2BmBkDSydnn
	o9G8VDYW3RZKu5wTI0pe7A7fZp48yOBepC11m8kAqg==
X-Google-Smtp-Source: AGHT+IGM1DvhNsHIpLRzl7TLlRhf+sSCR6McpSC15tKPCcbFJwj7U8mFeDmNKOAesBXFyLQOLaIWCh6aAZXNFJ7pswI=
X-Received: by 2002:ad4:5dca:0:b0:67f:143d:b8ca with SMTP id
 m10-20020ad45dca000000b0067f143db8camr12635720qvh.44.1703070308403; Wed, 20
 Dec 2023 03:05:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213233605.661251-1-iii@linux.ibm.com> <20231213233605.661251-25-iii@linux.ibm.com>
In-Reply-To: <20231213233605.661251-25-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 20 Dec 2023 12:04:28 +0100
Message-ID: <CAG_fn=X_MejbvJRG7qYih+qrL6D0hrJW7czfAJbOdY5ES4JyiA@mail.gmail.com>
Subject: Re: [PATCH v3 24/34] s390/cpumf: Unpoison STCCTM output buffer
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

On Thu, Dec 14, 2023 at 12:37=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> stcctm() uses the "Q" constraint for dest, therefore KMSAN does not
> understand that it fills multiple doublewords pointed to by dest, not
> just one. This results in false positives.
>
> Unpoison the whole dest manually with kmsan_unpoison_memory().
>
> Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
