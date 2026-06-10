Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8263126BC
	for <linux-s390@vger.kernel.org>; Wed, 10 Jun 2026 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098756; cv=none; b=a3EPjjPFv4PB++GNYgQDgXnAjkZHR8NklgJMOt5TtX3LKBEpdi62N7PuNWSNUkQeLmJ9qBMxBKh9xZ8y1QYHo1Dm0nESmKra+g7wvEIjPNP10/ltxG3Tuzw/m2HLLOO2eZyI7/FGqrQOPBFrVZWXYkGUB+fFocK8lPj/863x5uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098756; c=relaxed/simple;
	bh=N00Ky+WGYp84SzDMbu+B9refsaRvWDuX8zkxZe2IH6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofw+QG5THwPBQXtOP5ARi6TmBQRRpe5m8mJbyWUSVbzcgdHYkorXAh83g3MR5REJ5Yt+HS5vhnMBPjzCnLr24DDBwPODkctCEPsiOhGo3RfdGFNIasTbJzuXK1w38ETpDThAVEcxeO4WTuNVSTYg2sjVacd8htHw21ffYvRWefE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hyi9U7hf; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hyi9U7hf"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bef8b97655eso1211938066b.0
        for <linux-s390@vger.kernel.org>; Wed, 10 Jun 2026 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781098753; x=1781703553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PPHRXTOIn1D18o4cjb2DkZuJ0R5woSyQD9xCP2gFXJ8=;
        b=hyi9U7hfgZolEYgEQ3Jwq17irQMB/0NlS0TnZBiMuQkw4oQu3UIFLcbcTtGw7uItpb
         xemNm1mCVVLkjCIl7gz0BA843mGaTmbZB+pjs0rPvEefU6PQcsJAzP90ZIS7e53NMWNO
         2kBpLuAfiuO4BvpX2TNhHliiO2MB4YAnBPFIE+hSwHFJDsC7NAsGTG4rCX3JBVDanD7p
         5k4SYjtnjEzV0DlPfMsoh6OLnGuSsCd1MXMBu6CCmOkXiFIa41421N0UPPj3+pF3NpeI
         9TCDQUVI2Nrr7OMGPPW1siTU/TOi6cilxRsbMZZgPhYCtdRHWh6Tqp19XJY79MHmzVSY
         6Kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781098753; x=1781703553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPHRXTOIn1D18o4cjb2DkZuJ0R5woSyQD9xCP2gFXJ8=;
        b=PG14m+/nKt8CtpiltlRdDQ4/LY2F/VaOn7RJwnW/8JB7kWDXrPJAI+w+MaKFhgQ0eT
         tpYTBBXA9WeDzD/CFg69cqhQ+wLDKTp89KcyF1LicGLrjrfrCH5yCalrgGQ116j1BFCr
         7qkz3QuSYxjnebMITSCd0VCjrVwGbt2rex1mN2ptr//kKKHInOIx/5xEUHg49gvR5V8J
         WTtNmx6KCXGHyyQsWW1m4B62vBrDX0ARgl51TtiX1XXzFPRaZZfbTnUQhbpWuc9yIWvS
         zbbIc/HIavdBwWym1ZaY5vfPO64X1v0j2BbM5QP6yRgUZbkRnyD0tzss/z3GGlcOThe6
         +rnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+6h99o1qIEbM4sZBUdQH4UN7uxV+x6ydPQP19ES0sHAa0nBGt1Iu5y7G1VJr736aeZ0GqtG5VRwDZO@vger.kernel.org
X-Gm-Message-State: AOJu0YwmYHslPOd/Mr2fgZ4zl8Ap4R/iqB5+nhM9oA+aTbsHMAyaPOQb
	sbQL9bjPpXjqfsoi6OIqGH0D78goDmfw17kE1aHvbwOTr4LskPsdXzrsJhg0fVZFcno=
X-Gm-Gg: Acq92OFPz2ogyj9XfQRsYUUAEQLZLC8luW6mlBnK8+/0cVLKDNNDaOoM72i9FqV7BKW
	rsk7ysjDl6P8AKTZsI5U0cYXi4bt/hzMFPqG+jxWmNdrjDmTUlxH/xi8iqOrXn2RrczNvGOj2cZ
	HFbCFNKugp2kr/DFj9ON2i8fGql6fLCngRmCUITXIxq9w+XbvnlZNs5czt/2NWnnxkdM6ofHZCK
	vsdlmpnVrx+OtOveHq+NNMUtazpslWDKPJSgxkUDgYxxPjNO5doWGMCK9D8I2v0nHJAKf1UELEs
	X2Dv4gWEnZ5u35oxuWp3O6nxAXp3U0h+1PGcFxUQvZTwVCYiOOnlUaEOugkxkGw+fzdQ0Jxtr59
	3kly58n0awJrpfDocIO62NNAxkN3jTPlAWNdVoAB2WZ4TGbv+g9OvTwC90mLxMxnKy8bcgGhofA
	JevxlABc/pzSsjLktw9abKR2waKtAWkuSQyhey+Yw=
X-Received: by 2002:a17:907:60d1:b0:bd8:fc89:cda0 with SMTP id a640c23a62f3a-bf3a8a0cdbamr1035525466b.24.1781098752912;
        Wed, 10 Jun 2026 06:39:12 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e04a89sm1179772566b.41.2026.06.10.06.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 06:39:12 -0700 (PDT)
Message-ID: <a76b93d7-89bb-483a-80dd-59e3dbf921a3@linaro.org>
Date: Wed, 10 Jun 2026 14:39:10 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf s390: Fix TEXTREL in Python extension by compiling
 as PIC
To: Jens Remus <jremus@linux.ibm.com>
Cc: Jan Polensky <japo@linux.ibm.com>, Thomas Richter
 <tmricht@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260610112451.1553054-1-jremus@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260610112451.1553054-1-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/06/2026 12:24 pm, Jens Remus wrote:
> On s390 the Python extension build fails as follows when using a linker
> that is configured to treat text relocations (TEXTREL) in shared
> libraries as error by default:
> 
>    GEN     python/perf.cpython-314-s390x-linux-gnu.so
> /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
> 
> This occurrs because util/llvm-c-helpers.o is erroneously built from
> util/llvm-c-helpers.cpp without compiler option -fPIC but linked into
> the shared library (via libperf-util.a(perf-util-in.o)).
> 
> On s390, object files must be compiled as position-indepedent code (PIC)
> in order to be linked into shared libraries.  Commit a9a3f1d18a6c ("perf
> s390: Always build with -fPIC") added compiler option -fPIC to CFLAGS
> for s390, which is used in C compiles.  Add -fPIC to CXXFLAGS for s390
> as well, so that it is also used in C++ compiles.
> 
> Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>
> ---
> 
> Notes (jremus):
>      This patch applies on top of the perf-tools-next tree:
>      
>        git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git  master
>      
>      Note that this resolves the issue discussed in thread "[PATCH 1/1] perf
>      build: Fix Python extension build with GCC 16 hardening":
>      https://lore.kernel.org/all/ahV2XGx_6h7upuc3@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com/T/
> 
>   tools/perf/Makefile.config | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 333ddd0e4bd8..33f90968c8a9 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -109,6 +109,7 @@ endif
>   
>   ifeq ($(ARCH),s390)
>     CFLAGS += -fPIC
> +  CXXFLAGS += -fPIC
>   endif
>   
>   ifeq ($(ARCH),mips)

Reviewed-by: James Clark <james.clark@linaro.org>

