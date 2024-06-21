Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289D115FD1B;
	Fri, 21 Jun 2024 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718992533; cv=none; b=EbfMRQ2Wjd74wFnP+jsIXU+1xVjY4tIvsJbaQaC/7ty2wckOSVZ64bqzJwgq/vROt7y/hKClXjSHWApkhNbKKnXl2UoPeE+q19ZLseRLi1dR/UjUEqzypV5K15anmxa1MiKGS48Jw15khyHFPOmw5zW+HfMLfcTlLM2cCls7XLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718992533; c=relaxed/simple;
	bh=ViQ/sfxzgM4EimaA609XKxzWJd4KWbEZwS58C7naHfU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=O3O+KC2E2Oe6PZnX3K6VfaFO8t+hVPM2mpsycVjzC21ILtJiX51Lgjxdx65xrn+PLymv9wdOaxVoVk/GI4Lmesy58YlTCscxomBGaO4N3gsld40eeakDvO8p0gXGcoo+5vqlSSRVoT0lp8fHx3ycfncwrLf1omK0ruag7cTc1AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bwwQ7lsC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bwwQ7lsC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2634C2BBFC;
	Fri, 21 Jun 2024 17:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718992532;
	bh=ViQ/sfxzgM4EimaA609XKxzWJd4KWbEZwS58C7naHfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bwwQ7lsCQrW8h2s5dcm2x8q3LtS2fltP3U1iUWMzZMHfhCvkd3r2uyL0wBLonmQ1F
	 ufsni4eljVDZUaMLc+LUpnSzCSnYvbCUGq9RNUQEg9lo+QwMjSOwYqazZd+MY0Hl5+
	 J6BsqNGdB93f+EIHFUu4dVGi0ci++nnsVyrzz+6Q=
Date: Fri, 21 Jun 2024 10:55:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Alexander Potapenko
 <glider@google.com>, Christoph Lameter <cl@linux.com>, David Rientjes
 <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, Joonsoo Kim
 <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka
 <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, Dmitry
 Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle
 <svens@linux.ibm.com>
Subject: Re: [PATCH v7 00/38] kmsan: Enable on s390
Message-Id: <20240621105531.57736049ce642db59181eb06@linux-foundation.org>
In-Reply-To: <20240621113706.315500-1-iii@linux.ibm.com>
References: <20240621113706.315500-1-iii@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 13:34:44 +0200 Ilya Leoshkevich <iii@linux.ibm.com> wrote:

> v6 -> v7: Drop the ptdump patch.
>           All patches are reviewed.

I added v7 to mm.git (and hence linux-next).
