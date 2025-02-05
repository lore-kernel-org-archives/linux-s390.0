Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259651FF1A8;
	Wed,  5 Feb 2025 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780799; cv=none; b=sLf18RYUaM6vGql0GQ7Xpm+TWXxR8ErRUJu8P7epcHGd0sR6vAvUqUCaTUZEjK+ELYQaeIHZzO40aQAO9fgbi0EG1bIu0Z6xTyOvOWi13E7PTBso5w+YPE+OOa25WHMkAHUzKNUdN6T1Qqu3ZNRiagZ5RzaTHWY97ao9IxYc0vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780799; c=relaxed/simple;
	bh=43+A3OHQFbg4/Fn+/3/eAHiEQrJAD8MFDW6P7HioEDM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VY5ctCDKoWL/7p11ArmEBYJD4WNF6Lz1RsdelQT2/CgkBhKpPjgcvSGmS1i1QSkJ3QVlNARATPoxx9OhimRbL3zzqgt+UNDej1aDFUkoI7As9/fi8TOV7ymQxQBth60GBFtPCO+sPrIFDPa+hcONw5fCjKR5znrHQggq7ocOc04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7Fwdcw4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7Fwdcw4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2609C4CEDD;
	Wed,  5 Feb 2025 18:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738780799;
	bh=43+A3OHQFbg4/Fn+/3/eAHiEQrJAD8MFDW6P7HioEDM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=R7Fwdcw4Cxgle58nWtWULJiQMkGsB09LmjfEl4AkNGPniOIRgM7FGSMxcK3aXMn9U
	 1HIfdhzvyiBxHobpq4cFx9MTa/8ApAsSj8tJzDs4i/TPLpiWaH/a9LWhAQgXr0VBFE
	 POmXCNDDR4cNVl+uQ57oJvZXyS4HLSoqUrJ/jISlpnWr2EXMohDUYjIiUsfnB3Pcer
	 DBD14gs2kqLe6ggjVEw+/QjtnLGGoAJ9xHNV9UZaX7NhfTGbv5vW4yjRvD9j9nyBCU
	 Ok6pDl9HFu+VuoayqdJRPmTZFWMsRuEPf2qwjx7x9SCdNDh1Vu+aWY9mIqc2cHR33+
	 xAsU7DWpdpl7A==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, acme@kernel.org, irogers@google.com, 
 Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
 hca@linux.ibm.com
In-Reply-To: <20250131112400.568975-1-tmricht@linux.ibm.com>
References: <20250131112400.568975-1-tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf test: Fix perf test 11 hwmon endianess issue
Message-Id: <173878079868.596119.14927569860123031821.b4-ty@kernel.org>
Date: Wed, 05 Feb 2025 10:39:58 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 31 Jan 2025 12:24:00 +0100, Thomas Richter wrote:
> perf test 11 hwmon fails on s390 with this error
> 
>  # ./perf test -Fv 11
>  --- start ---
>  ---- end ----
>  11.1: Basic parsing test             : Ok
>  --- start ---
>  Testing 'temp_test_hwmon_event1'
>  Using CPUID IBM,3931,704,A01,3.7,002f
>  temp_test_hwmon_event1 -> hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
>  FAILED tests/hwmon_pmu.c:189 Unexpected config for
>     'temp_test_hwmon_event1', 292470092988416 != 655361
>  ---- end ----
>  11.2: Parsing without PMU name       : FAILED!
>  --- start ---
>  Testing 'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/'
>  FAILED tests/hwmon_pmu.c:189 Unexpected config for
>     'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/',
>     292470092988416 != 655361
>  ---- end ----
>  11.3: Parsing with PMU name          : FAILED!
>  #
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


