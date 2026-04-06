Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F5E322A;
	Mon,  6 Apr 2026 05:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775452229; cv=none; b=jUWAa7Hzb5wFVSh+VDbqMnb2ogAlO2Z+uU/NrKIUaC4nNLpezOO0IoOK60AAWWp03/ie0exiDbtsZH7/MyffrVcpHClHyNkOAHT2hJiOKOWyC7WLUgNmDli6zlrU+5py/j7DIUaTOBsJ7FxTwje2yy0yjL3fEAyqA2QLh4o6udw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775452229; c=relaxed/simple;
	bh=SNELPVeOoUGj3Y5MPWFhqP4D8GYPXnArCwONR4zWYvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+cOW9Cd/TpGHPyv0U2nUsmlkYlyqxqbiIbTRGS7SHM1lV19URqKmNVL2bS5S4EVp4eQriUubBINDJjJr8N4eEcPYQceY9UIRS59gyIWnBHjLTfALoo7ntxrhdTOEbxk9HIOeb95NS8O0r1+984fiGJIFwrnoz/oygpVwFcbAtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jriHKmoi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jriHKmoi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DA9C4CEF7;
	Mon,  6 Apr 2026 05:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775452229;
	bh=SNELPVeOoUGj3Y5MPWFhqP4D8GYPXnArCwONR4zWYvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jriHKmoiPDpaLxvtF8HmNAn/O+oMNiF4b7osEUecfcf4g6GXkESfZgpB2o1wu8Lmm
	 x+34G6V+Ay7DXGcbI2mYT/3wlw5yzR0WjmGFl3aCGA8ANMBAbeoI18/F3fgo5lmu53
	 Z4pKaTlrCkdIyoZOSfmvKuJyFDrtm4WgafBUm+4XqKbhzr0/ywSzcIY/BdURibjVxw
	 8qD+M1MaXE7gADGdcHobojg35U2sLtjggni4LNAua7LYyp1Zb+Z6bcTIjkgsQ9lpfw
	 QiRQ2TT8Z4hTqh6/02O3aRTcl02l/X5Yt2aP2E++HDnJhqSN4tLnNBsJh70TDhU5sk
	 sZ9S6c95IhK3w==
Date: Sun, 5 Apr 2026 22:10:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, tmricht@linux.ibm.com, agordeev@linux.ibm.com,
	gor@linux.ibm.com, hca@linux.ibm.com, jameshongleiwang@126.com,
	japo@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org,
	sumanthk@linux.ibm.com
Subject: Re: [PATCH v4 2/2] perf symbol: Lazily compute idle and use the
 perf_env
Message-ID: <adNAQzNcCufAf6Jk@google.com>
References: <20260326174521.1829203-1-irogers@google.com>
 <20260327045025.2276517-1-irogers@google.com>
 <20260327045025.2276517-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260327045025.2276517-3-irogers@google.com>

On Thu, Mar 26, 2026 at 09:50:25PM -0700, Ian Rogers wrote:
> Move the idle boolean to a helper symbol__is_idle function. In the
> function lazily compute whether a symbol is an idle function taking
> into consideration the kernel version and architecture of the
> machine. As symbols__insert no longer needs to know if a symbol is for
> the kernel, remove the argument.
> 
> This change is inspired by mailing list discussion, particularly from
> Thomas Richter <tmricht@linux.ibm.com> and Heiko Carstens
> <hca@linux.ibm.com>:
> https://lore.kernel.org/lkml/20260219113850.354271-1-tmricht@linux.ibm.com/
> 
> The change switches x86 matches to use strstarts which means
> intel_idle_irq is matched as part of strstarts(name, "intel_idle"), a
> change suggested by Honglei Wang <jameshongleiwang@126.com> in:
> https://lore.kernel.org/lkml/20260323085255.98173-1-jameshongleiwang@126.com/
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
[SNIP]
> +	if (e_machine == EM_S390 && strstarts(name, "psw_idle")) {
> +		int major = 0, minor = 0;
> +		const char *release = env && env->os_release
> +			? env->os_release : perf_version_string;

I think Sashiko's review is right.  You need to check the kernel version
instead of perf.

Thanks,
Namhyung

> +
> +		/* Before v6.10, s390 used psw_idle. */
> +		if (sscanf(release, "%d.%d", &major, &minor) != 2 ||
> +		    major < 6 || (major == 6 && minor < 10)) {
> +			sym->idle = SYMBOL_IDLE__IDLE;
> +			return true;
> +		}
> +	}
> +
> +	sym->idle = SYMBOL_IDLE__NOT_IDLE;
> +	return false;
>  }
