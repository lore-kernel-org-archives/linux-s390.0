Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944C129CB2B
	for <linux-s390@vger.kernel.org>; Mon, 23 Jun 2025 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750701229; cv=none; b=E+SQP85SqfWWT07lXbjDwkr3H5Wtfxdv/zjjn5VcacyTAM/Bn+pV7W/79Hn5/6xIstq3Oz4ZyiAQdW6ziYpv8ZL1eLyK54qUnwrLYO8tmdDiO5XqvHiVklX/yCGS7apQOCm28ngRQpt10skdnjRqmkABxvoJxbaIIv2p5UcF17s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750701229; c=relaxed/simple;
	bh=3QhJtzFP7oTRzX4HiLlB5ZhYEtFGRUp8DPuyNCN6c9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pbk79XTxkrDK6rFvG3zYie1jiulzqEf2O7YFrVsf84cL0EMTNFv79akSvkIo9mZEVD8zTU+D2G8ny4LQR+jXXVPR3Rgdkvdao0gOQ8Z4l6TksgWVdpTbvlrPAgYE7VqLF6Le0j69j7OhLyIr84f30Szcn1p7j0t0RBoObYJNFA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UnA1bkWZ; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UnA1bkWZ"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so22035ab.0
        for <linux-s390@vger.kernel.org>; Mon, 23 Jun 2025 10:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750701227; x=1751306027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfbdOGI6POgkEzM2U+zncQi7e79zC2DbeGl/tT1At+s=;
        b=UnA1bkWZs7ux1gGFGMGKyrDN4QC4IGpP5cM/D7FamcDRRbfJ8U5QgtzUH0OUQ83LvL
         3fUL5bbF/J6+RWocPnDf+yVQqy74SjHhC6YUte/j6BJ0uw8Y3tfom4cYEBWCPyCj9V5L
         hSdiasAxgRdVIbfXZ3yoXYMnO8UV4++wbyuWC7Aycy7KHi1OlKiHos6MvjDGT4L4jtew
         1StTDWqLpmsEsfA8ADSl6msqsySADOXdoWVWQ7J7I/yEyDeYXbMiSl99+xtb3I+Xl7ug
         wJVjGMF0pl+AnMgrK48KSpzKozulna0fVxcCMJGYnR8wCmol5ZsQAD6aQAiVms/et9I7
         gTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750701227; x=1751306027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfbdOGI6POgkEzM2U+zncQi7e79zC2DbeGl/tT1At+s=;
        b=ErBKfmT6EHgZggkccgypYQ3OGddkCuUQ9Sl5G1csMz5Ru5gV4Qj/tstHVK9YyGh7k/
         aI7KXm1G1cfXuXSNIHIyCbgpWu69LQkevuSiUD6Kx6QzawiM2+rJzbItqrEgAmKcZawX
         oR1cgSI9WX2aZ5on8UjlplIrmA7V+fG7aqtpIPdwe/+pTmKG2oBaNDXZ2Upy4MC39sXO
         C7wwvGPdw0p7/fAKZ8UEmvlmZ4zU3FsBTuX/sHOaEBHs+goOyi7Q3eCgu0ecvOC8eWfy
         iHewUIT60oEQBiMgx2Sqge79ABxlub5z/LB6BzHskuHA8BLt/oWZ3r1lZVfZd3mEtR3H
         5K4g==
X-Forwarded-Encrypted: i=1; AJvYcCW0MAlUiGReymfIkY1qk/5+pJ8nnxY8ZxY92aeVKSPzgppmNWbYHbnhjmtN26fm+/4t49tDP9WitLyS@vger.kernel.org
X-Gm-Message-State: AOJu0YwosiyvkoGGCVdjp4TA/2nc7JXegWcY1lcyCxaiDV8okTRPntaa
	Jj0BkGvUWTGK6aMaPvprtBefQ9JVVwQecp3iRnvo6esPtNAPj59OiZ/1YQiiWVWBKBef2Frnu1w
	pntpUXUNByFe15FhI9arSJbPz9CLy9wD3j2jokwtp
X-Gm-Gg: ASbGnctlcbV3AFohlbWGTj9hgCiO8/PyJ+XrXxlKnrlC5FuxLnpH0JDA16Fjm3x3u+m
	E0agyyCHgcGH9QNPg5sUH1xuP7qfYCp3BroojKk/sR2M8RjSnYlVikHscU/NltHo1AUXZwhXyek
	QlT8ZIF/y6ilZJ5CgNkrKqpNw/JhnEAvrITAas7TxSotjv2KmYXrKXwor3jhcCbnWgkJifm1Hm
X-Google-Smtp-Source: AGHT+IG9Kq5uHE16PKPlpcy4O1JeDUSo9YlkwbbeoAcnIyRyfQbVBGQVhbRkTfyQSGrCunqluTUKIJxkTfad+mvP74E=
X-Received: by 2002:a05:6e02:3a04:b0:3dd:d664:7e0d with SMTP id
 e9e14a558f8ab-3df0da3ce15mr5927995ab.25.1750701226425; Mon, 23 Jun 2025
 10:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623132731.899525-1-tmricht@linux.ibm.com>
In-Reply-To: <20250623132731.899525-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Jun 2025 10:53:34 -0700
X-Gm-Features: AX0GCFsCdOV-pfO9KZoCtwTrRPoKjKDvuzlbIOliBOG07bc30kwRiDQ7Fy8yOHc
Message-ID: <CAP-5=fV_hXzq0A-91NakejcQGnvPp+uJGGe=vccwM+47JVCmtA@mail.gmail.com>
Subject: Re: [PATCH] perf list: Add IBM z17 event descriptions
To: Thomas Richter <tmricht@linux.ibm.com>, sumanthk@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 6:35=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Update IBM z17 counter description using document SA23-2260-08:
> "The Load-Program-Parameter and the CPU-Measurement Facilities"
> released in May 2025 to include counter definitions for IBM z17
> counter sets:
> * Basic counter set
> * Problem/user counter set
> * Crypto counter set.
>
> Use document SA23-2261-09:
> "The CPU-Measurement Facility Extended Counters Definition
>  for z10, z196/z114, zEC12/zBC12, z13/z13s, z14, z15, z16 and z17"
> released on April 2025 to include counter definitions for IBM z17
> * Extended counter set
> * MT-Diagnostic counter set.
>
> Use document SA22-7832-14:
> "z/Architecture Principles of Operation."
> released in April 2025 to include counter definitions for IBM z17
> * PAI-Crypto counter set
> * PAI-Extention counter set.
>
> Use document
> "CPU MF Formulas and Updates April 2025"
> released in April 2025 to include metric calculations.
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>

[snip]

> +       {
> +               "Unit": "CPU-M-CF",
> +               "EventCode": "143",
> +               "EventName": "L1C_TLB2_MISSES",
> +               "BriefDescription": "L1C TLB2 Misses",
> +               "PublicDescription": "Increments by one for any cycle whe=
re a Level-1 cache or Level-2 TLB miss is in progress."
> +       },

[snip]

> +  {
> +    "BriefDescription": "Cycles per Instructions from Finite cache/memor=
y",
> +    "MetricName": "finite_cpi",
> +    "MetricExpr": "L1C_TLB2_MISSES / INSTRUCTIONS if has_event(L1C_TLB2_=
MISSES) else 0"
> +  },
> +  {
> +    "BriefDescription": "Estimated Instruction Complexity CPI infinite L=
evel 1",
> +    "MetricName": "est_cpi",
> +    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INST=
RUCTIONS) if has_event(INSTRUCTIONS) else 0"
> +  },
> +  {
> +    "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
> +    "MetricName": "scpl1m",
> +    "MetricExpr": "L1C_TLB2_MISSES / (L1I_DIR_WRITES + L1D_DIR_WRITES) i=
f has_event(L1C_TLB2_MISSES) else 0"
> +  },

Just a quick check. If the PMU CPU-M-CF is always present then the
"has_event(L1C_TLB2_MISSES)" check will always be true as the event is
in json and not in sysfs. I'm guessing this is being done for the
benefit of hypervisors.

> +  {
> +    "BriefDescription": "Estimated TLB CPU percentage of Total CPU",
> +    "MetricName": "tlb_percent",
> +    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / CPU_CYCLES) * (L1C_T=
LB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) * 100 if has_event(=
CPU_CYCLES) else 0"
> +  },
> +  {
> +    "BriefDescription": "Estimated Cycles per TLB Miss",
> +    "MetricName": "tlb_miss",
> +    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / (DTLB2_WRITES + ITLB=
2_WRITES)) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) =
if has_event(DTLB2_MISSES) else 0"
> +  }

Similar here but with different events.

Thanks,
Ian
