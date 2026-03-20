Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C9C3E0226;
	Fri, 20 Mar 2026 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030371; cv=none; b=e3/0rBS1XgGqdvfHZikRG3PWiIq8cMepeWWHznt+oA0lKg38HGDCaMFM150R6a+EgUR8xb0PSUViYXzYZb/dWj03XQhcoXE01WoY2WuMsvp+5KnkSR/ktnnpTNv81WLD0b+S/7guaC9+t8WIZosuYq9SA5ZMXcyMS2S3I/wR65E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030371; c=relaxed/simple;
	bh=wXlKT/adYsdpnI/u+Z9wPcZOZZ/MwshDM5G3iSOzys4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=poU/V/RRBTxk3ZJodfo/Nf3N1rSpdsrCZAibd5aLbYQdy/hCGRgZCYP2eVnqVgxII8qyQMQdIir1i5MBynBYYWVwEF2xhIO8DFIVtL1Cb3S3D5LzjuwtQ0hcPdJx+14IBS2gLhxIUaX+zRuSkYVae912V/pb5KwgxG5SuaacOBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcJ0yUdj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcJ0yUdj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3074C19425;
	Fri, 20 Mar 2026 18:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774030371;
	bh=wXlKT/adYsdpnI/u+Z9wPcZOZZ/MwshDM5G3iSOzys4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mcJ0yUdjm9Q2ofg9iTh+HV1T723kZiwNL9pllg96oCdleVAkQlRAzbT/w1QIL4c2u
	 3hiH89KSnsW0ogcnP+iPWKoRZdTdJ7R6l3spPdye+Q2ZtdQcL/wpHKelcCXChP5ZfG
	 dhIwt4U9wpfxioUqPdtTptZ6lwmXfTOhD70ET+QQvs9xslTLWTaBrYhd3eKXyB69gQ
	 Ol8GPniLkvn+UEeE5ZAyNx5QrMtPPCg8EmU+/lxlA+Xe6qVUKMy0tDMVwaEXR6Vyoj
	 cSl3WEFDFtkIlTJbQKffAptnuYcZ41N0oSYlkS1rEu9QNzpSFjMe8D9TehrAmHwuvb
	 1W92IyZu7aR3w==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
 japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
 sumanthk@linux.ibm.com
In-Reply-To: <20260318234600.730340-1-irogers@google.com>
References: <20260318234600.730340-1-irogers@google.com>
Subject: Re: [PATCH v8 0/5] perf evsel fallback changes, better s390
 defaults
Message-Id: <177403037073.155109.5895128300936871602.b4-ty@b4>
Date: Fri, 20 Mar 2026 11:12:50 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-02735

On Wed, 18 Mar 2026 16:45:55 -0700, Ian Rogers wrote:

> Discussion with Thomas Richter in:
> https://lore.kernel.org/lkml/20260306071002.2526085-1-tmricht@linux.ibm.com/
> showed that the evsel__fallback wasn't working for s390. These patches
> avoid the problematic frame pointer callchain on s390 and fix
> evsel__fallback from a range of problems when falling back to a
> software event. I simulated failures when developing the patches but
> they are untested other than that.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

