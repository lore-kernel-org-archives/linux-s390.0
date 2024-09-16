Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4AFA29;
	Mon, 16 Sep 2024 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726504178; cv=none; b=eLWYpTPkLe7PFL5ulk7t9pgtPiZk6K7R/+oG+g/VO/5KYJkTTQQIsfxubCm0uGWvgTsbJ+gAEipHi2bi4Djci3F2FZ1D3AiDFldqWjP/atbCU7tO4ViEyj693qoE9p2LB3PfvJ8A+mB0vb4Y9I0zG5wL7qH3EpujKlIi30fsQUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726504178; c=relaxed/simple;
	bh=Nm+KjuDd/6vIz7azXq22szrifIq7ZmeKemLmdwemJwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOMWbZM9FY/3qwehvoc+z4SFQ8FRUYRIlep/cH+V/3MOVjN1KXFeVVAGNELBDKVUqhTorlSSIWD0R+1Md3c4WBnR0zfbSoVcojj9msXCM2FD1ScU7Qv2p78oyqzH7CIncayJEho0iwMdsnR2Ov4OypAXaxfLDih6kiQscIZW27w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76A5C4CEC4;
	Mon, 16 Sep 2024 16:29:34 +0000 (UTC)
Date: Mon, 16 Sep 2024 12:29:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Masami Hiramatsu
 (Google)" <mhiramat@kernel.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v14 04/19] function_graph: Replace fgraph_ret_regs with
 ftrace_regs
Message-ID: <20240916122930.523af6c5@rorschach.local.home>
In-Reply-To: <20240916121656.20933-B-hca@linux.ibm.com>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
	<172615373091.133222.1812791604518973124.stgit@devnote2>
	<20240915051559.435abfcd@rorschach.local.home>
	<20240916121656.20933-B-hca@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Sep 2024 14:16:56 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> This does not pass the ftrace selftests. Please merge the patch below
> into this patch. With that:
> 
> Acked-by: Heiko Carstens <hca@linux.ibm.com>

Thank you very much, this is why I wanted arch maintainers acks before
taking anything.

There may be other patches in this series that I didn't Cc everyone
(yet). Did you look at the other patches? If not, I'll go and do the Cc.
It's a manual process.

-- Steve
